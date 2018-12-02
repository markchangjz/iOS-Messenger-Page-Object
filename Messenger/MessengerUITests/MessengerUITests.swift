import XCTest

class MessengerUITests: XCTestCase {
	
    var homePage: HomePage!
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
		
        XCUIApplication().launch()
		
        homePage = StartPage().loginMessengerIfNeeded("example@messenger.com", password: "example")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGoToAllOfTabBarPage() {
        homePage.goToHomePage().goToCallsPage().goToGroupsPage().goToPeoplePage().goToMePage()
    }
    
    func testSendMessage() {
        var chatPage = homePage.chat(with: "Mark")
        let numberOfMessageBeforeSendingMessage = chatPage.numberOfMessage
        
        chatPage = chatPage.sendMessage("Hi, Mark!")
        let numberOfMessageAfterSendingMessage = chatPage.numberOfMessage
        
        XCTAssertEqual(chatPage.leatestMessage, "Hi, Mark!")
        XCTAssertEqual(numberOfMessageBeforeSendingMessage + 1, numberOfMessageAfterSendingMessage)
        
        homePage = chatPage.backTo(HomePage.self)
        XCTAssertEqual(homePage.getRecentMessage(at: 0), "Hi, Mark!")
    }
    
    func testSeachPeople() {
        let chatPage = homePage.goToSearchPage().search("Mark").chatWithUser(at: 0)
        
        XCTAssertEqual(chatPage.userName, "Mark")
    }
	
	func testChatWithPeople() {
		let chatRoomPage = homePage.chat(with: "Nadia").sendMessage("Hello")
		
		XCTAssertEqual(chatRoomPage.leatestMessage, "Hello")
	}
}
