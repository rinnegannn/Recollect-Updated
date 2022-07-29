//
//  OnboardingViewController.swift
//  Recollect
//
//  Created by student on 2022-07-21.
//


// Onboarding Slide
import UIKit

class OnboardingViewController: UIViewController {
    // Buttons
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    // Slides variable
    var slides: [OnboardingSlide] = []
    // Current page for slides
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1{
                nextBtn.setTitle("Get Started", for: .normal)
            } else {
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Content of slides
        slides = [
            OnboardingSlide(title: "Quick Reminders", description: "Reduce stress by making critical reminders.", image: #imageLiteral(resourceName: "Phone..png")),
            OnboardingSlide(title: "Notifications On Time", description: "No need to worry, we have your back.", image: #imageLiteral(resourceName: "Noti.png")),
            OnboardingSlide(title: "Trust Us", description: "Enjoy, your every day!", image: #imageLiteral(resourceName: "Relief.png"))
        ]
        
        pageControl.numberOfPages = slides.count

        
        }
    
    // Next button function
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .coverVertical
            UserDefaults.standard.hasOnboarded = true
            present(controller, animated: true, completion: nil)

    // if you go back rather than Next
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    
    
}

// Extentions 
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)

    }
    
}
