//
//  TabsView.swift
//  NOADance
//
//  Created by Jack on 2021/5/19.
//

import SwiftUI

struct TabsView: View {
    var width: CGFloat
    var titles = [String]()
    var selectedIndex: Int = 0
    var action: (Int)->()
    
    private let perWidth: CGFloat
    @State var offset: CGFloat
    
    init(width: CGFloat, titles: [String], selectedIndex: Int, action: @escaping (Int)->()) {
        self.width = width
        self.titles = titles
        self.action = action
        self.selectedIndex = selectedIndex
        self.perWidth = width / CGFloat(titles.count)
        self.offset = CGFloat(CGFloat(selectedIndex) * perWidth)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 0, content: {
            ForEach(0..<self.titles.count, id:\.self) { index in
                _SelectBoxButton(action: {
                    self.offset = CGFloat(CGFloat(index) * perWidth)
                    self.action(index)
                }, title: self.titles[index], width: self.perWidth)
            }
        }).frame(height: 50)
        _SliderView(offset: offset, width: perWidth)
        //            .animation(.default, value: offset)
    }
}

struct _SliderView: View {
    var offset: CGFloat
    var width: CGFloat
    
    var body: some View {
        Color.red
            .frame(width: width, height: 5, alignment: .center)
            .offset(x: offset, y: 0)
            .animation(.easeOut, value: offset)
    }
}

struct _SelectBoxButton: View {
    var action: ()->()
    var title: String
    var width: CGFloat
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title).frame(width: width).foregroundColor(.red)
        })
    }
}
