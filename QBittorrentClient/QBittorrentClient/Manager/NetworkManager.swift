//
//  NetworkManager.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/20.
//

import Foundation

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    
    func getList(completition: @escaping (([AnyObject]?, APIError?) -> Void)) {
        
        guard let config = DefaultUtils.shared.getSettingModel() else {
            completition(nil, APIError.unknown)
            return
        }
        let baseUrlString = "http://\(config.ip):\(config.port)"
        guard let url = URL(string: baseUrlString+"/query/torrents") else {
            completition(nil, APIError.unknown)
            return
        }
        
        guard let token = DefaultUtils.shared.getToken() else {
            completition(nil, APIError.unknown)
            return
        }
        
        let headers = [
            "charset": "UTF-8",
            "Content-Type": "text/plain",
            "Cookie": "SID=\(token)",
        ]
//        let parameters = "username=\(config.username)&password=\(config.pwd)"
        self.baseRequest(httpMethod: "GET", url: url, headers: headers, parameters: nil) { result, err, cookies in
            
            completition(result, err)
//            if let error = err, error.isUnacceptableError {
//                debugPrint(error.description)
//                completition(error)
//                return
//            }
//            if let cookies = cookies {
//                for cookie in cookies {
//                    if cookie.name == "SID" {
//                        let token = cookie.value
//                        DefaultUtils.shared.setToken(token)
//                        completition(nil)
//                        return
//                    }
//                }
//            }
//            completition(APIError.unknown)
//            return
        }
    }
    
    
    func updateCookies(completition: @escaping ((APIError?) -> Void)) {
        
        guard let config = DefaultUtils.shared.getSettingModel() else {
            return
        }
        let baseUrlString = "http://\(config.ip):\(config.port)"
        guard let url = URL(string: baseUrlString+"/login") else {
            return
        }
        
        let headers = [
            "Referer": baseUrlString,
            "Content-Type": "application/x-www-form-urlencoded"]
        
        self.baseRequest(url: url, headers: headers, parameters: "username=\(config.username)&password=\(config.pwd)") { result, err, cookies in
            if let error = err, error.isUnacceptableError {
                debugPrint(error.description)
                completition(error)
                return
            }
            if let cookies = cookies {
                for cookie in cookies {
                    if cookie.name == "SID" {
                        let token = cookie.value
                        DefaultUtils.shared.setToken(token)
                        completition(nil)
                        return
                    }
                }
            }
            completition(APIError.unknown)
            return
        }
    }
    
    
    func baseRequest(httpMethod: String = "POST", url: URL, headers: Dictionary<String, String>?, parameters: String?, completition: @escaping (([AnyObject]?, APIError?, [HTTPCookie]?) -> Void)) {
        
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        if let parameters = parameters {
            request.httpBody = parameters.data(using: .utf8)
        }
        
        let task = session.dataTask(with: request) { data, response, responseError in
            guard let url = response?.url,
                  let httpResponse = response as? HTTPURLResponse,
                  let fields = httpResponse.allHeaderFields as? [String: String] else {
                      debugPrint("unknown error!")
                      completition(nil, APIError.unknown, nil)
                      return
                  }
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
            if httpResponse.statusCode == 403 {
                completition(nil, APIError.needUpdate, cookies)
                return
            } else if httpResponse.statusCode != 200 {
                completition(nil, APIError.badResponse(statusCode: httpResponse.statusCode), cookies)
                return
            }
            
            guard responseError == nil, let data = data else {
                debugPrint("request error:", responseError!)
                completition(nil, APIError.ogError(responseError), cookies)
                return
            }
            
            do {
                
                guard let respondJson = try JSONSerialization.jsonObject(with: data) as? [AnyObject] else {
                    completition(nil, APIError.jsonDecodeError(nil), cookies)
                    return
                }
                completition(respondJson, nil, cookies)
            } catch {
                debugPrint("json error!")
                completition(nil, APIError.jsonDecodeError(error), cookies)
            }
        }
        task.resume()
    }
}
