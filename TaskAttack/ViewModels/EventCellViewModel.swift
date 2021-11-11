//
//  EventCellViewModel.swift
//  TaskAttack
//
//  Created by Jacob Odle on 11/6/21.
//

import Foundation
import Combine

class EventCellViewModel: ObservableObject, Identifiable {
    @Published var eventRepository = EventRepository()
    @Published var event: Event
     
    private var cancellables = Set<AnyCancellable>()
    
    var id: String = ""
    @Published var completionStateIconName = ""
    
    init(event: Event) {
        self.event = event
        
        $event
//            .map { event in
//                event. ? "checkmark.circle.fill" : "circle"
//            }
//            .assign(to: \.completionStateIconName, on: self)
//            .store(in: &cancellables)
//                 $event
            .compactMap { event in
                event.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $event
            .dropFirst()  // Avoid infinite loops supposedly
            .debounce(for: 0.8, scheduler: RunLoop.main)  //  Only make changes once you have stopped typing
            .sink { event in
                self.eventRepository.updateEvent(event: event)
            }
            .store(in: &cancellables)
    }
    
}
