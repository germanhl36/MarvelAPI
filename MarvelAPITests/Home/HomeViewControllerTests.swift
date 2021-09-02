//
//  HomeViewControllerTests.swift
//  MarvelAPITests
//
//  Created by German Huerta on 31/08/21.
//

import XCTest
@testable import MarvelAPI
class HomeViewControllerTests: XCTestCase {
    var sutViewController:HomeViewController!
    var mockHomeVM = HomeViewModelMock()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sutViewController = self.makeSUT()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    
    func test_tableView_NumberOfRows() {
        let count = mockHomeVM.getCount()
        XCTAssertTrue(count == sutViewController.tableView(sutViewController.tableView, numberOfRowsInSection: 0),"The numberOfRowsInSection function returned a number different than the getCount function of the model")
    }
    
    func test_tableView_NumberOfRows_NotNil(){
        XCTAssertNotNil(sutViewController.tableView(sutViewController.tableView, numberOfRowsInSection: 0), "The numberOfRowsInSection function returned nil")
    }
    
    func test_tableView_CellForRow_NotNil(){
        XCTAssertNotNil(sutViewController.tableView(sutViewController.tableView, cellForRowAt: IndexPath(item: 0, section: 0)), "The cellForRow function returned nil ")
    }
    
    func test_tableViewCell_title_isEqualToVMTitle() {
        let cellIndex = 5
        guard let cell = sutViewController.tableView(sutViewController.tableView, cellForRowAt: IndexPath(item: cellIndex, section: 0)) as? ComicTableViewCell else {
            XCTFail()
            return
        }
        let vm = mockHomeVM.getItemVM(at: cellIndex)
        let title = vm.getTitle().string
        
        XCTAssertTrue(cell.titleLabel.text == title,"The cell title doesn't match with the model title")
    }
    
    func test_tableViewCell_description_isEqualToVMDescription() {
        let cellIndex = 5
        guard let cell = sutViewController.tableView(sutViewController.tableView, cellForRowAt: IndexPath(item: cellIndex, section: 0)) as? ComicTableViewCell else {
            XCTFail()
            return
        }
        let vm = mockHomeVM.getItemVM(at: cellIndex)
        let description = vm.getDescription().string
        
        XCTAssertTrue(cell.descriptionLabel.text == description,"The cell description doesn't match with the model description")
    }
    
    func test_tableViewCell_pagecount_isEqualToVMPageCount() {
        let cellIndex = 5
        guard let cell = sutViewController.tableView(sutViewController.tableView, cellForRowAt: IndexPath(item: cellIndex, section: 0)) as? ComicTableViewCell else {
            XCTFail()
            return
        }
        let vm = mockHomeVM.getItemVM(at: cellIndex)
        let pageCount = vm.getPageCount().string
        
        XCTAssertTrue(cell.pagesLabel.text == pageCount,"The cell description doesn't match with the model description")
    }
    
    func makeSUT() -> HomeViewController {
        mockHomeVM.setHeaderImage(imageName: "marvel_header")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        sut.config(withVM: mockHomeVM)
        sut.loadViewIfNeeded()
        return sut
    }
    
}




