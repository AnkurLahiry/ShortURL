//
//  Service.swift
//  ShortURL
//
//  Created by Ankur on 17/5/21.
//

import Foundation

public protocol ShortURLServiceDelegate {
    func didGenerate(short url: String, for longURL: String)
    func didFailGenerate(for longURL: String, error: Error?)
}

public enum ShortenError: Error {
    case emptyString
}

public class ShortURLService {
    
    public var delegate: ShortURLServiceDelegate?
    
    public init() { }
    
    public func requestShort(for service: URLShorterProvider) {
        switch service {
        case .bitly(let authorization, let longURL):
            guard let url = service.providerURL?.rawValue else { return }
            guard let request = generateBitlyRequest(with: authorization, url: url, longURL: longURL) else { return }
            start(request: request, longURL: longURL)
        }
    }
    
    private func generateBitlyRequest(with authorization: String,
                                      url: String,
                                      longURL: String) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        let body = BitlyPostBody(longURL: longURL)
        request.httpBody = try? JSONEncoder().encode(body)
        request.httpMethod = "POST"
        request.addValue(authorization, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func start(request: URLRequest, longURL: String) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                self.delegate?.didFailGenerate(for: longURL, error: error)
                return
            }
            guard let data = data else {
                self.delegate?.didFailGenerate(for: longURL, error: error)
                return
            }
            guard let decode = try? JSONDecoder().decode(BitlyResponseModel.self, from: data) else {
                self.delegate?.didFailGenerate(for: longURL, error: ShortenError.emptyString)
                return
            }
            guard let url = decode.link, !url.isEmpty else {
                self.delegate?.didFailGenerate(for: longURL, error: ShortenError.emptyString)
                return
            }
            self.delegate?.didGenerate(short: url, for: longURL)
        }
        task.resume()
    }
    
}
