//
//  AppConfig.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/18.
//

import Foundation

struct AppConfig {
    static let iconSize = 20.0
    static let iconPadding = 10.0
    static let edgePadding = 8.0
    static let normalCornerRadius = 5.0
}


struct QbittorrentConfig {
    static let shared = QbittorrentConfig()
    var baseUrl: String? {
        get {
            guard let config = DefaultUtils.shared.getSettingModel() else {
                return nil
            }
            return "http://\(config.ip):\(config.port)"
        }
    }
}
