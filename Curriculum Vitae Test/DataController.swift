//
//  DataController.swift
//  Curriculum Vitae
//
//  Created by Farouke Nnajiofor on 2019-10-20.
//  Copyright © 2019 Farouke Nnajiofor. All rights reserved.
//

import Foundation

let cvDataUrlString = "https://firebasestorage.googleapis.com/v0/b/funnaji-e5102.appspot.com/o/dataset.json?alt=media&token=40f8485c-ad7c-437c-b339-f1d9eaec36b2"

class DataController {
    
    static private func fetchData(url: URL,
                   completionHandler: @escaping (Data?, Error?) -> Void) {
        let cvDownloadTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            completionHandler(data, error)
        })
        cvDownloadTask.resume()
    }
    
    static func fetchCVData(url: URL,
                     completionHandler: @escaping (Vitae) -> Void,
                     errorHandler: @escaping (String) -> Void) {
        
        fetchData(url: url, completionHandler: {data, error in
            if let data = data {
                parseCVData(data: data, completionHandler: completionHandler, errorHandler: errorHandler)
            } else if let error = error {
                DispatchQueue.main.async {
                    errorHandler(error.localizedDescription)
                }
            } else {
                DispatchQueue.main.async {
                    errorHandler("Unknown error occured while loading the CV.")
                }
            }
        })
        
    }
    
    static func parseCVData(data: Data,
                     completionHandler: @escaping (Vitae) -> Void,
                     errorHandler: @escaping (String) -> Void) {
        
        let decodedData = decodeDataFromJSONToVitae(data: data)
        
        if let vitae = decodedData.0 {
            DispatchQueue.main.async {
                completionHandler(vitae)
            }
            return
        }
        
        if let error = decodedData.1 {
            DispatchQueue.main.async {
                errorHandler(error)
            }
        }
        
    }
    
    static private func decodeDataFromJSONToVitae(data: Data) -> (Vitae?, String?) {
        do {
            return (try JSONDecoder().decode(Vitae.self, from: data), nil)
        } catch {
            return (nil, error.localizedDescription)
        }
    }
    
    static func fetchImageData(url: URL,
                        completionHandler: @escaping (Data) -> Void) {
        
        DataController.fetchData(url: url, completionHandler: {data, _ in
            if let data = data {
                DispatchQueue.main.async {
                    completionHandler(data)
                }
            }
        })
        
    }
    
}
