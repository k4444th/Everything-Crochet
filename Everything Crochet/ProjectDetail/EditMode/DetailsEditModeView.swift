import SwiftUI

struct DetailsEditModeView: View {
    
    @State var newTechniques: String = ""
    @State var newStartdate: String = ""
    @State var newEnddate: String = ""
    @State var newDeadline: String = ""
    @State var newYarn: String = ""
    
    @Binding var techniques: String
    @Binding var startdate: String
    @Binding var enddate: String
    @Binding var deadline: String
    @Binding var yarn: String
    
    @FocusState var techniquesFocused: Bool
    @FocusState var startdateFocused: Bool
    @FocusState var enddateFocused: Bool
    @FocusState var deadlineFocused: Bool
    @FocusState var yarnFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Details:").font(.title2).padding(.vertical, 8)
            
            let columns = [
                GridItem(.fixed(30), alignment: .top),
                GridItem(.flexible(), alignment: .top)
            ]
            
            LazyVGrid(columns: columns, alignment: .leading) {
                Image(systemName: "hammer")
                        .imageScale(.large)
                        .foregroundColor(Color.accent).padding(.bottom, 8) .padding(.top, 4)
                
                HStack {
                    HStack {
                        Text("Techniques:")
                        TextField("eg. Crochet", text: $newTechniques) .textFieldStyle(RoundedBorderTextFieldStyle()) .focused($techniquesFocused)
                        Button {
                            techniquesFocused = false
                            newTechniques = techniques
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        Button {
                            techniquesFocused = false
                            techniques = newTechniques
                            print("Edit technique '" + newTechniques + "'")
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    }
                }
                
                Image(systemName: "scissors")
                        .imageScale(.large)
                        .foregroundColor(Color.accent).padding(.bottom, 8) .padding(.top, 6)
                
                HStack {
                    HStack {
                        Text("Yarn:")
                        TextField("eg. Cotton yarn", text: $newYarn) .textFieldStyle(RoundedBorderTextFieldStyle()) .focused($yarnFocused)
                        Button {
                            yarnFocused = false
                            newYarn = yarn
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        Button {
                            yarnFocused = false
                            yarn = newYarn
                            print("Edit yarn '" + newYarn + "'")
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    }
                }
                
                Image(systemName: "clock")
                        .imageScale(.large)
                        .foregroundColor(Color.accent).padding(.bottom, 8) .padding(.top, 6)
                
                VStack {
                    HStack {
                        Text("Startdate:")
                        TextField("eg. Aug 28th 2025", text: $newStartdate) .textFieldStyle(RoundedBorderTextFieldStyle()) .focused($startdateFocused)
                        Button {
                            startdateFocused = false
                            newStartdate = startdate
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        Button {
                            startdateFocused = false
                            startdate = newStartdate
                            print("Edit startdate '" + newStartdate + "'")
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    }
                    HStack {
                        Text("Enddate:")
                        TextField("eg. Sep 3rd 2025", text: $newEnddate) .textFieldStyle(RoundedBorderTextFieldStyle()) .focused($enddateFocused)
                        Button {
                            enddateFocused = false
                            newEnddate = enddate
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary)
                        }
                        Button {
                            enddateFocused = false
                            enddate = newEnddate
                            print("Edit enddate '" + newEnddate + "'")
                        } label: {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color.appSecondary2)
                        }
                    }
                }
                
                Image(systemName: "calendar")
                    .imageScale(.large)
                    .foregroundColor(Color.accent).padding(.bottom, 8) .padding(.top, 6)
                
                HStack {
                    Text("Deadline:")
                    TextField("eg. Sep 1st 2025", text: $newDeadline) .textFieldStyle(RoundedBorderTextFieldStyle()) .focused($deadlineFocused)
                    Button {
                        deadlineFocused = false
                        newDeadline = deadline
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.appSecondary)
                    }
                    Button {
                        deadlineFocused = false
                        deadline = newDeadline
                        print("Edit deadline '" + newDeadline + "'")
                    } label: {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.appSecondary2)
                    }
                }
            }
        }.frame(maxWidth: .infinity, alignment: .leading) .padding(.bottom) .onAppear() {
            newTechniques = techniques
            newStartdate = startdate
            newEnddate = enddate
            newDeadline = deadline
            newYarn = yarn
        }
    }
}


#Preview {
    DetailsEditModeView(techniques: .constant("Tunesian Crochet"), startdate: .constant("21.05.2025"), enddate: .constant("-"), deadline: .constant("15.3.2026"), yarn: .constant("Gründl Lisa Premium"))
}
