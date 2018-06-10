//
//  ViewController.swift
//  FuzzTestRefactor
//
//  Created by Lisa J on 6/9/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var dataList = [FuzzData]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var presentedData = [FuzzData]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func selectedSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            presentedData = dataList
        case 1:
            presentedData = dataList.filter{($0.type == "text")}
        case 2:
            presentedData = dataList.filter{($0.type == "image")}
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 400
        getDataFromFuzz()
    }

    private func getDataFromFuzz() {
        let endpoint = "http://quizzes.fuzzstaging.com/quizzes/mobile/1/data.json"
        if let url = URL(string: endpoint) {
            URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else {return}
                do {
                    let decoder = JSONDecoder()
                    let fuzzData = try decoder.decode([FuzzData].self, from: data)
                    self.dataList = fuzzData
                    self.presentedData = fuzzData
                    print("data",fuzzData)
                } catch let error {
                    print("Error getting fuzzData", error)
                }
            }.resume()
        } else {
            print("Not a valid url")
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presentedData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FuzzCell", for: indexPath) as! FuzzTableViewCell
        let data = presentedData[indexPath.row]
        cell.configureCell(cell: cell, data: data)
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = presentedData[indexPath.row]

        switch data.type {
        case "image":
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let imageViewController = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as! ImageViewController
             imageViewController.imageUrl = data.data
            navigationController?.pushViewController(imageViewController, animated: true)
            
        case "text":
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let webViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController")
            navigationController?.pushViewController(webViewController, animated: true)
        default:
            break
        }
    }
}
