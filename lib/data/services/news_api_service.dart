// import '../../core/constants/api_constants.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/data/services/news_api_exception.dart';

import '../models/article.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// TODO 3: Implementasi NewsApiService
// 1. Install package http: `flutter pub add http`
// 2. Import 'package:http/http.dart' as http;
// 3. Buat fungsi getTopHeadlines(String category) yang memanggil endpoint /v2/top-headlines
// 4. Buat fungsi searchArticles(String query) yang memanggil endpoint /v2/everything
// 5. Tangani error menggunakan NewsApiException

// service tingkat rendah yang berbicara lanngsung dengan NewsAPI.
class NewsApiService {

  /** 
   * dependesi injeksion adalah suatu teknik menyuntikkan/memasukan objek (http.Client) dari luar class, bukan dibuat langsung di dalam class ini.
   * tujuan --> memudahkan testing (uji coba aplikasi) dengan mamasukkan "client tiruan" (mock) tanpa harus tehubung ke internet sungguhan.
   * tanda ?? berarti jika client tidak diisi (null), otomatis akan memakai http.Client() standar bawaan.
   */ 
  NewsApiService({http.Client? client}) : _client = client ?? http.Client();

  // variable privat (diawal tanda _) untuk menyimpan client HTTP yang digunakan untuk berkomunikasi dengan SERVER
  final http.Client _client;

  // untuk mengambil daftar berita utama (top-headlines) berdasarkan kategori negara dan kategori berita (sport dll)
  Future<List<Article>> fetchTopHeadlines(String category) async {
    // Implementasi fetch API di sini
    return _get('/top-headlines', {
      'country': ApiConstants.country,
      'category': category,
    });
  }

// untuk mencari artikel berdasarkan kata kunci (query) diurutkan dari yang paling baru terbit (publishedAt)
  Future<List<Article>> searchArticles(String query) async {
    // Implementasi fetch API di sini
    return _get('/everything', {
      'q': query,
      'sortBy': 'publishedAt',
      'language': ApiConstants.language
    });
  }

// helper method: fungsi pembantu (private, diawali _) agar kita tidak menulis ulang kode request HTTP berkali - kali
  Future<List<Article>> _get(String path, Map<String, String> params) async {
    // validasi: cek apakah API Key sudah diisi di file .env agar tidak terjadi kegagalan otentikasi
    final apiKey = ApiConstants.apiKey;
    if (apiKey.isEmpty) {
      // petunjuk teknis hanya untuk developer (console), dan bukan untuk user.
      debugPrint('[Warta] NEWS_API_KEY kosong. Isi API key di file .env');
      throw NewsApiException.serviceUnavailable;
    }

    // membangun URL lengkap: menggabungkan BaseURL (alamat server utama) + path (endpoint tujuan)
    // lalu menyisipkan query parameters (parameter pencarian serta batas jumlah data/pageSize)
    final uri = Uri.parse('${ApiConstants.baseUrl}$path').replace(
      queryParameters: {...params, 'pageSize': '$ApiConstants.pageSize'}
    );

    try{
      // mengirim request GET ke server dengan header 'X-Api-Key' sebagai tiket izin akses,
      // serta batas waktu tunggu (.timeout) agar aplikasi tidak menggantung jika server lambat merespons.
      final response = await _client
          .get(uri, headers: {'X-Api-Key': apiKey})
          .timeout(ApiConstants.timeout);

      // cek status code HTTP: Kode 200 berarti request sukses (OK)
      // jika bukan 200 (misal 401, 429, 500), lempar error khusus sesuai code statusnya
      if (response.statusCode != 200) {
        debugPrint ('[WARTA] HTTP ${response.statusCode}: ${response.body}');
        throw _fromStatusCode(response.statusCode);
      }

      // JSON Decoding: mengubah data mentah berupa teks string dari server menjadi format MAP
      final body = jsonDecode(response.body) as Map<String, dynamic>;

      // mengambil daftar artikel dari key 'articles'. jika tidak ada/null, gunakan list kosong [] sebagai cadangan.    
      final articles = body['articles'] as List<dynamic>? ?? [];
      // Data Mapping: Mengubah setiap data JSON menjadi sebuah objek/properties Articles, lalu menyaring (filter) yang akan di tampilkan pada return output hanyalah data yang valid/lengkap.
      return articles
          .map((json) => Article.fromJson(json as Map<String, dynamic>))
          .where((article) => article.isValid)  
          .toList();
      // throw: meneruskan kembali NewsApiException ke fungsi pemanggil tanpa mengubah jenis errornya
    } on NewsApiException {
      rethrow;
     // socketException: Error koneksi pada level sistem operasi (misal: HP user sedang offline/mode pesawat) 
    } on SocketException {
      throw NewsApiException.offline;
      // ClientException: Error pada koneksi HTTP (misal: DNS agagl menemukan alamat server atau terputus tiba-tiba)
    } on http.ClientException {
      throw NewsApiException.offline;
      // TimeoutException: Batas waktu tunggu habis karena koneksi internet terlalu lambat
    } on TimeoutException {
      throw NewsApiException.slowConnection;
      // Catch: menangkap segala error tak terduga lainnya (fallback) agar aplikasi tidak crash/keluar sendiri (forced closed)
    } catch (error) {
      debugPrint('[Warta] Unexpected error: $error');
      throw NewsApiException.unknown;
    }
  }

  // Switch Expression (fitur pattern matching di Dart 3): cara ringkas mencocokkan code status HTTP dengan error NewsAPIException
  NewsApiException _fromStatusCode(int code) => switch (code) {
    // 401 (unauthorized): API Key salah/tidak ada. 403 (Forbidden): Akses di tolak 
    401 || 403 => NewsApiException.serviceUnavailable,

    // 429 (Too many request): Batas kuota request API harian sudah habis terpakai.
    429 => NewsApiException.tooManyRequests,

    // 500 ke atas (Server Erorr): Terjadi ketika masalah teknis di dalam server NewsAPI
    >= 500 => NewsApiException.serverBusy,

    // Garis bawah (_) adalah wildcard/defauld: menagani code HTTP lainnya yang tidak disebutkan di atas.
    _ => NewsApiException.unknown
  };
}
