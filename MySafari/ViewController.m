//
//  ViewController.m
//  MySafari
//
//  Created by Brian & Merideth on 5/14/14.
//  Copyright (c) 2014 Mathien. All rights reserved.
//

#import "ViewController.h"
// made a webview outlet and text field out let added delegate
@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *myWebView;
@property (strong, nonatomic) IBOutlet UITextField *myURLTextField;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *plusButton;

@end

////
@implementation ViewController





//
// button actions (reload, stop, forward, back)
- (IBAction)onReloadButtonPressed:(id)sender
{
    [self.myWebView reload];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender
{
    [self.myWebView stopLoading];
}

- (IBAction)onForwardButtonPressed:(id)sender
{
    [self.myWebView goForward];
}

- (IBAction)onBackButtonPressed:(UIButton *)sender
{
    [self.myWebView goBack];
}


//
// enabling and disabling buttons

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backButton.enabled = [self.myWebView canGoBack];
    self.forwardButton.enabled = [self.myWebView canGoForward];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.backButton.enabled = [self.myWebView canGoBack];
   self.forwardButton.enabled = [self.myWebView canGoForward];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//
// loads URL in text field dragged from storyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.myURLTextField setDelegate:self];

    // no http code required
    NSURL *myURL = [NSURL URLWithString:textField.text];
    NSString *typedURL = textField.text;

    if ([typedURL hasPrefix:@"http://"])
    {

        myURL = [NSURL URLWithString:myURL.absoluteString];
    }
    else {
        myURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",myURL]];
    }

    // loads URL in text field
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    [self.myWebView loadRequest:request];

    return YES;

// removes the keyboard
    [textField resignFirstResponder];

}
/// Coming soon alert on the new tab button
- (IBAction)onPlusButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"Coming soon!";
    [alert addButtonWithTitle:@"Can't wait!"];

    alert.delegate = self;
    [alert show];
}




@end
