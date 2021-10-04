import UIKit

class TableViewController: UIViewController {
    var contacts: [Person] = []
//        = [
//        .init(firstName: "Bogdan", lastName: "Golovach", date: nil),
//        .init(firstName: "Danil", lastName: "Kozyr", date: nil),
//        .init(firstName: "Aleks", lastName: "Alekseenko", date: nil),
//        .init(firstName: "Roman", lastName: "Pedchenko", date: nil),
//        .init(firstName: "Ivan", lastName: "Zavals", date: nil),
//        .init(firstName: "Dmytro", lastName: "Gorb", date: nil),
//    ]
            
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: "PersonTableViewCell")
        }
    }
    
    @IBAction private func editDidTap(_ sender: Any) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
        } else {
            tableView.setEditing(true, animated: true)
        }
    }
    
    @IBAction private func addDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "AddNewPersonViewController") as! AddNewPersonViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonTableViewCell", for: indexPath) as! PersonTableViewCell
        cell.configure(person: contacts[indexPath.row])
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "InfoViewController") as! InfoViewController
        vc.view.backgroundColor = .white // костыль чтобы не было краша
        vc.configure(person: contacts[indexPath.row])
        vc.index = indexPath.row
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension TableViewController: InfoViewControllerDelegate {
    func savePerson(at index: Int, person: Person) {
        contacts[index] = person
        tableView.reloadData()
    }
}

extension TableViewController: AddNewPersonViewControllerDelegate {
    func addPerson(person: Person) {
        contacts.append(person)
        tableView.reloadData()
    }
}
