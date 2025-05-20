# Resepin 🍲

**Resepin** adalah aplikasi pencatat resep masakan pribadi berbasis iOS yang dibangun menggunakan Swift dan SwiftUI. Aplikasi ini dirancang untuk memudahkan pengguna menyimpan, mengelola, dan melihat resep-resep masakan.

Aplikasi ini terintegrasi penuh dengan Firebase, mencakup autentikasi, penyimpanan data, dan unggahan gambar.

---

## ✨ Fitur Utama

- 🔐 **Register & Login**  
  Autentikasi pengguna menggunakan email dan password dengan Firebase Authentication.

- 📋 **List Resep Masakan**  
  Menampilkan daftar semua resep yang dimiliki pengguna.

- ➕ **Tambah Resep Baru**  
  Pengguna dapat membuat resep baru lengkap dengan judul, deskripsi, bahan, langkah-langkah, dan gambar.

- 📄 **Detail Resep**  
  Menampilkan informasi lengkap tentang resep tertentu.

---

## 🔧 Teknologi yang Digunakan

- **Swift & SwiftUI** – Framework utama untuk membangun UI aplikasi
- **Firebase Authentication** – Autentikasi pengguna (email/password)
- **Firebase Firestore** – Menyimpan data resep secara real-time
- **Firebase Storage** – Menyimpan gambar resep
- **Combine & MVVM Architecture** – Untuk alur data yang reaktif dan arsitektur terstruktur

---

## 🚀 Cara Menjalankan Proyek

### 1. Clone Repository
```bash
git clone https://github.com/username/resepin.git
cd resepin
```

### 2. Masukan GoogleService-Info
Silahkan masukan file GoogleService-Info.plist yang anda miliki dari akun firebase kedalam project ini dan jalankan kode ini dengan simulator maupun preview.
