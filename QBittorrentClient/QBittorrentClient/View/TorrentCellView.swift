//
//  TorrentCellView.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/23.
//

import SwiftUI

struct TorrentCellView: View {
     var model: TorrentModel
    
    var body: some View {
        
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(model.name)
                    Spacer()
                    
                        Group {
                            switch model.state {
                            case .pausedDL, .pausedUP:
                                
                                BaseButtonView(imageSystemName: "pause.circle.fill", size: 35, onClicked:  {
                                    print("pause")
                                })
                            default:
                                
                                BaseButtonView(imageSystemName: "arrowtriangle.forward.circle.fill", size: 35, onClicked:  {
                                    print("forward")
                                })
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    
                    
                    
                }
                
                
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

//struct TorrentCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        TorrentCellView()
//    }
//}
