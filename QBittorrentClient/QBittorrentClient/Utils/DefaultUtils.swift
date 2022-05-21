//
//  DefaultUtils.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/18.
//

import Foundation

import Foundation

class DefaultUtils {
    static let shared = DefaultUtils()
    
    private let kSettingConfig = "kSettingConfig"
    private let kTokenKey = "token"
    
    func setToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: kTokenKey)
    }
    
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: kTokenKey)
    }
    
    func saveSettingModel(_ model: SettingModel) {
        if model.isEmpty() {
            UserDefaults.standard.removeObject(forKey: kSettingConfig)
        } else {
            do {
                // Create JSON Encoder
                let encoder = JSONEncoder()
                // Encode Note
                let data = try encoder.encode(model)
                // Write/Set Data
                UserDefaults.standard.set(data, forKey: kSettingConfig)
            } catch {
                print("Unable to Encode Setting Config (\(error))")
            }
        }
    }
    
    func getSettingModel() -> SettingModel? {
        if let data = UserDefaults.standard.data(forKey: kSettingConfig) {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                // Decode Note
                let config = try decoder.decode(SettingModel.self, from: data)
                return config
            } catch {
                print("Unable to Decode Setting Config (\(error))")
                return nil
            }
        }
        return nil
    }
}
