//
//  HJHCardViewController.m
//  DeckOfC
//
//  Created by Hannah Hoff on 3/26/19.
//  Copyright © 2019 Hannah Hoff. All rights reserved.
//

#import "HJHCardViewController.h"
#import "HJHCardController.h"
#import "HJHCard.h"

@interface HJHCardViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardSuitLabel;

@end

@implementation HJHCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)newCardButtonTapped:(UIButton *)sender {
    [self updateViews];
}

-(void)updateViews {
    [[HJHCardController shared] drawNewCard:^(HJHCard *card) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cardSuitLabel.text = card.suit;
        });
        [[HJHCardController shared] fetchCardImage: card  completion:^(UIImage *image, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cardImageView.image = image;
            });
        }];
    }];
}

@end
