class Researcher {
  String researcherFullname;
  String researcherPhoneNumber;
  String researcherAddress;
  String researcherStory;
  //
  String researcherOrganization;
  String researcherSpecialized;

  Researcher({
    this.researcherFullname,
    this.researcherPhoneNumber,
    this.researcherAddress,
    this.researcherStory,
    this.researcherOrganization,
    this.researcherSpecialized,
  });

  Researcher.fromJson(Map<String, dynamic> parsedJson)
      : this.researcherFullname = parsedJson['researcherFullname'],
        this.researcherPhoneNumber = parsedJson['researcherPhoneNumber'],
        this.researcherAddress = parsedJson['researcherAddress'],
        this.researcherStory = parsedJson['researcherStory'],
        this.researcherOrganization = parsedJson['researcherOrganization'],
        this.researcherSpecialized = parsedJson['researcherSpecialized'];

  Map<String, dynamic> toMap() => <String, dynamic>{
        'researcherFullname': researcherFullname,
        'researcherPhoneNumber': researcherPhoneNumber,
        'researcherAddress': researcherAddress,
        'researcherStory': researcherStory,
        'researcherOrganization': researcherOrganization,
        'researcherSpecialized': researcherSpecialized,
      };
}
