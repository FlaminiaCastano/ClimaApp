//
//  ViewController.swift
//  ClimaApp
//
//  Created by Flaminia Castaño on 08/04/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var fondoView: UIView!
    @IBOutlet weak var txtCiudad: UITextField!
    @IBOutlet weak var lblCiudad: UILabel!
    
    @IBOutlet weak var lblTemperatura: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblDía: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }

    func setUpView() {
        fondoView.layer.cornerRadius = 15
        fondoView.layer.borderColor = UIColor(named: "#5CE1E6")?.cgColor
        fondoView.layer.borderWidth = 2
    }

    @IBAction func buscarButton(_ sender: Any) {
    }
}

