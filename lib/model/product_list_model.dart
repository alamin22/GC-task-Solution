class ProudctListModel{
   String name;
   String title;
   int price;
   int discount;
   String image;
   String des;
   ProudctListModel({
    required this.name, 
    required this.title,
    required this.price,
    required this.discount,
    required this.image,
    required this.des,
  });
}
  List<ProudctListModel> productList = [
   ProudctListModel(name: "Medicine 1", title: 'ACME Limited',price: 20,discount: 18,image: 'https://ace.globalintegrity.org/wp-content/uploads/2019/08/AdobeStock_171882033.jpeg',des: 'medicines have enabled doctors to cure many diseases and save lives. These days, medicines come from a variety of sources.'),
   ProudctListModel(name: "Medicine 2", title: 'Incepta',price: 60,discount: 55,image: 'https://resize.indiatvnews.com/en/resize/newbucket/730_-/2022/09/medicine-1663091617.jpg',des: 'People take medicines to fight illness, to feel better when theyre sick, and to keep from getting sick in the first place.'),
   ProudctListModel(name: "Medicine 3", title: 'ACME Limited',price: 50,discount: 44,image: 'https://www.healthnavigator.org.nz/media/17089/pills-and-tablets-canva-665x443.png?mode=pad&width=360&height=240',des: 'medicines have enabled doctors to cure many diseases and save lives. These days, medicines come from a variety of sources.'),
   ProudctListModel(name: "Medicine 4", title: 'Incepta',price: 40,discount: 35,image: 'https://resize.indiatvnews.com/en/resize/newbucket/730_-/2022/09/medicine-1663091617.jpg',des: 'People take medicines to fight illness, to feel better when theyre sick, and to keep from getting sick in the first place.'),
   ProudctListModel(name: "Medicine 5", title: 'ACME Limited',price: 10,discount: 9,image: 'https://pediaa.com/wp-content/uploads/2016/06/Difference-Between-Drug-and-Medicine-2.jpg',des: 'medicines have enabled doctors to cure many diseases and save lives. These days, medicines come from a variety of sources.'),
   ProudctListModel(name: "Medicine 6", title: 'Incepta',price: 30,discount: 24,image: 'https://resize.indiatvnews.com/en/resize/newbucket/730_-/2022/09/medicine-1663091617.jpg',des: 'People take medicines to fight illness, to feel better when they re sick, and to keep from getting sick in the first place.'),
  ];