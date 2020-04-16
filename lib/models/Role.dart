enum RoleTypes {
  farmer,
  retailer,
  researcher,
  administrator,
}

String toVietnam(RoleTypes role) {
  switch (role) {
    case (RoleTypes.farmer):
      return 'Nông dân';
    case (RoleTypes.retailer):
      return 'Đại lí';
    case (RoleTypes.researcher):
      return 'Nghiên cứu viên';
    case (RoleTypes.administrator):
      return 'Quản trị';
    default:
      return 'Nông dân';
  }
}

class Role {
  RoleTypes type;

  Role(RoleTypes type) : type = type;

  Role.fromInt(int id) {
    switch (id) {
      case (2):
        type = RoleTypes.retailer;
        break;
      case (3):
        this.type = RoleTypes.researcher;
        break;
      case (4):
        this.type = RoleTypes.administrator;
        break;
      default:
        this.type = RoleTypes.farmer;
    }
  }

  @override
  String toString() {
    final role = type.toString();
    return role.substring(role.indexOf('.') + 1);
  }

  int toInt() {
    switch (type) {
      case (RoleTypes.farmer):
        return 1;
      case (RoleTypes.retailer):
        return 2;
      case (RoleTypes.researcher):
        return 3;
      case (RoleTypes.administrator):
        return 4;
      default:
        return 1;
    }
  }
}
