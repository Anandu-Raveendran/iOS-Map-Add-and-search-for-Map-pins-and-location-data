//
//  CountryListViewController.swift
//  Anandu sem 2 final project
//
//  Created by Nandu on 2021-09-30.
//

import UIKit

class CountryListViewController: UITableViewController {

    var countries:[String] = []
    var callback:((String)->())!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCountries()

        // Do any additional setup after loading the view.
    }
    
    func getCountries(){
//        for code in NSLocale.isoCountryCodes  {
//            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
//            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
//            countries.append(name)
//        }
    
        let request = URLRequest(url: URL(string: String("http://api.countrylayer.com/v2/all?access_key=2dfd33238a1cefd5313d6fc5b2bab705"))!)

        
        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            
            if let data = data{
                if let results = self.parse(data){
                
                    results.forEach({country in
                        self.countries.append(country.name)
                        print(country.name)
                    })
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            
            
        }

        
        task.resume()
        
    }
    

    func parse(_ data:Data) -> [SearchResults]? {
     
//        do{
//        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
//        print("Data:  \(String(describing: json))")
//        } catch{
//            print("error to string")
//        }
//
        let decoder = JSONDecoder()
        do{
            let results = try decoder.decode([SearchResults].self, from: data)
            return results
        } catch
        {
            print("Error parsing")
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        callback(countries[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return countries.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            }
            
            cell?.textLabel?.text = countries[indexPath.row]
            
            return cell!
        }
}
