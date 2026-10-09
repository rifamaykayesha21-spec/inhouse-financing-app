-- 1. Insert Pelanggan
INSERT INTO pelanggan (id, nama, nik, telepon)
VALUES ('a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 'Budi Santoso', '3374012345670001', '081234567890');

-- 2. Insert Rumah
INSERT INTO rumah (id, nomor_unit, tipe, harga_jual, status)
VALUES ('b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 'A-12', 'Type 45', 300000000, 'TERJUAL');

-- 3. Insert Kontrak Penjualan
INSERT INTO kontrak_penjualan (id, nomor_kontrak, pelanggan_id, rumah_id, tanggal_kontrak, harga_total, uang_muka, sisa_piutang, tenor_bulan, status)
VALUES (
    'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 
    'KTRK-2026-001', 
    'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11', 
    'b0eebc99-9c0b-4ef8-bb6d-6bb9bd380a22', 
    '2026-10-01', 
    300000000, 
    50000000, 
    250000000, 
    24, 
    'AKTIF'
);

-- 4. Insert Jadwal Angsuran (Gunakan ID ini untuk tes pembayaran)
INSERT INTO jadwal_angsuran (id, kontrak_id, angsuran_ke, tgl_jatuh_tempo, jumlah_pokok, jumlah_bunga, total_tagihan, status_bayar)
VALUES (
    'd0eebc99-9c0b-4ef8-bb6d-6bb9bd380a44', 
    'c0eebc99-9c0b-4ef8-bb6d-6bb9bd380a33', 
    1, 
    '2026-11-01', 
    10000000, 
    416666, 
    10416666, 
    'BELUM'
);