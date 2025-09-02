import SwiftUI

struct SettingsView: View {
    
    @Binding var settings: Settings
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Settings").font(.title).padding(.bottom)
            HStack {
                Text("Appearance:")
                Picker("Appearance", selection: $settings.appearance) {
                    ForEach(Appearance.allCases, id: \.self) { mode in
                        Text(mode.rawValue.capitalized).tag(mode)
                    }
                }
                Spacer()
            } .padding(.bottom)
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
