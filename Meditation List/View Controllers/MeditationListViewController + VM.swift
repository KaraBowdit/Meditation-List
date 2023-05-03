//
//  MeditationListViewController.swift
//  Meditation List
//
//  Created by Haley Jones on 5/3/23.
//

import UIKit

class MeditationListViewController: UIViewController {
    
    struct ViewModel {
        let topicDescription: String
        let pageTitle: String
        let subTopics: [Subtopic]
        let meditations: [Meditation]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func apply(viewModel: ViewModel) {
        
    }
    
    func makeViewModel(forTopic topic: Topic) -> ViewModel {
        //grab the subtopics we need
        let subtopics: [Subtopic] = SubtopicController.shared.subtopics.filter { subtopic in
            return subtopic.parentTopicId == topic.uuid
        }
        //populate subtopics w/ appropriate meditations
        for subtopic in subtopics {
            subtopic.meditations = MeditationController.shared.meditations.filter({ meditation in
                return subtopic.meditationIDs.contains(meditation.uuid)
            })
        }
        
        let meditations = MeditationController.shared.meditations.filter { meditation in
            return topic.meditations.contains(meditation.uuid)
        }
        
        return ViewModel(topicDescription: topic.description, pageTitle: topic.title, subTopics: subtopics, meditations: meditations)
    }

}

//MARK: - Table View Delegate & Data Source

extension MeditationListViewController: UITableViewDelegate, UITableViewDataSource {
    
}
