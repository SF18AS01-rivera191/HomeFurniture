
import UIKit;

class FurnitureTableViewController: UITableViewController {

    struct PropertyKeys {
        static let furnitureCell: String = "FurnitureCell";
        static let furnitureSegue: String = "ToFurnitureDetail";
    }
    
    var rooms: [Room] = [
        Room(name: "Living Room",
             furniture: [Furniture(name: "Couch", description: "A comfy place to sit down."),
                         Furniture(name: "Television", description: "Entertainment for all to watch."),
                         Furniture(name: "Coffee Table", description: "A great place to set down your drink.")]),
        Room(name: "Kitchen",
             furniture: [Furniture(name: "Stove", description: "Warm and cook your food here."),
                         Furniture(name: "Oven", description: "Bake a delicious treat for your friends."),
                         Furniture(name: "Sink", description: "Don't forget to clean the dishes!")]),
        Room(name: "Bedroom",
             furniture: [Furniture(name: "Bed", description: "A place to sleep during the night."),
                         Furniture(name: "Desk", description: "Study to keep your mind sharp."),
                         Furniture(name: "Closet", description: "Hang up your clothes to keep them unwrinkled.")])];
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return rooms.count;
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms[section].furniture.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.furnitureCell, for: indexPath);
        
        //Configure the cell ...
        let room: Room = rooms[indexPath.section];
        let furniture: Furniture = room.furniture[indexPath.row];
        cell.textLabel?.text = furniture.name;
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard (0 ..< rooms.count).contains(section) else {
            return "Oops!";
        }
        
        return rooms[section].name;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndexPath: IndexPath = tableView.indexPathForSelectedRow else {return;}
        if segue.identifier == PropertyKeys.furnitureSegue {
            let selectedRoom: Room = rooms[selectedIndexPath.section];
            let selectedFurniture: Furniture = selectedRoom.furniture[selectedIndexPath.row];
            let furnitureDetailViewController: FurnitureDetailViewController? = segue.destination as? FurnitureDetailViewController;
            furnitureDetailViewController?.furniture = selectedFurniture;
        }
    }
}
