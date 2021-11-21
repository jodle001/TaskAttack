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
    @State var presentAddNewItem = false
    @State var showDetailView = false
    
    var date: Date
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List{
                    if #available(iOS 15.0, *) {
                        ForEach(eventListVM.eventCellViewModels) { eventCellVM in
                            if (sameDay(date1: eventCellVM.event.time.start, date2: date)) {
                                EventCell(eventCellVM: eventCellVM)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            eventListVM.delete(event: eventCellVM.event)
                                            print("Deleting conversation")
                                        } label: {
                                            Label("Delete", systemImage: "trash.fill")
                                        }
                                    }
                                    .swipeActions(edge: .leading, allowsFullSwipe: false){
                                        Button("add time") {
                                            print("Right on!")
                                        }
                                        .tint(.green)
                                    }
                                    .onTapGesture() {
                                        showDetailView.toggle()
                                    }
                                    .sheet(isPresented: $showDetailView) {
                                        EventDetailView(event: eventCellVM);
                                    }
                            }
                        }
                    } else {
                        // Fallback on earlier versions
                    }
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
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete")
    }
    
    func sameDay(date1: Date, date2: Date) -> Bool {
        return date1.get(.year) == date2.get(.year) &&
               date1.get(.month) == date2.get(.month) &&
               date1.get(.day) == date2.get(.day)
    }
    
}

struct EventListView_Previews: PreviewProvider {
    static var previews: some View {
        EventListView(date: Date())
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
