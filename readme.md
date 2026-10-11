# 🏢 Sistem Akuntansi Piutang Properti (In-House Financing)

UTS Mata Kuliah Pengkodean dan Pemrograman - S1 Akuntansi

Aplikasi berbasis web sederhana untuk mengelola dan mencatat transaksi piutang penjualan rumah dengan skema pembayaran *in-house financing* (angsuran langsung ke pengembang/developer).

---

## 🌟 Fitur Utama

- **Buku Besar Pembantu Piutang (Subsidiary Ledger):** Menampilkan daftar jadwal angsuran pelanggan beserta alokasi pembayaran pokok, bunga, total tagihan, dan status pelunasan.
- **Pencatatan Pembayaran Angsuran:** Form input transaksi pembayaran angsuran dengan nomor kwitansi otomatis dan jumlah bayar yang fleksibel.
- **Otomasi Status Pelunasan:** Menggunakan database trigger PostgreSQL untuk secara otomatis memperbarui status tagihan pada `jadwal_angsuran` menjadi **LUNAS** ketika transaksi pembayaran diinput.
- **Integrasi Real-time:** Terhubung langsung ke Supabase backend database via Supabase JS Client (CDN).

---

## 🛠️ Stack Teknologi

- **Frontend:** Vanilla HTML5, CSS3, JavaScript (ES6)
- **Backend / Database:** Supabase (PostgreSQL Database, Stored Procedures, & Triggers)
- **Deployment:** GitHub Pages

---

## 📁 Struktur Folder

```text
inhouse-financing-app/
├── backend/
│   └── schema.sql       # Script DDL, tabel, dan trigger PostgreSQL
├── frontend/
│   ├── index.html       # Tampilan antarmuka utama
│   ├── style.css        # Styling UI
│   ├── config.js        # Konfigurasi Supabase Project URL & Anon Key
│   └── app.js           # Logika aplikasi & integrasi API Supabase
├── .gitignore
└── README.md
