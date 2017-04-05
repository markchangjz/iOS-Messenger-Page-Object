import XCTest

class UITest {
	static let sharedInstance = UITest()
	var testCase: XCTestCase!
	
	fileprivate init() { }
}

class Page {
    static let app = XCUIApplication()
	
    fileprivate func waitForPageLoaded() { }
    
    required init() {
        waitForPageLoaded()
    }
}

final class StartPage: Page {
	
    func loginMessengerIfNeeded(_ account: String, password: String) -> HomePage {
        // Log in
        
        return HomePage()
    }
}

// MARK: Home Page

final class HomePage: Page, MessengerTabBar, MessengerSearchBar {
    
    private let newMessageButton = Page.app.buttons["New Message"]
    
    private func userCell(with name: String) -> XCUIElement {
        return Page.app.cells[name]
    }
    
    private func userCell(at i: UInt) -> XCUIElement {
        return Page.app.cells.element(boundBy: i)
    }
    
    fileprivate override func waitForPageLoaded() {
        waitFor(newMessageButton, .Exists)
    }
    
    func getRecentMessage(at i: UInt) -> String {
        return userCell(at: i).staticTexts["Message"].label
    }
    
    func chat(with name: String) -> ChatRoomPage {
		userCell(with: name).tap()
        return ChatRoomPage()
    }
    
    func goToNewMessagePage() -> NewMessagePage {
        newMessageButton.tap()
        return NewMessagePage()
    }
}

final class NewMessagePage: Page {
    // ...
}

// MARK: Calls Page

final class CallsPage: Page, MessengerTabBar, MessengerSearchBar {
    // ...
}

// MARK: Groups Page

final class GroupsPage: Page, MessengerTabBar, MessengerSearchBar {
    // ...
}

// MARK: People Page

class PeoplePage: Page, MessengerTabBar, MessengerSearchBar {
    
    let addFriendButton = Page.app.buttons["Add Friend"]
    let allButton = Page.app.buttons["All"]
    let activeButton = Page.app.buttons["Active"]
    
    fileprivate override func waitForPageLoaded() {
        waitFor(addFriendButton, .Exists)
    }
    
    func switchToAll() -> PeopleAllPage {
        allButton.tap()
        return PeopleAllPage()
    }
    
    func switchToActiveButton() -> PeopleActivePage {
        activeButton.tap()
        return PeopleActivePage()
    }
}

final class PeopleAllPage: PeoplePage {
    // ...
}

final class PeopleActivePage: PeoplePage {
    
    private let meCell = Page.app.cells["Me"]
    
    fileprivate override func waitForPageLoaded() {
        waitFor(meCell, .Exists)
    }
    
    private func userCell(at i: UInt) -> XCUIElement {
        return Page.app.cells.element(boundBy: i)
    }
    
    func talkWithFriend(at i: UInt) -> ChatRoomPage {
        userCell(at: i).tap()
        return ChatRoomPage()
    }
}

// MARK: Me Page

final class MePage: Page, MessengerTabBar, MessengerSearchBar {
    // ...
}

// MARK: Chat Page

final class ChatRoomPage: Page, ChatRoomNavigationBar {
    
    private let messageTextField = Page.app.textFields["message"]
    
    var numberOfMessage: UInt {
        return Page.app.cells.count
    }
    
    var userName: String {
        return Page.app.navigationBars.buttons["user name"].label
    }
    
    var leatestMessage: String {
        return messageCell(at: numberOfMessage - 1).label
    }
    
    fileprivate override func waitForPageLoaded() {
        waitFor(messageTextField, .Exists)
    }
    
    func messageCell(at i: UInt) -> XCUIElement {
        return Page.app.cells.element(boundBy: i)
    }
    
    func sendMessage(_ message: String) -> Self {
        messageTextField.tap()
        messageTextField.typeText(message)
        return self
    }
}

// MARK: Search

final class SearchPage: Page {
    
    let searchTextField = Page.app.textFields["search"]
    
    fileprivate override func waitForPageLoaded() {
        waitFor(searchTextField, .Exists)
    }
    
    func search(_ keyword: String) -> SearchResultPage {
        searchTextField.typeText(keyword + "\n")
        return SearchResultPage()
    }
}

final class SearchResultPage: Page {
    
    private func userCell(at i: UInt) -> XCUIElement {
        return Page.app.cells.element(boundBy: i)
    }
    
    fileprivate override func waitForPageLoaded() {
        // ...
    }
    
    func chatWithUser(at i: UInt) -> ChatRoomPage {
        userCell(at: i).tap()
        return ChatRoomPage()
    }
}
