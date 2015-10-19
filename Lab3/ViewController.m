//
//  ViewController.m
//  Lab3
//
//  Created by Oslo on 10/16/15.
//  Copyright © 2015 Shih Chi Lin. All rights reserved.
//

#import "ViewController.h"
#import <stdlib.h>

@interface ViewController ()

@property NSString *gameStatus;
@property int point1;
@property int point2;
@property int tempPoint;
@property BOOL isPlayingGame;
@property BOOL checkPlayer;
@property UIImage *image;

@property (weak, nonatomic) IBOutlet UILabel *score1;
@property (weak, nonatomic) IBOutlet UILabel *score2;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar1;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar2;
@property (weak, nonatomic) IBOutlet UIImageView *dice;
@property (weak, nonatomic) IBOutlet UITextField *turnScore;
@property (weak, nonatomic) IBOutlet UITextField *gameMessage;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property (weak, nonatomic) IBOutlet UIButton *holdButton;

@end

@implementation ViewController

// when hold button pressed, turn start button to Continue button
- (IBAction)holdValue:(id)sender {
    
    // check which player is playing now
    if (self.checkPlayer == YES) {
        // player1 is playing
        // add turn score to total score
        _point1 += _tempPoint;
        [self.score1 setText:[NSString stringWithFormat:@"%d", self.point1]];
        [self.progressBar1 setProgress:((float)self.point1)/100.0 animated:YES];
    } else if (self.checkPlayer == NO) {
        // player2 is playing
        _point2 += _tempPoint;
        [self.score2 setText:[NSString stringWithFormat:@"%d", self.point2]];
        [self.progressBar2 setProgress:((float)self.point2)/100.0 animated:YES];
    }
    
    // reset scores for each turn
    _tempPoint = 0;
    // disable roll, hold, and enable continue button
    self.rollButton.enabled = NO;
    self.holdButton.enabled = NO;
    self.startButton.enabled = YES;
    [self.turnScore setText:@"score :0"];
    // switch player turns
    self.checkPlayer = !self.checkPlayer;
    // check for new game
    [self checkNewGame];
}

// reset all the status to a brand new game
-(void) checkNewGame {
    if(self.point1 >= 100 || self.point2 >= 100) {
        
        self.isPlayingGame = NO;
        NSString *con = @"Congrats: ";
        NSString *congrats = [[NSString alloc] init];
        if (self.point1 >= 100) {
            congrats = [con stringByAppendingString:@"Player1"];
        } else {
            congrats = [con stringByAppendingString:@"Player2"];
        }
        
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Victory" message:congrats preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Thanks" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action1){}];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        // reset all settings
        //self.rollButton.enabled = NO;
        self.point1 = 0;
        self.point2 = 0;
        [self.score1 setText:[NSString stringWithFormat:@"0"]];
        [self.score2 setText:[NSString stringWithFormat:@"0"]];
    }
}

- (IBAction)rollDice:(id)sender {
    NSString *msg = @"score: ";
    NSString *yourScore = [[NSString alloc] init];
    int rand = arc4random_uniform(6);
    switch (rand) {
        case 0:
            _image = [UIImage imageNamed:@"1.png"];
            self.dice.contentMode = UIViewContentModeScaleAspectFit;
            self.dice.clipsToBounds = YES;
            _dice.image = self.image;
            self.rollButton.enabled = NO;
            self.holdButton.enabled = NO;
            self.startButton.enabled = YES;
            // switch player turns
            self.checkPlayer = !self.checkPlayer;
            [self.turnScore setText:@"score: 0"];
            _tempPoint = 0;
            [self.gameMessage setText:@"Oops! You lost the chance"];
            break;
        case 1:
            _image = [UIImage imageNamed:@"2.png"];
            self.dice.contentMode = UIViewContentModeScaleAspectFit;
            self.dice.clipsToBounds = YES;
            _dice.image = self.image;
            [self countScore:2];
            yourScore = [msg stringByAppendingFormat:@"%d", _tempPoint];
            [self.turnScore setText:yourScore];
            break;
        case 2:
            _image = [UIImage imageNamed:@"3.png"];
            self.dice.contentMode = UIViewContentModeScaleAspectFit;
            self.dice.clipsToBounds = YES;
            _dice.image = self.image;
            [self countScore:3];
            yourScore = [msg stringByAppendingFormat:@"%d", _tempPoint];
            [self.turnScore setText:yourScore];
            break;
        case 3:
            _image = [UIImage imageNamed:@"4.png"];
            self.dice.contentMode = UIViewContentModeScaleAspectFit;
            self.dice.clipsToBounds = YES;
            _dice.image = self.image;
            [self countScore:4];
            yourScore = [msg stringByAppendingFormat:@"%d", _tempPoint];
            [self.turnScore setText:yourScore];
            break;
        case 4:
            _image = [UIImage imageNamed:@"5.png"];
            self.dice.contentMode = UIViewContentModeScaleAspectFit;
            self.dice.clipsToBounds = YES;
            _dice.image = self.image;
            [self countScore:5];
            yourScore = [msg stringByAppendingFormat:@"%d", _tempPoint];
            [self.turnScore setText:yourScore];
            break;
        case 5:
            _image = [UIImage imageNamed:@"6.png"];
            self.dice.contentMode = UIViewContentModeScaleAspectFit;
            self.dice.clipsToBounds = YES;
            _dice.image = self.image;
            [self countScore:6];
            yourScore = [msg stringByAppendingFormat:@"%d", _tempPoint];
            [self.turnScore setText:yourScore];
            break;
        default:
            NSLog(@"No such Image/Error");
            break;
    }
    
}

-(void) countScore:(int)point {
    _tempPoint += point;
}

// method to change the title of the button
- (IBAction)startOrContinue:(id)sender {
    if ([self.startButton.titleLabel.text isEqualToString:@"Start"]) {
        [self.startButton setTitle:@"Continue" forState:UIControlStateNormal];
        self.isPlayingGame = YES;
        [self.progressBar1 setProgress:0.0 animated:YES];
        [self.progressBar2 setProgress:0.0 animated:YES];
    }
    if (self.checkPlayer == YES) {
        [self.gameMessage setText:@"Player 1's turn, please roll dice"];
    } else {
        [self.gameMessage setText:@"Player 2's turn, please roll dice"];
    }
    //[self checkStart];
    
    self.rollButton.enabled = YES;
    self.holdButton.enabled = YES;
    self.startButton.enabled = NO;
    
}


// set the boolean check values to NO for default
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.isButtonClick = NO;
    self.rollButton.enabled = NO;
    self.holdButton.enabled = NO;
    self.startButton.enabled = YES;
    [self.score1 setText:[NSString stringWithFormat:@"0"]];
    [self.score2 setText:[NSString stringWithFormat:@"0"]];
    [self.progressBar1 setProgressViewStyle:UIProgressViewStyleDefault];
    [self.progressBar2 setProgressViewStyle:UIProgressViewStyleDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
