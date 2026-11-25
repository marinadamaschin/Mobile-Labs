# Laboratorul 3 - Flutter, State Management, JSON și programare asincronă

## Important

Acest pachet conține codul aplicației (`lib/`), configurația (`pubspec.yaml`),
JSON-ul local (`assets/data/app_data.json`) și teste (`test/`). Fiind o arhivă
cu fișiere sursă, folderele de platformă `android/`, `ios/`, `windows/` etc.
se generează pe calculatorul tău cu `flutter create`.

## Instalare (în PowerShell / terminal Android Studio)

1. Intră în directorul rădăcină al repository-ului: `cd C:\Users\user\StudioProjects\Mobile-Labs`
2. Creează un proiect nou:
   `flutter create --project-name lab3_state_management Lab3_StateManagement`
3. Deschide directorul `Lab3_StateManagement` creat.
4. Copiază **conținutul din arhiva de soluție** peste proiectul nou:
   `lib/`, `assets/`, `test/`, `pubspec.yaml`, `analysis_options.yaml`.
5. În terminalul aflat în `Lab3_StateManagement` rulează:
   `flutter pub get`
   `flutter analyze`
   `flutter test`
   `flutter run`

Nu copia doar directorul `src/` din Lab2 fără `main.dart` și `pubspec.yaml`.

## Funcționalități

- Repo încarcă asincron JSON local, prin `AssetBundle.loadString`.
- `MedicalCubit` gestionează Loading/Success/Empty/Error și interacțiunile.
- Căutarea este după nume, specialitate și clinică (fără a ține cont de majuscule).
- Butoanele Tooth/Eye/Lungs/Ear filtrează doctorii; `All` elimină filtrul.
- Meniul din dreapta căutării sortează original/A-Z/aproape/departe.
- Inima de pe card adaugă sau scoate doctorul din favorite.
- `Favorites only` afișează doar favoriții.
- `See All` extinde lista; inițial vezi primii doi medici ca în Figma.
- Atingerea unui medic navighează către detaliile sale.
- Selectarea datei/orei este administrată de Cubit.
- Butonul Book arată o confirmare **demo**; nu trimite o rezervare reală.
- Loading și Error au UI explicit, iar Empty apare la căutare/filtrare fără rezultate.

## Demonstrarea stărilor

- Loading: pornește aplicația; apare indicatorul cât timp JSON-ul este încărcat.
- Success: apar datele și lista medicilor.
- Empty: caută `zzzz` sau activează `Favorites only` înainte să adaugi favorite.
- Error: pentru o demonstrație temporară, schimbă calea din
  `lib/data/repositories/app_repository.dart` în una inexistentă;
  execută *hot restart* (nu doar hot reload), apoi apasă Try again.
  Restabilește apoi calea corectă.

## Date JSON

Primele două înregistrări și detaliile ecranelor provin din JSON-ul furnizat.
Am adăugat trei medici fictivi (Eye, Lungs, Ear) și câmpurile
`category`, `distanceMeters`, `clinic`, `price` ca să poți demonstra
filtrarea și sortarea pentru toate cele patru categorii.

Fotografiile folosesc URL-urile din JSON, deci pot necesita internet.
Dacă o fotografie nu se poate încărca, se afișează o pictogramă locală.
Pictogramele pentru Tooth/Eye/Lungs/Ear sunt iconuri Material; nu cer
încărcarea URL-urilor SVG.

Favoritele și selecțiile se păstrează în memoria aplicației **doar cât
aceasta rulează**. Persistența lor după repornire nu este cerută în Lab3.
Sloturile/datelor sunt date demonstrative din JSON, nu disponibilitate reală.

## Git

Din rădăcina `Mobile-Labs`:

```powershell
git status
git add Lab3_StateManagement
git commit -m "Lab 3: Flutter Cubit, JSON async, filters, favorites and details"
git push origin main
```

Nu crea un repository Git separat în interiorul `Lab3_StateManagement`.
