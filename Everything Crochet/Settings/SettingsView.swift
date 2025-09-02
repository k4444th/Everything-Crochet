import SwiftUI

struct SettingsView: View {
    
    @Binding var settings: Settings
    @State var restartLanguage: Bool = false
    @State var selectedIcon: AppIcon = .default

    class CommonUtils {
        static func updateAppIcon(with iconName: String?) async {
            guard await UIApplication.shared.alternateIconName != iconName else { return }
            await MainActor.run {
                UIApplication.shared.setAlternateIconName(iconName)
            }
        }
    }

    
    func getCurrentIcon() {
        if let iconName = UIApplication.shared.alternateIconName {
            selectedIcon = AppIcon(from: iconName)
        } else {
            selectedIcon = .default
        }
    }
    
    func updateIcon() {
        Task {
            await CommonUtils.updateAppIcon(with: selectedIcon.name)
        }
    }
    
    func binding(for icon: AppIcon) -> Binding<Bool> {
        Binding<Bool>(
            get: { selectedIcon == icon },
            set: { newValue in
                if newValue {
                    selectedIcon = icon
                    updateIcon()
                }
            }
        )
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .font(.title)
                .padding(.bottom)
            
            HStack {
                Text("Appearance:")
                Picker("Appearance", selection: $settings.appearance) {
                    ForEach(Appearance.allCases, id: \.self) { mode in
                        Text(mode.name).tag(mode)
                    }
                }
                .onChange(of: settings.language) { oldValue, newValue in
                    UserDefaults.standard.set([newValue.rawValue], forKey: "AppleLanguages")
                    UserDefaults.standard.synchronize()
                    restartLanguage = true
                }
                Spacer()
            }
            
            HStack {
                Text("Language:")
                Picker("Language", selection: $settings.language) {
                    ForEach(Language.allCases, id: \.self) { mode in
                        Text(mode.name).tag(mode)
                    }
                }
                Spacer()
            }
            
            if restartLanguage {
                if settings.language.rawValue == "en" {
                    HStack {
                        Spacer()
                        TagView(
                            tagName: "Please restart the application to apply the changes!",
                            color: Color.appSecondary,
                            editMode: .constant(false),
                            info: true,
                            onDelete: { }
                        )
                        Spacer()
                    }
                } else if settings.language.rawValue == "de" {
                    HStack {
                        Spacer()
                        TagView(
                            tagName: "Bitte starte die App neu, um deine Änderungen anzuwenden!",
                            color: Color.appSecondary,
                            editMode: .constant(false),
                            info: true,
                            onDelete: { }
                        )
                        Spacer()
                    }
                }
            }
               
            
            HStack {
                Text("Icon:")
                Picker("Icon", selection: $selectedIcon) {
                    ForEach(AppIcon.allCases, id: \.self) { icon in
                        HStack {
                            Text(icon.description)
                        } .tag(icon)
                    }
                }
                .onChange(of: selectedIcon) { oldValue, newValue in
                    updateIcon()
                }
                Spacer()
            } .onAppear { getCurrentIcon() }
            
//            Form {
//                Section(
//                    header: Text("App Icon").font(.headline),
//                    footer: Text("You can customize the app icon to fit in with your home theme")
//                ) {
//                    ForEach(AppIcon.allCases, id: \.self) { icon in
//                        Toggle(isOn: binding(for: icon)) {
//                            HStack {
//                                icon.icon
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 50, height: 50)
//                                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                                Text(icon.description)
//                                    .font(.title3)
//                            }
//                        }
//                        .tint(Color.accentColor)
//                    }
//                }.onAppear { getCurrentIcon() }
//            } .scrollContentBackground(.hidden) .background(Color.background)
            
            Spacer()
        }  .padding()  .onChange(of: settings) { oldValue, newValue in
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "settings")
            }
        }
    }
}

#Preview {
    SettingsView(settings: .constant(Settings()))
}
