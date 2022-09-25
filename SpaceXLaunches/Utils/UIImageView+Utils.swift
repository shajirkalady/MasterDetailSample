//
//  UIImageView+Utils.swift
//  SpaceXLaunches
//
//  Created by Shajir Kalady on 9/23/22.
//

import Foundation
import UIKit

extension UIImageView {

    func cacheAndLoadImage(url: String, completion: ((Result<Bool, Error>) -> Void)?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //check for cached image
        if let image = appDelegate.nsCache.object(forKey: url as NSString) {
            self.image = image
            completion?(.success(true))
            return
        }
        
        //Load image from server
        guard let _url = URL(string: url) else {
            completion?(.failure(NwError.networkError))
            return
        }
        
        URLSession.shared.dataTask(with: _url, completionHandler: { (data, response, error) in
            if error != nil {
                print("Error : \(String(describing: error))")
                completion?(.failure(NwError.networkError))
                return
            }
            
            if let data = data {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                        appDelegate.nsCache.setObject(image, forKey: url as NSString)
                        completion?(.success(true))
                    }
                }
            }
        }).resume()
    }
}
