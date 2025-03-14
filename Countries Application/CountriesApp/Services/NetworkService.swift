import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchCountries(completion: @escaping (Result<[Country], Error>) -> Void) {
        guard let url = URL(string: "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                completion(.success(countries))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}