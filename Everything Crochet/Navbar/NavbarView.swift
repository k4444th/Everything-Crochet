import SwiftUI

struct NavbarView: View {
    
    @Binding var presentSideMenu: Bool
    @Binding var currentContent: MainContent
    @Binding var editMode: Bool
    @Binding var editModeVisible: Bool
    @Binding var addIconVisible: Bool
    @Binding var addMode: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button  {
                        presentSideMenu.toggle()
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                            .foregroundColor(Color.lighter)
                    }
                    
                    Spacer()
                    
                    if editModeVisible {
                        if editMode {
                            Button  {
                                editMode.toggle()
                            } label: {
                                Image(systemName: "pencil.slash")
                                    .imageScale(.large)
                                    .foregroundColor(Color.lighter)
                            }
                        }
                        if !editMode {
                            Button  {
                                editMode.toggle()
                            } label: {
                                Image(systemName: "pencil")
                                    .imageScale(.large)
                                    .foregroundColor(Color.lighter)
                            }
                        }
                    }
                    
                    if addIconVisible {
                        Button  {
                            addMode.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .foregroundColor(Color.lighter)
                        }
                    }
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("\(currentContent)".uppercased().replacingOccurrences(of: "_", with: " ")).foregroundColor(Color.lighter).fontWeight(.bold)
                    
                    // Text("Everything Crochet").foregroundColor(Color.lighter).font(.title2)
                    
                    // Image(systemName: "scissors") .imageScale(.large) .foregroundColor(Color.lighter)
                    
                    Spacer()
                }.frame(maxHeight: .infinity, alignment: .top)
            }
            .padding()
        }.padding(.horizontal) .frame(height: 50) .background(Color.appPrimary)
    }
}
