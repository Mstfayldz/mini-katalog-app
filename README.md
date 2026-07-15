# Mini Katalog Uygulaması

Flutter ile geliştirilmiş modern bir e-ticaret katalog uygulaması.

## Özellikler

- DummyJSON API'den gerçek zamanlı ürün listeleme
- Anlık ürün arama
- Ürün detay sayfası (açıklama, rating, stok bilgisi)
- Sepete ürün ekleme ve çıkarma
- Sepet verisi local storage ile saklanır (uygulama kapansa bile kaybolmaz)
- Checkout simülasyonu

## Ekran Görüntüleri

| Ana Sayfa                          | Detay Sayfası                    | Sepet                          | Siparis                              |
| ---------------------------------- | -------------------------------- | ------------------------------ | ------------------------------------ |
| ![Ana Sayfa](screenshots/home.png) | ![Detay](screenshots/detail.png) | ![Sepet](screenshots/cart.png) | ![Siparis](screenshots/checkout.png) |

## Kullanılan Teknolojiler

- Flutter 3.44.4
- Dart
- http paketi (REST API istekleri)
- shared_preferences paketi (local storage)

## Proje Yapısı

lib/
├── models/
│ └── product.dart
├── screens/
│ ├── home_screen.dart
│ ├── detail_screen.dart
│ └── cart_screen.dart
├── services/
│ ├── api_service.dart
│ └── local_storage_service.dart
├── widgets/
│ └── product_card.dart
└── main.dart

## Kurulum ve Çalıştırma

1. Repoyu klonla:

```bash
git clone https://github.com/KULLANICI_ADIN/mini-katalog-app.git
```

2. Proje klasörüne gir:

```bash
cd mini-katalog-app
```

3. Bağımlılıkları yükle:

```bash
flutter pub get
```

4. Uygulamayı çalıştır:

```bash
flutter run
```

## Gereksinimler

- Flutter SDK >= 3.44.4
- Android SDK (emulator veya fiziksel cihaz)
- Internet bağlantısı (API verileri için)

## API

Bu proje DummyJSON (https://dummyjson.com) API'sini kullanmaktadır. Gerçek bir e-ticaret altyapısını temsil etmez, eğitim amaçlıdır.

## Geliştirici

Mustafa AYYILDIZ - Yazılım Geliştirme Egitimi
Software Persona

## Detayli Kurulum Rehberi

### 1. Flutter SDK Kurulumu

1. https://flutter.dev/docs/get-started/install adresine git
2. Windows icin Flutter SDK'yi indir
3. Indirilen zip dosyasini `C:\src\flutter` klasorune cikart
4. Ortam degiskenlerine `C:\src\flutter\bin` yolunu ekle
5. Terminalde `flutter doctor` yazarak kurulumu dogrula

### 2. Android Studio Kurulumu

1. https://developer.android.com/studio adresinden indir ve kur
2. Android Studio'yu ac, SDK Manager'dan Android SDK'yi yukle
3. Lisanslari kabul et: terminalde `flutter doctor --android-licenses` calistir
4. Virtual Device Manager'dan yeni bir emulator olustur (Pixel 9, API 36 onerilir)

### 3. Visual Studio Code Kurulumu

1. https://code.visualstudio.com adresinden indir ve kur
2. Eklentiler sekmesinden Flutter ve Dart eklentilerini yukle

### 4. Projeyi Calistirma

1. Repoyu klonla:

```bash
git clone https://github.com/KULLANICI_ADIN/mini-katalog-app.git
```

2. Proje klasorune gir:

```bash
cd mini-katalog-app
```

3. Bagimlilikları yukle:

```bash
flutter pub get
```

4. Emulatorü baslat (Android Studio > Device Manager > Play butonu)

5. Uygulamayi calistir:

```bash
flutter run
```

### Notlar

- Internet baglantisi zorunludur (DummyJSON API icin)
- Emulator yerine fiziksel Android telefon da kullanilabilir (USB hata ayiklama acik olmali)
- Minimum Flutter surumu 3.0.0 olmalidir
