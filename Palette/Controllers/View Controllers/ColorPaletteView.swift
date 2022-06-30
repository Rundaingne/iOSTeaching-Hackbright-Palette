//
//  ColorPaletteView.swift
//  Palette
//
//  Created by Erich Kumpunen on 6/29/22.
//

import UIKit

class ColorPaletteView: UIView {
    
    // MARK: Property Observers: didSet, willSet, etc
    // didSet: After the property gets a value set to it, do something
    // willSet: Before the property gets a value set to it, do something.

    var colors: [UIColor]? {
        didSet {
            buildColorBricks()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupViews()
    }
    
    func setupViews() {
        self.addSubview(colorStackView)
        colorStackView.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeft: 0, paddingRight: 0)
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    
    func buildColorBricks() {
        resetColorBricks()
        guard let colors = colors else { return }
        for color in colors {
            let brick = createColorBrick(for: color)
            self.addSubview(brick)
            self.colorStackView.addArrangedSubview(brick)
        }
        self.layoutIfNeeded()
    }
    
    func createColorBrick(for color: UIColor) -> UIView {
        let colorBrick = UIView()
        colorBrick.backgroundColor = color
        return colorBrick
    }
    
    func resetColorBricks() {
        for subView in colorStackView.arrangedSubviews {
            colorStackView.removeArrangedSubview(subView)
        }
    }
    
    let colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
}
