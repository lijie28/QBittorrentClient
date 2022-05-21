//
//  MainView.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/18.
//

import SwiftUI

extension Int {
    func getSizeString() -> String {
        var sizeStr = ""
        if self > 1024 * 1024 * 1024 {
            sizeStr = String(format: "%.2f Gib", Double(self) / (1024 * 1024 * 1024))
        }
        else if self > 1024 * 1024{
            sizeStr = String(format: "%.2f Mib", Double(self) / (1024 * 1024 ))
        }
        else if self > 1024{
            sizeStr = String(format: "%.2f Kib", Double(self) / 1024)
        }
        else{
            sizeStr = String(format: "%d B", self)
        }
        return sizeStr
    }
}

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.modelList, id: \.id ) { item in
                if item.type == .content, item.value is TorrentModel {
                    let model = item.value as! TorrentModel
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(model.name)
                        
                        HStack() {
                            Text(model.size.getSizeString())
                            Text(String(format: "%.2f%%" , model.progress*100))
                        }
                        
                    }
                }
            }
            .listStyle(PlainListStyle())
            .animation(.none, value: 0)
                .navigationBarItems(
                    leading: HStack {
                        BarButtonItem(imageSystemName: "square.and.pencil", onClicked: {
                            viewModel.clickOnEdit()
                        })
                    },
                    trailing: HStack {
                        BarButtonItem(imageSystemName: "arrow.clockwise.circle") {
                            viewModel.refreshStatus()
                        }.padding(.trailing, 10)
                    }
                )
                .navigationBarTitle(viewModel.title ?? "qbittorrent", displayMode: .inline)
            
        }
        .fullScreenCover(isPresented: $viewModel.showingSetting, content: {
            SettingView(viewModel: SettingViewModel()) { hasBeenEdited in
                if hasBeenEdited {
                    viewModel.refreshStatus()
                }
            }
        })
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
