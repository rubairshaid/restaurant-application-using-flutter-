class Menu {
  int id;
  int restId;
  String name;
  String descr;
  int price;
  String image;
  dynamic rating;
  String men;

  Menu(
      {this.id,
      this.restId,
      this.name,
      this.descr,
      this.price,
      this.image,
      this.rating,
      this.men});

  factory Menu.fromJson(dynamic json) {
    String M = json['id'];
    String img=json['image'];
    return Menu(
      id: json["id"],
      restId: json["rest_id"],
      name: json["name"],
      descr: json["descr"],
      price: json["price"],
      image:'http://appback.ppu.edu/static/$img',
      rating: json["rating"],
      men: 'http://appback.ppu.edu/menus/$M',
    );
  }
}
