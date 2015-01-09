//
//  ViewController.m
//  TicTacToe
//
//  Created by Kyle Magnesen on 1/8/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

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
@property NSString *xString;
@property NSString *oString;
@property NSString *stringToPlace;
@property NSString *whoWon;
@property UIColor *xColor;
@property UIColor *oColor;

@property NSArray *labelArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self togglePlayer];
// do we need this

    self.whichPlayerLabel.backgroundColor = [UIColor blueColor];
    self.xColor = [UIColor blueColor];
    self.oColor = [UIColor redColor];
    self.xString = @"X";
    self.oString = @"O";

    self.turnStatus = self.xString;
    self.whichPlayerLabel.text = self.turnStatus;

    self.labelArray = @[self.labelOne, self.labelTwo, self.labelThree, self.labelFour, self.labelFive,self.labelSix, self.labelSeven, self.labelEight, self.labelNine];

}

- (void) togglePlayer {
    if ([self.turnStatus isEqualToString:self.xString]) {
        self.turnStatus = self.oString;

        self.whichPlayerLabel.text = self.oString;
        self.whichPlayerLabel.backgroundColor = self.oColor;
    } else {
        self.turnStatus = self.xString;

        self.whichPlayerLabel.text = self.xString;
        self.whichPlayerLabel.backgroundColor = self.xColor;
    }

}

- (void)findLabelUsingPoint:(CGPoint)point{

}

- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender {

    CGPoint point = [sender locationInView:self.view];
//    self.whichPlayerLabel.center = point;

    self.touchLocation = [sender locationInView:self.view];

    for (UILabel *label in self.labelArray) {
        if (CGRectContainsPoint(label.frame, point)) {


            if ([label.text isEqualToString:@""]) {
                label.text = self.turnStatus;
                self.whichPlayerLabel.text = self.turnStatus;


                if ([self.whichPlayerLabel.text isEqualToString:self.xString]) {
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
