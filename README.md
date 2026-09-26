<div align="center">

# LRC System — Library Loan & Inventory Management

**Single-file, offline, bilingual (Arabic / English) library system for school Learning Resource Centers.**

[![Version](https://img.shields.io/badge/version-v0.9.2-blue)](#)
[![Runs offline](https://img.shields.io/badge/runs-offline%20%7C%20no%20install-success)](#)
[![Browser](https://img.shields.io/badge/browser-Chrome%20%7C%20Edge-informational)](#)
[![Database](https://img.shields.io/badge/database-SQLite%20(sql.js)-lightgrey)](#)

**Language / اللغة:** English · [العربية](README.ar.md)

![Dashboard](screenshots/dashboard.png)

</div>

---

## Two editions — pick one file

| File | For | Arabic wording | Launcher | Sample data |
|---|---|---|---|---|
| **`LRC_System.html`** | Boys' schools (default) | طلاب / معلمون | `START_LRC.bat` | `samples/` |
| **`LRC_System_F.html`** | Girls' schools | طالبات / معلمات | `START_LRC_F.bat` | `samples_F/` |

Both editions are identical in features, screens and database format — only the Arabic
wording differs (the English interface is the same). Use one file per school; the edition name
is printed at the bottom of every page.

## What it is

`LRC_System.html` is the whole application in **one HTML file** (~2.3 MB). It combines the previous
loan-management web app and the barcode inventory tool. There is no server, no installation and no
internet connection needed — double-click the file and it opens in Chrome or Edge.

## Quick start

1. Download this repository (green **Code ▸ Download ZIP** button, or `git clone`) and extract it anywhere on the PC — or copy just the HTML file of your edition.
2. Double-click **`START_LRC.bat`** (boys) or **`START_LRC_F.bat`** (girls), or open the HTML file directly in Google Chrome / Microsoft Edge.
3. Click **Choose folder** in the blue banner and pick your **Documents** folder.
   The database and all backups are then written there automatically (see below).
4. Import the students and books lists from CSV (Import/Export page) — or restore a previous
   `lrc_library.db` file.

## Features

| Area | Details |
|---|---|
| **Loans by barcode** | Lend by the book's general number with a barcode reader. Leading zeros are ignored (`00045` = `45`). |
| **Warnings, not blocks** | A student with unreturned books gets a visible warning; more than 3 books in one day triggers a warning — lending is still allowed in both cases. |
| **Returns** | Scan the book barcode (instant return with undo) or search by student name and return selected / all. |
| **Members** | Add, edit or delete students and teachers manually at any time, or import from CSV. |
| **Teacher loans** | Separate register for teachers and events, with its own active list. |
| **Reports** | Date range from / to; for everyone, per class / section, or per student; CSV export and print. |
| **Inventory** | Annual barcode inventory with multi-copy books, damaged and out-of-list books, progress, resume, and full reports/exports. |
| **Search & analytics** | Universal search; monthly trends, top borrowers, popular titles, loans by class, overdue analysis. |
| **Bilingual** | Arabic (RTL, default) and English, switchable from the menu. |
| **Dark mode** | Moon/sun button in the menu; follows the Windows dark setting by default and remembers your choice. Printing always uses light colours. |

## Where your data lives

| Location | When | What |
|---|---|---|
| Browser storage (IndexedDB) | always | A copy of the SQLite database, saved after every change. |
| `Documents\LRC_Library\lrc_library.db` | after you choose a folder | The database file, rewritten after every change. |
| `Documents\LRC_Library\backups\lrc_backup_<date>_<reason>.db` | automatic | Every 50 save operations, once a day on first launch, before any restore or reset, and on demand. Old backups are pruned (default: keep 40). |
| `Documents\LRC_Library\backups\csv_<date>\` | on demand ("Full backup") | students, books, teachers, loans, teacher loans and inventory as CSV. |

- On start the app compares the browser copy with the folder file; the **newer one wins** and the other is kept as a backup.
- On later launches the browser may ask for a one-click **Reconnect**.
- Without a folder, automatic backups fall back to browser downloads.
- One active PC per data folder at a time. Both editions use the same database format, so a folder created by one edition opens in the other.

## Importing CSV files from Excel (Arabic text)

Excel on Arabic Windows saves *CSV (Comma delimited)* as **Windows-1256** and *Unicode Text* as
**UTF-16 with tabs**. The import page:

- detects the encoding (UTF-8, UTF-16, Windows-1256, ISO-8859-6) and the delimiter (`,` `;` or tab),
- shows a **preview of the first 5 rows** so you can confirm the Arabic is correct before importing,
- lets you override the encoding manually,
- can **update existing records** (tick the box) to repair names or titles that were imported garbled earlier.

Required columns: students `stNumber, stName, stClass, stSec` — books `Gnumber, BookTitle` plus optional `CNumber`
(a repeated number inside the file means an extra physical copy).

### Sample data

| File | Content |
|---|---|
| `samples/students_sample.csv` | 24 students with Omani names (boys' edition) in classes **4/1, 4/2, 5/1, 5/2, 6/1, 6/2**. Enter the grade in `stClass` and the section in `stSec` (`4` and `1`); the app shows it as **4 / 1**. |
| `samples_F/students_sample.csv` | The same structure with Omani girls' names, for the girls' edition. |
| `samples/books_sample.csv`, `samples_F/books_sample.csv` | 40 Omani titles (novels, history, heritage, children's books) with Dewey `CNumber` values. Number `1` appears twice, so it imports as one title with two copies. |

Use them to try the app, then import your own lists with the same column names.

## Classification numbers (CNumber) and categories

Books can carry a Dewey classification number in an optional **`CNumber`** column. If the column is
missing, books import normally without it (no warning). Accepted forms: `892.73`, `892,73` (decimal comma,
quoted or not) and plain `892`. The first three digits decide the category:

| Range | Category |
|---|---|
| 000-099 | Generalities — المعارف العامة (علم الحاسبات، المعلومات والأعمال العامّة) |
| 100-199 | Philosophy & psychology — الفلسفة وعلم النفس |
| 200-299 | Religions — الديانات |
| 300-399 | Social sciences — العلوم الاجتماعية |
| 400-499 | Languages — اللّغات |
| 500-599 | Pure sciences (incl. mathematics) — العلوم البحتة |
| 600-699 | Applied sciences (technology) — العلوم التطبيقية |
| 700-799 | Fine arts, recreation & decoration — الفنون والاستجمام والديكور |
| 800-899 | Literatures — الآداب |
| 900-999 | History, geography & biography — التاريخ، الجغرافيا والتراجم |

Where categories appear: the **Reports** page has a category filter and a "By category" tab (loans, share,
distinct titles, unreturned, overdue per category), **Analytics** has "Loans by category" and "Collection by
category" charts, the **Dashboard** lists the most borrowed categories, **Search** and the loan/inventory scan
panels show the number and category, and inventory exports include the `CNumber` column. Re-importing a book
list that now has `CNumber` fills in the numbers for existing books without touching anything else.

## Browser support

Google Chrome or Microsoft Edge (current versions) are recommended: they support saving directly into
the Documents folder. Other browsers run the app but only keep data in browser storage and download backups.

## Security

- Hash-based Content-Security-Policy: only the embedded scripts can run, no network access at all.
- All output is HTML-escaped; all database access uses bound parameters; CSV exports neutralise formula injection.
- Static analysis (Semgrep, 328 rules) and dynamic testing (Playwright/Chromium, 150+ automated checks per edition
  including XSS, CSP, SQL/CSV injection and backup scenarios) are documented in the project's `security/` folder.

## Credits

Built with [Bootstrap](https://getbootstrap.com/) 5.3, [Bootstrap Icons](https://icons.getbootstrap.com/) 1.13,
[Chart.js](https://www.chartjs.org/) 4.5 and [sql.js](https://sql.js.org/) 1.13 (SQLite compiled to WebAssembly) — all MIT licensed.
