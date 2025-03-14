struct Country: Codable {
    let name: String
    let capital: String
    let code: String
    let region: String
    let currency: Currency
    let language: Language
    let flag: String
    
    struct Currency: Codable {
        let code: String
        let name: String
        let symbol: String?
    }
    
    struct Language: Codable {
        let code: String?
        let name: String
    }
}