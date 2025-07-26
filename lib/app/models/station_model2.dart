class StationModel2 {
  int? id;
  String? creationDate;
  String? lastUpdatedDate;
  String? stationName;
  int? capacity;
  int? numberOfBays;
  int? numOfAvailableBays;
  int? maxWatingPerBay;
  int? numOfMaintenanceBays;
  int? status;
  int? unitPrice;
  int? addressId;
  bool? autoOperationMode;
  String? currentLEDMessage;
  String? lastUsedGroup;
  Address? address;
  List<Barriers>? barriers;
  List<StationBays>? stationBays;

  StationModel2({
    this.id,
    this.creationDate,
    this.lastUpdatedDate,
    this.stationName,
    this.capacity,
    this.numberOfBays,
    this.numOfAvailableBays,
    this.maxWatingPerBay,
    this.numOfMaintenanceBays,
    this.status,
    this.unitPrice,
    this.addressId,
    this.autoOperationMode,
    this.currentLEDMessage,
    this.lastUsedGroup,
    this.address,
    this.barriers,
    this.stationBays,
  });

  StationModel2.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    creationDate = json['CreationDate'];
    lastUpdatedDate = json['LastUpdatedDate'];
    stationName = json['StationName'];
    capacity = json['Capacity'];
    numberOfBays = json['NumberOfBays'];
    numOfAvailableBays = json['NumOfAvailableBays'];
    maxWatingPerBay = json['MaxWatingPerBay'];
    numOfMaintenanceBays = json['NumOfMaintenanceBays'];
    status = json['Status'];
    unitPrice = json['UnitPrice'];
    addressId = json['AddressId'];
    autoOperationMode = json['AutoOperationMode'];
    currentLEDMessage = json['CurrentLEDMessage'];
    lastUsedGroup = json['lastUsedGroup'];
    address =
        json['Address'] != null ? new Address.fromJson(json['Address']) : null;
    if (json['Barriers'] != null) {
      barriers = <Barriers>[];
      json['Barriers'].forEach((v) {
        barriers!.add(new Barriers.fromJson(v));
      });
    }
    if (json['StationBays'] != null) {
      stationBays = <StationBays>[];
      json['StationBays'].forEach((v) {
        stationBays!.add(new StationBays.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['CreationDate'] = this.creationDate;
    data['LastUpdatedDate'] = this.lastUpdatedDate;
    data['StationName'] = this.stationName;
    data['Capacity'] = this.capacity;
    data['NumberOfBays'] = this.numberOfBays;
    data['NumOfAvailableBays'] = this.numOfAvailableBays;
    data['MaxWatingPerBay'] = this.maxWatingPerBay;
    data['NumOfMaintenanceBays'] = this.numOfMaintenanceBays;
    data['Status'] = this.status;
    data['UnitPrice'] = this.unitPrice;
    data['AddressId'] = this.addressId;
    data['AutoOperationMode'] = this.autoOperationMode;
    data['CurrentLEDMessage'] = this.currentLEDMessage;
    data['lastUsedGroup'] = this.lastUsedGroup;
    if (this.address != null) {
      data['Address'] = this.address!.toJson();
    }
    if (this.barriers != null) {
      data['Barriers'] = this.barriers!.map((v) => v.toJson()).toList();
    }
    if (this.stationBays != null) {
      data['StationBays'] = this.stationBays!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  int? id;
  String? dateCreated;
  String? dateUpdated;
  double? latitude;
  double? longitude;
  String? state;
  String? stateDistrict;
  String? postcode;
  String? countryCode;
  String? country;
  String? city;

  Address({
    this.id,
    this.dateCreated,
    this.dateUpdated,
    this.latitude,
    this.longitude,
    this.state,
    this.stateDistrict,
    this.postcode,
    this.countryCode,
    this.country,
    this.city,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateUpdated = json['date_updated'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    state = json['State'];
    stateDistrict = json['StateDistrict'];
    postcode = json['Postcode'];
    countryCode = json['CountryCode'];
    country = json['Country'];
    city = json['City'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_updated'] = this.dateUpdated;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['State'] = this.state;
    data['StateDistrict'] = this.stateDistrict;
    data['Postcode'] = this.postcode;
    data['CountryCode'] = this.countryCode;
    data['Country'] = this.country;
    data['City'] = this.city;
    return data;
  }
}

class FillingStations {
  String? stationName;

  FillingStations({this.stationName});

  factory FillingStations.fromJson(Map<String, dynamic> json) {
    return FillingStations(stationName: json['StationName']);
  }

  Map<String, dynamic> toJson() {
    return {'StationName': stationName};
  }
}

class Barriers {
  int? id;
  String? name;
  int? fillingStationId;
  String? creationDate;
  String? lastUpdatedDate;
  int? status;
  bool? barrierStatus;
  FillingStations? fillingStations; // استخدم الموديل الجديد هنا

  Barriers({
    this.id,
    this.name,
    this.fillingStationId,
    this.creationDate,
    this.lastUpdatedDate,
    this.status,
    this.barrierStatus,
    this.fillingStations,
  });

  factory Barriers.fromJson(Map<String, dynamic> json) {
    return Barriers(
      id: json['Id'],
      name: json['Name'],
      fillingStationId: json['FillingStationId'],
      creationDate: json['CreationDate'],
      lastUpdatedDate: json['LastUpdatedDate'],
      status: json['Status'],
      barrierStatus: json['BarrierStatus'],
      fillingStations:
          json['FillingStations'] != null
              ? FillingStations.fromJson(json['FillingStations'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'FillingStationId': fillingStationId,
      'CreationDate': creationDate,
      'LastUpdatedDate': lastUpdatedDate,
      'Status': status,
      'BarrierStatus': barrierStatus,
      'FillingStations': fillingStations?.toJson(),
    };
  }
}

class StationBays {
  int? id;
  String? bayName;
  int? fillingStationId;
  bool? bayStatus;
  bool? bayActive;
  int? flowRate;
  int? flowTotalizer;
  int? totalWorkHours;
  int? waitingVehicles;
  int? activeVehicles;
  int? maxWaitingVehicles;
  String? creationDate;
  String? lastUpdatedDate;
  int? assignedAccountNumber;
  bool? bayMaintenance;
  bool? bayOccupied;
  int? currentDischargedValue;
  int? processStatus;
  bool? spare1;
  bool? spare2;
  bool? spare3;
  bool? spare4;
  double? spareReal1;
  double? spareReal2;
  double? spareReal3;
  int? spareInt2;
  int? spareInt3;
  int? waitingAccountNumber;
  String? sRSName;
  int? rFIDTagNumber;
  int? pH;
  int? cONDUCTIVITY;
  bool? allowedDischarge;

  StationBays({
    this.id,
    this.bayName,
    this.fillingStationId,
    this.bayStatus,
    this.bayActive,
    this.flowRate,
    this.flowTotalizer,
    this.totalWorkHours,
    this.waitingVehicles,
    this.activeVehicles,
    this.maxWaitingVehicles,
    this.creationDate,
    this.lastUpdatedDate,
    this.assignedAccountNumber,
    this.bayMaintenance,
    this.bayOccupied,
    this.currentDischargedValue,
    this.processStatus,
    this.spare1,
    this.spare2,
    this.spare3,
    this.spare4,
    this.spareReal1,
    this.spareReal2,
    this.spareReal3,
    this.spareInt2,
    this.spareInt3,
    this.waitingAccountNumber,
    this.sRSName,
    this.rFIDTagNumber,
    this.pH,
    this.cONDUCTIVITY,
    this.allowedDischarge,
  });

  StationBays.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    bayName = json['BayName'];
    fillingStationId = json['FillingStationId'];
    bayStatus = json['BayStatus'];
    bayActive = json['BayActive'];
    flowRate = json['FlowRate'];
    flowTotalizer = json['FlowTotalizer'];
    totalWorkHours = json['TotalWorkHours'];
    waitingVehicles = json['WaitingVehicles'];
    activeVehicles = json['ActiveVehicles'];
    maxWaitingVehicles = json['MaxWaitingVehicles'];
    creationDate = json['CreationDate'];
    lastUpdatedDate = json['LastUpdatedDate'];
    assignedAccountNumber = json['Assigned_Account_Number'];
    bayMaintenance = json['BayMaintenance'];
    bayOccupied = json['BayOccupied'];
    currentDischargedValue = json['Current_Discharged_Value'];
    processStatus = json['Process_Status'];
    spare1 = json['Spare1'];
    spare2 = json['Spare2'];
    spare3 = json['Spare3'];
    spare4 = json['Spare4'];
    spareReal1 = json['Spare_Real1'];
    spareReal2 = json['Spare_Real2'];
    spareReal3 = json['Spare_Real3'];
    spareInt2 = json['Spare_int2'];
    spareInt3 = json['Spare_int3'];
    waitingAccountNumber = json['Waiting_Account_Number'];
    sRSName = json['SRSName'];
    rFIDTagNumber = json['RFID_Tag_number'];
    pH = json['PH'];
    cONDUCTIVITY = json['CONDUCTIVITY'];
    allowedDischarge = json['Allowed_Discharge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['BayName'] = this.bayName;
    data['FillingStationId'] = this.fillingStationId;
    data['BayStatus'] = this.bayStatus;
    data['BayActive'] = this.bayActive;
    data['FlowRate'] = this.flowRate;
    data['FlowTotalizer'] = this.flowTotalizer;
    data['TotalWorkHours'] = this.totalWorkHours;
    data['WaitingVehicles'] = this.waitingVehicles;
    data['ActiveVehicles'] = this.activeVehicles;
    data['MaxWaitingVehicles'] = this.maxWaitingVehicles;
    data['CreationDate'] = this.creationDate;
    data['LastUpdatedDate'] = this.lastUpdatedDate;
    data['Assigned_Account_Number'] = this.assignedAccountNumber;
    data['BayMaintenance'] = this.bayMaintenance;
    data['BayOccupied'] = this.bayOccupied;
    data['Current_Discharged_Value'] = this.currentDischargedValue;
    data['Process_Status'] = this.processStatus;
    data['Spare1'] = this.spare1;
    data['Spare2'] = this.spare2;
    data['Spare3'] = this.spare3;
    data['Spare4'] = this.spare4;
    data['Spare_Real1'] = this.spareReal1;
    data['Spare_Real2'] = this.spareReal2;
    data['Spare_Real3'] = this.spareReal3;
    data['Spare_int2'] = this.spareInt2;
    data['Spare_int3'] = this.spareInt3;
    data['Waiting_Account_Number'] = this.waitingAccountNumber;
    data['SRSName'] = this.sRSName;
    data['RFID_Tag_number'] = this.rFIDTagNumber;
    data['PH'] = this.pH;
    data['CONDUCTIVITY'] = this.cONDUCTIVITY;
    data['Allowed_Discharge'] = this.allowedDischarge;
    return data;
  }
}
