//
//  ContentView.swift
//  PocketSchedule
//
//  Created by Austin Trumbly on 2/19/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var store = Store()
    @State private var showingSettings = false
    @State private var isLoggedIn = true
    @State private var isUserAdmin = true
    @State private var showingLogin = false
    @State private var searchTerm = "" // Added state for search term
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    TextField("Search Departments", text: $searchTerm)
                        .padding()
                        .background(.background)
                        .cornerRadius(5)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                        .padding(.horizontal)
                        .autocorrectionDisabled()
                    
                    VStack {
                        ForEach(store.departments.filter { department in
                            searchTerm.isEmpty || department.name.localizedCaseInsensitiveContains(searchTerm)
                        }) { department in
                            NavigationLink(destination: DepartmentView(department: department, store: store)) {
                                Text(department.name)
                                    .frame(maxWidth: .infinity, minHeight: 100)
                                    .font(.title)
                                    .foregroundColor(.primary)
                                    .background(.gray)
                                    .cornerRadius(10)
                                    .padding(5)
                            }
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if isUserAdmin {
                            Button(action: { showingSettings = true }) {
                                Image(systemName: "gear")
                            }
                        }
                    }
                }
//                .navigationDestination(isPresented: $showingSettings) {
//                    SettingsView(store: store)
//                }
                .blur(radius: showingLogin ? 30 : 0)
                .disabled(showingLogin)
                
                if showingLogin {
                    LoginView(isLoggedIn: $isLoggedIn, isUserAdmin: $isUserAdmin, showingLogin: $showingLogin)
                        .zIndex(1)
                }
            }
            .navigationTitle("Departments")
        }
    }
}

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var isUserAdmin: Bool
    @Binding var showingLogin: Bool
    
    @State private var username: String = ""
    @State private var pin: String = ""
    @State private var loginFailed: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Login")
                .font(.largeTitle)
                .foregroundColor(.primary)
            
            TextField("Username", text: $username)
                .padding()
                .background(.tertiary)
                .foregroundColor(.primary)
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
            
            SecureField("PIN", text: $pin)
                .padding()
                .background(.tertiary)
                .foregroundColor(.primary)
                .cornerRadius(5)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
            
            if loginFailed {
                Text("Incorrect username or PIN")
                    .foregroundColor(.red)
            }
            
            Button("Login") {
                authenticateUser(username: username.trimmingCharacters(in: .whitespacesAndNewlines), pin: pin.trimmingCharacters(in: .whitespacesAndNewlines))
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(5)
        }
        .padding()
        .background(.background)
        .cornerRadius(10)
        .shadow(radius: 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            UIApplication.shared.endEditing() // Dismiss the keyboard when tapping outside the fields
        }
    }
    
    private func authenticateUser(username: String, pin: String) {
        if username.lowercased() == "atrumbly" && pin == "123456" {
            isLoggedIn = true
            isUserAdmin = true
            loginFailed = false
            showingLogin = false // Dismiss login view on successful login
        } else if username.lowercased() == "brthielman" && pin == "123456" {
            isLoggedIn = true
            isUserAdmin = false
            loginFailed = false
            showingLogin = false // Dismiss login view on successful login
        } else {
            loginFailed = true
            isUserAdmin = false
            isLoggedIn = false
        }
    }
}

// Helper extension to dismiss the keyboard
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}
