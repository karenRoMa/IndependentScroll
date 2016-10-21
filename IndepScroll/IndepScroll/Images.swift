//
//  Images.swift
//  IndepScroll
//
//  Created by Karen Viviana Rodriguez Macias on 13/10/16.
//  Copyright © 2016 Karen Viviana Rodriguez Macias. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import SwiftyJSON

class Images : AnyObject{

    
    //var actionJSON : JSON
    //var dramaJSON : JSON
    //var scienfict : JSON
    
    func refreshImages(gender: String, completionHandler: @escaping ( JSON?, NSError?, String) -> ()) {

        
        let headers: HTTPHeaders = [
            "Api-Key": "gzw5svpscncc9zantnfdpj7b",
            //"Api-Secret" : "8DXPqjE5fygXaF9j7dXSrUpR9rvPrdKPYR9ZeKArNNJBz",
            "Accept": "application/json"
        ]
        
        Alamofire.request("https://api.gettyimages.com/v3/search/images?fields=id,title,thumb,referral_destinations&sort_order=most_popular&phrase=\(gender)",headers:headers).responseJSON{ response in
            switch response.result{
            case .success :
                if let jsonValue = response.result.value{
                    let genderJSON = JSON(jsonValue)
                    completionHandler(genderJSON, nil, "Datos obtenidos correctamente")
                    //if let urlImage = genderJSON["images"][0]["referral_destinations"]["uri"].string{
                    //print(urlImage)
                    //}
                    
                }
                break
            case .failure(let error) :
                completionHandler( nil, error as NSError?, "Error")
                break
            }
        }
    }
}
