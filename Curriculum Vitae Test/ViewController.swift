//
//  ViewController.swift
//  Curriculum Vitae
//
//  Created by Farouke Nnajiofor on 2019-10-18.
//  Copyright © 2019 Farouke Nnajiofor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var feedbackView = {return UIView()}()
    lazy var cvImageView = {return UIImageView(frame: .zero)}()
    
    let feedbacklabel = UILabel(frame: .zero)
    let nameLabel = UILabel(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    let socialMediaLabel = UILabel(frame: .zero)
    
    let bioLabel = UILabel(frame: .zero)
    let skillsLabel = UILabel(frame: .zero)
    let educationLabel = UILabel(frame: .zero)
    let experienceLabel = UILabel(frame: .zero)
    let referenceLabel = UILabel(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeedbackLabel()
        
        let url = URL(string: cvDataUrlString)!
        fetchCVData(url: url, completionHandler: {[weak self] vitae in
            self?.onSuccessLoadingData(vitae: vitae)
        }, errorHandler: {[weak self] error in
            self?.onErrorLoadingData(error: error)
        })
    }
    
}

extension ViewController {
    
    private func setupFeedbackLabel() {
        feedbacklabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(feedbacklabel)
        NSLayoutConstraint.activate([
            feedbacklabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedbacklabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        feedbacklabel.text = "Loading Data..."
    }
    
    private func onErrorLoadingData(error: String) {
        feedbacklabel.text = error
    }
    
    private func onSuccessLoadingData(vitae: Vitae) {
        feedbacklabel.removeFromSuperview()
        setupFeedbackView()
        setupImageView(vitae: vitae)
        setupLabels(vitae: vitae)
    }
    
    private func setupFeedbackView() {
        let feedbackScrollView = UIScrollView()
        feedbackScrollView.addTo(parentView: view)
        feedbackView.addTo(parentView: feedbackScrollView)
    }
    
    private func setupImageView(vitae: Vitae) {
        cvImageView.translatesAutoresizingMaskIntoConstraints = false
        cvImageView.backgroundColor = .lightGray
        feedbackView.addSubview(cvImageView)
        NSLayoutConstraint.activate([
            cvImageView.topAnchor.constraint(equalTo: feedbackView.topAnchor, constant: 15),
            cvImageView.trailingAnchor.constraint(equalTo: feedbackView.trailingAnchor, constant: -15),
            cvImageView.heightAnchor.constraint(equalToConstant: 80),
            cvImageView.widthAnchor.constraint(equalToConstant: 80)
        ])
        cvImageView.layer.cornerRadius = 40
        cvImageView.clipsToBounds = true
        cvImageView.contentMode = .scaleAspectFill
        let url = URL(string: vitae.CVImage)!
        fetchImageData(url: url, completionHandler: {[weak cvImageView] data in
            cvImageView?.image = UIImage(data: data)
        })
    }
    
    private func setupLabels(vitae: Vitae) {
        feedbackView.add(label: nameLabel, aboveView: cvImageView, value: vitae.name, topAnchorConstant: 15, font: UIFont.systemFont(ofSize: 21, weight: .bold), color: .black)
        
        feedbackView.add(label: titleLabel, aboveView: nameLabel, value: vitae.title, topAnchorConstant: 0, font: UIFont.systemFont(ofSize: 16, weight: .medium), color: .lightGray)
        
        feedbackView.add(label: socialMediaLabel, aboveView: titleLabel, value: vitae.socialMedia, topAnchorConstant: 3, font: UIFont.systemFont(ofSize: 11, weight: .semibold), color: .darkGray)
        
        feedbackView.add(label: bioLabel, aboveView: socialMediaLabel, value: vitae.bio, topAnchorConstant: 15, font: UIFont.systemFont(ofSize: 15, weight: .medium), color: .darkGray)
        
        feedbackView.add(label: skillsLabel, aboveView: bioLabel, value: vitae.skills, topAnchorConstant: 15, font: UIFont.systemFont(ofSize: 15, weight: .medium), color: .darkGray)
        
        feedbackView.add(label: educationLabel, aboveView: skillsLabel, value: vitae.education, topAnchorConstant: 15, font: UIFont.systemFont(ofSize: 15, weight: .medium), color: .darkGray)
        
        feedbackView.add(label: experienceLabel, aboveView: educationLabel, value: vitae.experiences, topAnchorConstant: 15, font: UIFont.systemFont(ofSize: 15, weight: .medium), color: .darkGray)
        
        feedbackView.add(label: referenceLabel, aboveView: experienceLabel, value: vitae.references, topAnchorConstant: 15, font: UIFont.systemFont(ofSize: 15, weight: .medium), color: .darkGray)
        
        NSLayoutConstraint.activate([
            referenceLabel.bottomAnchor.constraint(equalTo: feedbackView.bottomAnchor, constant: -15)
        ])
    }
    
}

private extension UIView {
    
    func addTo(parentView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(self)
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor),
            self.leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor)
        ])
    }
    
    func add(label: UILabel, aboveView: UIView, value: String, topAnchorConstant: CGFloat, font: UIFont, color: UIColor) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.textColor = color
        self.addSubview(label)
        label.text = value
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: topAnchorConstant),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
}
