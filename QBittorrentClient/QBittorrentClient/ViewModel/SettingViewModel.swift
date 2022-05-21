//
//  SettingViewModel.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/18.
//

import Foundation

class SettingViewModel: ObservableObject {
    
    enum ErrorStatus: String {
        case failCreated = "Fail created a new session"
        case failResponsed  = "Fail Responsed"
        case failAuthorized = "Fail authorized"
    }
    
    @Published var ip: String = ""
    @Published var port: String = ""
    @Published var username: String = ""
    @Published var pwd: String = ""
    @Published var config: SettingModel? = nil
    @Published var isEditing = false
    @Published var result: String? = nil
    @Published var errorMes: String? = nil
    @Published var successMes: String? = nil
    @Published var pwdCanSee = false
    @Published var hasBeenEdited = false
    
    init() {
        if let config = DefaultUtils.shared.getSettingModel() {
            self.config = config
            self.ip = config.ip
            self.port = config.port
            self.username = config.username
            self.pwd = config.pwd
        }
        self.refreshStatus()
    }
    
    func refreshStatus() {
    }
    
    func cleanSSHResut() {
        self.result = nil
    }
    
    func updateSelectedDate(_ selectedDate: [String], index: Int) {
//        self.cellData = SSHSettingViewModel.getCellData()
        self.refreshStatus()
    }
    
    func clickOnEdit() {
        self.isEditing = true
    }
    
    func cancelEditting() {
        self.isEditing = false
        self.errorMes = nil
        self.successMes = nil
    }
    
    func deleteConfig() {
        ip = ""
        port = ""
        username = ""
        pwd = ""
        let config = SettingModel(ip: ip,
                                  port: port,
                               username: username,
                               pwd: pwd)
        DefaultUtils.shared.saveSettingModel(config)
        self.errorMes = nil
        self.successMes = "Setting config was deleted Successfully"
        self.hasBeenEdited = true
    }
    
    func saveConfig() {
        guard !ip.isEmpty else {
            self.errorMes = "Save Error: no ip"
            return
        }
        guard !port.isEmpty else {
            self.errorMes = "Save Error: no port"
            return
        }
        guard !username.isEmpty else {
            self.errorMes = "Save Error: no username"
            return
        }
        guard !pwd.isEmpty else {
            self.errorMes = "Save Error: no pwd"
            return
        }
        
        let config = SettingModel(ip: ip,
                                  port: port,
                               username: username,
                               pwd: pwd)
        DefaultUtils.shared.saveSettingModel(config)
        self.errorMes = nil
        self.successMes = "Setting config was saved successfully"
        self.hasBeenEdited = true
    }
}
