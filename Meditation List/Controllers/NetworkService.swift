//
//  NetworkService.swift
//  Meditation List
//
//  Created by Haley Jones on 5/2/23.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    enum Constants {
        static let topicsURL = "https://tenpercent-interview-project.s3.amazonaws.com/topics.json"
        static let subtopicsURL = "https://tenpercent-interview-project.s3.amazonaws.com/subtopics.json"
        static let meditationsURL = "https://tenpercent-interview-project.s3.amazonaws.com/meditations.json"
    }
    
    //Using a dispatch group to batch my network calls
    func fetchAllData(completion: @escaping () -> Void) {
        let fetchGroup = DispatchGroup()
        
        fetchTopics(with: fetchGroup) {
            fetchGroup.leave()
            print("Finished fetching topics. \(TopicController.shared.topics.count) topics.")
        }
        fetchSubTopics(with: fetchGroup) {
            fetchGroup.leave()
            print("finished fetching Subtopics. \(SubtopicController.shared.subtopics.count) subtopics")
        }
        fetchMeditations(with: fetchGroup) {
            print("finished fetching meditations. \(MeditationController.shared.meditations.count) meditations.")
            fetchGroup.leave()
        }
        
        fetchGroup.notify(queue: .main) {
            completion()
        }
    }
    
    //Examined a few options, wound up using individual functions for each call & then wrapping them for convenience.
    func fetchTopics(with dispatchGroup: DispatchGroup?, completion: @escaping () -> Void) {
        guard let fetchURL = URL(string: Constants.topicsURL) else {
            print("⚠️ There was an error constructing the Topics URL")
            completion()
            return
        }
        dispatchGroup?.enter()
        URLSession.shared.dataTask(with: fetchURL) { fetchedData, response, error in
            if let unwrappedError = error {
                print("⚠️ There was an error during the Fetch Topics network request. \(unwrappedError.localizedDescription)")
                completion()
                return
            }
            guard let unwrappedData = fetchedData else {
                print("⚠️ There was an error unwrapping the Topics response.")
                completion()
                return
            }
            print(unwrappedData)
            if let decodedTLD = try? JSONDecoder().decode(TopicsTLD.self, from: unwrappedData) {
                TopicController.shared.topics = decodedTLD.topics
            } else {
                print("⚠️ There was an error decoding the JSON recieved from the Topics endpoint.")
            }
            completion()
            return
        }.resume()
    }
    
    func fetchSubTopics(with dispatchGroup: DispatchGroup?, completion: @escaping () -> Void) {
        guard let fetchURL = URL(string: Constants.subtopicsURL) else {
            print("⚠️ There was an error constructing the Subopics URL")
            completion()
            return
        }
        dispatchGroup?.enter()
        URLSession.shared.dataTask(with: fetchURL) { fetchedData, response, error in
            if let unwrappedError = error {
                print("⚠️ There was an error during the Fetch Subtopics network request. \(unwrappedError.localizedDescription)")
                completion()
                return
            }
            guard let unwrappedData = fetchedData else {
                print("⚠️ There was an error unwrapping the Subtopics response.")
                completion()
                return
            }
            
            if let decodedTLD = try? JSONDecoder().decode(SubtopicsTLD.self, from: unwrappedData) {
                SubtopicController.shared.subtopics = decodedTLD.subtopics
            } else {
                print("⚠️ There was an error decoding the JSON recieved from the Subtopics endpoint.")
            }
            completion()
            return
        }.resume()
    }
    
    func fetchMeditations(with dispatchGroup: DispatchGroup?, completion: @escaping () -> Void) {
        guard let fetchURL = URL(string: Constants.meditationsURL) else {
            print("⚠️ There was an error constructing the Meditations URL")
            completion()
            return
        }
        dispatchGroup?.enter()
        URLSession.shared.dataTask(with: fetchURL) { fetchedData, response, error in
            if let unwrappedError = error {
                print("⚠️ There was an error during the Fetch Meditations network request. \(unwrappedError.localizedDescription)")
                completion()
                return
            }
            guard let unwrappedData = fetchedData else {
                print("⚠️ There was an error unwrapping the Meditations response.")
                completion()
                return
            }
            
            if let decodedTLD = try? JSONDecoder().decode(MeditationsTLD.self, from: unwrappedData) {
                MeditationController.shared.meditations = decodedTLD.meditations
            } else {
                print("⚠️ There was an error decoding the JSON recieved from the Meditations endpoint.")
                print(unwrappedData.prettyPrintedJSONString)
            }
            completion()
            return
        }.resume()
    }
}
