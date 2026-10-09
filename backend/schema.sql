-- TABEL PELANGGAN
CREATE TABLE pelanggan (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nama VARCHAR(100) NOT NULL,
    nik VARCHAR(16) UNIQUE NOT NULL,
    telepon VARCHAR(15),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- TABEL RUMAH
CREATE TABLE rumah (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nomor_unit VARCHAR(10) UNIQUE NOT NULL,
    tipe VARCHAR(20) NOT NULL,
    harga_jual NUMERIC(15,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'TERSEDIA' CHECK (status IN ('TERSEDIA', 'TERJUAL'))
);

-- TABEL KONTRAK PENJUALAN
CREATE TABLE kontrak_penjualan (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nomor_kontrak VARCHAR(50) UNIQUE NOT NULL,
    pelanggan_id UUID REFERENCES pelanggan(id) ON DELETE RESTRICT,
    rumah_id UUID REFERENCES rumah(id) ON DELETE RESTRICT,
    tanggal_kontrak DATE NOT NULL,
    harga_total NUMERIC(15,2) NOT NULL,
    uang_muka NUMERIC(15,2) NOT NULL,
    sisa_piutang NUMERIC(15,2) NOT NULL,
    tenor_bulan INT NOT NULL,
    status VARCHAR(20) DEFAULT 'AKTIF' CHECK (status IN ('AKTIF', 'LUNAS', 'MACET')),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- TABEL JADWAL ANGSURAN
CREATE TABLE jadwal_angsuran (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    kontrak_id UUID REFERENCES kontrak_penjualan(id) ON DELETE CASCADE,
    angsuran_ke INT NOT NULL,
    tgl_jatuh_tempo DATE NOT NULL,
    jumlah_pokok NUMERIC(15,2) NOT NULL,
    jumlah_bunga NUMERIC(15,2) DEFAULT 0,
    total_tagihan NUMERIC(15,2) NOT NULL,
    status_bayar VARCHAR(20) DEFAULT 'BELUM' CHECK (status_bayar IN ('BELUM', 'LUNAS'))
);

-- TABEL PEMBAYARAN
CREATE TABLE pembayaran (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    jadwal_id UUID REFERENCES jadwal_angsuran(id) ON DELETE RESTRICT,
    nomor_kwitansi VARCHAR(50) UNIQUE NOT NULL,
    tgl_bayar DATE NOT NULL DEFAULT CURRENT_DATE,
    jumlah_dibayar NUMERIC(15,2) NOT NULL,
    metode_bayar VARCHAR(20) DEFAULT 'TRANSFER',
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- TRIGGER AUTOMATISASI STATUS ANGSURAN
CREATE OR REPLACE FUNCTION update_status_angsuran_func()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE jadwal_angsuran
    SET status_bayar = 'LUNAS'
    WHERE id = NEW.jadwal_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_status_angsuran
AFTER INSERT ON pembayaran
FOR EACH ROW
EXECUTE FUNCTION update_status_angsuran_func();