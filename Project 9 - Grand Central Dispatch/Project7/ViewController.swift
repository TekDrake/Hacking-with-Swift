//
//  ViewController.swift
//  Project7
//
//  Created by Juan Garcia on 6/19/17.
//  Copyright © 2017 Juan Garcia. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [[String: String]]()
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //fetchJSON()
        // performSelector
        performSelector(inBackground: #selector(fetchJSON), with: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        cell.textLabel?.text = "Title goes here"
//        cell.detailTextLabel?.text = "Subtitle goes here"

        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        return cell
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Title
    func fetchJSON() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
 
        //First implementation
//        if let url = URL(string: urlString) {
//            if let data = try? Data(contentsOf: url) {
//                let json = JSON(data: data)
//                
//                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
//                    parse(json: json)
//                } else {
//                    showError()
//                }
//            } else {
//                showError()
//            }
//        } else {
//            showError()
//        }
        //Second implementation
//        if let url = URL(string: urlString) {
//            if let data = try? Data(contentsOf: url) {
//                let json = JSON(data: data)
//                
//                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
//                    parse(json: json)
//                    return
//                }
//            }
//        }
//        
//        showError()
        //GCD
        //DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    let json = JSON(data: data)
                    
                    if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                        self.parse(json: json)
                        return
                    }
                }
            }
            
           // self.showError()
        //}
        // PerformSelector
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    //MARK: - Helper methods
    func parse(json: JSON) {
        for result in json["results"].arrayValue {
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]
            petitions.append(obj)
        }
        
        //tableView.reloadData()
        //GCD
//        DispatchQueue.main.async { [unowned self] in
//            self.tableView.reloadData()
//        }
        //performSelector
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    func showError() {
//        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
//        present(ac, animated: true)
        //GCD
        DispatchQueue.main.async { [unowned self] in
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
}

