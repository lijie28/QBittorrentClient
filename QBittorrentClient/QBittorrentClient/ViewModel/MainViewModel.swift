//
//  MainViewModel.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/20.
//

import Foundation

class MainViewModel: ObservableObject {
    
    @Published var showingSetting = false
    @Published var title: String? = nil
    
    init() {
        self.refreshStatus()
    }
    
    func clickOnEdit() {
        self.showingSetting = true
    }
    
    func refreshStatus() {
        guard let config = DefaultUtils.shared.getSettingModel() else {
            return
        }
        title = "http://\(config.ip):\(config.port)"
        
        NetworkManager.shared.getList { respondResult, respondError in
            guard respondError == nil else {
                debugPrint(respondError!.description)
                return
            }
            debugPrint(respondResult)
        }
    }
}
