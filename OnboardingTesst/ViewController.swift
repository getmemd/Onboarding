//
//  ViewController.swift
//  OnboardingTesst
//
//  Created by Адиль Медеуев on 03.03.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    var slides = [Slide]()
    var currentPage = 0 {
        didSet {
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Войти", for: .normal)
            } else {
                nextButton.setTitle("Далее", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = [Slide(title: "Защитите себя и своих близких", description: "Старайтесь как можно реже контактировать с окружающими, чтобы замедлить распространение вируса", image: #imageLiteral(resourceName: "0000-1")),
                  Slide(title: "Статистика", description: "Следите за количеством людей, с которыми Вы контактируете. Это поможет Вам и Вашим близким оставаться в безопасности", image: #imageLiteral(resourceName: "0000-3")),
                  Slide(title: "Ваши данные удалятся после карантина", description: "Ваши данные будут удалены после окончания пандемии COVID-19", image: #imageLiteral(resourceName: "0000-4")),
                  Slide(title: "Оставайтесь в курсе", description: "Будьте в курсе последних новостей Казахстана и всего мира на тему коронавируса", image: #imageLiteral(resourceName: "0000-5"))
        ]
        pageControl.numberOfPages = slides.count        
    }

    @objc func scrollToNextCell(){
        currentPage += 1
        pageControl.currentPage = currentPage
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let ac = UIAlertController(title: "Вход", message: "Завершено", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Ок", style: .default, handler: { _ in
                exit(0)
            }))
            present(ac, animated: true)
        } else {
            scrollToNextCell()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = currentPage
    }
}
