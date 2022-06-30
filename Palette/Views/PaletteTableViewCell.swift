//
//  PaletteTableViewCell.swift
//  Palette
//
//  Created by Erich Kumpunen on 6/29/22.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {
    
    
    /// source of truth/ variables
    
    // MARK: We need what objects in this cell?
    // 1) UIImage
    // 2) UILabel
    // 3) Uhhh...ColorPaletteView. We will create this as its own custom view.
    
    var photo: UnsplashPhoto? {
        didSet {
            // MARK: do something once we've received a photo
            updateViews()
        }
    }
    
    /// lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addAllSubviews()
        constrainImageView()
        constrainTitleLabel()
        constrainColorPaletteView()
    }
    
    /// view update/helper methods
    func updateViews() {
        guard let photo = photo else { return }
        fetchAndSetImage(for: photo)
        paletteTitleLabel.text = photo.description ?? "No photo caption here...👻"
        fetchAndSetColorStack(for: photo)
    }
    
    func fetchAndSetImage(for photo: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: photo) { image in
            DispatchQueue.main.async {
                self.paletteImageView.image = image
            }
        }
    }
    
    func fetchAndSetColorStack(for photo: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: photo.urls.regular) { colors in
            DispatchQueue.main.async {
                guard let colors = colors else { return }
                self.colorPaletteView.colors = colors
            }
        }
    }
    
    /// View setup
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
    
    /// View creation
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
        return label
    }()
    
    let colorPaletteView: ColorPaletteView = {
        return ColorPaletteView()
    }()

}
