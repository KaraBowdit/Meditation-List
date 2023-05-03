//
//  TopicTableViewCell.swift
//  Meditation List
//
//  Created by Haley Jones on 5/2/23.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    struct ViewModel {
        let title: String
        let color: String
        let numberOfMeditations: Int
    }
    
    let labelStackView = UIStackView()
    let titleLabel = UILabel()
    let countLabel = UILabel()
    let colorStripe = UIView()
    let cellWrapperView = UIView()
    
    func apply(viewModel: ViewModel) {
        setUpViews()
        titleLabel.text = viewModel.title
        countLabel.text = "\(viewModel.numberOfMeditations) Meditations"
        colorStripe.backgroundColor = UIColor(hexValue: viewModel.color)
    }
    
    func makeViewModel(forTopic topic: Topic) -> ViewModel? {
        return ViewModel(title: topic.title, color: topic.color, numberOfMeditations: topic.meditations.count)
    }
    
    func setUpViews() {
        
        contentView.addSubview(cellWrapperView)
        
        //border, radius
        cellWrapperView.layer.borderColor = UIColor.lightGray.cgColor
        cellWrapperView.layer.cornerRadius = 4
        cellWrapperView.layer.borderWidth = 1
        cellWrapperView.clipsToBounds = true
        
        //subviews
        cellWrapperView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        colorStripe.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        countLabel.font = UIFont(name: "HelveticaNeue", size: 12)
        countLabel.textColor = .lightGray
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(countLabel)
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading
        labelStackView.distribution = .fillProportionally
        labelStackView.spacing = 4
        
        cellWrapperView.addSubview(colorStripe)
        cellWrapperView.addSubview(labelStackView)
        contentView.addSubview(cellWrapperView)
        
        NSLayoutConstraint.activate([
            cellWrapperView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellWrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            cellWrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellWrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            colorStripe.topAnchor.constraint(equalTo: cellWrapperView.topAnchor),
            colorStripe.bottomAnchor.constraint(equalTo: cellWrapperView.bottomAnchor),
            colorStripe.widthAnchor.constraint(equalToConstant: 12),
            labelStackView.leadingAnchor.constraint(equalTo: colorStripe.trailingAnchor, constant: 16),
            labelStackView.centerYAnchor.constraint(equalTo: cellWrapperView.centerYAnchor),
        ])
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
