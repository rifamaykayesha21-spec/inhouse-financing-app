document.addEventListener('DOMContentLoaded', () => {
    fetchJadwalAngsuran();
    const formPembayaran = document.getElementById('form-pembayaran');
    formPembayaran.addEventListener('submit', handlePembayaran);
});

function formatRupiah(number) {
    return new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR' }).format(number);
}

async function fetchJadwalAngsuran() {
    const tableBody = document.getElementById('tabel-angsuran-body');
    try {
        const { data, error } = await supabaseClient
            .from('jadwal_angsuran')
            .select('*')
            .order('tgl_jatuh_tempo', { ascending: true });

        if (error) throw error;

        if (data.length === 0) {
            tableBody.innerHTML = '<tr><td colspan="7" class="text-center">Belum ada data jadwal angsuran.</td></tr>';
            return;
        }

        tableBody.innerHTML = data.map(item => `
            <tr>
                <td><code>${item.kontrak_id}</code></td>
                <td>${item.angsuran_ke}</td>
                <td>${item.tgl_jatuh_tempo}</td>
                <td>${formatRupiah(item.jumlah_pokok)}</td>
                <td>${formatRupiah(item.jumlah_bunga)}</td>
                <td>${formatRupiah(item.total_tagihan)}</td>
                <td>
                    <span class="badge ${item.status_bayar === 'LUNAS' ? 'badge-lunas' : 'badge-belum'}">
                        ${item.status_bayar}
                    </span>
                </td>
            </tr>
        `).join('');
    } catch (err) {
        console.error('Error fetching data:', err.message);
        tableBody.innerHTML = `<tr><td colspan="7" class="text-center">Gagal memuat data: ${err.message}</td></tr>`;
    }
}

async function handlePembayaran(event) {
    event.preventDefault();
    const jadwalId = document.getElementById('jadwal_id').value;
    const nomorKwitansi = document.getElementById('nomor_kwitansi').value;
    const jumlahDibayar = document.getElementById('jumlah_dibayar').value;

    try {
        const { error } = await supabaseClient
            .from('pembayaran')
            .insert([
                { 
                    jadwal_id: jadwalId, 
                    nomor_kwitansi: nomorKwitansi, 
                    jumlah_dibayar: parseFloat(jumlahDibayar) 
                }
            ]);

        if (error) throw error;

        alert('Pembayaran berhasil dicatat!');
        document.getElementById('form-pembayaran').reset();
        fetchJadwalAngsuran();
    } catch (err) {
        console.error('Error insert pembayaran:', err.message);
        alert('Gagal mencatat pembayaran: ' + err.message);
    }
}