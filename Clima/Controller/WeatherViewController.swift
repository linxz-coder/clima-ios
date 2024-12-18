import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //先delegate才不会crash
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }
    
    @IBAction func LocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

//MARK: - UITextFieldDelegate

//extension:textField
extension WeatherViewController: UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        //keyboard退出
        print(searchTextField.text!)
    }
    
    // textfield生命周期：处理键盘回车
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        //keyboard退出
        searchTextField.endEditing(true)
        return true
    }
    
    //textfield生命周期：验证是否应该结束编辑
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            //如果未输入内容，不应该结束编辑，返回false
            textField.placeholder = "Type something"
            return false
        }
    }
    
    //textfield生命周期：完成编辑
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        
        //清空输入框
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate
//extention: WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate{
    
    
    func didUpdateWeather(_ weatherManage:WeatherManager, weather: WeatherModel){
        //异步任务必须包裹
        DispatchQueue.main.async{
            print(weather.conditionId)
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperaturestring
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }

        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - LocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude:lat, longtitude:lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}
