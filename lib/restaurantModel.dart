List items = [];
List<String> categories = [];
List categoryItems = [];
bool underMaintenance = false;
bool updateAvailable = false;
List<Map<String,dynamic>> menu = [];

initialiseCategories(){
  categories = [];// === > [biryani, chinese, ...]
  items.forEach((e) {
    categories.add(e['category']);
  });
}

initialiseCategoryItems(){
  categoryItems = [];
  // items.map((e) => {
  //   categoryItems.add(e.items)
  // });
  items.forEach((e) {
    categoryItems.add(e['items']); // list of items. [biryaniitems , chineseitems ...]
  });
}

initialiseMenu(){
  categoryItems.forEach((e) {
    e.forEach((item){
      menu.add({
        'id': item['id'],
        'item': item
      });
    });
  });
}

