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
                        if addMode {
                            Button  {
                                addMode.toggle()
                            } label: {
                                Image(systemName: "multiply")
                                    .imageScale(.large)
                                    .foregroundColor(Color.lighter)
                            }
                        }
                        if !addMode {
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
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Text("\(currentContent.title)".uppercased() .replacingOccurrences(of: "(", with: "") .replacingOccurrences(of: ")", with: "")) .foregroundColor(Color.lighter) .fontWeight(.bold)
                    
                    Spacer()
                }.frame(maxHeight: .infinity, alignment: .top)
            }
            .padding()
        }.padding(.horizontal) .frame(height: 50) .background(Color.appPrimary)
    }
}

#Preview {
    NavbarView(presentSideMenu: .constant(false), currentContent: .constant(.project_detail), editMode: .constant(false), editModeVisible: .constant(false), addIconVisible: .constant(false), addMode: .constant(false))
}
