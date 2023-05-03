//
//  Topic.swift
//  Meditation List
//
//  Created by Haley Jones on 5/2/23.
//

import Foundation

class Topic: Decodable {
    
    let uuid: String
    let title: String
    let position: Int
    let meditations: [String]
    let featured: Bool
    let color: String
    let description: String
}

class TopicsTLD: Decodable {
    let topics: [Topic]
}
