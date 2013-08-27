//
//  PCViewController.m
//  push4cocoa
//
//  Created by 吕健 on 13-8-23.
//  Copyright (c) 2013年 lv. All rights reserved.
//

#import "PCViewController.h"
#import <socket.IO/SocketIOPacket.h>

#define PCSocketIOHostName @"192.168.1.6"

@interface PCViewController ()

@end

@implementation PCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	_socketIO = [[SocketIO alloc] initWithDelegate:self];
	[_socketIO connectToHost:PCSocketIOHostName onPort:3000];
	[_socketIO sendEvent:@"sub" withData:@{@"topic": @"/column"}];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	if ([_inputField isFirstResponder] && (_inputField != touch.view)) {
		[_inputField resignFirstResponder];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if ([textField isFirstResponder]) {
		[textField resignFirstResponder];
	}
	
	NSString *message = textField.text;
	NSLog(@"--input: %@", message);
	[_socketIO sendEvent:@"push" withData:@{@"to": @"/column", @"event": @"news",
											@"body": @{@"sender": @"iphone5", @"msg": message}
											} andAcknowledge:^(id argsData) {
												NSLog(@"%@", argsData);
											}];
		
	textField.text = @"";
	
	return YES;
}


- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
	NSLog(@"did Receive event ...");
	NSDictionary *json = [packet dataAsJSON];
	NSLog(@"%@", json);
}

@end
