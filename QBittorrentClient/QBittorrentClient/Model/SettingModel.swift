//
//  SettingModel.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/18.
//

import Foundation

struct SettingModel: Codable  {
    let ip: String
    let port: String
    let username: String
    let pwd: String
    
    func isEmpty() -> Bool {
        if ip.isEmpty,
           port.isEmpty,
           username.isEmpty,
           pwd.isEmpty
        {
            return true
        }
        return false
    }
}
