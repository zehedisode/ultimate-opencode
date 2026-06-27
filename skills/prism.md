---
name: prism
description: "🧠 PRISM — Kişisel AI Evrim Sistemi. Her seansta seni daha iyi tanır, kod stilini öğrenir, hatalarını hatırlar ve giderek SANA özel bir asistan olur."
---

# 🧠 PRISM — Personal Reflective Intelligence & Self-Learning Memory

**Her seansta daha akıllı hale gelen tek AI asistan.**

Diğer tüm skill'ler statiktir — ne okuduysan odur. PRISM ise **dinamiktir**: her oturumda senin kod stilini, tercihlerini, hatalarını ve mimari kararlarını öğrenir. 10 seans sonra seni herkesten daha iyi tanıyan bir asistana dönüşür.

## Nasıl Çalışır?

```
PRISM Döngüsü:
  1. Oku    → ~/.opencode/prism/ içindeki profilini yükle
  2. Uygula → Öğrendiği tercihlerine göre cevap ver
  3. Gözlem → Seans boyunca verdiğin kararları, düzeltmeleri not et
  4. Öğren  → Seans sonunda profili güncelle
  5. Geliş  → Bir sonraki seansta DAHA İYİ ol
```

## PRISM'in Öğrendikleri

| Ne Öğrenir | Nasıl Kullanır |
|---|---|
| Kod stilin (camelCase/snake_case, spacing) | Yeni kodları senin tarzında yazar |
| Sık yaptığın hatalar | Aynı hatayı tekrar yapmanı engeller |
| Mimari tercihlerin | Önerilerini senin tarzına göre şekillendirir |
| Proje terminolojin | Doğru terimleri kullanır |
| İletişim tarzın | Sana uygun detay seviyesinde cevap verir |

## Kullanım Talimatı

### Her Seans Başlangıcında (Otomatik):
1. `~/.opencode/prism/profile.md` dosyasını oku
2. Profildeki tercihlere göre yanıt stilini ayarla
3. Daha önce yapılmış hataları hatırla, tekrarlama

### Her Seans Sonunda (Otomatik):
1. Bu seansta öğrenilen yeni şeyleri özetle
2. `profile.md`'yi güncelle
3. Yeni keşifleri `lessons.md`'ye ekle

### İlk Kurulum (Manuel):
```bash
# Prism'i başlat
mkdir -p ~/.opencode/prism
cp prism/profile.md ~/.opencode/prism/
```

## PRISM Git İzleme

PRISM ayrıca git commit geçmişini tarar ve:
- En çok hangi dosyaları değiştirdiğini
- Hangi commit mesajı stilini kullandığını  
- Hangi branch stratejisini tercih ettiğini
- Hangi hataların tekrarladığını

öğrenir ve buna göre davranır.

## Neden Benzersiz?

| Diğer Skill'ler | PRISM |
|---|---|
| Herkes için aynı | Sana özel evrilir |
| Statik, değişmez | Her seans güncellenir |
| Geçmişi unutur | Her şeyi hatırlar |
| Genel öneri verir | Senin tarzına uygun öneri verir |
| Hataları tekrarlar | Hatalardan ders alır |
