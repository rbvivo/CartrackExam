//
//  MapViewController.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/16/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var viewModel: MapViewModel?
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close, target: self, action: #selector(closeButtonPressed))
        closeButton.tintColor = UIColor.black
        return closeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadLocation()
    }
    
    private func setupUI() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        navigationItem.leftBarButtonItem = closeButton
    }
    
    private func loadLocation() {
        let coordinate = CLLocationCoordinate2D(latitude: Double(viewModel?.latitude ?? "0") ?? 0.0, longitude: Double(viewModel?.longitude ?? "0") ?? 0.0)
        let coordinateRegion = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.isZoomEnabled = true
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    
    @objc private func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
