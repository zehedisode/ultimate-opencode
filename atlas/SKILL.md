---
name: atlas
description: "🌍 ATLAS — Proje Bilinç Sistemi. 7 modül: proje zekası, kalite kontrol, metrikler, dökümantasyon, takım, raporlar, regresyon. AI ajanına tam proje bilinci kazandırır."
---

# 🌍 ATLAS — Project Intelligence System

**Tek bir AI ajanını tüm projenin beynine dönüştürür.**

ATLAS, projeni baştan aşağı anlayan, her değişikliğin etkisini ölçen, kaliteyi garanti eden, dokümantasyonu canlı tutan ve takım koordinasyonunu sağlayan **tek sistemdir.**

## 🏗️ 7 Modül

```
ATLAS/
├── core/       → Proje Bilinci (yapı, bağımlılıklar, kararlar)
├── quality/    → Kalite Kontrol (standartlar, review, regresyon)
├── metrics/    → Analitik (token, maliyet, performans, ısı haritası)
├── docs/       → Dökümantasyon (API, mimari, README)
├── team/       → Takım (ajan koordinasyonu, senkronizasyon)
└── reports/    → Raporlar (weekly, insights)
```

## 🔄 Kullanım Akışı

### Her Seans Başında (5 saniye):
```
1. core/project.md → projeyi tanı
2. quality/regression.md → geçmiş hataları kontrol et
3. metrics/performance.md → son durumu gör
```

### Kod Yazarken (Otomatik):
```
1. Değişiklikleri core/changelog.md'ye kaydet
2. Quality gates'i otomatik uygula
3. Etki analizi yap → quality/regression.md'ye yaz
4. Metrikleri güncelle
```

### Her Seans Sonunda (10 saniye):
```
1. Yapılanları core/decisions.md'ye ekle
2. Dokümantasyonu güncelle
3. Metrikleri kaydet
4. insights raporu oluştur
```

## 📋 Detaylı Modül Kılavuzu

### 1️⃣ core/ — Proje Bilinci
Projenin tam haritasını çıkarır ve canlı tutar.

```markdown
📄 project.md
  - Proje adı, dil, framework
  - Klasör yapısı ve sorumluluklar
  - Bağımlılık ağacı
  - Ortam değişkenleri ve konfigürasyon
  
📄 decisions.md  
  - Tüm mimari kararlar (ADR)
  - Neden-sonuç ilişkisi
  - Alternatifler ve gerekçeler
  
📄 changelog.md
  - Her değişikliğin kaydı
  - Değişiklik → etkilenen dosya eşlemesi
  - Rollback noktaları
```

### 2️⃣ quality/ — Kalite Kontrol
Her değişikliği otomatik denetler.

```markdown
📄 standards.md
  - Kod standartları
  - İsimlendirme kuralları
  - Test gereksinimleri
  - Performans eşikleri

📄 review-checklist.md  
  - Code review kontrol listesi
  - Her değişiklik için otomatik doldurulur
  - Security scan
  - Performance check

📄 regression.md
  - Geçmiş bug'ların kaydı
  - Her bug için: belirti, çözüm, test
  - Yeni kod aynı hatayı yaparsa UYARI
  - "Bu kod daha önce X hatasına sebep olmuştu"
```

### 3️⃣ metrics/ — Analitik
Her şeyi ölç, hiçbir şeyi kaçırma.

```markdown
📄 costs.md
  - Token tüketimi (günlük/haftalık/aylık)
  - Tahmini maliyet (USD)
  - En pahalı işlemler
  - Tasarruf önerileri

📄 performance.md
  - İşlem başına süre
  - En yavaş tool'lar
  - Context kullanım oranı
  - Optimizasyon fırsatları

📄 heatmap.md
  - En çok değişen dosyalar
  - En çok bug çıkan modüller
  - Karmaşıklık trendi
  - Tech debt göstergeleri
```

### 4️⃣ docs/ — Yaşayan Dökümantasyon
Kendini güncelleyen dokümanlar.

```markdown
📄 api.md
  - Tüm API endpoint'leri
  - Request/response örnekleri
  - Otomatik güncellenir

📄 architecture.md  
  - Proje mimarisi (C4 model)
  - Veri akış diyagramları
  - Deployment şeması

📄 README.md
  - Kurulum, kullanım, katkı
  - Otomatik güncellenen badge'ler
```

### 5️⃣ team/ — Takım Koordinasyonu
Birden fazla ajan birlikte çalışsın.

```markdown
📄 agents.md
  - Hangi ajan ne yapıyor
  - Görev dağılımı
  - Bekleyen işler

📄 sync.md
  - Oturumlar arası senkronizasyon
  - Çakışma önleme
  - Ortak context
```

### 6️⃣ reports/ — Raporlar
Projenin nabzını tut.

```markdown
📄 weekly.md
  - Bu hafta yapılanlar
  - Metrik özeti
  - Riskler ve öneriler
  - Gelecek hafta planı

📄 insights.md
  - Trend analizi
  - Teknik borç uyarıları
  - Performans iyileştirmeleri
  - Mimari değişiklik önerileri
```

## 💥 ATLAS vs Her Şey

| Özellik | ATLAS | Diğer Sistemler |
|---|---|---|
| Proje bilinci | Tam (yapı + kararlar + geçmiş) | Yok |
| Kalite kontrol | Otomatik, her değişiklikte | Manuel |
| Regresyon engelleme | Geçmiş bug'ları hatırlar | Hiçbiri |
| Metrik takibi | Token, süre, maliyet | Yok |
| Yaşayan doküman | Otomatik güncellenir | Statik |
| Takım koordinasyonu | Çoklu ajan desteği | Tek ajan |
| Raporlama | Haftalık + insight | Yok |
| Etki analizi | "X değişirse Y etkilenir" | Yok |

## 🚀 Başlatma

```bash
atlas/init.sh
```

Bu komut:
- `atlas/core/` içindeki tüm dosyaları `~/.opencode/atlas/`'a kopyalar
- Proje bilincini başlatır
- Kalite şablonlarını kurar

---

> **ATLAS, AI çağında proje yönetiminin yeni standardıdır.**
