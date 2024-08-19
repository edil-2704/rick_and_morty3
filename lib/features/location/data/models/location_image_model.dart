class ImagesLocationModel {
  final List<String> urls;
  int currentIndex = 0;

  ImagesLocationModel({required this.urls});

  String getNextImageUrl() {
    final imageUrl = urls[currentIndex];
    currentIndex = (currentIndex + 1) % urls.length;
    return imageUrl;
  }
}

final imagesLocation = ImagesLocationModel(

  urls: [
    "https://static.wikia.nocookie.net/rickandmorty/images/f/fc/S2e5_Earth.png/revision/latest?cb=20160926065208",
    "https://static.wikia.nocookie.net/rickandmorty/images/d/d3/Anatomy_Park_7.png/revision/latest/scale-to-width-down/1200?cb=20160913082442",
    "https://static.wikia.nocookie.net/rickandmorty/images/3/39/S3e5_resort.png/revision/latest?cb=20171119203200",
    "https://static.wikia.nocookie.net/rickandmorty/images/b/ba/The_Smith_Residence.jpg/revision/latest?cb=20151015031818",
    "https://decider.com/wp-content/uploads/2021/06/rick-and-morty-5.jpg?quality=75&strip=all",
    "https://i.pinimg.com/736x/f0/a4/40/f0a44059fdc442bb3fac6c19c04f5ab2.jpg",
    "https://i.pinimg.com/236x/03/a8/2f/03a82f56b3dde7355531d9c52c16fd1f.jpg",
    "https://i.pinimg.com/564x/9e/d3/d9/9ed3d9f83422f5ee8faf5450489545e2.jpg",
    "https://i.pinimg.com/564x/b1/1d/8c/b11d8c97eb6a37377d2e076985520507.jpg",
    "https://i.pinimg.com/564x/70/01/43/700143678ddfb9dae5534bf3dca2e7ab.jpg",
    "https://pyxis.nymag.com/v1/imgs/dcb/698/eea6b585943cfb9f9ce6048e514f174dbc-The-Old-Man-and-the-Seat.1x.rsquare.w1400.jpg",
    "https://www.al.com/resizer/ZQ_Z1VR-w8avRmvpZTTS5tbLwRs=/arc-anglerfish-arc2-prod-advancelocal/public/HHIC7OU5KBFG5GVJRQXXGLO4CU.jpg",
  ],
);