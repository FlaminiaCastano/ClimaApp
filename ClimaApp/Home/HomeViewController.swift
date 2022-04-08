//
//  ViewController.swift
//  ClimaApp
//
//  Created by Flaminia Castaño on 08/04/2022.
//

import UIKit
import Alamofire
import PromiseKit

class HomeViewController: UIViewController {

    @IBOutlet weak var fondoView: UIView!
    @IBOutlet weak var txtCiudad: UITextField!
    @IBOutlet weak var lblCiudad: UILabel!
    
    @IBOutlet weak var lblTemperatura: UILabel!
    @IBOutlet weak var lblMax: UILabel!
    @IBOutlet weak var lblMin: UILabel!
    @IBOutlet weak var lblDía: UILabel!
    
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        txtCiudad.text = "Santa Fe"
        activityLoading.isHidden = true 
        searchWeatherCity()
    }

    func setUpView() {
        fondoView.layer.cornerRadius = 15
        fondoView.layer.borderColor = UIColor(named: "#5CE1E6")?.cgColor
        fondoView.layer.borderWidth = 2
    }

    @IBAction func buscarButton(_ sender: Any) {
        searchWeatherCity()
    }

    
    func searchWeatherCity() {
        activityLoading.isHidden = false
        activityLoading.startAnimating()
        
        let cityTitle = validateEmptyFields(txtCiudad.text!)
        let city = replaceCityName(cityTitle)
        
        firstly {
            when(fulfilled:
                    APIClima.weatherPromises(city),
                    APIClima.descriptionDayPromises(city)
            )
        }
        .done { (weather, descriptionDay) in
            self.lblTemperatura.text = "\(Int(weather.temp))°"
            self.lblMax.text = "\(Int(weather.tempMax))°"
            self.lblMin.text = "\(Int(weather.tempMin))°"
            self.lblDía.text = descriptionDay.uppercased()
            self.lblCiudad.text = cityTitle
        }
        .catch { error in
            let alert = UIAlertController(title: "Error", message: "No se pudo encontrar esa ciudad. Intente de nuevo.", preferredStyle: .alert)
            
            let accept = UIAlertAction(title: "Aceptar", style: .default)
            
            alert.addAction(accept)
            self.present(alert, animated: true)
        }.finally{
            self.activityLoading.stopAnimating()
            self.activityLoading.isHidden = true
        }
    }
    
    func replaceCityName(_ city: String) -> String{
        return city.replacingOccurrences(of: " ", with: "%20")
    }
    
    func validateEmptyFields(_ city: String) -> String{
        if city.isEmpty{
            let alert = UIAlertController(title: "Weather", message: "Complete el campo vacío", preferredStyle: .alert)
            
            let accept = UIAlertAction(title: "Aceptar", style: .default)
            
            alert.addAction(accept)
            present(alert, animated: true)
        }
            return city
    }
    
    //Cierra el teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // oculta el teclado
        return true
    }
}

