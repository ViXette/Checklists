import UIKit


protocol ItemDetailTVCDelegate: class {

	func itemDetailTVCDidCancel (_ controller: ItemDetailTVC)

	func itemDetailTVC (_ controller: ItemDetailTVC, didFinishAdding item: ChecklistItem)

	func itemDetailTVC (_ controller: ItemDetailTVC, didFinishEditing item: ChecklistItem)

}



class ItemDetailTVC: UITableViewController, UITextFieldDelegate {

	@IBOutlet weak var item_textField: UITextField!
	@IBOutlet weak var cancel_barButton: UIBarButtonItem!
	@IBOutlet weak var done_barButton: UIBarButtonItem!

	weak var delegate: ItemDetailTVCDelegate?

	var itemToEdit: ChecklistItem?
	
	
	override func viewDidLoad () {
		super.viewDidLoad()

		item_textField.delegate = self

		if let itemToEdit = itemToEdit {
			title = "Edit Item"
			item_textField.text = itemToEdit.text
			done_barButton.isEnabled = true
		}
	}


	override func tableView (_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
		return nil
	}


	override func viewWillAppear (_ animated: Bool) {
		item_textField.becomeFirstResponder()
	}


	@IBAction func cancelTapped(_ sender: UIBarButtonItem) {
		navigationController?.popViewController(animated: true)

		delegate?.itemDetailTVCDidCancel(self)
	}


	@IBAction func doneTapped () {
		if let itemToEdit = itemToEdit {
			itemToEdit.text = item_textField.text!
			itemToEdit.checked = false

			delegate?.itemDetailTVC(self, didFinishEditing: itemToEdit)
		} else {
			let item = ChecklistItem()
			item.text = item_textField.text!
			item.checked = false

			delegate?.itemDetailTVC(self, didFinishAdding: item)
		}
	}


	func textField (_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let oldText = textField.text!
		let stringRange = Range(range, in: oldText)
		let newText = oldText.replacingCharacters(in: stringRange!, with: string)

		done_barButton.isEnabled = !newText.isEmpty

		return true
	}


//	func textFieldShouldReturn (_ textField: UITextField) -> Bool {
//		item_textField.resignFirstResponder()
//
//		return false
//	}

}
