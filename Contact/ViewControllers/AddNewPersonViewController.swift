import UIKit

protocol AddNewPersonViewControllerDelegate {
    func addPerson(person: Person)
}

class AddNewPersonViewController: UIViewController {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var addPersonButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.maximumDate = Date()
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField! {
        didSet {
            lastNameTextField.borderStyle = .none
            lastNameTextField.placeholder = "************"
            lastNameTextField.textAlignment = .center
        }
    }
    
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            firstNameTextField.borderStyle = .none
            firstNameTextField.placeholder = "Введите имя"
            firstNameTextField.textAlignment = .center
        }
    }
    
    var delegate: AddNewPersonViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новый штемп"
        firstNameLabel.text = "Имя"
        lastNameLabel.text = "Фамилия"
        addPersonButton.setTitle("Сохранить", for: .normal)
        dateLabel.text = "День рождения"
    }
    
    @IBAction func didTapAddPerson(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty else {
            showAlert(title: "Ошибка", message: "Введите имя", buttonTitle: "Ок")
            return
        }
        
        guard let lastName = lastNameTextField.text, !lastName.isEmpty else {
            showAlert(title: "Ошибка", message: "Введите фамилию", buttonTitle: "Ок")
            return
        }
            
        let person = Person(firstName: firstName, lastName: lastName, date: datePicker.date)
        delegate?.addPerson(person: person)
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
