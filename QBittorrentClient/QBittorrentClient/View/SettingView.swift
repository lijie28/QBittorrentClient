//
//  SettingView.swift
//  QBittorrentClient
//
//  Created by Jack on 2022/05/18.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: SettingViewModel
    
    @State private var restStartTimePickerShow = false
    @State private var restEndTimePickerShow = false
    @State private var timeFrequencyPickerShow = false
    var onDisapper: ((_ hasBeenEdited: Bool)->Void)? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                if let mes = viewModel.errorMes {
                    MessageBarView(mes: mes, type: .error, bottomPadding: 5, textHeight: 30)
                } else if let mes = viewModel.successMes {
                    MessageBarView(mes: mes, type: .success, bottomPadding: 5, textHeight: 30)
                }
                
                ScrollView(showsIndicators: false) {
                    //                List {
                    //                    if viewModel.isEditing {
                    Group {
                        textFildArea
                            .padding(.bottom, 10)
                        buttonArea
                        Spacer(minLength: 30)
                        Divider()
                    }
                    .padding([.leading, .trailing], 8)
                    //                    }
                    
                    if viewModel.result != nil {
                        self.sshResultView()
                    }
                }
                .padding([.leading, .trailing], 8)
            }
            .navigationBarItems(
                leading: BaseButtonView(imageSystemName: "xmark", onClicked: {
                    if viewModel.isEditing {
                        viewModel.cancelEditting()
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                })
            )
            .navigationBarTitle("http://\(viewModel.ip):\(viewModel.port)", displayMode: .inline)
        }
        .onDisappear(perform: {
            self.onDisapper?(viewModel.hasBeenEdited)
        })
    }
    
    func sshResultView() -> some View {
        return VStack {
            HStack {
                Text("👇👇👇")
                    .padding(.top, 20)
                    .padding(.bottom, 5)
                Spacer()
                Button {
                    viewModel.cleanSSHResut()
                } label: {
                    BaseIconView(imageSystemName: "trash")
                }
                .padding(.trailing, 10)
            }
            HStack {
                VStack(alignment: .leading, spacing: 0)  {
                    Text(viewModel.result!)
                        .padding()
                        .foregroundColor(.green)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.green, lineWidth: 1)
                        )
                }
                Spacer()
            }
        }
    }
    
    var textFildArea: some View {
        VStack {
            BaseEditingView(title: "ip:", editContent: $viewModel.ip, type: .noral)
                .padding(.bottom, 10)
            BaseEditingView(title: "port:", editContent: $viewModel.port, type: .noral)
                .padding(.bottom, 10)
            BaseEditingView(title: "username:", editContent: $viewModel.username, type: .noral)
                .padding(.bottom, 10)
            BaseEditingView(title: "pwd:", editContent: $viewModel.pwd, type: .secureMode(canSee: viewModel.pwdCanSee)) {
                viewModel.pwdCanSee.toggle()
            }
            .padding(.bottom, 10)
        }
    }
    
    var buttonArea: some View {
        return HStack {
            Button("save", role: .destructive) {
                viewModel.saveConfig()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
            Button("delete", role: .destructive) {
                viewModel.deleteConfig()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
            .padding([.leading, .trailing], 10)
            Spacer()
            Button("cancel", role: .destructive) {
                viewModel.cancelEditting()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.regular)
        }
    }
    
}
