import SwiftUI

struct NavbarView: View {
    
    @Binding var presentSideMenu: Bool
    @Binding var currentContent: MainContent
    @Binding var editMode: Bool
    @Binding var editModeVisible: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button  {
                        presentSideMenu.toggle()
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                            .foregroundColor(Color.background)
                    }
                    
                    Spacer()
                    
                    if editModeVisible {
                        if editMode {
                            Button  {
                                editMode.toggle()
                            } label: {
                                Image(systemName: "pencil.slash")
                                    .imageScale(.large)
                                    .foregroundColor(Color.background)
                            }
                        }
                        if !editMode {
                            Button  {
                                editMode.toggle()
                            } label: {
                                Image(systemName: "pencil")
                                    .imageScale(.large)
                                    .foregroundColor(Color.background)
                            }
                        }
                    }
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("\(currentContent)".uppercased().replacingOccurrences(of: "_", with: " ")).foregroundColor(Color.background).fontWeight(.bold)
                    
                    // Text("Everything Crochet").foregroundColor(Color.background).font(.title2)
                    
                    // Image(systemName: "scissors") .imageScale(.large) .foregroundColor(Color.background)
                    
                    Spacer()
                }.frame(maxHeight: .infinity, alignment: .top)
            }
            .padding()
        }.padding(.horizontal) .frame(height: 50) .background(Color.appPrimary)
    }
}
