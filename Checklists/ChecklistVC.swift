import UIKit


class ChecklistVC: UITableViewController {
	
	var items: [ChecklistItem]


	required init?(coder aDecoder: NSCoder) {
		items = [ChecklistItem]()
		
		let row0Item = ChecklistItem()
		row0Item.text = "Walk the dog"
		row0Item.checked = false
		items.append(row0Item)
		
		let row1Item = ChecklistItem()
		row1Item.text = "Brush my teeth"
		row1Item.checked = false
		items.append(row1Item)
		
		let row2Item = ChecklistItem()
		row2Item.text = "Learn iOS development"
		row2Item.checked = false
		items.append(row2Item)
		
		let row3Item = ChecklistItem()
		row3Item.text = "Soccer pratice"
		row3Item.checked = false
		items.append(row3Item)
		
		let row4Item = ChecklistItem()
		row4Item.text = "Eat ice cream"
		row4Item.checked = false
		items.append(row4Item)
		
		super.init(coder: aDecoder)
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
		
		let item = items[indexPath.row]
		
		
		configureText(for: cell, with: item)
		configureCheckmark(for: cell, with: item)
		
		return cell
	}
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			let item = items[indexPath.row]
			item.toggleChecked()
			
			configureCheckmark(for: cell, with: item)
		}
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	
	func configureText (for cell: UITableViewCell, with item: ChecklistItem) {
		let label = cell.viewWithTag(1000) as! UILabel
		label.text = item.text
	}
	
	
	func configureCheckmark (for cell: UITableViewCell, with item: ChecklistItem) {
		cell.accessoryType = item.checked ? .checkmark : .none
	}

}
