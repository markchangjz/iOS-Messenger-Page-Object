import XCTest

// MARK: MessengerTabBar

protocol MessengerTabBar {
    func goToHomePage() -> HomePage
    func goToCallsPage() -> CallsPage
    func goToGroupsPage() -> GroupsPage
    func goToPeoplePage() -> PeoplePage
    func goToMePage() -> MePage
}

extension MessengerTabBar {
    fileprivate var homeButton: XCUIElement {
        return Page.app.buttons["Home"]
    }
    
    fileprivate var callsButton: XCUIElement {
        return Page.app.buttons["Calls"]
    }
    
    fileprivate var groupsButton: XCUIElement {
        return Page.app.buttons["Groups"]
    }
    
    fileprivate var peopleButton: XCUIElement {
        return Page.app.buttons["People"]
    }
    
    fileprivate var meButton: XCUIElement {
        return Page.app.buttons["Me"]
    }

	@discardableResult
    func goToHomePage() -> HomePage {
        homeButton.tap()
        return HomePage()
    }

	@discardableResult
    func goToCallsPage() -> CallsPage {
        callsButton.tap()
        return CallsPage()
    }
    
	@discardableResult
	func goToGroupsPage() -> GroupsPage {
        groupsButton.tap()
        return GroupsPage()
    }
    
	@discardableResult
	func goToPeoplePage() -> PeoplePage {
        peopleButton.tap()
        return PeoplePage()
    }
    
	@discardableResult
	func goToMePage() -> MePage {
        meButton.tap()
        return MePage()
    }
}

// MARK: ChatNavigationBar

protocol ChatRoomNavigationBar {
    func backTo<T: Page>(_ type: T.Type) -> T
}

extension ChatRoomNavigationBar {
    fileprivate var backButton: XCUIElement {
        return Page.app.navigationBars.buttons["Back"]
    }
    
    func backTo<T: Page>(_ type: T.Type) -> T {
        backButton.tap()
        return type.init()
    }
}

// MARK: MessengerSearchBar

protocol MessengerSearchBar {
    func goToSearchPage() -> SearchPage
    func cancelAndExpectTransitionToPage<T: Page>(_ type: T.Type) -> T
}

extension MessengerSearchBar {
    fileprivate var cancelButton: XCUIElement {
        return Page.app.navigationBars.buttons["Cancel"]
    }
    
    fileprivate var searchTextField: XCUIElement {
        return Page.app.textFields["search"]
    }
    
    func goToSearchPage() -> SearchPage {
        searchTextField.tap()
        return SearchPage()
    }
    
    func cancelAndExpectTransitionToPage<T: Page>(_ type: T.Type) -> T {
        cancelButton.tap()
        return type.init()
    }
}

// MARK: Wait element

enum UIStatus: String {
    case Exists = "exists == true"
    case NotExists = "exists == false"
}

func waitFor(_ element: XCUIElement, _ status: UIStatus, withIn timeout: TimeInterval = 20) {
    UITest.sharedInstance.testCase.expectation(for: NSPredicate(format: status.rawValue), evaluatedWith: element, handler: nil)
    UITest.sharedInstance.testCase.waitForExpectations(timeout: timeout, handler: nil)
}
