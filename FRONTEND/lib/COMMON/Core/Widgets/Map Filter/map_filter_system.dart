import 'package:nb_utils/nb_utils.dart';

///----------------------------- 🌎 PROJECT IMPORTS -----------------------------///
import 'package:health_pulse/imports.dart';
import 'package:http/http.dart' as http;

List<HealthFacilityInformationModel> mapFilterFunction({
  List<HealthFacilityInformationModel>? healthFacilitiesDatabaseContent,
  List<String>? healthFacilityType,
  List<String>? sectorType,
  List<String>? insuranceSectorType,
  List<String>? insuranceProvided,
  List<String>? isEmergencyProvided,
  List<String>? specialization,
  List<String>? workingHours,
}) {
  List<HealthFacilityInformationModel> allFilteredHealthFacilities =
      <HealthFacilityInformationModel>[];

  if (workingHours == null || workingHours.isEmpty) {
    if (healthFacilityType == null || healthFacilityType.isEmpty) {
      if (sectorType == null || sectorType.isEmpty) {
        if (insuranceSectorType == null || insuranceSectorType.isEmpty) {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 1 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!;
              } else {
                ///------ OUTPUT: 2 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) => element.speciality!
                        .toSet()
                        .intersection(specialization.toSet())
                        .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 3 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 4 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 5 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) => element.insurance_provided!
                        .toSet()
                        .intersection(insuranceProvided.toSet())
                        .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 6 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 7 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 8 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        } else {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 09 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) => element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty
                   )
                    .toList();
              } else {
                ///------ OUTPUT: 10 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 11 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 12 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 13 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 14 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 15 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 16 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        }
      } else {
        if (insuranceSectorType == null || insuranceSectorType.isEmpty) {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 17 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where(
                        (element) => sectorType.contains(element.sector_type))
                    .toList();
              } else {
                ///------ OUTPUT: 18 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 19 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 20 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 21 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 22 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 23 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 24 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        } else {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 25 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 26 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 27 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 28 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 29 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 30 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 31 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 32 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        }
      }
    } else {
      if (sectorType == null || sectorType.isEmpty) {
        if (insuranceSectorType == null || insuranceSectorType.isEmpty) {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 33 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type))
                    .toList();
              } else {
                ///------ OUTPUT: 34 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 35 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 36 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 36 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 37 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 38 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 39 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        } else {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 40 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 41 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 42 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 43 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 45 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 46 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 47 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 48 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        }
      } else {
        if (insuranceSectorType == null || insuranceSectorType.isEmpty) {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 49 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type))
                    .toList();
              } else {
                ///------ OUTPUT: 50 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 51 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 52 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 53 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 54 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 55 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 56 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        } else {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 57 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 58 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 59 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 60 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 61 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 62 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 63 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 64 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        }
      }
    }
  } else {
    if (healthFacilityType == null || healthFacilityType.isEmpty) {
      if (sectorType == null || sectorType.isEmpty) {
        if (insuranceSectorType == null || insuranceSectorType.isEmpty) {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 65 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) => element.opening_hours!
                        .toSet()
                        .intersection(workingHours.toSet())
                        .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 66 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 67 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 68 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 69 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 70 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 71 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 72 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        } else {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 73 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 74 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 75 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 76 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 77 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 78 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 79 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 80 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        }
      } else {
        if (insuranceSectorType == null || insuranceSectorType.isEmpty) {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 81 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type))
                    .toList();
              } else {
                ///------ OUTPUT: 82 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 83 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 84 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 85 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 86 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 87 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 88 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        } else {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 89 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 90 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 91 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 92 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 93 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 94 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 95 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 96 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        }
      }
    } else {
      if (sectorType == null || sectorType.isEmpty) {
        if (insuranceSectorType == null || insuranceSectorType.isEmpty) {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 97 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type))
                    .toList();
              } else {
                ///------ OUTPUT: 98 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 99 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 100 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 101 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 102 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 103 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 104 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        } else {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 105 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 106 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 107 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 108 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 109 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 110 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 111 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 112 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        }
      } else {
        if (insuranceSectorType == null || insuranceSectorType.isEmpty) {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 113 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type))
                    .toList();
              } else {
                ///------ OUTPUT: 114 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 115 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 116 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 117 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 118 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 119 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 120 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        } else {
          if (insuranceProvided == null || insuranceProvided.isEmpty) {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 121 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 122 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 123 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 124 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          } else {
            if (isEmergencyProvided == null || isEmergencyProvided.isEmpty) {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 125 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty)
                    .toList();
              } else {
                ///------ OUTPUT: 126 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            } else {
              if (specialization == null || specialization.isEmpty) {
                ///------ OUTPUT: 127 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency))
                    .toList();
              } else {
                ///------ OUTPUT: 128 ------///
                allFilteredHealthFacilities = healthFacilitiesDatabaseContent!
                    .where((element) =>
                        element.opening_hours!
                            .toSet()
                            .intersection(workingHours.toSet())
                            .isNotEmpty &&
                        healthFacilityType.contains(element.facility_type) &&
                        sectorType.contains(element.sector_type) &&
                        element.insurance_sector_type!
                    .toSet()
                    .intersection(insuranceSectorType.toSet())
                    .isNotEmpty &&
                        isEmergencyProvided.contains(element.emergency) &&
                        element.insurance_provided!
                            .toSet()
                            .intersection(insuranceProvided.toSet())
                            .isNotEmpty &&
                        element.speciality!
                            .toSet()
                            .intersection(specialization.toSet())
                            .isNotEmpty)
                    .toList();
              }
            }
          }
        }
      }
    }
  }

  print(
      "healthFacilitiesDatabaseContent: ${healthFacilitiesDatabaseContent.length}");
  print("allFilteredHealthFacilities: ${allFilteredHealthFacilities.length}");

  return allFilteredHealthFacilities;
}
