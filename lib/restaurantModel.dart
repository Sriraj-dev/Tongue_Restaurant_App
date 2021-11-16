

List items = [];
List<String> categories = [];
List categoryItems = [];
bool underMaintenance = false;
bool updateAvailable = false;

initialiseCategories(){
  categories = [];
  items.map((e) => {
    categories.add(e.category)
  });
}

initialiseCategoryItems(){
  categoryItems = [];
  items.map((e) => {
    categoryItems.add(e.items)
  });
}
