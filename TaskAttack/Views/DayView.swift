//
//  DayView.swift.swift
//  TaskAttack
//
//  Created by Jacob Odle on 11/4/21.
//

import SwiftUI

struct DayView: View {
    var body: some View {
        VStack {
            Text("Thursday November 4th")
                .font(.title)
                .underline()
                .foregroundColor(Color("DayIconNumber"))
            Spacer()
            EventListView()
//            List{
//                ForEach(0..<4) {_ in
//                    HStack {
//                        Image(systemName: "circle")
//                            .resizable()
//                            .frame(width: 20, height: 20, alignment: .center)
//
//                        Text("Enter the task title")
//                    }
//
//                }
//            }
            }
        }
    }

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
    }
}
