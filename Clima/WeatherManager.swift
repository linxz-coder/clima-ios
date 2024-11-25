import Foundation

struct WeatherManager {
    let weatherURL =
    "https://api.openweathermap.org/data/2.5/weather?appid=2681fe78b902a849c6b60336c8ed332a&&units=metric&lang=zh_cn"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
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
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    self.parseJSON(weatherData: safeData) //在closure里面要加self.
                    
                    //测试响应
                    //let dataString = String(data: safeData, encoding: .utf8)
                    //print(dataString!)
                }
            }
            
            //4.Start the task
            task.resume()
        }
    }
    
    func parseJSON (weatherData: Data){
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
            
        } catch{
            print(error)
        }
    }
    

}
