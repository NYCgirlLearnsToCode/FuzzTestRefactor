//
//  FuzzTableViewCell.swift
//  FuzzTestRefactor
//
//  Created by Lisa J on 6/9/18.
//  Copyright © 2018 Lisa J. All rights reserved.
//

import UIKit

class FuzzTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fuzzImageView: UIImageView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dataTextView: UITextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url){(data, response, error)in
            completion(data, response, error)
        }.resume()
    }
    
    func getImage(cell: FuzzTableViewCell, url: URL) {
        getDataFromUrl(url: url, completion: {(data, response, error) in
            guard let data = data, error == nil
                else {return}
            DispatchQueue.main.async {
                cell.fuzzImageView.image = UIImage(data: data)
            }
        })
    }
    
    
    func configureCell(cell: FuzzTableViewCell, data: FuzzData) {
        cell.fuzzImageView?.image = nil
        if let imageUrl = URL(string: data.data ?? "" ) {
            activityIndicator.startAnimating()
            getImage(cell: cell, url: imageUrl)
            cell.setNeedsLayout()
            activityIndicator.stopAnimating()
        } else {
            cell.fuzzImageView.image = #imageLiteral(resourceName: "na")
        }
        cell.idLabel.text = "Id: \(data.id)"
        cell.dataTextView.text = "Data: \(data.data ?? "No data available")"
        cell.typeLabel.text = "Type: \(data.type)"
        cell.dateLabel.text = "Date: \(data.date ?? "No date available")"
    }
}
