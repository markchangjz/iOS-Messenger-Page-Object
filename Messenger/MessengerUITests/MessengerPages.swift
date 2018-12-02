import XCTest

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
    
    private func userCell(at index: Int) -> XCUIElement {
        return Page.app.cells.element(boundBy: index)
    }
    
    fileprivate override func waitForPageLoaded() {
        wait(for: newMessageButton, .exists)
    }
    
    func getRecentMessage(at index: Int) -> String {
        return userCell(at: index).staticTexts["Message"].label
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
    
    private let addFriendButton = Page.app.buttons["Add Friend"]
    private let allButton = Page.app.buttons["All"]
    private let activeButton = Page.app.buttons["Active"]
    
    fileprivate override func waitForPageLoaded() {
        wait(for: addFriendButton, .exists)
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
        wait(for: meCell, .exists)
    }
    
    private func userCell(at index: Int) -> XCUIElement {
        return Page.app.cells.element(boundBy: index)
    }
    
    func talkWithFriend(at index: Int) -> ChatRoomPage {
        userCell(at: index).tap()
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
    
    var numberOfMessage: Int {
        return Page.app.cells.count
    }
    
    var userName: String {
        return Page.app.navigationBars.buttons["user name"].label
    }
    
    var leatestMessage: String {
        return messageCell(at: numberOfMessage - 1).label
    }
    
    fileprivate override func waitForPageLoaded() {
        wait(for: messageTextField, .exists)
    }
    
    func messageCell(at index: Int) -> XCUIElement {
        return Page.app.cells.element(boundBy: index)
    }
    
    func sendMessage(_ message: String) -> Self {
        messageTextField.tap()
        messageTextField.typeText(message)
        return self
    }
}

// MARK: Search

final class SearchPage: Page {
    
    private let searchTextField = Page.app.textFields["search"]
    
    fileprivate override func waitForPageLoaded() {
        wait(for: searchTextField, .exists)
    }
    
    func search(_ keyword: String) -> SearchResultPage {
        searchTextField.typeText(keyword + "\n")
        return SearchResultPage()
    }
}

final class SearchResultPage: Page {
    
    private func userCell(at index: Int) -> XCUIElement {
        return Page.app.cells.element(boundBy: index)
    }
    
    fileprivate override func waitForPageLoaded() {
        // ...
    }
    
    func chatWithUser(at index: Int) -> ChatRoomPage {
        userCell(at: index).tap()
        return ChatRoomPage()
    }
}
