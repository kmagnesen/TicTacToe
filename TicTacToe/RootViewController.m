//
//  ViewController.m
//  TicTacToe
//
//  Created by Kyle Magnesen on 1/8/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "RootViewController.h"
#import "WebViewController.h"

@interface RootViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *boardBackgroundLabel;
@property (strong, nonatomic) IBOutlet UILabel *squareOne;
@property (strong, nonatomic) IBOutlet UILabel *squareTwo;
@property (strong, nonatomic) IBOutlet UILabel *squareThree;
@property (strong, nonatomic) IBOutlet UILabel *squareFour;
@property (strong, nonatomic) IBOutlet UILabel *squareFive;
@property (strong, nonatomic) IBOutlet UILabel *squareSix;
@property (strong, nonatomic) IBOutlet UILabel *squareSeven;
@property (strong, nonatomic) IBOutlet UILabel *squareEight;
@property (strong, nonatomic) IBOutlet UILabel *squareNine;

@property (strong, nonatomic) IBOutlet UILabel *whichPlayerLabel;
@property (strong, nonatomic) IBOutlet UILabel *dragLabel;

@property (strong, nonatomic) IBOutlet UILabel *timerLabel;

@property CGPoint originalCenter;
@property CGPoint dragPoint;

@property NSTimer *gameTimer;
@property int gameTimerStatus;

@property CGPoint touchLocation;

@property NSString *boardStatus;
@property NSString *turnStatus;
@property NSString *playerX;
@property NSString *playerO;
@property NSString *theCat;
@property NSString *playerStringToPlace;
@property UIColor *playerColorToPlace;
@property NSString *stringToPlace;
@property NSString *whoWon;
@property UIColor *xColor;
@property UIColor *oColor;
@property NSString *xWins;
@property NSString *oWins;
@property NSString *winningCombinations;

@property int numberOfMovesMade;
@property int coinFlip;


@property NSArray *labelArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.xColor = [UIColor blueColor];
    self.oColor = [UIColor redColor];
    self.playerX = @"X";
    self.playerO = @"O";
    self.xWins = @"XXX";
    self.oWins = @"OOO";
    self.theCat = @"The Cat";

    [self whoGoesFirst];

    self.winningCombinations = @"123_456_789_147_258_369_159_357";

    self.gameTimerStatus = 11;
    self.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCountdown:) userInfo:nil repeats:YES];

    self.labelArray = @[self.squareOne, self.squareTwo, self.squareThree, self.squareFour, self.squareFive,self.squareSix, self.squareSeven, self.squareEight, self.squareNine];
    [self resetGame];

}

- (void) resetTimer {
    self.gameTimerStatus = 11;
    [self timerCountdown:self.gameTimer];
}

- (void) timerCountdown:(NSTimer *)timer {

    self.gameTimerStatus--;
    self.timerLabel.text = [NSString stringWithFormat:@"%d", self.gameTimerStatus];

    if (self.gameTimerStatus == 0) {
        [self togglePlayer];
        [self resetTimer];
        NSLog(@"You took too long");
    }

}


- (void) stopTimer:(NSTimer *)stopTimer {

    [self.gameTimer invalidate];
    self.gameTimer = nil;
    
}

- (void) togglePlayer {
    if ([self.turnStatus isEqualToString:self.playerX]) {
        self.turnStatus = self.playerO;

        self.whichPlayerLabel.text = self.playerO;
        self.dragLabel.text = self.playerO;
        self.whichPlayerLabel.backgroundColor = self.oColor;
        self.playerColorToPlace = self.oColor;
    } else {
        self.turnStatus = self.playerX;

        self.whichPlayerLabel.text = self.playerX;
        self.dragLabel.text = self.playerX;
        self.whichPlayerLabel.backgroundColor = self.xColor;
        self.playerColorToPlace = self.xColor;
    }

    [self resetTimer];

}

// CHECK LABELS FOR WINNING COMBINATIONS

- (NSString*)checkLabelsForWin:(NSString *)labelText label:(UILabel *)label {

    // A MILLION FREAKIN' IF STATMENTS...DIDN'T WANT TO DO IT THIS CRAPPY WAY, BUT OH WELL

    if ([label isEqual: self.squareOne]) {
        self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"1" withString:label.text];

    } else if ([label isEqual: self.squareTwo]) {
        self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"2" withString:label.text];

    } else if ([label isEqual: self.squareThree]) {
        self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"3" withString:label.text];

    } else if ([label isEqual: self.squareFour]) {
        self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"4" withString:label.text];

    } else if ([label isEqual: self.squareFive]) {
        self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"5" withString:label.text];

    } else if ([label isEqual: self.squareSix]) {
        self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"6" withString:label.text];

    } else if ([label isEqual: self.squareSeven]) {
        self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"7" withString:label.text];

    } else if ([label isEqual: self.squareEight]) {
        self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"8" withString:label.text];

    } else if ([label isEqual: self.squareNine]) {
        self.winningCombinations = [self.winningCombinations stringByReplacingOccurrencesOfString:@"9" withString:label.text];

    }

    return self.winningCombinations;
}

//- (void)computerMove:(UILabel *)label {
//
//    if (self.numberOfMovesMade == 1 && ![label isEqual:self.labelArray]) {
//
//    }
//}


// SEE IF SOMEBODY WONNNN

- (void)checkForWinner:(NSString *)whoWon {

    if ([whoWon containsString:self.xWins]) {
        [self displayWinner:self.playerX];

    } else if ([whoWon containsString:self.oWins]) {
        [self displayWinner:self.playerO];

    } else {

        if (self.numberOfMovesMade >= 9) {
            [self displayWinner:self.theCat];
        }
    }

}


// ALERT POP UP DISPLAYING THE WINNER

- (void)displayWinner:(NSString *)winner {
    //    [self stopTimer:self.gameTimer];


    NSString *playerWinnerMessage = [NSString stringWithFormat:@"%@ WINS! AW YAYEAH!", winner];
    UIAlertView *winnerAlert = [[UIAlertView alloc] initWithTitle:playerWinnerMessage message:nil delegate:self cancelButtonTitle:@"New Game" otherButtonTitles: nil];

    [winnerAlert show];
    //    [self resetGame];

}


// AND THEN WHEN THEY DISMISS THE ALERT

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self resetGame];

}

- (IBAction)onResetButtonTapped:(UIButton *)sender {
    [self resetGame];
}

- (void) resetGame {

    self.numberOfMovesMade = 0;
    self.winningCombinations = @"123_456_789_147_258_369_159_357";
    
    for (UILabel *label in self.labelArray) {
        label.text = @"";
    }
    
    [self whoGoesFirst];
    [self resetTimer];
    
}

- (NSString *)setPlayer:(NSString *)player {
    if ([player isEqualToString:self.playerX]) {
        self.whichPlayerLabel.backgroundColor = self.xColor;
        self.whichPlayerLabel.text = self.playerX;
        self.dragLabel.text = self.playerX;
        self.playerColorToPlace = self.xColor;
    } else {
        self.whichPlayerLabel.backgroundColor = self.oColor;
        self.whichPlayerLabel.text = self.playerO;
        self.dragLabel.text = self.playerO;
        self.playerColorToPlace = self.oColor;
    }

    return player;
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
//3)Look for a winning combination

- (void)findLabelUsingPoint:(CGPoint)point{
    for (UILabel *label in self.labelArray) {
        if ([label.text isEqualToString:@""]) {

            if (CGRectContainsPoint(label.frame, point)) {
                label.text = self.playerStringToPlace;
                label.textColor = self.playerColorToPlace;

                self.numberOfMovesMade++;

                [self checkLabelsForWin:label.text label:label];
                [self checkForWinner:self.winningCombinations];
                [self togglePlayer];

                NSLog(@"%@", self.winningCombinations);
                
            }
        }
    }
}

- (IBAction)onLabelDrag:(UIPanGestureRecognizer *)sender {

    self.dragPoint = [sender locationInView:self.view];
    self.dragLabel.center = self.dragPoint;
    self.dragLabel.center = self.dragPoint;

    if (sender.state == UIGestureRecognizerStateEnded) {

        for (UILabel *label in self.labelArray) {

            if ([label.text isEqualToString:@""]) {

            if (CGRectContainsPoint(label.frame, self.dragLabel.center)) {
                label.text = self.turnStatus;
                label.textColor = self.playerColorToPlace;

                [UIView animateWithDuration:.55f animations:^{

                    self.dragLabel.center = self.whichPlayerLabel.center;

                } completion:^(BOOL finished) {

                    if (finished) {

                        self.numberOfMovesMade++;

                        [self checkLabelsForWin:label.text label:label];
                        [self checkForWinner:self.winningCombinations];
                        [self togglePlayer];

                        NSLog(@"%@", self.winningCombinations);
                    }
                }];
            }
            }
        }
    }

}

- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender {

    CGPoint point = [sender locationInView:self.view];

    self.touchLocation = [sender locationInView:self.view];
//    [self findLabelUsingPoint:self.touchLocation];

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
                [self checkForWinner:self.winningCombinations];

            }
        }
    }
}




@end
