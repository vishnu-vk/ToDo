//
//  WeatherDataService.swift
//  ToDo
//
//  Created by Vishnu on 09/07/24.
//

import Foundation

class WeatherDataService {
    
    static let instance = WeatherDataService()
    private init() {}
    
    private let apiBaseUrl = "https://api.open-meteo.com/v1/"
    
    func getWeatherData(for latitude:Double, and longitude: Double, completionHandler: @escaping (ForecastModel) -> Void) {
        
        let urlString = apiBaseUrl + "forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,weather_code"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                return
            }
            
            guard let data = data else { return }
            
            do {
                let forecastData = try JSONDecoder().decode(ForecastModel.self, from: data)
                completionHandler(forecastData)
            } catch let parsingError {
                print("Error parsing response: \(parsingError.localizedDescription)")
            }
        }.resume()
    }
}
