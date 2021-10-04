import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var downloadDataButton: UIButton!
    
    let networkLayer = NetworkLayer()
    
    @IBAction func downloadDataButtonDidTap(_ sender: Any) {
        networkLayer.getData(from: "https://raw.githubusercontent.com/bholovach/json/master/new.json") { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let persons):
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
                vc.contacts = persons
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class NetworkLayer {
    func getData(from url: String, completion: @escaping (Result<[Person], Error>) -> Void) {
        // трансформируем стринг юрл в переменную юрлреквест типа юрл
        guard let urlRequest = URL(string: url) else {
            return
        }
        
        // URLSession.shared.dataTask(with: urlRequest) { data, response, error in отвечает за запрос на сервер
        // дата - данные с сервера в закодиравнном виде, респонс - пока не нужен, еррор - ошибка (неправильный юрл, нет доступа или еще какая то поебота
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            //  проверяме пришла ли нам дата (дата не равно нил)
            guard let data = data else {
                print("data is nil")
                return
            }
            
            // если нет ошибок то идем дальше по коду
            guard error == nil else {
                print("error")
                return
            }
            
            do {
                // создаем декодер для подальшего использования
                let decoder = JSONDecoder()
                // трансфоормируем ключ с сервера (например first_name) в название нашей переменной (firstName)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                // декодируем данные из data в массив [NewPerson]
                let persons = try decoder.decode([Person].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(persons))
                }
            } catch { // если не удается декодировать то выполняется catch block
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

struct NewPerson: Decodable {
    let firstName: String
    let lastName: String
    let gender: String
}

//struct NewPerson: Decodable {
//    let imya: String
//    let familiya: String
//    let pol: String
//
//    enum CodingKeys: String, CodingKey {
//        case imya = "first_name"
//        case familiya = "last_name"
//        case gender
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.imya = try values.decode(String.self, forKey: .familiya)
//        self.familiya = try values.decode(String.self, forKey: .familiya)
//        self.pol = try values.decode(String.self, forKey: .gender)
//    }
//}
