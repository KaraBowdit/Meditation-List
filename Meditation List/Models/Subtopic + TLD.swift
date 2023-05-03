//
//  Subtopic.swift
//  Meditation List
//
//  Created by Haley Jones on 5/2/23.
//

import Foundation

class Subtopic: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case parentTopicId = "parent_topic_uuid"
        case title = "title"
        case position = "position"
        case meditationIDs = "meditations"
    }
    
    let uuid: String
    let parentTopicId: String
    let title: String
    let position: Int
    let meditationIDs: [String]
    var meditations: [Meditation] = []
}

class SubtopicsTLD: Decodable {
    var subtopics: [Subtopic]
}
