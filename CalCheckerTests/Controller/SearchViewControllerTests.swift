//
//  SearchViewControllerTests.swift
//  CalChecker
//
//  Created by Abisola Adeniran on 2016-11-18.
//  Copyright © 2016 Abisola Adeniran. All rights reserved.
//

import XCTest
@testable import CalChecker
class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController")
        sut = viewController as! SearchViewController
        _ = sut.view
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_FieldsLabelsButtons_Exists(){
        XCTAssertNotNil(sut.errorLabel)
        XCTAssertNotNil(sut.buttonText)
        XCTAssertNotNil(sut.searchText)
    }
    
}
