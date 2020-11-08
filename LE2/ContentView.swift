//
//  ContentView.swift
//  LE2
//
//  Created by Beverly Abadines on 11/7/20.
//  Copyright © 2020 BeverlyAb. All rights reserved.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        VStack{
            Button(action: {
                print("Recordingz")
            }) {
                HStack {
                    Image(systemName:"Gavel")
                        .font(.title)
                    Text("Start")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(40)
        }
        Divider()
        
        Text("Echo...echo")
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
