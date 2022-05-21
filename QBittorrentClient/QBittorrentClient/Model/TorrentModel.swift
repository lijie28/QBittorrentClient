//
//  TorrentModel.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/21.
//

import Foundation

struct TorrentModel: Codable {
    let dlspeed: Int
    let eta: Int
//    let f_l_piece_prio: Int
//    let forceStart: Int
    let hash: String
    let label: String
    let name: String
//    let numComplete: Int
//    let numIncomplete: Int
//    let numLeechs: Int
//    let numSeeds: Int
    let priority: Int
    let progress: Double
    let ratio: Double
//    let savePath: String
//    let seqDl: Int
    let size: Int
    let state: String
//    let superSeeding: Int
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
