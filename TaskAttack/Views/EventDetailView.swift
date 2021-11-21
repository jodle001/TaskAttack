//
//  TaskDetailView.swift
//  TaskAttack
//
//  Created by Jacob Odle on 11/18/21.
//

import SwiftUI

struct EventDetailView: View {
    @ObservedObject var event: EventCellViewModel
    var onCommit: (Event) -> (Void) = { _ in }

    var body: some View {
        
        VStack {
            HStack() {
                Text("Title:")
                    .font(.title)
                Spacer()
            }
            .padding(.leading)
            Divider()
            if #available(iOS 15.0, *) {
                TextField("Enter the task title", text: $event.event.title)
                    .onSubmit {
                        self.onCommit(self.event.event)
                    }
            } else {
                // Fallback on earlier versions
            }
            ExDivider()
            HStack {
                Text("Body:")
                Spacer()
            }
            ScrollView {
                if #available(iOS 15.0, *) {
                    TextEditor(text: $event.event.body)
                        .onSubmit {
                            self.onCommit(self.event.event)
                        }
                } else {
                    // Fallback on earlier versions
                }
            }
            Spacer()
        }
    }
}

struct ExDivider: View {
    let color: Color = .gray
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let event = Event(title: "Implement the UI", body: "test1", time: DateInterval(start: Date(), duration: 0))
        let eventVM = EventCellViewModel(event: event)
        EventDetailView(event: eventVM)
    }
}

