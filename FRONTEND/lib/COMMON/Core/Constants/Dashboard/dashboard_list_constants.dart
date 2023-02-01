String setPrefix(String? value) {
  switch (value) {
    case 'Physician':
      return "Dr";
      break;
    case 'Nurse':
      return "Nurse";
      break;
    case 'Pharmacist':
      return "Dr";
      break;
    case 'Lab Technician':
      return "Dr";
      break;
    default:
      return "Dr";
      break;
  }
}

List<String> medicalSpecialityList = [
  "Physician",
  "Nurse",
  "Pharmacist",
  "Dentist",
  "Lab Technician",
];

List<bool> medicalSpecialityBoolList = [
  false,
  false,
  false,
  false,
  false,
];

List<String> medicalTopSpecialistList = [
  "Physician",
  "Nurse",
  "Pharmacist",
  "Dentist",
  "Lab Technician",
];

List<bool> medicalTopSpecialistBoolList = [
  false,
  false,
  false,
  false,
  false,
];

List<String> physicianList = [
  "Allergy and immunology",
  "Anesthesiology",
  "Cardiology medicine",
  "Dermatology",
  "Diagnostic radiology",
  "Emergency medicine",
  "Family medicine",
  "Internal medicine",
  "Medical genetics",
  "Neurology",
  "Nuclear medicine",
  "Obstetrics and gynecology",
  "Ophthalmology",
  "Pathology",
  "Pediatrics",
  "Physical medicine and rehabilitation",
  "Preventive medicine",
  "Psychiatry",
  "Radiation oncology",
  "Surgery",
  "Urology",
];

List<String> physicianImageList = [
  "assets/Medical Personnel Speciality/Physician/Allergy and immunology.png",
  "assets/Medical Personnel Speciality/Physician/Anesthesiology.png",
  "assets/Medical Personnel Speciality/Physician/Cardiology medicine.png",
  "assets/Medical Personnel Speciality/Physician/Dermatology.png",
  "assets/Medical Personnel Speciality/Physician/Diagnostic radiology.png",
  "assets/Medical Personnel Speciality/Physician/Emergency medicine.png",
  "assets/Medical Personnel Speciality/Physician/Family medicine.png",
  "assets/Medical Personnel Speciality/Physician/Internal medicine.png",
  "assets/Medical Personnel Speciality/Physician/Medical genetics.png",
  "assets/Medical Personnel Speciality/Physician/Neurology.png",
  "assets/Medical Personnel Speciality/Physician/Nuclear medicine.png",
  "assets/Medical Personnel Speciality/Physician/Obstetrics and gynecology.png",
  "assets/Medical Personnel Speciality/Physician/Ophthalmology.png",
  "assets/Medical Personnel Speciality/Physician/Pathology.png",
  "assets/Medical Personnel Speciality/Physician/Pediatrics.png",
  "assets/Medical Personnel Speciality/Physician/Physical medicine and rehabilitation.png",
  "assets/Medical Personnel Speciality/Physician/Preventive medicine.png",
  "assets/Medical Personnel Speciality/Physician/Psychiatry.png",
  "assets/Medical Personnel Speciality/Physician/Radiation oncology.png",
  "assets/Medical Personnel Speciality/Physician/Surgery.png",
  "assets/Medical Personnel Speciality/Physician/Urology.png",
];

List<String> dentistList = [
  "Endodontist",
  "Orthodontist",
  "Periodontist",
  "Prosthodontist,Oral and Maxillofacial Surgeon",
  "Oral and Maxillofacial Radiologist",
  "Dentist Anesthesiologists",
  "Oral and Maxillofacial Pathologist",
  "Pediatric Dentist or Pedodontist",
  "Orofacial Pain (OFP)",
  "Oral Medicine",
  "Dental Public Health (DPH)"
];

List<String> dentistImageList = [
  "assets/Medical Personnel Speciality/Dentist/Endodontist.png",
  "assets/Medical Personnel Speciality/Dentist/Orthodontist.png",
  "assets/Medical Personnel Speciality/Dentist/Periodontist.png",
  "assets/Medical Personnel Speciality/Dentist/Prosthodontist,Oral and Maxillofacial Surgeon.png",
  "assets/Medical Personnel Speciality/Dentist/Oral and Maxillofacial Radiologist.png",
  "assets/Medical Personnel Speciality/Dentist/Dentist Anesthesiologists.png",
  "assets/Medical Personnel Speciality/Dentist/Oral and Maxillofacial Pathologist.png",
  "assets/Medical Personnel Speciality/Dentist/Pediatric Dentist or Pedodontist.png",
  "assets/Medical Personnel Speciality/Dentist/Orofacial Pain (OFP).png",
  "assets/Medical Personnel Speciality/Dentist/Oral Medicine.png",
  "assets/Medical Personnel Speciality/Dentist/Dental Public Health (DPH).png",
];

List<String> pharmacyList = [
  "Ambulatory Care",
  "Critical Care Pharmacy",
  "Nuclear Pharmacy",
  "Nutrition Support Pharmacy",
  "Oncology Pharmacy",
  "Pediatric Pharmacy",
  "Pharmacotherapy",
  "Psychiatric Pharmacy",
];

List<String> pharmacyImageList = [
  "assets/Medical Personnel Speciality/Pharmacist/Ambulatory Care.png",
  "assets/Medical Personnel Speciality/Pharmacist/Critical Care Pharmacy.jpeg",
  "assets/Medical Personnel Speciality/Pharmacist/Nuclear Pharmacy.jpeg",
  "assets/Medical Personnel Speciality/Pharmacist/Nutrition Support Pharmacy.jpeg",
  "assets/Medical Personnel Speciality/Pharmacist/Oncology Pharmacy.jpeg",
  "assets/Medical Personnel Speciality/Pharmacist/Pediatric Pharmacy.jpeg",
  "assets/Medical Personnel Speciality/Pharmacist/Pharmacotherapy.jpeg",
  "assets/Medical Personnel Speciality/Pharmacist/Psychiatric Pharmacy.jpeg",
];

List<String> nurseList = [
  "Certified Nursing Assistant (CNA)",
  "Licensed Practical Nurse (LPN) and Licensed Vocational Nurse (LVN)",
  "Registered Nurse (RN)",
  "Surgical Assistant Registered Nurse",
  "Home Care Registered Nurse",
  "Emergency Room Registered Nurse",
  "Labor and Delivery Nurse",
  "Clinical Nurse Supervisor",
  "Nurse Case Manager",
  "Critical Care Registered Nurse",
  "Oncology Registered Nurse",
  "Health Informatics Nurse Specialist",
  "Advanced Practice Registered Nurse (APRN)",
  "Clinical Nurse Specialist",
  "Nurse Practitioner",
  "Nurse Educator",
];

List<String> nurseImageList = [
  "assets/Medical Personnel Speciality/Nurse/Certified Nursing Assistant (CNA).png",
  "assets/Medical Personnel Speciality/Nurse/Licensed Practical Nurse (LPN) and Licensed Vocational Nurse (LVN).png",
  "assets/Medical Personnel Speciality/Nurse/Registered Nurse (RN).png",
  "assets/Medical Personnel Speciality/Nurse/Surgical Assistant Registered Nurse.png",
  "assets/Medical Personnel Speciality/Nurse/Home Care Registered Nurse.png",
  "assets/Medical Personnel Speciality/Nurse/Emergency Room Registered Nurse.png",
  "assets/Medical Personnel Speciality/Nurse/Labor and Delivery Nurse.png",
  "assets/Medical Personnel Speciality/Nurse/Clinical Nurse Supervisor.png",
  "assets/Medical Personnel Speciality/Nurse/Nurse Case Manager.png",
  "assets/Medical Personnel Speciality/Nurse/Critical Care Registered Nurse.png",
  "assets/Medical Personnel Speciality/Nurse/Oncology Registered Nurse.png",
  "assets/Medical Personnel Speciality/Nurse/Health Informatics Nurse Specialist.png",
  "assets/Medical Personnel Speciality/Nurse/Advanced Practice Registered Nurse (APRN).png",
  "assets/Medical Personnel Speciality/Nurse/Clinical Nurse Specialist.png",
  "assets/Medical Personnel Speciality/Nurse/Nurse Practitioner.png",
  "assets/Medical Personnel Speciality/Nurse/Nurse Educator.png",
];

List<String> labTechnicianList = [
  "Microbiology",
  "Blood banking",
  "Immunology",
  "Clinical chemistry",
  "Molecular biology",
];

List<String> labTechnicianImageList = [
  "assets/Medical Personnel Speciality/Lab Technician/Microbiology.png",
  "assets/Medical Personnel Speciality/Lab Technician/Blood banking.png",
  "assets/Medical Personnel Speciality/Lab Technician/Immunology.png",
  "assets/Medical Personnel Speciality/Lab Technician/Clinical chemistry.png",
  "assets/Medical Personnel Speciality/Lab Technician/Molecular biology.png",
];
