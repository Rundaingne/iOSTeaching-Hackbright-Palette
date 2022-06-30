//
//  PaletteListViewController.swift
//  Palette
//
//  Created by Erich Kumpunen on 6/29/22.
//

import UIKit

class PaletteListViewController: UIViewController {
    
    // MARK: Properties
    var safeAreaLayout: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }

    // MARK: Lifecycle
    override func loadView() {
        super.loadView()
        self.addAllSubviews()
        setupButtonStackview()
        constrainTableView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemIndigo
        configureTableView()
    }
    
    // MARK: Helper functions
    func addAllSubviews() {
        self.view.addSubview(featureButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(doubleRainbowButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(paletteTableView)
    }
    
    func configureTableView() {
        paletteTableView.delegate = self
        paletteTableView.dataSource = self
        paletteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "photoCell")
    }
    
    func constrainTableView() {
        paletteTableView.anchor(top: buttonStackView.bottomAnchor, bottom: self.safeAreaLayout.bottomAnchor, leading: self.safeAreaLayout.leadingAnchor, trailing: self.safeAreaLayout.trailingAnchor, paddingTop: 4, paddingBottom: 4, paddingLeft: 4, paddingRight: 4)
    }
    
    
    fileprivate func setupButtonStackview() {
        buttonStackView.addArrangedSubview(featureButton)
        buttonStackView.addArrangedSubview(randomButton)
        buttonStackView.addArrangedSubview(doubleRainbowButton)
        
        buttonStackView.topAnchor.constraint(equalTo: self.safeAreaLayout.topAnchor, constant: 8).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayout.leadingAnchor, constant: 8).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayout.trailingAnchor, constant: -8).isActive = true
    }
    
    // MARK: Views
    let featureButton: UIButton = {
        let button = UIButton()
        button.setTitle("Featured", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()

    let doubleRainbowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Double Rainbow", for: .normal)
//        button.titleLabel?.font = button.titleLabel?.font.withSize(10)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
        
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()

    let paletteTableView: UITableView = {
       let tableView = UITableView()
        
        return tableView
    }()
}

extension PaletteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PaletteTableViewCell else { return UITableViewCell() }
        cell.updateViews()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 1) Height of image and image padding
        let outerVerticalPaddingSpace: CGFloat = 2 * SpacingConstants.outerVerticalPadding
        let imageViewSpace: CGFloat = view.frame.width - (2 * SpacingConstants.outerHorizontalPadding)
        // 2) Height of label and label padding
        let labelSpace: CGFloat = SpacingConstants.oneLineElementHeight
        let objectBuffer: CGFloat = SpacingConstants.verticalObjectBuffer
        
        // 3) Height of color palette and padding
        let paletteBuffer: CGFloat = SpacingConstants.verticalObjectBuffer
        let paletteHeight: CGFloat = SpacingConstants.twoLineElementHeight
        
        return outerVerticalPaddingSpace + imageViewSpace + labelSpace + objectBuffer + paletteBuffer + paletteHeight
    }
}
