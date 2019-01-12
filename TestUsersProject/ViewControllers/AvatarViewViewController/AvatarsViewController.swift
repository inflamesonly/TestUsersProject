//
//  AvatarsViewController.swift
//  TestUsersProject
//
//  Created by macOS on 12.01.2019.
//  Copyright © 2019 macOS. All rights reserved.
//

import UIKit

protocol AvatarsViewControllerDelegate : class {
    func setNewAvatar (image : UIImage, imageURL : Image)
}

class AvatarsViewController: ParentViewController {
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    
    weak var delegate: AvatarsViewControllerDelegate?
    var images = [Image]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New avatar"
        self.getImages()
    }
    
    func getImages () {
        self.startActivity()
        RequestManager.sharedInstance.getImagesFromServer(success: { images in
            self.images = images
            self.imagesCollectionView.reloadData()
            self.stopActivity()
        }) { errorCode in
            self.stopActivity()
            self.presentAlert(withTitle: "Error", message: "Server error!")
        }
    }
}

extension AvatarsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvatarCell", for: indexPath) as! AvatarCell
        let image = self.images[indexPath.row]
        cell.configure(image: image)
        return cell
    }
}

extension AvatarsViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = self.images[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as! AvatarCell
        self.delegate?.setNewAvatar(image: cell.avatar.image!, imageURL: image)
        self.navigationController?.popViewController(animated: true)
    }
}
