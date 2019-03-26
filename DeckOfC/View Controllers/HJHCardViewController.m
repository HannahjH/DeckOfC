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
}

-(void)updateViews {
    [[HJHCardController shared] drawNewCard:1 completion:^(NSArray<HJHCard *> * cards, NSError * error) {
        if (error){
            NSLog(@"Error getting photo references for %@ on %@:", cards, error);
            return;
        }
        
        HJHCard *card = [cards objectAtIndex:0];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cardSuitLabel.text = card.suit;
        });
        [[HJHCardController shared] fetchCardImage:card completion:^(UIImage *image, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.cardImageView.image = image;
            });
        }];
    }];
}

@end
