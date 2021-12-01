//
//  Event.swift
//  TaskAttack
//
//  Created by Jacob Odle on 11/6/21.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Event: Codable, Identifiable{
    @DocumentID var id: String?
    @ServerTimestamp var createdTime: Timestamp?
    var setDate: Date
    var title: String
    var body: String
    var time: DateInterval
    var userID: String?
}


#if DEBUG
let testDataEvents = [
    Event(setDate: Date(), title: "test title", body: "Test body", time: DateInterval(start: Date(), duration: 0))
]
#endif
