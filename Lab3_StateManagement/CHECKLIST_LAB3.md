# Checklist: cerințe profesor -> implementare -> probă

| Cerință | Implementare | Cum demonstrezi |
|---|---|---|
| BLoC/Cubit sau GetX | `flutter_bloc`, `MedicalCubit` | `lib/state/medical_cubit.dart` |
| Date JSON incluse în proiect | `assets/data/app_data.json`, declarat în `pubspec.yaml` | Deschizi fișierul JSON |
| Încărcare asincronă | `AppRepository.load()` (Future, await, AssetBundle.loadString) | `lib/data/repositories/app_repository.dart` |
| Modelare date | `AppData`, `Doctor`, `HealthService`, `SelectionSlot` | `lib/data/models/app_data.dart` |
| Loading | `LoadStatus.loading`, indicator circular | La pornire; poate apărea scurt pe fișier local |
| Success | `LoadStatus.success` | Pagina principală și lista |
| Empty | `LoadStatus.empty`, `StatusPanel` | Caută `zzzzz` sau filtrează pe favorite goale |
| Error | `LoadStatus.error`, buton Try again | Temporar schimbi calea JSON, hot restart |
| Căutare | `MedicalCubit.search` | Caută `Sonja`, `dental`, `Vision` |
| Filtrare | `setCategory`, `toggleOnlyFavorites` | Tooth, Eye, Lungs, Ear; Favorites only |
| Sortare | `setSort`, `DoctorSort` | Icon de reglaje din câmpul de căutare |
| Favorite | `toggleFavorite` | Apasă inima unui medic |
| Navigare detalii | `Navigator.push`, `AppointmentDetailsScreen` | Apasă un doctor din listă |
| Componente UI reutilizabile | `DoctorCard`, `Portrait`, `SlotSelectionSection` | `lib/widgets/` |
| Arhitectură modulară | `core`, `data`, `state`, `screens`, `widgets` | Structura directorului `lib/` |
| Interacțiune ecran detalii | `selectHour`, `selectDate` | Schimbă data / ora și apasă butonul de demo |
| Teste | `test/medical_state_test.dart`, `test/medical_cubit_test.dart` | `flutter test` |

## Observații

- Booking este doar demo local, fără backend, fără notificări sau plăți reale.
- URL-urile pentru poze au fallback dacă nu există conexiune la internet.
- Favoritele nu sunt persistate după repornire; cerința este gestionarea stării, nu bază de date.
- În JSON, trei medici au fost adăugați ca **date fictive demonstrative** pentru a avea câte unul în fiecare categorie Figma.
- JSON-ul oferit conține nume diferite în cardul programării față de detaliile exemplu. Ecranul din soluție afișează numele medicului pe care utilizatorul a apăsat, evitând nepotrivirea.
