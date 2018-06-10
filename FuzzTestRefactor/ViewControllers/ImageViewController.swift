//
//  DetailViewController.swift
//  FuzzTestRefactor
//
//  Created by Lisa J on 6/9/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    
    var imageUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: imageUrl!) {
            getImage(url: url)
        }
    }

    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) ->()) {
        URLSession.shared.dataTask(with: url){(data, response, error) in
            completion(data, response, error)
        }.resume()
    }
    
    private func getImage(url: URL){
        getDataFromUrl(url: url, completion: {(data, response, error) in
            guard let data = data, error == nil else {return}
            if UIImage(data: data) != nil {
                DispatchQueue.main.async {
                    self.detailImageView.image = UIImage(data: data)
                }
            } else {
                DispatchQueue.main.async {
                    self.detailImageView.image = #imageLiteral(resourceName: "na")
                }
            }
        })
    }
}
