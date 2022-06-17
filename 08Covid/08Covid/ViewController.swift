//
//  ViewController.swift
//  08Covid
//
//  Created by 李 グッゴン on 2022/06/17.
//

import UIKit
import Charts
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var totalCaseLabel: UILabel!
    @IBOutlet weak var newCaseLabel: UILabel!
    
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchCovidoverview(completionHandler: { result in
            switch result {
            case let .success(result):
                debugPrint("success \(result)")
            case let .failure(result):
                debugPrint("error \(result)")
            }
        })
    }
    
    private func fetchCovidoverview(
        completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void
    
    ) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        let param = [
            "serviceKey": API_KEY
        ]
        
        AF.request(url, method: .get, parameters: param)
            .responseData(completionHandler: { [weak self] response in
                guard let self = self else { return }
                switch response.result {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CityCovidOverview.self, from: data)
                        completionHandler(.success(result))
                    } catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            })
    }


}

