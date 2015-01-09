//
//  ViewController.m
//  TicTacToe
//
//  Created by Kyle Magnesen on 1/8/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "RootViewController.h"

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

    self.whichPlayerLabel.backgroundColor = [UIColor blueColor];
    self.xColor = [UIColor blueColor];
    self.oColor = [UIColor redColor];
    self.playerX = @"X";
    self.playerO = @"O";

    self.turnStatus = self.playerX;
    self.whichPlayerLabel.text = self.turnStatus;

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
                    label.backgroundColor = self.xColor;
                } else {
                    label.backgroundColor = self.oColor;
                }
                [self togglePlayer];
            }
        }
    }
}



@end
