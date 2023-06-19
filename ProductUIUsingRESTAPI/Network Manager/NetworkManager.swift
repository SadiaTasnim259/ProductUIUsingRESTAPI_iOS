//
//  NetworkManager.swift
//  ProductUIUsingRESTAPI
//
//  Created by Sadia on 19/6/23.
//

import Foundation

struct NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
}


//MARK: - Http Request
extension NetworkManager{
    
    func httpRequest<T: Decodable>(urlString: String, httpMethodType: HttpMethodType,  respnseType: T.Type, completionHandler: @escaping(Result<T, NetworkErrors>) -> Void) {
        
        guard let removedSpaceURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)//This will fill the spaces with the %20
        else {
            print("HTTP_ERROR: FAILED to Remove Space URL")
            completionHandler(.failure(.invalidURL))
            return
        }
        
        
        guard let url = URL(string: removedSpaceURL) else {
            print("HTTP_ERROR: FAILED to Create URL")
            completionHandler(.failure(.invalidURL))
            return
        }
        
        
        var request : URLRequest?
        
        
        //request.httpBody = params.percentEscaped().data(using: .utf8)
        do {
            request = try buildRequest(fron: url, methodType: httpMethodType)
        } catch {
            print("HTTP_ERROR: FAILED to generate body, error: \(error.localizedDescription)")
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        guard let request else{
            print("HTTP_ERROR: Request is nil")
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("HTTP_ERROR: \(error.localizedDescription)")
                completionHandler(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                print("HTTP_ERROR: Invalid Response. Response status code \(statusCode)")
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                print("HTTP_ERROR: data is nil")
                completionHandler(.failure(.invalidData))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(respnseType, from: data)
                completionHandler(.success(decodedResponse))
            } catch {
                print("HTTP_ERROR: FAILED to Decode data, Error: \(error)")
                completionHandler(.failure(.invalidData))
            }
        }.resume()
        
    }
}


extension NetworkManager{
    private func buildRequest(fron url: URL, methodType: HttpMethodType) throws -> URLRequest{
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
        
        switch methodType{
            
        case .GET:
            request.httpMethod = "GET"
        case .POST(params: let params):
            request.httpMethod = "POST"
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        case .PUT(params: let params):
            request.httpMethod = "PUT"
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        case .DELETE:
            request.httpMethod = "DELETE"
        }
        
        return request
    }
}


//MARK: - Enum
extension NetworkManager{
    enum HttpMethodType{
        case GET
        case POST(params: [String: Any])
        case PUT (params: [String: Any])
        case DELETE
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
