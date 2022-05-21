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
    @Published var modelList: [CellInfo] = []
    
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
            guard let dataList = respondResult else {
                debugPrint("no list")
                return
            }
            var temp = [CellInfo]()
            for data in dataList {
                print(data)
                if let dict = data as? [String: Any], let model = TorrentModel.active(fromDict: dict) {
                    temp.append(CellInfo(type: .content, value: model))
                }
            }
            DispatchQueue.main.async {
                self.modelList = temp
            }
        }
    }
}
