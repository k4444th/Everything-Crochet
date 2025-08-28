//
//  SideMenuContentView.swift
//  Everything Crochet
//
//  Created by Katharina Weinberger on 28.08.25.
//

import SwiftUI

struct SideMenuContentView: View {
    
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button  {
                    presentSideMenu.toggle()
                } label: {
                    Image(systemName: "multiply")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                }
                Spacer()
            }.frame(maxHeight: .infinity, alignment: .top)
        }
        .padding()
    }
}
