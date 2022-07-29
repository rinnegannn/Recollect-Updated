//
//  RefillViewController.swift
//  Recollect
//
//  Created by Aryan on 2022-07-28.
//

import UIKit

class RefillViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtn(_ sender: Any) {
        guard let cont = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as? UINavigationController else {
            return
        }
        cont.modalPresentationStyle = .fullScreen
        cont.modalTransitionStyle = .coverVertical
        present(cont, animated: true, completion: nil)
        
    }
    
    



}
