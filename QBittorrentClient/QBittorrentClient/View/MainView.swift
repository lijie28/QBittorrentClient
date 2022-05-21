//
//  MainView.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/18.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            EmptyView()
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
