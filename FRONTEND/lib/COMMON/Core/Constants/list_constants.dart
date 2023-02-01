///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';

///----------------------------------- LIST OF DISEASES -----------------------------------///
List<String> categoryOfChronicDiseasesEN = [
  "List of Diseases",
  "Cardiovascular Diseases",
  "Diabetes",
  "Blood Pressure",
  "Allergies",
  "Others",
];

List<String> listOfChronicDiseasesEN = [
  "List of Diseases",
  "Diabetes",
  "Blood Pressure",
  "Allergies",
  "Heart diseases and stroke",
  "Arthritis",
  "Alcohol-related health issues",
  "Cancer",
  "Obesity",
  "Alzheimer's disease",
  "Smoking-related health issues",
  "Tooth Decay",
  "Epilepsy",
  "Others",
];

List<String> categoryOfChronicDiseasesAR = [
  "قائمة الأمراض",
  "أمراض القلب والأوعية الدموية",
  "داء السكري",
  "مرض ضغط الدم",
  "حساسية",
  "أخرى",
];

// 1.	cardiovascular diseases              أمراض القلب والأوعية الدموية
// 2.	Diabetes                                       داء السكري
// 3.	Blood pressure                             مرض ضغط الدم
// 4.	Allergies                                       حساسية
// 5.	Others                                          أخرى

List sectorType = [
  {'text': 'ALL', 'isSelected': true},
  {'text': 'Private', 'isSelected': false},
  {'text': 'Public', 'isSelected': false},
];

/*List insuranceSectorTypeList = [
  {'text': 'ALL', 'isSelected': true},
  {'text': 'Social', 'isSelected': false},
  {'text': 'Private', 'isSelected': false},
];*/

/*List emergencyList = [
  {'text': 'ALL', 'isSelected': true},
  {'text': 'Yes', 'isSelected': false},
  {'text': 'No', 'isSelected': false},
];*/

///------------------ HEALTH FACILITY TYPE LIST ------------------///

List healthFacilityTypeListEN = [
  "Clinic",
  "Hospital",
  "Dentist",
  "Doctors",
  "Pharmacy",
  "Laboratory"
];

List healthFacilityTypeListAR = [
  "عيادة",
  "مستشفى",
  "طبيب أسنان",
  "أطباء",
  "صيدلية",
  "مختبر"
];

///------------------ SPECIALIZATION LIT ------------------///

List<String> specializationListEN = [
  "Clinic",
  "Community",
  "Dentist",
  "General",
  "Chiropractic",
  "Gynaecology",
  "Paediatrics",
  "Internal",
  "Orthopaedics",
  "Dermatology",
  "Otolaryngology",
  "Psychiatry",
  "Maternity",
  "Oncology",
  "Pharmacy",
  "اﺧﺘﺼﺎﺻﻰ اﺷﻌﺔ وﻣﻮﺟﺎت ﺻﻮﺗﯿﮫ",
  "اﺧﺘﺼﺎﺻﻰ أول ﻋﻼج طﺒﯿﻌﻰ",
  "اﺧﺘﺼﺎﺻﻰ ﺛﺎﻧﻰ ﻋﻼج طﺒﯿﻌﻰ",
  "اﺧﺘﺼﺎﺻﻰ ﻋﻼج طﺒﯿﻌﻰ",
  "اﺧﺘﺼﺎﺻﻰ ﻣﻮﺟﺎت ﺻﻮﺗﯿﺔ",
  "انف و اذن و حنجرة",
  "أطفال",
  "باطنية",
  "جراحة",
  "طب نفسي",
  "طﺒﯿﺐ",
  "طﺒﯿﺐ اﺳﻨﺎن",
  "طﺒﯿﺐ أﺧﺼﺎﺋﻰ",
  "طﺒﯿﺐ إﺧﺘﺼﺎﺻﻲ",
  "طﺒﯿﺐ إﺧﺘﺼﺎﺻﻲ أﺳﻨﺎن",
  "طﺒﯿﺐ إﺧﺘﺼﺎﺻﻲ أﺳﻨﺎن ﺗﺮﻛﯿﺒﺎت اﻷﺳﻨﺎن اﻟﺜﺎﺑﺘﺔ واﻟﻤﺘﺤﺮﻛﺔ",
  "طﺒﯿﺐ ﻋﻤﻮﻣﻰ",
  "طﺒﯿﺐ ﻋﻤﻮﻣﻲ أﺳﻨﺎن",
  "عام",
  "عمومي",
  "عيون",
  "كلى",
  "نساء و توليد",
];

List<String> specializationListAR = [
  "Clinic",
  "Community",
  "Dentist",
  "General",
  "Chiropractic",
  "Gynaecology",
  "Paediatrics",
  "Internal",
  "Orthopaedics",
  "Dermatology",
  "Otolaryngology",
  "Psychiatry",
  "Maternity",
  "Oncology",
  "Pharmacy",
  "اﺧﺘﺼﺎﺻﻰ اﺷﻌﺔ وﻣﻮﺟﺎت ﺻﻮﺗﯿﮫ",
  "اﺧﺘﺼﺎﺻﻰ أول ﻋﻼج طﺒﯿﻌﻰ",
  "اﺧﺘﺼﺎﺻﻰ ﺛﺎﻧﻰ ﻋﻼج طﺒﯿﻌﻰ",
  "اﺧﺘﺼﺎﺻﻰ ﻋﻼج طﺒﯿﻌﻰ",
  "اﺧﺘﺼﺎﺻﻰ ﻣﻮﺟﺎت ﺻﻮﺗﯿﺔ",
  "انف و اذن و حنجرة",
  "أطفال",
  "باطنية",
  "جراحة",
  "طب نفسي",
  "طﺒﯿﺐ",
  "طﺒﯿﺐ اﺳﻨﺎن",
  "طﺒﯿﺐ أﺧﺼﺎﺋﻰ",
  "طﺒﯿﺐ إﺧﺘﺼﺎﺻﻲ",
  "طﺒﯿﺐ إﺧﺘﺼﺎﺻﻲ أﺳﻨﺎن",
  "طﺒﯿﺐ إﺧﺘﺼﺎﺻﻲ أﺳﻨﺎن ﺗﺮﻛﯿﺒﺎت اﻷﺳﻨﺎن اﻟﺜﺎﺑﺘﺔ واﻟﻤﺘﺤﺮﻛﺔ",
  "طﺒﯿﺐ ﻋﻤﻮﻣﻰ",
  "طﺒﯿﺐ ﻋﻤﻮﻣﻲ أﺳﻨﺎن",
  "عام",
  "عمومي",
  "عيون",
  "كلى",
  "نساء و توليد",];

///------------------ INSURANCE SECTOR LIST ------------------///

List<String> insuranceSectorTypeListEN = ["Private", "Social"];

List<String> insuranceSectorTypeListAR = ["خاص", "الاجتماعي"];

///------------------ INSURANCE LIST ------------------///

List<String> insuranceCompaniesListEN = [
  "National Health Insurance Fund (NHIF)",
  "Health Insurance Corporation of Khartoum State (HIKS)",
  "Military Insurance",
  "Police Insurance",
  "Neelain Insurance Company Ltd",
  "Shiekan Insurance and Reinsurance Company Ltd",
  "Sudanese Company for Insurance and Reinsurance Ltd",
  "Islamic Insurance Company Ltd",
  "United Insurance Company (Sudan) Ltd",
  "Middle East Insurance Ltd",
  "Juba Insurance Company Ltd",
  "Baraka Insurance Company (Sudan) Ltd",
  "Blue Nile Insurance Company",
  "CIGNA",
  "Bupa",
];

List<String> insuranceCompaniesListAR = [
];

///------------------ SECTOR TYPE LIST ------------------///

List<String> sectorTypeListEN = ["Private", "Public"];

List<String> sectorTypeListAR = ["خاص", "عام"];

///------------------ EMERGENCY LIST ------------------///

List<String> isEmergencyProvidedListEN = ["yes", "no"];

List<String> isEmergencyProvidedListAR = ["نعم", "لا"];

///------------------ WORKING HOURS LIST ------------------///

List<String> workingHoursListEN = [];

List<String> workingHoursListAR = [];



///------------------ EMERGENCY CONTACT LIST ------------------///

List<String> isEmergencyContactListEN = ["Police", "Ambulance", "Fire", "Traffic Police"];
