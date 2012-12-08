//
//  CharacterGeneratorWindowController.h
//  CocosCharacterGenerator
//
//  Created by Cem Olcay on 12/8/12.
//  Copyright (c) 2012 Cem Olcay. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum
{
    GenderMale,
    GenderFemale
}Gender;

typedef enum
{
    ChooseModeHead,
    ChooseModeBody
}ChooseMode;

@interface CharacterGeneratorWindowController : NSWindowController 
{
    NSSegmentedControl *segmentedHairBody;
    NSSegmentedControl *segmentedMaleFemale;
    
    NSImageView *imageView;
}

@property (nonatomic, retain) IBOutlet NSSegmentedControl *segmentedHairBody;
@property (nonatomic, retain) IBOutlet NSSegmentedControl *segmentedMaleFemale;

@property (nonatomic, retain) IBOutlet NSImageView *imageView;

-(IBAction)segmentedValueChanged:(id)sender;

-(IBAction)nextColor:(id)sender;
-(IBAction)previousColor:(id)sender;

-(IBAction)nextItem:(id)sender;
-(IBAction)previousItem:(id)sender;

-(IBAction)randomCharacter:(id)sender;
-(IBAction)savePNG:(id)sender;

@end
