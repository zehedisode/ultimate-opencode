# Test Suite

## Gereksinimler

```bash
# BATs yükle
npm install -g bats
# veya
brew install bats-core
```

## Çalıştırma

```bash
cd ultimate-opencode
bats tests/test_basics.bats
```

## Testler

| Test | Açıklama |
|---|---|
| install.sh syntax | Bash syntax validasyonu |
| uninstall.sh syntax | Bash syntax validasyonu |
| verify.sh syntax | Bash syntax validasyonu |
| All scripts syntax | Tüm script'lerde bash -n |
| Skill frontmatter | Tüm skill'lerde YAML --- var mı |
| Agent fields | Tüm agent'larda 4 alan (name, subagent_type, model, tools, color) |
| Council count | 18 council agent |
| No 404 | skills/agents/commands'de 404 içerik yok |
| README count | README'deki sayı gerçek sayıyla eşleşiyor |
| Council refs | SKILL.md referansları gerçek dosyalarla eşleşiyor |
| JSON valid | config/opencode.json geçerli JSON |
