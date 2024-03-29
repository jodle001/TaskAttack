//
//  ContentView.swift
//  TaskAttack
//
//  Created by Jacob Odle on 9/16/21.
//

import SwiftUI
import MapKit

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    let tasks = testDataTasks
    @State var presentAddNewItem = false
    @State var showSignInForm = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List{
                    if #available(iOS 15.0, *) {
                        ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                            TaskCell(taskCellVM: taskCellVM)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        taskListVM.delete(task: taskCellVM.task)
                                        print("Deleting conversation")
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                    }
                                }
                        }
                    }
                    //.onDelete(perform: delete)

                    if presentAddNewItem {
                        TaskCell(taskCellVM: TaskCellViewModel(task: Task(title: "", completed: false))) { task in
                            self.taskListVM.addTask(task: task)
                            self.presentAddNewItem.toggle() // This prevents a new empty task from poping up after clicking "enter"
                        }
                    }
                }
                Button(action: { self.presentAddNewItem.toggle() }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                        Text("Add New Task")
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showSignInForm) {
                SigninView()
            }
            .toolbar() {
                Button(action: {self.showSignInForm.toggle()}) {
                    Image(systemName: "person.circle")
                }
            }
            .navigationTitle("Tasks")
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    
    var onCommit: (Task) -> (Void) = { _ in }

    var body: some View {
        HStack {
            Image(systemName: taskCellVM.task.completed ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 20, height: 20, alignment: .center)
                .onTapGesture {
                    self.taskCellVM.task.completed.toggle()
                }
            TextField("Enter the task title", text: $taskCellVM.task.title, onCommit: {
                self.onCommit(self.taskCellVM.task)
            })
        }
    }
}
