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
    
    func goToHomePage() -> HomePage {
        homeButton.tap()
        return HomePage()
    }
    
    func goToCallsPage() -> CallsPage {
        callsButton.tap()
        return CallsPage()
    }
    
    func goToGroupsPage() -> GroupsPage {
        groupsButton.tap()
        return GroupsPage()
    }
    
    func goToPeoplePage() -> PeoplePage {
        peopleButton.tap()
        return PeoplePage()
    }
    
    func goToMePage() -> MePage {
        meButton.tap()
        return MePage()
    }
}

// MARK: ChatNavigationBar

protocol ChatRoomNavigationBar {
    func backTo<T: Page>(type: T.Type) -> T
}

extension ChatRoomNavigationBar {
    private var backButton: XCUIElement {
        return Page.app.navigationBars.buttons["Back"]
    }
    
    func backTo<T: Page>(type: T.Type) -> T {
        backButton.tap()
        return type.init()
    }
}

// MARK: MessengerSearchBar

protocol MessengerSearchBar {
    func goToSearchPage() -> SearchPage
    func cancelAndExpectTransitionToPage<T: Page>(type: T.Type) -> T
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
    
    func cancelAndExpectTransitionToPage<T: Page>(type: T.Type) -> T {
        cancelButton.tap()
        return type.init()
    }
}

// MARK: Wait element

enum UIStatus: String {
    case Exists = "exists == true"
    case NotExists = "exists == false"
}

func waitFor(element: XCUIElement, _ status: UIStatus, withIn timeout: NSTimeInterval = 20) {
    UITest.sharedInstance.testCase.expectationForPredicate(NSPredicate(format: status.rawValue), evaluatedWithObject: element, handler: nil)
    UITest.sharedInstance.testCase.waitForExpectationsWithTimeout(timeout, handler: nil)
}
