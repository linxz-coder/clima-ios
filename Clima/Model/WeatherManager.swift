import Foundation
import CoreLocation

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManage:WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?appid=2681fe78b902a849c6b60336c8ed332a&&units=metric&lang=zh_cn"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longtitude:CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        //1.Create a url
        if let url = URL(string: urlString){
            //2.Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3.Give the session a task
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    //在closure里面要加self.
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                    //测试响应
                    //let dataString = String(data: safeData, encoding: .utf8)
                    //print(dataString!)
                }
            }
            
            //4.Start the task
            task.resume()
        }
    }
    
    func parseJSON (_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decoderData.main.temp)
            print(decoderData.weather[0].description)
            
            let id = decoderData.weather[0].id
            let temp = decoderData.main.temp
            let name = decoderData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            
            print(weather.conditionName)
            print(weather.temperaturestring)
            
            return weather
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    

}
