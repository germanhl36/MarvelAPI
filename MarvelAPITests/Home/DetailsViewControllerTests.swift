//
//  DetailsViewControllerTests.swift
//  MarvelAPITests
//
//  Created by German Huerta on 01/09/21.
//

import XCTest
@testable import MarvelAPI

class DetailsViewControllerTests: XCTestCase {
    var sutViewController:DetailsViewController!
    var mockHomeVM = HomeViewModelMock()
    var detailVM:ItemDetailProtocol!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockHomeVM.getItems(offset: 0)
        detailVM = mockHomeVM.getItemVM(at: 0)
        sutViewController = self.makeSUT()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_detailviewcontroller_content_contains_vm_title() {
        let content = sutViewController.contentTextView.attributedText.string
        let titleOnVM = detailVM.getTitle().string
        XCTAssertTrue(content.contains(titleOnVM), "The content of the DetailsViewController doesn't contain the title of the vm")
    }
    
    
    func test_detailviewcontroller_content_contains_vm_description() {
        let content = sutViewController.contentTextView.attributedText.string
        let titleOnVM = detailVM.getDescription().string
        XCTAssertTrue(content.contains(titleOnVM), "The content of the DetailsViewController doesn't contain the description of the vm")
    }
    
    func test_detailviewcontroller_content_contains_vm_pagecount() {
        let content = sutViewController.contentTextView.attributedText.string
        let titleOnVM = detailVM.getPageCount().string
        XCTAssertTrue(content.contains(titleOnVM), "The content of the DetailsViewController doesn't contain the page count of the vm")
    }
    
    func testIfLoginButtonHasActionAssigned() {
        
        //Check if Controller has UIButton property
        let closeButton: UIButton = sutViewController.closeButton
        XCTAssertNotNil(closeButton, "View Controller does not have UIButton property")
        
        // Attempt Access UIButton Actions
        guard let closeButtonActions = closeButton.actions(forTarget: sutViewController, forControlEvent: .touchUpInside) else {
            XCTFail("UIButton does not have actions assigned for Control Event .touchUpInside")
            return
        }
     
        // Assert UIButton has action with a method name
        XCTAssertTrue(closeButtonActions.contains("closeButtonTapped:"))
    }
    
    func test_collectionView_numberOfItemsInSection() {
        let imageCount = detailVM.getImages().count
        
        XCTAssertTrue(imageCount == sutViewController.collectionView(sutViewController.imagesCollectionView, numberOfItemsInSection: 0),"The numberOfItemsInSection function returned a number different than the getImages().count function of the model")
    }
    
    func test_collectionView_numberOfItemsInSection_NotNil(){
        XCTAssertNotNil(sutViewController.collectionView(sutViewController.imagesCollectionView, numberOfItemsInSection: 0), "The numberOfRowsInSection function returned nil")
    }
    
    func test_tableView_CellForRow_NotNil(){
        
        XCTAssertNotNil(sutViewController.collectionView(sutViewController.imagesCollectionView, cellForItemAt: IndexPath(item: 0, section: 0)), "The cellForItemAt function returned nil ")
    }
    
    func makeSUT() -> DetailsViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        sut.config(withVM: detailVM)
        sut.loadViewIfNeeded()
        return sut
    }
}
