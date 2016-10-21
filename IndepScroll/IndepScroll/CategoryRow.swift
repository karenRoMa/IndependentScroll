//
//  CategoryRow.swift
//  IndepScroll
//
//  Created by Karen Viviana Rodriguez Macias on 11/10/16.
//  Copyright © 2016 Karen Viviana Rodriguez Macias. All rights reserved.
//

import Foundation
import UIKit

class CategoryRow : UITableViewCell{
    let images = ["https://s-media-cache-ak0.pinimg.com/564x/25/cd/b0/25cdb011604f0c4e6bdb45bab03bfdf1.jpg","https://s-media-cache-ak0.pinimg.com/564x/fd/b0/73/fdb073d7f30c8d8e29866bc720220100.jpg","https://s-media-cache-ak0.pinimg.com/564x/1e/67/49/1e67493c5d91e7d9f6e1302d5239e66e.jpg","https://s-media-cache-ak0.pinimg.com/564x/7a/50/9a/7a509a3ee7b7180b613344ab74ef9ecd.jpg"]
    
}

extension CategoryRow: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! PhotoCell
       //let imageCell = UIImage(named: images[indexPath.row])
        //let photo = photoForIndexPath(indexPath)
        cell.indicator.isHidden = false
        cell.indicator.startAnimating()
        if indexPath.section == 0{
            if let checkedUrl = URL(string: images[indexPath.row]) {
                downloadImage(url: checkedUrl){ image in
                cell.imageViewCell.image = image
                cell.indicator.stopAnimating()
                cell.indicator.isHidden = true
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Pelicula seleccionada. Index : \(indexPath.row)")
        
    }
    

    
}

extension CategoryRow: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let itemsPerRow : CGFloat = 4
        let hardCodedPadding : CGFloat = 5
        //let itemWidth = (collectionView.bounds.width/itemsPerRow) - hardCodedPadding
        let itemWidth = 200.0 - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2*hardCodedPadding)
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
    URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        completion(data, response, error)
        }.resume()
}

func downloadImage(url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
    getDataFromUrl(url: url) { (data, response, error)  in
        DispatchQueue.main.sync() { () -> Void in
            guard let data = data, error == nil else { return }
            let image = UIImage(data: data)
            completion(image)
        }
    }
}
