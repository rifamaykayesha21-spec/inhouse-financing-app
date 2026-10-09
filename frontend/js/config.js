// Konfigurasi Supabase Client via CDN
const SUPABASE_URL = 'https://bbaocuunjzaugpwrtybx.supabase.co';
const SUPABASE_PUBLISHABLE_KEY = 'sb_publishable_r5B6d7SuyTtd-PQaGFY4kQ_ie9elWph';

// Inisialisasi client global
const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY);