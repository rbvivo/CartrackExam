//
//  CountryListViewModel.swift
//  CarTrackExam
//
//  Created by Bryan Vivo on 9/15/20.
//  Copyright © 2020 Bryan Vivo. All rights reserved.
//

import Foundation

class CountryListViewModel {
    var countryList: [String]
    var selectedCountry: String = ""
    var isSearching = false
    var searchList: [String] = []
    
    init() {
        countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }
    }
    
    func searchCountry(searchText: String) {
        searchList = countryList.filter({$0.lowercased().contains(searchText.lowercased())})
    }
}
