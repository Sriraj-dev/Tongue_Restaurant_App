//import 'package:delivery_app/components/SearchBox.dart';
import 'package:delivery_app/Screens/dish.dart';
import 'package:delivery_app/constants.dart';
import 'package:delivery_app/restaurantModel.dart';
import 'package:delivery_app/userModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchText = new TextEditingController();
  List allItems = [];
  List searchItems = [];

  initialiseAllItems() {
    menu.forEach((e) {
      allItems.add(e['item']);
    });
    searchItems = allItems;
  }

  setSearchItems(String searchText) {
    List tempList = [];
    allItems.forEach((e) {
      if (e['itemName'].toLowerCase().contains(searchText.toLowerCase())) {
        tempList.add(e);
      }
    });
    searchItems = tempList;
  }

  @override
  void initState() {
    super.initState();

    initialiseAllItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Background_Color,
      appBar: topBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (searchText.text.isEmpty)
                  ? Container()
                  : Text(
                      'Found ${searchItems.length} results',
                      style: GoogleFonts.lora(
                          fontWeight: FontWeight.bold, fontSize: 22),
                    ),
              showSearchItems(),
            ],
          ),
        ),
      ),
    );
  }

  showSearchItems() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: (searchItems.isEmpty)
          ? Container(
              child: Lottie.asset(
                'assets/search.json',
              ),
            )
          : ListView.builder(
              itemCount: searchItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Dish(searchItems[
                              index])), // map == name,cost,id,offer.
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Material(
                      elevation: 5,
                      shadowColor: kPrimaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        //height: MediaQuery.of(context).size.height*0.15,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: [
                                    //itemImage
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Hero(
                                        tag: searchItems[index]['id'],
                                        child: Image.network(
                                          searchItems[index]['image'],
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        itemDetails(searchItems, index),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: (userCart.contains(
                                                      searchItems[index]['id']))
                                                  ? ksecondaryColor
                                                  : kPrimaryColor,
                                              // padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (!userCart.contains(
                                                    searchItems[index]['id'])) {
                                                  addToUserCart(
                                                      searchItems[index]['id']);
                                                } else {
                                                  print('trying to remove');
                                                  removeFromUserCart(
                                                      searchItems[index]['id']);
                                                }
                                              });
                                            },
                                            child: Center(
                                              child: Text(
                                                (userCart.contains(
                                                        searchItems[index]
                                                            ['id']))
                                                    ? 'Added'
                                                    : 'Add to Cart',
                                                style: GoogleFonts.lora(
                                                  fontSize: 17,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 4),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Container(
                                              width: 16,
                                              height: 16,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: (searchItems[index]
                                                              ['type'] ==
                                                          'veg')
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4)),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: (searchItems[index]
                                                                ['type'] ==
                                                            'veg')
                                                        ? Colors.green
                                                        : Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 70,
                                          ),
                                          LikeButton(
                                            //onTap: onLikeButtonTapped(isLiked,e[index]),
                                            isLiked: userFav.contains(
                                                searchItems[index]['id']),
                                            likeBuilder: (isLiked) {
                                              final color = isLiked
                                                  ? Colors.red
                                                  : Colors.grey;
                                              return Icon(
                                                Icons.favorite,
                                                color: color,
                                                size: 30,
                                              );
                                            },
                                            onTap: (isLiked) async {
                                              setState(() {
                                                // if (!userFav.contains(e[index]))
                                                //   userFav.add(e[index]);
                                                // else {
                                                //   userFav.remove(e[index]);
                                                // }
                                                if (!userFav.contains(
                                                    searchItems[index]['id'])) {
                                                  addToUserFav(
                                                      searchItems[index]['id']);
                                                } else {
                                                  removeFromUserFav(
                                                      searchItems[index]['id']);
                                                }
                                              });
                                              return !isLiked;
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  Padding itemDetails(e, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: Text(e[index]['itemName'],
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: kTextColor,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              '₹' + e[index]['cost'],
              style: TextStyle(
                fontSize: 16,
                color: kTextLightColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize topBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(250),
      child: Padding(
        padding: const EdgeInsets.only(top: 32),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  elevation: 3,
                  shadowColor: kPrimaryColor.withOpacity(0.5),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: IconButton(
                        iconSize: 25,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: kTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              searchBox(),
            ],
          ),
        ),
      ),
    );
  }

  searchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        elevation: 3,
        shadowColor: kPrimaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        child: Container(
          //margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width * 0.65,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 2,
                    spreadRadius: 0.5)
              ]),
          child: TextField(
            onChanged: (value) {
              setState(() {
                setSearchItems(searchText.text);
              });
            },
            controller: searchText,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search ",
              hintStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: kTextColor.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
