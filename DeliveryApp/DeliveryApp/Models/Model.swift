//
//  Api.swift
//  DeliveryApp
//
//  Created by Abduraxmon on 03/04/23.
//

import Foundation

protocol ModelDelegate {
    func dataFetch(_ data:ProductModel)
}

class Model {
    
    var delegate: ModelDelegate?
    
    func getPizzas() {
        //Create url object
        let url = URL(string: K.url)
        
        guard url != nil else {
            return
        }
        //Create urlSession object
        let sesion = URLSession.shared
        
        //Get data task from urlsession obj
        let dataTask = sesion.dataTask(with: url!) { (data, response, error) in
            //Check if there were any errors
            if error != nil || data == nil {
                return
            }
            
            do {
                //Parsing the data to video object
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(ProductModel.self, from: data!)
                // call the delegate method
                if !response.isEmpty {
                    self.delegate?.dataFetch(response)
                }
            } catch {
                
            }
            
        }
        //Kick off the task
        dataTask.resume()
    }
    
}
