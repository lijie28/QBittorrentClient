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
    @Published var selectTabIndex = 0
    private var myTimer: Timer? = nil
    let sortTypeString = ["Size", "Done", "Down", "up"]
    
    init() {
        self.myTimer = Timer.scheduledTimer(timeInterval:1,
                                            target:self,
                                            selector:#selector(self.refreshStatus),
                                            userInfo:nil,
                                            repeats:true)
        self.refreshStatus()
    }
    
    
    func selectTabIndex(_ index: NSInteger) {
        self.selectTabIndex = index
        self.refreshStatus(forceUpdate: true)
    }
    
    func clickOnEdit() {
        self.showingSetting = true
    }
    
    @objc func refreshStatus(forceUpdate: Bool = false) {
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
            
            if let modelList = TorrentModel.active(fromArray: dataList)?.sorted(by: {
                switch self.selectTabIndex {
                case 0:
                    return $0.size > $1.size
                case 1:
                    return $0.progress > $1.progress
                case 2:
                    return $0.dlspeed > $1.dlspeed
                case 3:
                    return $0.upspeed > $1.upspeed
                default:
                    return $0.size > $1.size
                }
                
            }) {
                for model in modelList {
                    temp.append(CellInfo(type: .content, value: model))
                }
            }
            
            
            DispatchQueue.main.async {
                if forceUpdate || self.modelList.count != temp.count  {
                    self.modelList = temp
                } else {
                    // prevent reset scroll when data update
                    for index in 0..<self.modelList.count {
                        self.modelList[index].value = temp[index].value
                    }
                }
            }
            
        }
    }
}
