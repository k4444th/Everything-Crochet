//
//  MainView.swift
//  Everything Crochet
//
//  Created by Katharina Weinberger on 28.08.25.
//

import SwiftUI

struct MainView: View {
    @State private var presentSideMenu = false
        
    var body: some View {
        ZStack {
            ContentView(presentSideMenu: $presentSideMenu)
            
            SideMenuView(
                isShowing: $presentSideMenu,
                content: AnyView(SideMenuContentView(presentSideMenu: $presentSideMenu))
            )
        }
    }
}

#Preview {
    MainView()
}
