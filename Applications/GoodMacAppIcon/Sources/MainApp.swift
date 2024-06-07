//
//  MainApp.swift
//  GoodMacAppIcon
//
//  Created by Yoshimasa Niwa on 6/6/24.
//

import SwiftUI

@main
struct MainApp: App {
    @NSApplicationDelegateAdaptor
    private var service: Service

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(service)
        }
    }
}
