const API_BASE = `http://${window.location.hostname}:3000`;

// Global State
let state = {
    currentUser: null,
    orders: [],
    clients: [],
    plates: [],
    currentNewOrder: { id: null, items: [], type: 'local', clientId: null, addressId: null }
};

const screens = {
    login: document.getElementById('login-screen'),
    dashboard: document.getElementById('dashboard-screen')
};

document.addEventListener('DOMContentLoaded', () => {
    initEventListeners();
    checkExistingAuth();
});

function initEventListeners() {
    document.getElementById('login-btn').addEventListener('click', login);
    document.getElementById('logout-btn').addEventListener('click', logout);
    document.getElementById('new-order-btn').addEventListener('click', () => openOrderModal());
    document.querySelector('.close-modal').addEventListener('click', closeModal);
    document.getElementById('plate-search-input').addEventListener('input', filterPlates);
    document.getElementById('submit-order-btn').addEventListener('click', submitOrder);

    document.querySelectorAll('.toggle-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
            document.querySelectorAll('.toggle-btn').forEach(b => b.classList.remove('active'));
            e.target.classList.add('active');
            state.currentNewOrder.type = e.target.dataset.type;
            const addrContainer = document.getElementById('delivery-address-container');
            if (state.currentNewOrder.type === 'delivery') {
                addrContainer.classList.remove('hidden');
                loadAddresses();
            } else {
                addrContainer.classList.add('hidden');
            }
            updateSummary();
        });
    });

    document.getElementById('client-select').addEventListener('change', (e) => {
        state.currentNewOrder.clientId = e.target.value;
        if (state.currentNewOrder.type === 'delivery') loadAddresses();
    });
}

function showToast(msg, type = 'info') {
    console.log(`[Toast ${type}] ${msg}`);
    const toast = document.createElement('div');
    toast.className = `toast glass-morphism ${type}`;
    toast.innerText = msg;
    const container = document.getElementById('toast-container');
    if (container) {
        container.appendChild(toast);
        setTimeout(() => toast.remove(), 5000);
    } else {
        alert(msg);
    }
}

async function login() {
    const username = document.getElementById('username').value.trim();
    const password = document.getElementById('password').value.trim();
    if (!username || !password) return showToast('Enter both fields', 'error');
    try {
        const response = await fetch(`${API_BASE}/empleados`);
        const employees = await response.json();
        const user = employees.find(e => e.usuario === username && e.contrasena === password);
        if (user) {
            state.currentUser = user;
            localStorage.setItem('poly_auth', JSON.stringify(user));
            switchToScreen('dashboard');
            loadDashboard();
        } else {
            document.getElementById('login-error').innerText = 'Invalid credentials.';
        }
    } catch (err) { showToast('API connection error.', 'error'); }
}

function checkExistingAuth() {
    const saved = localStorage.getItem('poly_auth');
    if (saved) {
        state.currentUser = JSON.parse(saved);
        switchToScreen('dashboard');
        loadDashboard();
    }
}

function logout() {
    localStorage.removeItem('poly_auth');
    state.currentUser = null;
    switchToScreen('login');
}

async function loadDashboard() {
    try {
        const [orders, clients, plates] = await Promise.all([
            fetch(`${API_BASE}/pedidos`).then(r => r.json()),
            fetch(`${API_BASE}/clientes`).then(r => r.json()),
            fetch(`${API_BASE}/platos`).then(r => r.json())
        ]);
        state.orders = orders; state.clients = clients; state.plates = plates;
        renderOrdersTable();
        updateStats();
        populateClientSelect();
        renderPlatesGrid();
    } catch (err) { console.error('Load Error:', err); }
}

function renderOrdersTable() {
    const tbody = document.getElementById('orders-body');
    tbody.innerHTML = '';
    state.orders.slice().reverse().slice(0, 15).forEach(order => {
        const client = state.clients.find(c => c.id === order.cliente_id);
        const isOpen = order['abierto?'] === 1 || order['abierto?'] === true;
        const tr = document.createElement('tr');
        tr.innerHTML = `
            <td>#${order.id}</td>
            <td>${client ? client.nombre : 'Unknown'}</td>
            <td><span class="status-badge ${isOpen ? 'open' : 'closed'}">${isOpen ? 'Open' : 'Closed'}</span></td>
            <td>${parseFloat(order.subtotal || 0).toFixed(2)}€</td>
            <td><strong>${parseFloat(order.total || 0).toFixed(2)}€</strong></td>
            <td>
                ${isOpen ? `<button class="btn-primary btn-small" onclick="window.editOrder(${order.id})">Edit</button>` : ''}
                <button class="btn-secondary btn-small" onclick="window.closeOrder(${order.id})">${isOpen ? 'Close' : 'Reopen'}</button>
            </td>
        `;
        tbody.appendChild(tr);
    });
}

function updateStats() {
    const openOrders = state.orders.filter(o => o['abierto?'] === 1 || o['abierto?'] === true);
    document.getElementById('count-active').innerText = openOrders.length;
    const total = state.orders.reduce((acc, curr) => acc + parseFloat(curr.total || 0), 0);
    document.getElementById('revenue-today').innerText = `${total.toFixed(2)}€`;
}

function populateClientSelect() {
    const select = document.getElementById('client-select');
    select.innerHTML = '<option value="">Choose a client...</option>';
    state.clients.forEach(c => {
        const opt = document.createElement('option');
        opt.value = c.id; opt.text = `${c.nombre} ${c.apellido1}`;
        select.appendChild(opt);
    });
}

async function loadAddresses() {
    if (!state.currentNewOrder.clientId) return;
    try {
        const resp = await fetch(`${API_BASE}/Direcciones`);
        const addresses = await resp.json();
        const select = document.getElementById('address-select');
        select.innerHTML = '<option value="">Choose address...</option>';
        addresses.slice(0, 15).forEach(a => {
            const opt = document.createElement('option');
            opt.value = a.id; opt.text = `${a.Direccion}, ${a.Ciudad || 'Málaga'}`;
            select.appendChild(opt);
        });
    } catch (e) { console.error('Address load failed'); }
}

function renderPlatesGrid(filter = '') {
    const grid = document.getElementById('plates-grid');
    if (!grid) return;
    grid.innerHTML = '';
    const filtered = state.plates.filter(p => p.nombre.toLowerCase().includes(filter.toLowerCase()));
    filtered.forEach(plate => {
        const div = document.createElement('div');
        div.className = 'plate-item';
        div.innerHTML = `<h5>${plate.nombre}</h5><div class="plate-price">${plate.precio_x_racion}€</div>`;
        div.onclick = () => addPlateToCart(plate);
        grid.appendChild(div);
    });
}

function filterPlates(e) {
    renderPlatesGrid(e.target.value);
}

async function openOrderModal(orderId = null) {
    document.getElementById('order-modal').style.display = 'flex';
    resetOrderState();
    if (orderId) {
        state.currentNewOrder.id = orderId;
        const order = state.orders.find(o => o.id === orderId);
        state.currentNewOrder.clientId = order.cliente_id;
        state.currentNewOrder.type = order.es_a_domicilio ? 'delivery' : 'local';
        document.getElementById('client-select').value = order.cliente_id;
        document.querySelectorAll('.toggle-btn').forEach(b => b.classList.toggle('active', b.dataset.type === state.currentNewOrder.type));
        try {
            const resp = await fetch(`${API_BASE}/platos_pedidos`);
            const allDetails = await resp.json();
            allDetails.filter(d => d.pedido_id === orderId).forEach(d => {
                const plate = state.plates.find(p => p.id === d.plato_id);
                if (plate) for(let i=0; i<d.cantidad; i++) state.currentNewOrder.items.push(plate);
            });
            updateSummary();
        } catch(e) { console.error(e); }
    }
}
window.editOrder = openOrderModal;

window.closeOrder = async (id) => {
    try {
        const order = state.orders.find(o => o.id === id);
        const newStatus = (order['abierto?'] === 1 || order['abierto?'] === true) ? 0 : 1;
        await fetch(`${API_BASE}/pedidos/${id}`, { 
            method: 'PUT', 
            headers: { 'Content-Type': 'application/json' }, 
            body: JSON.stringify({ 'abierto?': newStatus }) 
        });
        loadDashboard();
    } catch (e) {}
};

function closeModal() { document.getElementById('order-modal').style.display = 'none'; }
function resetOrderState() {
    state.currentNewOrder = { id: null, items: [], type: 'local', clientId: null, addressId: null };
    document.getElementById('client-select').value = "";
    document.getElementById('modal-items-list').innerHTML = '';
    updateSummary();
}
function addPlateToCart(plate) { state.currentNewOrder.items.push(plate); updateSummary(); }
function updateSummary() {
    const list = document.getElementById('modal-items-list');
    list.innerHTML = '';
    state.currentNewOrder.items.forEach((p, idx) => {
        const itemDiv = document.createElement('div');
        itemDiv.className = 'summary-item';
        itemDiv.innerHTML = `<span>${p.nombre}</span><span>${parseFloat(p.precio_x_racion).toFixed(2)}€ <button class="btn-remove" onclick="window.removeItem(${idx})">×</button></span>`;
        list.appendChild(itemDiv);
    });
    const subtotal = state.currentNewOrder.items.reduce((acc, p) => acc + parseFloat(p.precio_x_racion), 0);
    const tax = subtotal * 0.21;
    const deliveryFee = state.currentNewOrder.type === 'delivery' ? 2.50 : 0;
    const total = subtotal + tax + deliveryFee;
    document.getElementById('modal-subtotal').innerText = `${subtotal.toFixed(2)}€`;
    document.getElementById('modal-tax').innerText = `${tax.toFixed(2)}€`;
    document.getElementById('modal-total').innerText = `${total.toFixed(2)}€`;
}
window.removeItem = (idx) => { state.currentNewOrder.items.splice(idx, 1); updateSummary(); };

async function submitOrder() {
    console.log('--- Order Submission Started ---');
    const o = state.currentNewOrder;
    if (!o.clientId || o.items.length === 0) return showToast('Check client and items', 'error');

    const btn = document.getElementById('submit-order-btn');
    btn.disabled = true;
    btn.innerText = 'Creating...';

    try {
        const subtotal = o.items.reduce((acc, p) => acc + parseFloat(p.precio_x_racion), 0);
        const total = (subtotal * 1.21) + (o.type === 'delivery' ? 2.50 : 0);
        let orderId = o.id;

        if (orderId) {
            console.log('Step: Updating Existing Order...');
            await fetch(`${API_BASE}/pedidos/${orderId}`, {
                method: 'PUT',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ 
                    total, 
                    subtotal, 
                    cliente_id: parseInt(o.clientId), 
                    'esadomicilio?': o.type === 'delivery' ? 1 : 0 
                })
            });
        } else {
            console.log('Step 1: Creating Order Header...');
            const addrEl = document.getElementById('address-select');
            const addrVal = addrEl ? addrEl.value : null;
            
            const body = {
                total, subtotal,
                cliente_id: parseInt(o.clientId),
                empleado_id: state.currentUser ? state.currentUser.id : 1,
                'esadomicilio?': o.type === 'delivery' ? 1 : 0,
                direccion_id: (o.type === 'delivery' && addrVal) ? parseInt(addrVal) : null
            };
            console.log('Payload:', body);

            const orderResp = await fetch(`${API_BASE}/pedidos`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(body)
            });

            if (!orderResp.ok) throw new Error(`Order Header Error: ${orderResp.status}`);
            const newOrder = await orderResp.json();
            orderId = newOrder.id;
            console.log('Success: Order ID created:', orderId);

            console.log('Step 2: Adding Items...');
            const grouped = o.items.reduce((acc, item) => {
                const k = item.id;
                if (!acc[k]) acc[k] = { ...item, cantidad: 0 };
                acc[k].cantidad += 1;
                return acc;
            }, {});

            for (const k in grouped) {
                const item = grouped[k];
                console.log(`Adding item ${item.nombre} (x${item.cantidad})...`);
                const res = await fetch(`${API_BASE}/platos_pedidos`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({
                        pedido_id: orderId,
                        plato_id: item.id,
                        'media o completa?': 'completa',
                        cantidad: item.cantidad,
                        'precio unitario': item.precio_x_racion
                    })
                });
                if (!res.ok) console.warn(`Item ${k} failed: ${res.status}`);
            }
        }
        showToast('Order confirmed!', 'success');
        closeModal();
        await loadDashboard();
    } catch (err) {
        console.error('Submit Error:', err);
        showToast(`Failure: ${err.message}`, 'error');
    } finally {
        btn.disabled = false;
        btn.innerText = 'Confirm Order';
    }
}

function switchToScreen(screenId) {
    Object.values(screens).forEach(s => s.classList.remove('active'));
    screens[screenId].classList.add('active');
}
