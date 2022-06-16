//
//  WeatherInformation.swift
//  07Weather
//
//  Created by Good geon Lee on 2022/06/16.
//

import Foundation

//Codable: json decoding & encoding 가능
//key와 변수명이 같아야함 (다른 경우 CodingKey Protocol 채택)
struct WeatherInformation: Codable {
    let weather: [Weather]
    let temp: Temp
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case name
    }
}


struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
