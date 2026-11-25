# Laboratorul 4 — HTTP, JSON Serialization și Clean Architecture

Aplicație Flutter medicală reutilizată din Lab 3, conectată la API-urile profesorului:

- `GET https://test-api-jlbn.onrender.com/lab2026/v2/feed` — Home Screen
- `GET https://test-api-jlbn.onrender.com/lab2026/v2/feed/details` — Appointment Details

**Atenție:** această arhivă conține un **strat de fișiere sursă** care se aplică peste un proiect NOU creat cu `flutter create`. **Nu conține platformele generate automat** (`android`, `ios`, etc.). Lab 3 nu se modifică.

## Instalare în Windows PowerShell

Deschide terminalul în folderul `C:\Users\user\StudioProjects\Mobile-Labs`:

```powershell
cd C:\Users\user\StudioProjects\Mobile-Labs
flutter create --project-name lab4_clean_architecture Lab4_CleanArchitecture
```

Apoi extrage fișierele din `Lab4_CleanArchitecture_Source.zip` în folderul `Mobile-Labs` (cu suprascrierea fișierelor din `Lab4_CleanArchitecture` nou creat). Atenție la nivelurile de foldere: calea rezultată trebuie să fie `Mobile-Labs\Lab4_CleanArchitecture\lib\main.dart`, nu `...\Lab4_CleanArchitecture\Lab4_CleanArchitecture\...`.

Exemplu de extragere dacă ZIP-ul a fost salvat la Downloads:

```powershell
Expand-Archive -Path "$env:USERPROFILE\Downloads\Lab4_CleanArchitecture_Source.zip" `
  -DestinationPath "C:\Users\user\StudioProjects\Mobile-Labs" -Force
```

Editează **doar** fișierul noului proiect `Lab4_CleanArchitecture/android/app/src/main/AndroidManifest.xml` și inserează permisiunea după tagul `manifest`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

De exemplu:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
    <application
        ...
```

(În exemplu, `...` arată restul fișierului deja existent. Nu îl înlocui cu cele trei puncte!)

Apoi:

```powershell
cd C:\Users\user\StudioProjects\Mobile-Labs\Lab4_CleanArchitecture
flutter pub get
dart format lib test
flutter analyze
flutter test
flutter run
```

La prima lansare serverul Render poate răspunde mai lent; aplicația afișează Loading, apoi Home sau Error cu Try again. Dacă utilizatorul intră pe Appointment, aplicația realizează al doilea GET. Pozele sunt încărcate din URL-urile returnate de server.

## Structura Clean Architecture

```text
lib/
├── main.dart                          # Dependency wiring (crearea componentelor)
├── core/constants/app_colors.dart      # Design refolosit din Lab 3
├── domain/
│   ├── entities/medical_entities.dart  # Date pure, fără HTTP/Flutter/JSON
│   ├── repositories/medical_repository.dart  # Contract/abstract class
│   └── usecases/
│       ├── get_home_data.dart
│       └── get_appointment_details.dart
├── data/
│   ├── datasources/medical_remote_data_source.dart # HTTP GET
│   ├── models/medical_models.dart      # fromJson, toJson, toEntity
│   └── repositories/medical_repository_impl.dart  # Implementare contract
└── presentation/
    ├── cubit/medical_cubit.dart        # Operații async, filtrare, favorite
    ├── cubit/medical_state.dart        # Home status + Details status
    ├── screens/                         # Cele două ecrane Lab 3
    └── widgets/                         # Widgeturi Lab 3
```

## Fluxul de date pentru prezentare

1. `HomeScreen` primește date și schimbări de stare de la `MedicalCubit`.
2. `MedicalCubit.loadHome()` cheamă `GetHomeData` (use case).
3. `GetHomeData` depinde de interfața abstractă `MedicalRepository`.
4. `MedicalRepositoryImpl` invocă `MedicalRemoteDataSource.getFeed()`.
5. Data source trimite `GET` cu `http.Client` către primul endpoint, verifică codul HTTP și decodează JSON cu `jsonDecode`.
6. `HomeResponseModel.fromJson` interpretează câmpurile și `toEntity` construiește entitățile Domain.
7. Răspunsul se întoarce prin Repository → Use Case → Cubit; Cubit emite `Success` sau `Empty`/`Error`, iar UI se actualizează prin `BlocBuilder`.
8. La deschiderea celui de-al doilea ecran `loadDetails()` repetă procesul pentru API-ul `.../feed/details`, separat de Home.

Am folosit deserializare/serializare manuală (`fromJson`, `toJson`) pentru claritate; `json_serializable` și generarea de cod nu sunt necesare pentru cerința profesorului. Datele afișate în aplicație sunt primite de la API, nu din `assets/data/app_data.json`.

## Ce funcționalități rămân locale

- Căutare după nume/specialitate, filtrare după serviciu, sortare A-Z/distanță, favorite și See All.
- API-ul nu furnizează `category` sau `distanceMeters` pentru medici. Filtrarea pe servicii folosește asocierea locală după textul specialității (`Dental` → `tooth` etc.), iar sortarea după distanță citește numărul de metri din textul `distance`.
- Nu există un endpoint pentru creare programare. Butonul **Book an Appointment** arată doar un `SnackBar` demonstrativ. Nu trimite POST și nu pretinde că rezervarea a fost salvată.
- API-ul de detalii nu primește ID-ul medicului; detaliile afișate sunt aceleași indiferent de cardul din care se navighează. În special, nu am inventat prețuri/clinici per medic.
- Fotografiile vin din URL-uri externe. Dacă imaginile nu sunt disponibile, interfața afișează placeholder.
- URL-urile serviciilor medicale sunt SVG, iar widgeturile Lab 3 reprezintă serviciile folosind iconuri Flutter în locul lor, pentru a evita dependențe suplimentare.

## Teste incluse

- `models_test.dart`: JSON → model/entitate și caz JSON invalid
- `remote_data_source_test.dart`: două HTTP GET și cod de eroare, prin `MockClient` (fără rețea reală)
- `medical_cubit_test.dart`: Loading → Success, Empty, Error, detalii, filtre/favorite
- `widget_test.dart`: indicatorul de încărcare pe ecranul Home

Testele nu depind de disponibilitatea serverului real.

## Git (din directorul Mobile-Labs)

```powershell
cd C:\Users\user\StudioProjects\Mobile-Labs
git status
git add Lab4_CleanArchitecture
git commit -m "Add Lab 4 HTTP JSON Clean Architecture"
git push origin main
```

Nu executa `git init` în `Lab4_CleanArchitecture`.
