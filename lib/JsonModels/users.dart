//In here first we create the users json model
// To parse this JSON data, do
//

class Users {
  final int? usrId;
  final String usrName;
  final String usrEmail;
  final String usrPassword;
  final String usrTelefono;

  Users({
    this.usrId,
    required this.usrName,
    required this.usrEmail,
    required this.usrPassword,
    required this.usrTelefono,
  });

  factory Users.fromMap(Map<String, dynamic> json) => Users(
        usrId: json["usrId"],
        usrName: json["usrName"],
        usrEmail: json["usrEmail"],
        usrPassword: json["usrPassword"],
        usrTelefono: json["usrTelefono"],
      );

  Map<String, dynamic> toMap() => {
        "usrId": usrId,
        "usrName": usrName,
        "usrEmail": usrEmail,
        "usrPassword": usrPassword,
        "usrTelefono": usrTelefono,
      };
}
