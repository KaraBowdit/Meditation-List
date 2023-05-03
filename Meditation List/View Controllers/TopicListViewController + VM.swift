//
//  TopicListViewController + VM.swift
//  Meditation List
//
//  Created by Haley Jones on 5/3/23.
//

import UIKit

class TopicListViewController: UIViewController {
    
    enum Constants {
        static let cellIdentifier = "TopicCell"
        static let pageTitle = "Topics"
        static let backgroundColorHex = "#fbfbfb"
    }
    
    var viewModel: ViewModel?
    let tableView = UITableView()
    let titleLabel = UILabel()
    
    struct ViewModel {
        let topics: [Topic]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func apply(viewModel: ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }
    
    func makeViewModel() -> ViewModel {
        let featuredTopics = TopicController.shared.topics.filter({ $0.featured == true })
        let sortedTopics = featuredTopics.sorted(by: { $0.position < $1.position } )
        return ViewModel(topics: sortedTopics)
    }
    
    func setUpViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor(hexValue: Constants.backgroundColorHex)
        
        titleLabel.backgroundColor = .clear
        titleLabel.text = Constants.pageTitle
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        titleLabel.textAlignment = .left
        tableView.register(TopicTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)])
    }

}

//MARK: - TableView Delegate & DataSource

extension TopicListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel != nil else {
            return 0
        }
        return viewModel?.topics.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as? TopicTableViewCell,
              let cellTopic = viewModel?.topics[indexPath.row],
              let cellVM = cell.makeViewModel(forTopic: cellTopic) else {
            return UITableViewCell()
        }
        
        cell.apply(viewModel: cellVM)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    //Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {
            return
        }
        let destinationVC = MeditationListViewController()
        let destinationVM = destinationVC.makeViewModel(forTopic: viewModel.topics[indexPath.row])
        //apply the VM, present the new view
        destinationVC.apply(viewModel: destinationVM)
        present(destinationVC, animated: true)
        return
    }

}
