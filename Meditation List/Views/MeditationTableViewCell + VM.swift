//
//  SubtopicTableViewCell.swift
//  Meditation List
//
//  Created by Haley Jones on 5/2/23.
//

import UIKit

class MeditationTableViewCell: UITableViewCell {
    
    enum Constants {
        static let imageViewColorHex = "#548bb8"
    }
    
    struct ViewModel {
        let title: String
        let teacherName: String
        let imageData: Data?
    }
    
    private var viewModel: ViewModel?
    let meditationImageView = UIImageView()
    let titleLabel = UILabel()
    let teacherLabel = UILabel()
    
    func setUpViews() {
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading
        labelStackView.distribution = .fillProportionally
        labelStackView.spacing = 0
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(teacherLabel)
        
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        teacherLabel.font = UIFont(name: "HelveticaNeue", size: 14)
        teacherLabel.textColor = .lightGray
        
        meditationImageView.backgroundColor = UIColor(hexValue: Constants.imageViewColorHex)
        meditationImageView.clipsToBounds = true
        meditationImageView.layer.cornerRadius = 8
        meditationImageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(meditationImageView)
        contentView.addSubview(labelStackView)
        
        //Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        teacherLabel.translatesAutoresizingMaskIntoConstraints = false
        meditationImageView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            meditationImageView.heightAnchor.constraint(equalTo: labelStackView.heightAnchor),
            meditationImageView.widthAnchor.constraint(equalTo: meditationImageView.heightAnchor),
            meditationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            meditationImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: meditationImageView.trailingAnchor, constant: 8),
            labelStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -16)
            ])
    }
    
    func apply(viewModel: ViewModel?) {
        setUpViews()
        titleLabel.text = viewModel?.title
        teacherLabel.text = viewModel?.teacherName
        if let imageData = viewModel?.imageData {
            meditationImageView.image = UIImage(data: imageData)
        }
        self.viewModel = viewModel
    }
    
    func makeViewModel(forMeditation meditation: Meditation) -> ViewModel? {
        return ViewModel(title: meditation.title, teacherName: meditation.teacherName, imageData: meditation.imageData)
    }

}
