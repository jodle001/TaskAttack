//
//  EventRepository.swift
//  TaskAttack
//
//  Created by Jacob Odle on 11/6/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventRepository: ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var events = [Event]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        let userID = Auth.auth().currentUser?.uid
        
        if userID != nil {
            // This is how to access sub-collections within a parent collection.
            db.collection("users").document(userID!).collection("events")
                .order(by: "createdTime")
                .addSnapshotListener { ( querySnapshot, error ) in
                    if let querySnapshot = querySnapshot {
                        self.events = querySnapshot.documents.compactMap { document in
                            do {
                                let x = try document.data(as: Event.self)
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
    
    func addEvent( event: Event) {
        do {
            var addedEvent = event
            addedEvent.userID = Auth.auth().currentUser?.uid
            let _ = try db.collection("users").document(addedEvent.userID!).collection("events").addDocument(from: addedEvent)
        }
        catch {
            fatalError("Unable to encode event: \(error.localizedDescription)")
        }
        
    }
    
    func deleteEvent( event: Event) {
        do {
            var deleteEvent = event
            deleteEvent.userID = Auth.auth().currentUser?.uid
            let _ = try db.collection("users").document(deleteEvent.userID!).collection("events").document(deleteEvent.id!).delete()
        }
        catch {
            fatalError("Unable to delete event: \(error.localizedDescription)")
        }
    }
    
    func updateEvent( event: Event) {
        let userID = Auth.auth().currentUser?.uid  // added for getting the subcollection
        if let eventID = event.id {
            do {
                try db.collection("users").document(userID!).collection("events").document(eventID).setData(from: event)
            }
            catch {
                fatalError("Unable to encode event: \(error.localizedDescription)")
            }
        }
    }
    
}
