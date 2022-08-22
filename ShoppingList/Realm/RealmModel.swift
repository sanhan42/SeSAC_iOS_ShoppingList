//
//  RealmModel.swift
//  ShoppingList
//
//  Created by 한상민 on 2022/08/23.
//

import Foundation
import RealmSwift

class UserList: Object {
    @Persisted var check: Bool
    @Persisted var content: String
    @Persisted var favorite: Bool
    @Persisted var date = Date()
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    convenience init(content: String) {
           self.init()
        self.check = false
        self.favorite = false
        self.date = Date()
        self.content = content
    }
}
