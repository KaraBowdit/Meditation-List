//
//  SubtopicController.swift
//  Meditation List
//
//  Created by Haley Jones on 5/2/23.
//

import Foundation

class SubtopicController {
    
    static let shared = SubtopicController()
    var subtopics: [Subtopic] = []
    
    func getSubtopics(for topic: Topic) -> [Subtopic] {
        return subtopics.filter({$0.parentTopicId == topic.uuid})
    }
    
}
