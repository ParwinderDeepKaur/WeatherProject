//
//  ViewController.swift
//  Weather Project
//
//  Created by Appsmartz on 13/03/22.
//

import UIKit
let API_Key = "15d0a0969631954044983ff714cbd22f"
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchWeatherOfLocation(lon:75.7771589,lat:31.1287481)
    }
    
    // show alert view with message, if any error occur
    private func showError(_ message:String) {
        let alertVC = UIAlertController(title:"Error", message: message, preferredStyle: .alert)
        let retry = UIAlertAction(title:"Retry", style: .default) { [weak self] action in
            self?.fetchWeatherOfLocation(lon:75.7771589,lat:31.1287481)
        }
        alertVC.addAction(retry)
        present(alertVC, animated: true, completion: nil)
    }

    // fetching list of dog breeds from remote server using API
    private func fetchWeatherOfLocation(lon:Double,lat:Double) {
        guard let all_breeds_url = URL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(API_Key)") else { return }
        var request = URLRequest(url: all_breeds_url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.showError(error.localizedDescription)
                } else if let data = data {
                    do {
                        let dictRespone = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                        print("Response:\(dictRespone)")
                    } catch {
                        self?.showError("Invalid JSON response")
                    }
                } else {
                    self?.showError("Nil Data response")
                }
            }
        }
        task.resume()
    }

}

