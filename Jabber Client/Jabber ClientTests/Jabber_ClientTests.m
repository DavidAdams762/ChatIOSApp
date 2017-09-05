#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "XMPPStream.h"

#import "JabberClientAppDelegate.h"


@interface Jabber_ClientTests : XCTestCase<UIApplicationDelegate>
@end

@implementation Jabber_ClientTests {
    JabberClientAppDelegate *jbClient;
    NSString *userAddress;
    NSString *pwd;
}

- (void)setUp {
    [super setUp];
    userAddress = @"ophelie@localhost";
    pwd = @"voiture";
    
    jbClient = [[JabberClientAppDelegate alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testConnection {
    BOOL connect = [jbClient connect];
    XCTAssertTrue(connect);
}

- (void)testDisconnection {
    [jbClient connect];
    [jbClient disconnect];
    BOOL disconnected = [[jbClient xmppStream]isDisconnected];
    XCTAssertTrue(disconnected);
}

@end
