//
//  DataController.swift
//  Curriculum Vitae
//
//  Created by Farouke Nnajiofor on 2019-10-20.
//  Copyright © 2019 Farouke Nnajiofor. All rights reserved.
//

import Foundation

let cvDataUrlString = "https://firebasestorage.googleapis.com/v0/b/malta-b7a9a.appspot.com/o/HSBC%20Recuirtmant%20Data%2Fdataeset.json?alt=media&token=7ae9770f-f8f1-42f0-89f4-9eefdc68db1c"

struct Vitae : Codable {
    let CVImage : String
    let name : String
    let title : String
    let socialMedia : String
    let bio : String
    let skills : String
    let education : String
    let experiences : String
    let references : String
}

func fetchData(url: URL,
               completionHandler: @escaping (Data?, Error?) -> Void) {
    let cvDownloadTask = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
        completionHandler(data, error)
    })
    cvDownloadTask.resume()
}

func fetchCVData(url: URL,
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

func parseCVData(data: Data,
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

func decodeDataFromJSONToVitae(data: Data) -> (Vitae?, String?) {
    do {
        return (try JSONDecoder().decode(Vitae.self, from: data), nil)
    } catch {
        return (nil, error.localizedDescription)
    }
}

func fetchImageData(url: URL,
                    completionHandler: @escaping (Data) -> Void) {
    
    fetchData(url: url, completionHandler: {data, _ in
        if let data = data {
            DispatchQueue.main.async {
                completionHandler(data)
            }
        }
    })
    
}