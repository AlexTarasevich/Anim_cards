//
//  ContentView.swift
//  animCard
//
//  Created by Александр Тарасевич on 09.02.2022.
//

import SwiftUI

struct ContentView: View {
    
    
    @GestureState var dragState = DragState.inactive
    
    var body: some View {
        let dragGester = DragGesture()
           .updating($dragState) { (value, state, transaction) in
              state = .dragging(translation: value.translation)
           }
        
        return ZStack{
            Card(title: "Third card")
                .blendMode(.hardLight)
                .padding(dragState.isActive ? 32 : 64)
                .padding(.bottom, dragState.isActive ? 32 : 64)
                .animation(.spring())
            Card(title: "Second card")
                .blendMode(.hardLight)
                .padding(dragState.isActive ? 16 : 32)
                .padding(.bottom, dragState.isActive ? 0 : 32)
                .animation(.spring())
            MainCard(title: "Main Card")
                .offset(
                    x: self.dragState.translation.width,
                    y: self.dragState.translation.height
                )
                 .gesture(dragGester)
        }        .animation(.spring())
    }
}

//Анимация карточек
enum DragState {

        case inactive
        case dragging(translation: CGSize)

        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }

        var isActive: Bool {
            switch self {
            case .inactive:
                return false
            case .dragging:
                return true
            }
        }
}





struct MainCard: View{
    
    var title: String
    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color.black)
                .frame(height: 230)
                .cornerRadius(10)
                .padding(16)
            Text("Main Card")
                .foregroundColor(Color.white)
                .font(.title)
                .bold()
        }
      }
    }






struct Card: View{
    
    var title: String
    var body: some View{
        ZStack{
            Rectangle()
                .fill(Color(red: 68 / 255, green: 41 / 255, blue: 182 / 255))
                .frame( height: 230)
                .cornerRadius(10)
                .padding(16)
            Text(title)
                .foregroundColor(Color.white)
                .font(.title)
                .bold()
            
        }
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
