//
//  Tag+CoreDataClass.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 10/01/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//
//

import Foundation
import CoreData
import EZCoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

public class Tag: NSManagedObject, Codable {

    required convenience public init(from decoder: Decoder) throws {
        // Init: First we create NSEntityDescription with NSManagedObjectContext
        guard let contextUserInfoKey = CodingUserInfoKey.context,
            let context = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Article", in: context) else {
                fatalError("Failed to decode Person!")
        }
        self.init(entity: entity, insertInto: nil)

        // Decode
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int16.self, forKey: .id)
        label = try values.decode(String.self, forKey: .label)
    }

}

extension Tag {
    /// Populates Tag objects from JSON
    override open func populateFromJSON(_ json: [String: Any], context: NSManagedObjectContext) {
        guard let id = json["id"] as? Int16 else { return }
        self.id = id
        self.label = json["label"] as? String
    }
}
