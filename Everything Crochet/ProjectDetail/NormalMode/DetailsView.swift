import SwiftUI

struct DetailsView: View {
    
    @Binding var techniques: String
    @Binding var startdate: String
    @Binding var enddate: String
    @Binding var deadline: String
    @Binding var yarn: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Details:").font(.title2).padding(.vertical, 8)
            
            let columns = [
                GridItem(.fixed(30), alignment: .top),
                GridItem(.flexible(),  alignment: .top)
            ]
            
            LazyVGrid(columns: columns, alignment: .leading) {
                VStack {
                    Image(systemName: "hammer")
                        .imageScale(.large)
                        .foregroundColor(Color.accent)
                    Spacer()
                }
                
                HStack {
                    VStack {
                        Text("Techniques:").padding(.bottom, 8)
                        Spacer()
                    }
                    VStack {
                        Text(techniques).padding(.bottom, 8)
                        Spacer()
                    }
                    Spacer()
                }
                
                VStack {
                    Image(systemName: "scissors")
                        .imageScale(.large)
                        .foregroundColor(Color.accent)
                    Spacer()
                }
                HStack {
                    VStack {
                        Text("Yarn:").padding(.bottom, 8)
                        Spacer()
                    }
                    VStack {
                        Text(yarn).padding(.bottom, 8)
                        Spacer()
                    }
                    Spacer()
                }
                
                VStack {
                    Image(systemName: "clock")
                        .imageScale(.large)
                        .foregroundColor(Color.accent)
                    Spacer()
                }
                VStack {
                    HStack {
                        VStack {
                            Text("Startdate:").padding(.bottom, 8)
                            Spacer()
                        }
                        VStack {
                            Text(startdate).padding(.bottom, 8)
                            Spacer()
                        }
                        Spacer()
                    }
                    HStack {
                        VStack {
                            Text("Enddate:").padding(.bottom, 8)
                            Spacer()
                        }
                        VStack {
                            Text(enddate).padding(.bottom, 8)
                            Spacer()
                        }
                        Spacer()
                    }
                }
               
               
                VStack {
                    Image(systemName: "calendar")
                        .imageScale(.large)
                        .foregroundColor(Color.accent)
                    Spacer()
                }
                
                HStack {
                    VStack {
                        Text("Deadline:").padding(.bottom, 8)
                        Spacer()
                    }
                    VStack {
                        Text(deadline).padding(.bottom, 8)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }.frame(maxWidth: .infinity, alignment: .leading) .padding(.bottom)
    }
}


#Preview {
    DetailsView(techniques: .constant("Tunesian Crochet, TSS, Join-as-you-go-Methode"), startdate: .constant("21.05.2025"), enddate: .constant("-"), deadline: .constant("15.3.2026"), yarn: .constant("Gründl Lisa Premium"))
}
