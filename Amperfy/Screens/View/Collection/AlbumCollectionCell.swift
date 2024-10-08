//
//  AlbumCollectionCell.swift
//  Amperfy
//
//  Created by Maximilian Bauer on 21.01.22.
//  Copyright (c) 2022 Maximilian Bauer. All rights reserved.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import UIKit
import AmperfyKit

class AlbumCollectionCell: BasicCollectionCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var entityImage: EntityImageView!
    @IBOutlet weak var artworkImageWidthConstraint: NSLayoutConstraint!
    
    static let maxWidth: CGFloat = 250.0
    
    private var container: PlayableContainable?
    private var rootView: UICollectionViewController?
    
    func display(container: PlayableContainable, rootView: UICollectionViewController) {
        self.container = container
        self.rootView = rootView
        titleLabel.text = container.name
        subtitleLabel.text = container.subtitle
        entityImage.display(theme: appDelegate.storage.settings.themePreference, container: container, cornerRadius: .big)
        let newImageWidth = min(entityImage.superview?.bounds.width ?? 0.0, entityImage.superview?.bounds.height ?? 0.0)
        artworkImageWidthConstraint.constant = newImageWidth
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        let newImageWidth = min(entityImage.superview?.bounds.width ?? 0.0, entityImage.superview?.bounds.height ?? 0.0)
        artworkImageWidthConstraint.constant = newImageWidth
        super.layoutSubviews()
    }
    
}
