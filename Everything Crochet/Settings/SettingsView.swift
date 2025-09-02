import SwiftUI

struct SettingsView: View {
    
    @Binding var settings: Settings
    @State var restartLanguage: Bool = false
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Settings").font(.title).padding(.bottom)
            
            HStack {
                Text("Appearance:")
                Picker("Appearance", selection: $settings.appearance) {
                    ForEach(Appearance.allCases, id: \.self) { mode in
                        Text(mode.rawValue.capitalized).tag(mode)
                    }
                } .onChange(of: settings.language, {oldValue, newValue in UserDefaults.standard.set([newValue.rawValue], forKey: "AppleLanguages")
                    UserDefaults.standard.synchronize()
                    restartLanguage = true
                })
                Spacer()
            }
            
            HStack {
                Text("Language:")
                Picker("Language", selection: $settings.language) {
                    ForEach(Language.allCases, id: \.self) { mode in
                        Text(mode.name.capitalized).tag(mode)
                    }
                }
                Spacer()
            }
            HStack {
                Spacer()
                if restartLanguage {
                    if Locale.current.language.languageCode?.identifier == "en" {
                        TagView(tagName: "Please restart the application to apply the changes!", color: Color.appSecondary, editMode: .constant(false), info: true, onDelete: {  })
                    }
                    else {
                        TagView(tagName: "Bitte starte die App neu, um deine Änderungen anzuwenden!", color: Color.appSecondary, editMode: .constant(false), info: true, onDelete: { })
                    }
                }
                Spacer()
            }

            Spacer()
        }.padding() .onChange(of: settings) { oldValue, newValue in
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "settings")
            }
        }
    }
}

#Preview {
    SettingsView(settings: .constant(Settings()))
}
