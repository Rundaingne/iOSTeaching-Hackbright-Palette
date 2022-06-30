//
//  PaletteTableViewCell.swift
//  Palette
//
//  Created by Erich Kumpunen on 6/29/22.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var photo: UnsplashPhoto? {
        didSet {
            updateViews()
        }
    }
    // MARK: Lifecycles
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addAllSubviews()
        constrainImageView()
        constrainTitleLabel()
        constrainColorPaletteView()
    }
    
    // MARK: Helper Functions
    func updateViews() {
        colorPaletteView.colors = [.cyan, .green, .blue, .magenta, .orange]
    }
    
    func addAllSubviews() {
        self.addSubview(paletteImageView)
        self.addSubview(paletteTitleLabel)
        self.addSubview(colorPaletteView)
    }
    
    func constrainImageView() {
        let imageViewWidth = self.contentView.frame.width - (2 * SpacingConstants.outerHorizontalPadding)
        paletteImageView.anchor(top: self.contentView.topAnchor, bottom: nil, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: SpacingConstants.outerVerticalPadding, paddingBottom: 0, paddingLeft: SpacingConstants.outerHorizontalPadding, paddingRight: SpacingConstants.outerVerticalPadding, width: imageViewWidth, height: imageViewWidth)
    }
    
    func constrainTitleLabel() {
        paletteTitleLabel.anchor(top: paletteImageView.bottomAnchor, bottom: nil, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectBuffer, paddingBottom: SpacingConstants.verticalObjectBuffer, paddingLeft: SpacingConstants.outerHorizontalPadding, paddingRight: SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.oneLineElementHeight)
    }
    
    func constrainColorPaletteView() {
        colorPaletteView.anchor(top: paletteTitleLabel.bottomAnchor, bottom: self.contentView.bottomAnchor, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectBuffer, paddingBottom: SpacingConstants.outerVerticalPadding, paddingLeft: SpacingConstants.outerHorizontalPadding, paddingRight: SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.twoLineElementHeight)
    }
    
    // MARK: Views
    let paletteImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .cyan
        return imageView
    }()
    
    let paletteTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Replace me"
        return label
    }()
    
    let colorPaletteView: ColorPaletteView = {
        return ColorPaletteView()
    }()

}
