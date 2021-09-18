//
//  TaskCellViewModel.swift
//  TaskAttack
//
//  Created by Jacob Odle on 9/17/21.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    @Published var taskRepository = TaskRepository()
    @Published var task: Task
     
    private var cancellables = Set<AnyCancellable>()
    
    var id: String = ""
    @Published var completionStateIconName = ""
    
    init(task: Task) {
        self.task = task
        
        $task
            .map { task in
                task.completed ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
                 $task
            .compactMap { task in
                task.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $task
            .dropFirst()  // Avoid infinite loops supposedly
            .debounce(for: 0.8, scheduler: RunLoop.main)  //  Only make changes once you have stopped typing
            .sink { task in
                self.taskRepository.updateTask(task: task)
            }
            .store(in: &cancellables)
    }
    
}
