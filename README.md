# Zásoby – obsah (návody a oznámení)

Tenhle repozitář je **zdroj obsahu pro aplikaci Zásoby**. Appka si ho stahuje při spuštění
a při obnovení (potažení dolů). Cokoli tady změníš a uložíš, uvidí všichni uživatelé
**do pár minut, bez aktualizace aplikace a bez schvalování Applem.**

Vše jde upravovat přímo na GitHubu v prohlížeči (tužka u souboru → upravit → Commit).

## Struktura

```
index.json          seznam kategorií a článků
oznameni.json       oznámení (vyskočí uživatelům jako novinka)
clanky/*.md         texty článků (Markdown)
obrazky/*.png|jpg   obrázky k článkům
```

## Jak přidat článek

1. Napiš soubor `clanky/nazev-clanku.md` (viz formát níže).
2. Nahraj obrázek do `obrazky/` (ideálně 1200×675, JPG nebo PNG, do 300 kB).
3. Do `index.json` přidej záznam do `articles`:

```json
{
  "id": "nazev-clanku",
  "title": "Název článku",
  "summary": "Jedna dvě věty, co se čtenář dozví.",
  "category": "zaciname",
  "image": "obrazky/nazev-clanku.png",
  "date": "2026-10-27",
  "file": "clanky/nazev-clanku.md",
  "tags": ["spíž", "rotace"]
}
```

`category` musí odpovídat `id` některé kategorie v `categories`. Články se řadí podle `date` (nejnovější první).

## Formát článku (Markdown)

```markdown
# Nadpis
Běžný odstavec. **Tučně**, *kurzíva*, [odkaz](https://example.cz).

## Podnadpis
- odrážka
- další odrážka

1. číslovaný krok
2. další krok

![Popisek obrázku](obrazky/foto.jpg)

@video https://www.youtube.com/watch?v=XXXXXXXXXXX

> Citace nebo zvýrazněná poznámka.

---

:::nakup
- Rýže basmati 1 kg | 2 ks
- Tuňák v oleji | 6 ks
- Voda balená 1,5 l | 12 ks
:::
```

- `@video` – YouTube odkaz se v appce přehraje přímo v článku.
- `:::nakup … :::` – blok nákupního seznamu: uživatel si položky zaškrtne a jedním klepnutím
  je přidá do svého nákupního seznamu v appce. Formát řádku: `- Název | množství jednotka`
  (množství je nepovinné, výchozí 1 ks).
- Obrázky zadávej relativní cestou (`obrazky/...`) nebo plnou URL.

## Jak poslat oznámení všem uživatelům

Do `oznameni.json` přidej na začátek pole nový záznam:

```json
{
  "id": "2026-10-27-sleva-lidl",
  "title": "Sleva na konzervy v Lidlu",
  "text": "Do neděle jsou konzervy tuňáka za 19 Kč. Dobrá příležitost doplnit zásobu.",
  "date": "2026-10-27",
  "url": "https://www.lidl.cz/letak",
  "urlTitle": "Otevřít leták",
  "validUntil": "2026-11-02",
  "important": false
}
```

- `id` musí být unikátní (uživateli vyskočí každé `id` jen jednou).
- `validUntil` je nepovinné – po tomto datu se oznámení už nezobrazuje.
- `important: true` zvýrazní oznámení červeně.
- `url` je nepovinný odkaz pod oznámením; `urlTitle` je popisek tlačítka (výchozí „Otevřít odkaz“).
- Odkazy jdou dát i **přímo do textu**: `[Leták Lidl](https://www.lidl.cz/letak)` nebo jen holá
  adresa `https://www.lidl.cz` – obojí je v appce klikací. Uvozovky v textu se v JSON zapisují jako `\"`.
- Uživatel vidí nové oznámení v okně při otevření appky, pak na hlavní straně záložky *Připraven*,
  dokud ho neoznačí jako přečtené. Ve „Všechny“ zůstává do data `validUntil`.
- Uživatelům s aplikací na pozadí přijde lokální upozornění při nejbližší kontrole (iOS ji
  spouští zhruba jednou za několik hodin, podle používání telefonu).

## Kontrola

Před uložením zkontroluj, že je JSON platný (např. https://jsonlint.com). Rozbitý JSON appka
ignoruje a zůstane u poslední funkční verze.
