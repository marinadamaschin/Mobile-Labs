// Representative response shapes of the professor's two APIs.
// They are test fixtures only: the running app always calls the real APIs.
const feedJson = <String, dynamic>{
  'user': {
    'name': 'Jonathan',
    'greeting': 'Hi, Jonathan',
    'subtitle': 'May you always be healthy!',
    'avatarUrl': '',
  },
  'notifications': {'hasUnread': true},
  'search': {'hint': 'Search something'},
  'appointment': {
    'title': 'Appointment',
    'date': '22 October, 2023',
    'time': '08:00 AM - 10.30 AM',
    'doctor': {
      'name': 'Dr. Richar Kandowen',
      'specialty': 'Child Specialist',
      'avatarUrl': '',
    },
  },
  'healthServices': [
    {'id': 'tooth', 'name': 'Tooth', 'iconUrl': ''},
    {'id': 'eye', 'name': 'Eye', 'iconUrl': ''},
  ],
  'nearbyDoctors': [
    {
      'id': 'doctor-001',
      'name': 'Dr. Emmly Lestiryno',
      'specialty': 'General Practitioner',
      'distance': '3167 Durgan Shores - 500M from you',
      'avatarUrl': '',
      'isFavorite': false,
    },
    {
      'id': 'doctor-002',
      'name': 'Dr. Sonja Litel',
      'specialty': 'Dental Specialist',
      'distance': '950 Sigrid Port - 753M from you',
      'avatarUrl': '',
      'isFavorite': true,
    },
  ],
};

const detailsJson = <String, dynamic>{
  'title': 'Appointment',
  'doctor': {'name': 'Dr.Upul', 'clinic': 'Denteeth', 'avatarUrl': ''},
  'payment': {'label': 'Payment', 'amount': 120.0, 'currency': 'USD'},
  'details': {'title': 'Details', 'description': 'Appointment description'},
  'workingHours': {
    'title': 'Working Hours',
    'slots': [
      {'id': '10am', 'label': '10.00 AM', 'selected': false},
      {'id': '11am', 'label': '11.00 AM', 'selected': true},
    ]
  },
  'date': {
    'title': 'Date',
    'slots': [
      {'id': 'sun-4', 'label': 'Sun 4', 'selected': true},
      {'id': 'mon-5', 'label': 'Mon 5', 'selected': false},
    ]
  },
  'actions': {
    'bookAppointment': {'label': 'Book an Appointment', 'enabled': true},
  },
};
