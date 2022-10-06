//
//  TorrentModel.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/21.
//

import Foundation


enum TorrentState: String, Codable  {
    case error    // Some error occurred, applies to paused torrents
    case pausedUP    // Torrent is paused and has finished downloading
    case pausedDL    // Torrent is paused and has NOT finished downloading
    case queuedUP    // Queuing is enabled and torrent is queued for upload
    case queuedDL    // Queuing is enabled and torrent is queued for download
    case uploading    // Torrent is being seeded and data is being transferred
    case stalledUP    // Torrent is being seeded, but no connection were made
    case checkingUP    // Torrent has finished downloading and is being checked; this status also applies to preallocation (if enabled) and checking resume data on qBt startup
    case checkingDL    // Same as checkingUP, but torrent has NOT finished downloading
    case downloading    // Torrent is being downloaded and data is being transferred
    case stalledDL    // Torrent is being downloaded, but no connection were made
    case metaDL    // Torrent has just started downloading and is fetching metadata
}

struct TorrentModel: Codable, BaseModelProtocol {
    static func getPreviewModel() -> BaseModelProtocol {
        return TorrentModel(dlspeed: 20, eta: 20, hash: "hash", label: "label", name: "name", priority: 4, progress: 0.3, ratio: 0.5, size: 100, state: .pausedDL, upspeed: 30)
    }
    
    let dlspeed: Int
    let eta: Int
    let hash: String
    let label: String
    let name: String
    let priority: Int
    let progress: Double
    let ratio: Double
    let size: Int
    let state: TorrentState
    let upspeed: Int
    
    static func active(fromDict dict: [String: Any]) -> TorrentModel? {
        do {
            let json = try JSONSerialization.data(withJSONObject: dict)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode(TorrentModel.self, from: json)
            return model
        } catch {
            print(error)
            return nil
        }
    }
    
    static func active(fromArray array: [AnyObject]) -> [TorrentModel]? {
        do {
            let json = try JSONSerialization.data(withJSONObject: array)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let model = try decoder.decode([TorrentModel].self, from: json)
            return model
        } catch {
            print(error)
            return nil
        }
    }
}
