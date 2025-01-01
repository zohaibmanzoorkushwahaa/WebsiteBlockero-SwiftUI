//
//  ContentBlockerView.swift
//  WebSiteBlocker
//
//  Created by Muhammad Irfan Zafar on 27/08/2024.
//

import SwiftUI

struct ContentBlockerView: View {
    
    @State var textField: String = ""
    @State private var websites: [String] = []
    
    var body: some View {
        ZStack {
            Color(.brown)
                .ignoresSafeArea()
            VStack {
                title
                
                textFieldView
                
                if websites.count > 0 {
                    listView
                }else {
                    
                    Spacer()
                    Image(systemName: "exclamationmark.triangle")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 32, height: 32)
                    Text("No Website added yet!")
                        .bold()
                        .font(.title)
                        .foregroundStyle(.white)
                    Spacer()
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button {
                        //TODO: MEthod for Blocking websites list
                        //TODO: - also need to add Validation
                        debugPrint("Start Blocking")
                        //SheildWebManager().startShielding(webDomain: websites)
                        SheildWebManager().saveSchedule()
                    } label: {
                        Label("Start", systemImage: "play.fill")
                            .font(.title)
                            .foregroundColor(.white)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.clear)
                    
                    Spacer()
                    Button {
                        debugPrint("Stop")
                        SheildWebManager().clearStore()
                    } label: {
                        Label("Stop", systemImage: "stop.fill")
                            .font(.title)
                            .foregroundColor(.white)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.clear)
                    Spacer()
                }
            }
        }
    }
}

private extension ContentBlockerView {
    var textFieldView: some View {
        HStack {
            TextField("", text: $textField, prompt: Text("Enter Website").foregroundColor(.white))
                .padding(.vertical)
                .foregroundColor(.white)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            
            Button {
                addWebsite()
            } label: {
                Label("", systemImage: "plus.circle")
                    .font(.title)
                    .foregroundColor(.white)
                
            }
            .buttonStyle(.borderedProminent)
            .tint(.clear)
        }
        .padding(.horizontal)
        .background(.secondary)
    }
    
    var title: some View {
        Text("WebSite Blocker")
            .padding()
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.white)
    }
    
    var listView: some View {
        
        List {
            ForEach(websites, id: \.self) { website in
                HStack {
                    Text(website)
                        .padding(.vertical, 5)
                        .foregroundColor(.white)
                }
                .listRowBackground(Color(.secondaryLabel))
                .clipped()
                .cornerRadius(10)
          
            }
            .onDelete(perform: deleteWebsite)
        }
        .scrollContentBackground(.hidden)
  
    }
    
    func addWebsite() {
        let trimmedText = textField.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        websites.append(trimmedText)
        textField = ""
    }
    
    func deleteWebsite(at offsets: IndexSet) {
        websites.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentBlockerView()
}
