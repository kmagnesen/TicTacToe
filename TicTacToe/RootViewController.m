//
//  ViewController.m
//  TicTacToe
//
//  Created by Kyle Magnesen on 1/8/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "RootViewController.h"
#import "WebViewController.h"

@interface RootViewController ()

@property (strong, nonatomic) IBOutlet UILabel *boardBackgroundLabel;
@property (strong, nonatomic) IBOutlet UILabel *labelOne;
@property (strong, nonatomic) IBOutlet UILabel *labelTwo;
@property (strong, nonatomic) IBOutlet UILabel *labelThree;
@property (strong, nonatomic) IBOutlet UILabel *labelFour;
@property (strong, nonatomic) IBOutlet UILabel *labelFive;
@property (strong, nonatomic) IBOutlet UILabel *labelSix;
@property (strong, nonatomic) IBOutlet UILabel *labelSeven;
@property (strong, nonatomic) IBOutlet UILabel *labelEight;
@property (strong, nonatomic) IBOutlet UILabel *labelNine;

@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;

@property CGPoint touchLocation;

@property NSString *turnStatus;
@property NSString *playerX;
@property NSString *playerO;
@property NSString *stringToPlace;
@property NSString *whoWon;
@property UIColor *xColor;
@property UIColor *oColor;

@property NSArray *labelArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.xColor = [UIColor blueColor];
    self.oColor = [UIColor redColor];
    self.playerX = @"X";
    self.playerO = @"O";

    [self whoGoesFirst];

//    self.turnStatus = self.playerX;
    self.turnStatus = self.whichPlayerLabel.text;

    self.labelArray = @[self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive,self.labelSix, self.labelSeven, self.labelEight, self.labelNine];


}

- (void) togglePlayer {
    if ([self.turnStatus isEqualToString:self.playerX]) {
        self.turnStatus = self.playerO;

        self.whichPlayerLabel.text = self.playerO;
        self.whichPlayerLabel.backgroundColor = self.oColor;
    } else {
        self.turnStatus = self.playerX;

        self.whichPlayerLabel.text = self.playerX;
        self.whichPlayerLabel.backgroundColor = self.xColor;
    }

}

- (void)displayWinner {
    NSString *winner;
    NSString *winnerMsg = [NSString stringWithFormat:@"%@ WINS! YEAHHHHH BUDDDDY!!!", winner];

    UIAlertView *winnerAlert = [[UIAlertView alloc] initWithTitle:winnerMsg message:@"Yeah Buddy!!!" delegate:self cancelButtonTitle:@"Thank You For Playing!" otherButtonTitles:nil];
    [winnerAlert show];
}

- (IBAction)onResetButtonTapped:(UIButton *)sender {
    for (UILabel *label in self.labelArray) {
        label.text = @"";
    }
    [self whoGoesFirst];
}

- (void)setPlayer:(NSString *)player {
    if ([player isEqualToString:self.playerX]) {
        self.whichPlayerLabel.backgroundColor = self.xColor;
        self.whichPlayerLabel.text = self.playerX;
    } else {
        self.whichPlayerLabel.backgroundColor = self.oColor;
        self.whichPlayerLabel.text = self.playerO;
    }
}

- (NSString *)whoGoesFirst {
    int random = arc4random_uniform(2);
    if (random == 1) {
        self.turnStatus = self.playerX;
    } else {
        self.turnStatus = self.playerO;
    }

    [self setPlayer:self.turnStatus];
    return self.turnStatus;
}

//win logic
//1)Get index of label from label array
//2)Substitute player token into combo array
//3)look for a winning combination

- (void)findLabelUsingPoint:(CGPoint)point{
    
}

- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender {

    CGPoint point = [sender locationInView:self.view];

    self.touchLocation = [sender locationInView:self.view];

    for (UILabel *label in self.labelArray) {
        if (CGRectContainsPoint(label.frame, point)) {


            if ([label.text isEqualToString:@""]) {

                label.text = self.turnStatus;
                self.whichPlayerLabel.text = self.turnStatus;


                if ([self.whichPlayerLabel.text isEqualToString:self.playerX]) {
                    label.textColor = self.xColor;
                } else {
                    label.textColor = self.oColor;
                }
                [self togglePlayer];

            }
        }
    }
}




@end
