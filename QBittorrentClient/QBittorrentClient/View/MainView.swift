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
    
    var headerTabsView: some View {
        TabsView(width:UIScreen.main.bounds.size.width,
                 titles: viewModel.sortTypeString,
                 selectedIndex: viewModel.selectTabIndex,
                 action: { (index) in
            viewModel.selectTabIndex(index)
        })
    }
    var contentCellListView: some View {
        
        List(viewModel.modelList, id: \.id ) { item in
            if item.type == .content, item.value is TorrentModel {
                let model = item.value as! TorrentModel
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(model.name)
                    
                    HStack(alignment: .center, spacing: 10) {
                        Text("Done:")
                        Text(String(format: "%.2f%%" , model.progress*100))
                    }
                    
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Size")
                            Text(model.size.getSizeString())
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Down Speed")
                            Text(model.dlspeed.getSizeString() + "/s")
                        }
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Up Speed")
                            Text(model.upspeed.getSizeString() + "/s")
                        }
                    }
                    
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack( alignment: .leading, spacing: 0){
                    headerTabsView
                    contentCellListView
                }
                .listStyle(PlainListStyle())
                .animation(.none, value: 0)
                .navigationBarItems(
                    leading: HStack {
                        BarButtonItem(imageSystemName: "text.justify") {
                            viewModel.menuOpened.toggle()
                        }
                    },
                    trailing: HStack {
                        BarButtonItem(imageSystemName: "arrow.clockwise.circle") {
                            viewModel.refreshStatus()
                        }.padding(.trailing, 10)
                        BarButtonItem(imageSystemName: "square.and.pencil", onClicked: {
                            viewModel.clickOnEdit()
                        })
                    }
                )
                .navigationBarTitle(viewModel.title ?? "qbittorrent", displayMode: .inline)
            }
            
            .offset(x: self.viewModel.menuOpened ?
                    0.6 * UIScreen.main.bounds.size.width : 0)
            .animation(.default, value: self.viewModel.menuOpened ?
                       0.6 * UIScreen.main.bounds.size.width : 0)
            SideMenu(width: 0.6 * UIScreen.main.bounds.size.width, menuOpened: viewModel.menuOpened, toggleMenu: {
                
                    viewModel.menuOpened.toggle()
            }) { index in
                viewModel.sideMenuSelectButtonIndex(index)
            }
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
