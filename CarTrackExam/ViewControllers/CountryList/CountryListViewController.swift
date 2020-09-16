//
//  CountryListViewController.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/15/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import UIKit

class CountryListViewController: UIViewController {
    private let viewModel: CountryListViewModel = CountryListViewModel()
    private let searchController = UISearchController()
    var selectCountry: ((_ selectedCountry: String) -> ())?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 40
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.registerCell(CountryTableViewCell.self)
        tableView.separatorColor = .separator
        return tableView
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonPressed))
        doneButton.tintColor = UIColor.black
        doneButton.isEnabled = false
        return doneButton
    }()
    
    private lazy var closeButton: UIBarButtonItem = {
        let closeButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(closeButtonPressed))
        closeButton.tintColor = UIColor.black
        return closeButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearch()
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.accessibilityIdentifier = "searchBar"
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = .done
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.automaticallyShowsCancelButton = true
        searchController.searchBar.tintColor = .black
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    @objc private func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func doneButtonPressed() {
        selectCountry?(viewModel.selectedCountry)
        searchController.searchBar.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

}

extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isSearching ? viewModel.searchList.count : viewModel.countryList.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        doneButton.isEnabled = true
        viewModel.selectedCountry = viewModel.isSearching ? viewModel.searchList[indexPath.row] : viewModel.countryList[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CountryTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setCountryText(countryText: viewModel.isSearching ? viewModel.searchList[indexPath.row] : viewModel.countryList[indexPath.row])
        return cell
    }
}

extension CountryListViewController: UISearchBarDelegate {
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        
    }
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isSearching = false
        viewModel.searchCountry(searchText: "")
        tableView.reloadData()
        searchBar.showsCancelButton = false
    }
}

extension CountryListViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        if text.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return
        }
        
        viewModel.isSearching = true
        viewModel.searchCountry(searchText: text)
        tableView.reloadData()
    }
}
