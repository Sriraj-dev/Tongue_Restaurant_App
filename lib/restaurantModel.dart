List items = [];
List<String> categories = [];
List categoryItems = [];
bool underMaintenance = false;
bool updateAvailable = false;
List<Map<String,dynamic>> menu = []; // list of maps = = {id: UniqueId , item: Item}

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
  menu = [];
  categoryItems.forEach((e) {
    e.forEach((item){
      menu.add({
        'id': item['id'],
        'item': item
      });
    });
  });
}

