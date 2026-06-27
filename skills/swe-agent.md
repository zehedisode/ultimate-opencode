---
name: swe-agent
description: "AI framework / agent harness — Software Engineering Agent: GitHub issue'larını otomatik çözen AI 12982⭐"
---

# SWE-Agent

GitHub issue'larını otomatik olarak okuyan, anlayan ve çözen AI yazılım mühendisi ajanı.

## Ne İşe Yarar

- GitHub issue'larını otomatik çöz
- Kod tabanını anla ve düzenle
- Test yaz ve çalıştır
- PR oluştur

## Kullanım

```bash
swe-agent run "https://github.com/org/repo/issues/42"
swe-agent run --repo ./ --issue "Add dark mode"
swe-agent review ./changes.diff
```

## Mimarisi

1. Issue'yu oku ve anla
2. Kod tabanını keşfet
3. Değişiklik planı yap
4. Kodu düzenle
5. Testleri çalıştır
6. PR oluştur

## Özellikler

- 12K+ GitHub issue'da test edilmiş
- SWE-bench'te %30+ başarı
- Çoklu dil desteği
- Docker sandbox'ında güvenli çalıştırma
