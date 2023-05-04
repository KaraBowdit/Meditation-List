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
    
    enum Constants {
        static let cellIdentifier = "MeditationCell"
        static let meditationsSectionCopy = "Meditations"
    }
    
    private var viewModel: ViewModel?
    let tableView = UITableView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MeditationTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        titleLabel.textAlignment = .left
        descriptionLabel.font = UIFont(name: "HelveticaNeue", size: 16)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(tableView)
        
        //constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func apply(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.pageTitle
        descriptionLabel.text = viewModel.topicDescription
        
        tableView.reloadData()
    }
    
    func makeViewModel(forTopic topic: Topic) -> ViewModel {
        //grab the subtopics we need
        let subtopics: [Subtopic] = SubtopicController.shared.getSubtopics(for: topic)
        
        //populate subtopics w/ appropriate meditations
        for subtopic in subtopics {
            subtopic.meditations = MeditationController.shared.meditations.filter({ meditation in
                return subtopic.meditationIDs.contains(meditation.uuid)
            }).sorted { ($0.playCount ?? 0) > ($1.playCount ?? 0) }
        }
        
         let meditations = MeditationController.shared.meditations.filter({ meditation in
            return topic.meditations.contains(meditation.uuid)
         }).sorted { ($0.playCount ?? 0) > ($1.playCount ?? 0) }
        
        return ViewModel(topicDescription: topic.description, pageTitle: topic.title, subTopics: subtopics, meditations: meditations)
    }

}

//MARK: - Table View Delegate & Data Source

extension MeditationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        if section >= viewModel.subTopics.count && !viewModel.meditations.isEmpty {
            return viewModel.meditations.count
        } else {
            return viewModel.subTopics[section].meditations.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        var sectionsCount = viewModel.subTopics.count
        if !viewModel.meditations.isEmpty {
            sectionsCount += 1
        }
        
        
        return sectionsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? MeditationTableViewCell,
            let viewModel = viewModel else {
            return UITableViewCell()
        }
        
        if indexPath.section >= viewModel.subTopics.count || viewModel.subTopics.isEmpty {
            if !viewModel.meditations.isEmpty {
                let cellVM = cell.makeViewModel(forMeditation: viewModel.meditations[indexPath.row])
                cell.apply(viewModel: cellVM)
            }
        } else {
            if !viewModel.subTopics[indexPath.section].meditations.isEmpty {
                let sectionSubtopic = viewModel.subTopics[indexPath.section]
                let cellVM = cell.makeViewModel(forMeditation: sectionSubtopic.meditations[indexPath.row])
                cell.apply(viewModel: cellVM)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else {
            return UIView()
        }
        let headerLabel = UILabel()
        headerLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
        headerLabel.textAlignment = .left
        headerLabel.backgroundColor = .white
        
        if section < viewModel.subTopics.count {
            headerLabel.text = viewModel.subTopics[section].title
        } else {
            if !viewModel.meditations.isEmpty {
                headerLabel.text = Constants.meditationsSectionCopy
            }
        }
        
        return headerLabel
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
}
