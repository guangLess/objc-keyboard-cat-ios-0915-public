//
//  ViewController.m
//  KeyboardCat
//
//  Created by Timothy Clem on 10/29/15.
//  Copyright © 2015 Flatiron School. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldBottomConstraint;
@property (weak, nonatomic) IBOutlet UITextField *catTextField;

@end


@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *catImage = [UIImage animatedImageNamed:@"keyboard-cat-" duration:3];
    self.imageView.image = catImage;
    
    
    self.catTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    // to hide the autocorrect. becuase the keyboard fires notification when it is being tapped;
    // no need to set constrins for the notification if autocorrectionType is set to NO; 
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)keyboardWillShow:(NSNotification*)aNotification
{
    NSLog(@"keyboard shown!");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //kbSize is the keyboard size of the keyboard. it needs to be accessed as kbSize.height (value gaven to you);
    //use animation to show the keyboard and textfield. 20 is the original constant vablue
    
    //if (self.textFieldBottomConstraint.constant == -20) {
        [UIView animateWithDuration:0.25 animations:^{
            self.textFieldBottomConstraint.constant -= kbSize.height - 20;
            self.catTextField.backgroundColor = [UIColor yellowColor];
            self.catTextField.alpha = 0.6;
            [self.view layoutIfNeeded];
        }];
    //}
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSLog(@"keyboard hidden");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    //if (self.textFieldBottomConstraint.constant <= -20) {
        [UIView animateWithDuration:0.25 animations:^{
            self.textFieldBottomConstraint.constant += kbSize.height - 20;
            self.catTextField.backgroundColor = [UIColor whiteColor];
            [self.view layoutIfNeeded];
        }];
    //}
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

-(IBAction)catTextChanged:(UITextField *)sender{
    NSLog(@"%@", sender.text);
}

@end
