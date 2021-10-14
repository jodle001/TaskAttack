//
//  TaskRepository.swift
//  TaskAttack
//
//  Created by Jacob Odle on 9/18/21.x
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class TaskRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var tasks = [Task]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        let userID = Auth.auth().currentUser?.uid
        
        
        // Original code for reference from video tutorial.
//        db.collection("tasks")
//            .order(by: "createdTime")
//            .whereField("userID", isEqualTo: userID)
//            .addSnapshotListener { (querySnapshot, error) in
//            if let querySnapshot = querySnapshot {
//                self.tasks = querySnapshot.documents.compactMap { document in
//                    do {
//                        let x = try document.data(as: Task.self)
//                        return x
//                    }
//                    catch {
//                        print(error)
//                    }
//                    return nil
//                }
//            }
//        }
        if try userID != nil {
            // This is how to access sub-collections within a parent collection.
            db.collection("users").document(userID!).collection("tasks")
                .order(by: "createdTime")
                .addSnapshotListener { ( querySnapshot, error ) in
                    if let querySnapshot = querySnapshot {
                        self.tasks = querySnapshot.documents.compactMap { document in
                            do {
                                let x = try document.data(as: Task.self)
                                return x
                            }
                            catch {
                                print(error)
                            }
                            return nil
                        }
                    }
                }
        }
        
    }
    
    func addTask( task: Task) {
        do {
            var addedTask = task
            addedTask.userID = Auth.auth().currentUser?.uid
//            let _ = try db.collection("tasks").addDocument(from: addedTask)
            let _ = try db.collection("users").document(addedTask.userID!).collection("tasks").addDocument(from: addedTask)
        }
        catch {
            fatalError("Unable to encode task: \(error.localizedDescription)")
        }
        
    }
    
    func updateTask( task: Task) {
        let userID = Auth.auth().currentUser?.uid  // added for getting the subcollection
        if let taskID = task.id {
            do {
//                try db.collection("tasks").document(taskID).setData(from: task)
                try db.collection("users").document(userID!).collection("tasks").document(taskID).setData(from: task)
            }
            catch {
                fatalError("Unable to encode task: \(error.localizedDescription)")
            }
        }
    }
    
}
