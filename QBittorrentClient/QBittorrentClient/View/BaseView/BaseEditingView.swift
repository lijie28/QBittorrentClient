//
//  BaseEditingView.swift
//  NOADance
//
//  Created by Jack on 2022/05/10.
//

import SwiftUI

enum BaseEditingViewType {
    case noral
    case secureMode(canSee: Bool)
    
    var isNormal: Bool {
        switch self {
        case .noral:
            return true
        default:
            return false
        }
    }
    
    var isSecureMode: Bool {
        switch self {
        case .secureMode(canSee: false):
            return true
        default:
            return false
        }
    }
}

struct BaseEditingView: View {
    enum focusedField {
        case unSecure, secure
    }
    let title: String
    @Binding var editContent: String
    
    let type: BaseEditingViewType
    @FocusState var focused: focusedField?
    var clickCompletion:(()->Void)?
    var keyboardType: UIKeyboardType = .alphabet
    
    let cornerRadius = 8.0
    
    init(title: String, editContent: Binding<String>, type: BaseEditingViewType, clickCompletion: (()->Void)? = nil) {
        self._editContent = editContent
        self.title = title
        self.type = type
        self.clickCompletion = clickCompletion
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
            
            ZStack(alignment: .trailing) {
                TextField(
                    editContent,
                    text: $editContent
                ).keyboardType(keyboardType)
                    .focused($focused, equals: .unSecure)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //                    .border(.secondary)
                //                    .cornerRadius(cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(.secondary, lineWidth: 1)
                    )
                    .opacity(type.isSecureMode ? 0 : 1)
                SecureField(
                    editContent,
                    text: $editContent
                )
                    .focused($focused, equals: .secure)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                //                    .border(.secondary)
                //                    .cornerRadius(cornerRadius)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(.secondary, lineWidth: 1)
                    )
                    .opacity(type.isSecureMode ? 1 : 0)
                if !type.isNormal {
                    Button(action: {
                        focused = (focused == .secure) ? .secure : .unSecure
                        clickCompletion?()
                    }, label: {
                        BaseIconView(systemName:type.isSecureMode ?  "eye.slash": "eye")
                    })
                }
            }
            .frame( height: 30)
            .padding(.top, 5)
        }
    }
}
