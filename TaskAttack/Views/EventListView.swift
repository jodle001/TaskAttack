//
//  EventListView.swift
//  TaskAttack
//
//  Created by Jacob Odle on 11/6/21.
//

import SwiftUI
import MapKit

struct EventListView: View {
    @ObservedObject var eventListVM = EventListViewModel()
    let events = testDataEvents
    @State var presentAddNewItem = false
    @State var showSignInForm = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List{
                    ForEach(eventListVM.eventCellViewModels) { eventCellVM in
                        EventCell(eventCellVM: eventCellVM)
                    }
                    .onDelete(perform: delete)
                    if presentAddNewItem {
                        EventCell(eventCellVM: EventCellViewModel(event: Event(title: "", body: "", time: DateInterval(start: Date(), duration: 0)))) { event in
                            self.eventListVM.addEvent(event: event)
                            self.presentAddNewItem.toggle() // This prevents a new empty task from poping up after clicking "enter"
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                        Text("Add New Event")
                    }
                }
                .padding()
            }
//            .sheet(isPresented: $showSignInForm) {
//                SigninView()
//            }
//            .toolbar() {
//                Button(action: {self.showSignInForm.toggle()}) {
//                    Image(systemName: "person.circle")
//                }
//            }
//            .navigationTitle("Events")
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete")
    }
    
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView()
    }
}

struct EventCell: View {
    @ObservedObject var eventCellVM: EventCellViewModel
    
    var onCommit: (Event) -> (Void) = { _ in }

    var body: some View {
        HStack {
            Image("checkmark.circle.fill")
                .resizable()
                .frame(width: 20, height: 20, alignment: .center)
//                .onTapGesture {
//                    self.eventCellVM.task.completed.toggle()
//                }
            TextField("Enter the event title", text: $eventCellVM.event.title, onCommit: {
                self.onCommit(self.eventCellVM.event)
            })
        }
    }
}
