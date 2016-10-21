//
//  SetImage.swift
//  IndepScroll
//
//  Created by Karen Viviana Rodriguez Macias on 13/10/16.
//  Copyright © 2016 Karen Viviana Rodriguez Macias. All rights reserved.
//

import Foundation
import UIKit

func getDataFromUrl(url: URL, completionHandler: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
    URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        completionHandler(data, response, error)
        }.resume()
}

func downloadImage(url: URL, cell : UICollectionViewCell) {
    print("Download Started")
    getDataFromUrl(url: url) { (data, response, error)  in
        DispatchQueue.main.sync() { () -> Void in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            cell.backgroundColor = UIColor.black
        }
    }
}
