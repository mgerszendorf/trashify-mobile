//
//  EditSheetView.swift
//  Trashify
//
//  Created by Marek Gerszendorf on 07/10/2023.
//

import SwiftUI

enum UpdateType {
    case email, username
}

struct EditSheetView: View {
    @Binding var isPresented: Bool
    var title: String
    @Binding var text: String
    var updateType: UpdateType
    @EnvironmentObject var userManagementViewModel: UserManagementViewModel
    @EnvironmentObject var darkModeManager: DarkModeManager
    
    @State private var showError: Bool = false

    var body: some View {
        VStack {
            Text(title)
                .bold()
                .font(.system(size: 20))
                .foregroundColor(Color.primary)
                .padding(.bottom, 20)
                .padding(.top, 30)

            TextField("Enter \(title.lowercased())", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .padding(.bottom, 15)
                .accentColor(AppColors.originalGreen)
                .onChange(of: text) { newValue in
                    switch updateType {
                    case .email:
                        userManagementViewModel.newEmail = newValue
                    case .username:
                        userManagementViewModel.newUsername = newValue
                    }
                }

            if userManagementViewModel.errorMessage != nil {
                Text(userManagementViewModel.errorMessage ?? "Unknown error")
                    .foregroundColor(.red)
                    .padding(.bottom, 15)
            }

            Button(action: {
                switch updateType {
                case .email:
                    userManagementViewModel.updateEmail()
                case .username:
                    userManagementViewModel.updateUsername()
                }
            }) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(width: 100, height: 40)
                    .background(AppColors.darkerGreen)
                    .cornerRadius(10.0)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.horizontal)
    }
}

struct EditSheetView_Previews: PreviewProvider {
    @State static var mockIsPresented: Bool = true
    @State static var mockText: String = "Example Text"
    
    static var previews: some View {
        EditSheetView(isPresented: $mockIsPresented, title: "Edit Email", text: $mockText, updateType: .email)
    }
}