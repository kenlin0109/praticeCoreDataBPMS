//
//  SettingTest.swift
//  pratice
//
//  Created by 林秀謙 on 2023/10/12.
//

import Foundation
import SwiftUI

struct SettingsTestView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.gray)
                        Text("Sign in to your iPhone")
                            .font(.headline)
                        Spacer()
                        Text("Set up iCloud, the App Store, and more.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Section {
                    SettingRow(title: "VPN", imageName: "globe")
                    SettingRow(title: "Screen Time", imageName: "hourglass")
                    SettingRow(title: "Action Button", imageName: "play.rectangle.fill")
                }
                
                Section {
                    SettingRow(title: "General", imageName: "gear")
                    SettingRow(title: "Accessibility", imageName: "person.crop.circle")
                    SettingRow(title: "Privacy & Security", imageName: "hand.raised.fill")
                }
                
                Section {
                    SettingRow(title: "Passwords", imageName: "lock.fill")
                    SettingRow(title: "Safari", imageName: "safari")
                    SettingRow(title: "News", imageName: "newspaper.fill")
                    SettingRow(title: "Translate", imageName: "arrow.right.arrow.left.circle")
                    SettingRow(title: "Maps", imageName: "map.fill")
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
        }
    }
}

struct SettingRow: View {
    var title: String
    var imageName: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.blue)
            Text(title)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 10)
    }
}
