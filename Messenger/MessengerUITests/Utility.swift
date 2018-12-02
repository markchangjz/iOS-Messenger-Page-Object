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
    private var homeButton: XCUIElement {
        return Page.app.buttons["Home"]
    }
    
    private var callsButton: XCUIElement {
        return Page.app.buttons["Calls"]
    }
    
    private var groupsButton: XCUIElement {
        return Page.app.buttons["Groups"]
    }
    
    private var peopleButton: XCUIElement {
        return Page.app.buttons["People"]
    }
    
    private var meButton: XCUIElement {
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
    private var backButton: XCUIElement {
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
    private var cancelButton: XCUIElement {
        return Page.app.navigationBars.buttons["Cancel"]
    }
    
    private var searchTextField: XCUIElement {
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
    case exists = "exists == true"
    case notExists = "exists == false"
	case hittable = "isHittable == true"
}

func wait(for element: XCUIElement, _ status: UIStatus, withIn timeout: TimeInterval = 0.1) {
	let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: status.rawValue), object: element)
	let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
	
	if (result == .timedOut) {
		XCTFail(expectation.description)
	}
}
