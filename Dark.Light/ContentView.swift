//
//  ContentView.swift
//  Dark.Light
//
//  Created by eyh.mac on 25.12.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isDarkMode: Bool = false
    @State private var circleScale: CGFloat = 0
    
    var body: some View {
        NavigationView{
            ZStack{
                isDarkMode ? Color.black : Color.white
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 1)) {
                        self.isDarkMode.toggle()
                    }
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.circleScale = 5
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.circleScale = 0
                        }
                    }
                })
                 {
                   Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                       .font(.largeTitle)
                       .foregroundColor(isDarkMode ? .white : .yellow)
                       .frame(width: 100, height: 100)
                       .background(Circle()
                           .fill(isDarkMode ? .white : .black)
                           .scaleEffect(circleScale)
                           .opacity(circleScale == 5 ? 0 : 1)
                                   
                       )
               }
                 .shadow(radius: 10)
            }
                .edgesIgnoringSafeArea(.all)
                .onChange(of: isDarkMode){ newValue in
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
                    
                }
                .navigationTitle("Light - Dark")
        }
    }
}

#Preview {
    ContentView()
    
}
