// To parse this JSON data, do
//
//     final userrequesttoadminresponsemodel = userrequesttoadminresponsemodelFromMap(jsonString);

import 'dart:convert';

Userrequesttoadminresponsemodel userrequesttoadminresponsemodelFromMap(String str) => Userrequesttoadminresponsemodel.fromMap(json.decode(str));

String userrequesttoadminresponsemodelToMap(Userrequesttoadminresponsemodel data) => json.encode(data.toMap());

class Userrequesttoadminresponsemodel {
    final String message;

    Userrequesttoadminresponsemodel({
        required this.message,
    });

    factory Userrequesttoadminresponsemodel.fromMap(Map<String, dynamic> json) => Userrequesttoadminresponsemodel(
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "message": message,
    };
}
