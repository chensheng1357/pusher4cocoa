//
//  PCViewController.h
//  push4cocoa
//
//  Created by 吕健 on 13-8-23.
//  Copyright (c) 2013年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <socket.IO/SocketIO.h>

@interface PCViewController : UIViewController <
	UITextFieldDelegate, SocketIODelegate> {
		
	SocketIO *_socketIO;
		
}

@property(strong, nonatomic) IBOutlet UITextField *inputField;
@property(strong, nonatomic) IBOutlet UITextView *textView;


@end
