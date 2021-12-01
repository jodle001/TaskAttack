//
//  EventListViewModel.swift
//  TaskAttack
//
//  Created by Jacob Odle on 11/6/21.
//


import Foundation
import Combine

class EventListViewModel: ObservableObject {
    @Published var eventRepository = EventRepository()
    @Published var eventCellViewModels = [EventCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        eventRepository.$events.map { events in
            events.map { event in
                EventCellViewModel(event: event)
            }
        }
        .assign(to: \.eventCellViewModels, on: self)
        .store(in: &cancellables)
    }
    
    func addEvent(event: Event) {
        eventRepository.addEvent(event: event)
//        let taskVM = TaskCellViewModel(task: task)
//        self.taskCellViewModels.append(taskVM)
        
    }
    
    func delete(event: Event) {
        eventRepository.deleteEvent(event: event)
    }
    
}
