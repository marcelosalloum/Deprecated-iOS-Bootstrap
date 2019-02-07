//
//  Article+CoreDataClass.swift
//  iOS Bootstrap
//
//  Created by Marcelo Salloum dos Santos on 10/01/19.
//  Copyright © 2019 Marcelo Salloum dos Santos. All rights reserved.
//
//

import Foundation
import CoreData
import EZCoreData

// MARK: - Encodable & Decodable
public class Article: NSManagedObject, Codable {

    /// Encoding/Decoding keys
    enum CodingKeys: String, CodingKey {
        case authors
        case content
        case date
        case id
        case title
        case website
        case wasRead
        case tags
    }

    /// MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(authors, forKey: .authors)
        try container.encode(content, forKey: .content)
        try container.encode(stringDate, forKey: .date)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(website, forKey: .website)
        try container.encode(wasRead, forKey: .wasRead)
        try container.encode(tags?.allObjects as? [Tag], forKey: .tags)
    }

    // MARK: - Decodable
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
        authors = try values.decode(String.self, forKey: .authors)
        content = try values.decode(String.self, forKey: .content)
        title = try values.decode(String.self, forKey: .title)
        website = try values.decode(String.self, forKey: .website)
        wasRead = try values.decode(Bool.self, forKey: .wasRead)
        stringDate = try values.decode(String.self, forKey: .date)
        tags = NSSet(array: try values.decode([Tag].self, forKey: .tags))
    }

    // TODO: Move to an specialized class
    var stringDate: String? {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Constants.serverDateFormat
            guard let date = self.date as Date? else {
                return nil
            }
            return dateFormatter.string(from: date)
        }
        set (stringVaue) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Constants.serverDateFormat
            guard let stringVaue = stringVaue else { self.date = nil; return }
            guard let nsDate = dateFormatter.date(from: stringVaue) as NSDate? else { self.date = nil; return }
            self.date = nsDate
        }
    }
}

extension Article {
    /// Populates Article objects from JSON
    override open func populateFromJSON(_ json: [String: Any], context: NSManagedObjectContext) {
        guard let rawId = json["id"], let id = Int16("\(rawId)") else { return }
        self.id       = id
        self.authors  = json["authors"] as? String
        self.content  = json["content"] as? String
        self.imageUrl = json["image_url"] as? String
        self.title    = json["title"] as? String
        self.website  = json["website"] as? String

        if let dateString = json["date"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"

            if let date = dateFormatter.date(from: dateString) as NSDate? {
                self.date = date
            }
        }

        if let tags = json["tags"] as? [[String: Any]] {
            do {
                guard let tagObjects = try Tag.importList(tags,
                                                          idKey: "id",
                                                          shouldSave: false,
                                                          context: context) else { return }
                let tagsSet = NSSet(array: tagObjects)
                self.addToTags(tagsSet)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: Data Model
extension Article {
    /// Transfors the list of tagsinto a comma-separated string
    func tagsToString() -> String {

        guard let tags = self.tags else { return "" }
        if tags.count == 0 { return "" }
        guard let tagsArray = tags.allObjects as? [Tag] else { return "" }

        var stringfiedTags = ""
        for tag in tagsArray {
            guard let label = tag.label else { continue }
            if stringfiedTags.count > 0 {
                stringfiedTags += ", "
            }
            stringfiedTags += label
        }

        return stringfiedTags
    }
}
