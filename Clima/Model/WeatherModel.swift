import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperaturestring: String{
        String(format: "%.1f", temperature)
    }
    
    var conditionName: String{
        switch conditionId {
        case 200...299:
            return "cloud.bolt"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "snowflake"
        case 700...799:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 800-804:
            return "cloud"
        default:
            return "cloud.bolt"
        }
    }
    
}
