import UIKit
import Photos

protocol InfoViewControllerDelegate {
    func savePerson(at index: Int, person: Person)
}

class InfoViewController: UIViewController {
    
    @IBOutlet private weak var firstNameLabel: UILabel!
    @IBOutlet private weak var lastNameLabel: UILabel!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var lastNameTexField: UITextField!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateNumberLabel: UILabel!
    @IBOutlet weak var addPhotoButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    var images = [PHAsset]()
    var delegate: InfoViewControllerDelegate?
    var index: Int?
    @IBAction private func didTapSaveButton(_ sender: Any) {
        guard let index = index else {
            return
        }
        
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {
            showAlert(title: "Ошибка", message: "Введите имя", buttonTitle: "Ок")
            return
        }
        
        guard let lastName = lastNameTexField.text, !lastName.isEmpty else {
            showAlert(title: "Ошибка", message: "Введите фамилию", buttonTitle: "Ок")
            return
        }
        
        let person = Person(firstName: firstName, lastName: lastName, date: datePicker.date)
        delegate?.savePerson(at: index, person: person)
        navigationController?.popViewController(animated: true)
    }
    
    func configure(person: Person) {
        firstNameLabel.text = "Имя"
        lastNameLabel.text = "Фамилия"
        saveButton.setTitle("Сохранить", for: .normal)
        firstNameTextField.placeholder = "Имя"
        lastNameTexField.placeholder = "Фамилия"
        title = person.firstName + " " + person.lastName
    }
    
    private func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
