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
    @Published var menuOpened = false
    
    
    private var myTimer: Timer? = nil
    let sortTypeString = ["Down", "up", "Size", "Done"]
    let filterList = ["all", "downloading", "completed", "paused", "active", "inactive"]
    var selectFilterIndex = 0
    
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
    
    func sideMenuSelectButtonIndex(_ index: NSInteger) {
        if index < 6 {
            self.selectFilterIndex = index
            self.refreshStatus(forceUpdate: true)
        } else if index == 6 {
            NetworkManager.shared.setAllTorrents(pause: true) { _,_ in
                self.refreshStatus(forceUpdate: true)
            }
        } else if index == 7 {
            NetworkManager.shared.setAllTorrents(pause: false) { _,_ in
                self.refreshStatus(forceUpdate: true)
            }
        }
    }
    
    func clickOnEdit() {
        self.showingSetting = true
    }
    
    @objc func refreshStatus(forceUpdate: Bool = false) {
        guard let config = DefaultUtils.shared.getSettingModel() else {
            return
        }
        title = "http://\(config.ip):\(config.port)"
        
        NetworkManager.shared.getList(parameters: "filter=\(self.filterList[selectFilterIndex])") { respondResult, respondError in
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
                case 2:
                    return $0.size > $1.size
                case 3:
                    return $0.progress > $1.progress
                case 0:
                    return $0.dlspeed > $1.dlspeed
                case 1:
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
