//
//  SideMenu.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/22.
//

import SwiftUI

struct SideMenu: View {
    let width: CGFloat
    let menuOpened: Bool
    let toggleMenu: () -> Void
    let selectButtonIndex: (Int) -> Void
    
    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.black.opacity(0.7))
            .opacity(self.menuOpened ? 1 : 0)
            .animation(Animation.default.delay(0.25), value: menuOpened)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.toggleMenu()
            }
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    MenuContent(width: width, selectButtonIndex: selectButtonIndex)
                    Spacer().edgesIgnoringSafeArea(.all)
                }
                Spacer().edgesIgnoringSafeArea(.all)
            }
            .animation(.default, value: menuOpened)
            .offset(x: menuOpened ? 0 : -width)
        }
    }
}


struct MenuContent: View {
    
    var width: CGFloat
    let selectButtonIndex: (Int) -> Void
    let buttonTitles = ["all", "downloading", "completed", "paused", "active", "inactive", "pauseAll", "resumeAll"]
    let fontSize: CGFloat = 16
    
    var maxSize: CGSize = CGSize(width: 0, height: 0)
    
    init(width: CGFloat, selectButtonIndex: @escaping (Int) -> Void) {
        self.width = width
        self.selectButtonIndex = selectButtonIndex
        self.maxSize = self.getMaxSize()
    }
    
    func getMaxSize() -> CGSize {
        var maxWidth = 0.0
        var maxHeight = 0.0
        for title in buttonTitles {
            let textSize = title.getStystemStyleSize(size: fontSize)
            if textSize.width > maxWidth {
                maxWidth = textSize.width
            }
            if textSize.height > maxHeight {
                maxHeight = textSize.height
            }
        }
        return CGSize(width: maxWidth, height: maxHeight)
    }
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(Array(buttonTitles.enumerated()), id: \.offset) { index, title in
                contentCell(title: title, textSize: self.maxSize, index: index)
            }
        }
        .padding(.top, 50)
    }
    
    /// 侧拉菜单cell
    /// - Parameters:
    ///   - title: 标题
    ///   - textSize: 算上边框的最大size
    ///   - index: 点击标识
    /// - Returns: View
    func contentCell(title: String, textSize: CGSize, index: Int) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: textSize.width + 12, height: textSize.height + 16)
            Button {
                selectButtonIndex(index)
            } label: {
                Text(title)
                    .font(.system(size: fontSize))
                    .foregroundColor(.gray)
            }
            .frame(width: textSize.width + 12, height: textSize.height + 16)
            .padding(10)
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu(width: 200, menuOpened: true) {
            
        } selectButtonIndex: { _ in
            
        }
    }
}

struct MenuContent_Previews: PreviewProvider {
    static var previews: some View {
        MenuContent(width: 100) { index in
            print(index)
        }
    }
}


extension String {
    func getStystemStyleSize(size: CGFloat) -> CGSize {
        let font = UIFont.systemFont(ofSize: size)
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: fontAttributes)
        return size
    }
}
