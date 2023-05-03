//
//  Meditation.swift
//  Meditation List
//
//  Created by Haley Jones on 5/2/23.
//

import Foundation

class Meditation: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case title = "title"
        case teacherName = "teacher_name"
        case imageUrl = "image_url"
        case playCount = "play_count"
    }
    
    let uuid: String
    let title: String
    let teacherName: String
    let imageUrl: String
    let playCount: Int?
    
}

class MeditationsTLD: Decodable {
    let meditations: [Meditation]
}
