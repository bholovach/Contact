import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(person: Person) {
        fullNameLabel.text = person.getFullName()
        dateOfBirthLabel.text = person.date?.convertToString()
    }
}

fileprivate extension Date {
    func convertToString() -> String {
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yy"
        let stringDate = formater.string(from: self)
        return stringDate
    }
}

extension Person {
    func getFullName() -> String {
        return self.firstName + " " + self.lastName
    }
}
