//
//  MemeCollectionViewController.swift
//  memeMe2.0
//
//  Created by Stu Almeleh on 12/8/15.
//  Copyright © 2015 Stu Almeleh. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet var memeCollectionV: UICollectionView!
    
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        
        collectionView?.reloadData()
        print((UIApplication.sharedApplication().delegate as! AppDelegate).memes.count)
        print("collectionView reloaded")

    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        //determine which cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionViewCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        //determine the correct meme
        let meme = memes[indexPath.item]
        //set text and image
        cell.setText(meme.topText, bottom: meme.bottomText)
        cell.memeImageView? = UIImageView(image: meme.memedImage)
        
        return cell
    }
    

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath:NSIndexPath) {
        
        //Grab the DetailVC from Storyboard
        let detailVC = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        //Populate view controller with data from the selected item
        detailVC.meme = memes[indexPath.row]
        
        //Present the view controller using navigation
        self.navigationController!.pushViewController(detailVC, animated: true)
        
        
    }
    

}
