import 'package:sihaclik/store/models/convention.dart';
import 'package:sihaclik/store/models/structure.dart';

class PDSOptions {
  final int homeConsultation;
  final int holidays;
  final List<Convention> conventions;
  final Structure structure;

  PDSOptions(
      {this.homeConsultation, this.holidays, this.conventions, this.structure});

  factory PDSOptions.fromJson({Map<String, dynamic> data}) {
    return PDSOptions(
      homeConsultation: data['at_home'] ?? 0,
      holidays: data['holidays'] ?? 0,
      conventions: (data["convontions"] as List)
          ?.map((e) => e == null
              ? null
              : Convention.fromJson(data: e as Map<String, dynamic>))
          ?.toList(),
      structure: data['structur'] != null
          ? Structure.fromJson(data: data['structur'] as Map<String, dynamic>)
          : null,
    );
  }

/*
  {
                "id": 1,
                "pds_id": 1,
                "structur_id": 1,
                "speciality_id": 1,
                "holidays": 1,
                "at_home": 1,
                "convontions": [
                    {
                        "id": 1,
                        "name": "CNAS"
                    },
                    {
                        "id": 2,
                        "name": "CASNOS"
                    }
                ],
                "services": [
                    {
                        "id": 1,
                        "name": "radio"
                    },
                    {
                        "id": 2,
                        "name": "ECG"
                    }
                ],
                "speciality": {
                    "id": 1,
                    "name": "infectiologie"
                },
                "structur": {
                    "id": 1,
                    "name": "Cabinet privé"
                }
   */
}
