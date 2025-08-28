//
//  Everything_CrochetApp.swift
//  Everything Crochet
//
//  Created by Katharina Weinberger on 28.08.25.
//

import SwiftUI

@main
struct Everything_CrochetApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(presentSideMenu: .constant(false))
        }
    }
}
