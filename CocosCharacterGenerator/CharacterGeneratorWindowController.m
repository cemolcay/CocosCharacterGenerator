//
//  CharacterGeneratorWindowController.m
//  CocosCharacterGenerator
//
//  Created by Cem Olcay on 12/8/12.
//  Copyright (c) 2012 Cem Olcay. All rights reserved.
//

#import "CharacterGeneratorWindowController.h"
#import <CoreGraphics/CoreGraphics.h>

#define maxMaleHeadIndex 22
#define maxMaleBodyIndex 14
#define maxFemaleHeadIndex 22
#define maxFemaleBodyIndex 14

@interface CharacterGeneratorWindowController ()
{
    NSArray *colorArray;
    NSImage *sheet;
    
    int headColorIndex;
    int bodyColorIndex;
    
    int headIndex;
    int bodyIndex;
    
    ChooseMode chooseMode;
    Gender gender;
}

@property (nonatomic, retain) NSArray *colorArray;
@property (nonatomic, retain) NSImage *sheet;

@end

@implementation CharacterGeneratorWindowController

@synthesize imageView;
@synthesize sheet;
@synthesize segmentedHairBody;
@synthesize segmentedMaleFemale;

@synthesize colorArray;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        chooseMode = (ChooseMode)segmentedHairBody.selectedSegment;
        gender = (Gender)segmentedMaleFemale.selectedSegment;
        
        colorArray = [[NSArray alloc] initWithObjects:@"black", @"white", @"red", @"blue", @"green", @"yellow", nil];
        
        [self resetIndexes];
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];

    [self drawCharacter];
}

-(void)dealloc
{
    [colorArray release];
    [sheet release];
    [segmentedMaleFemale release];
    [segmentedHairBody release];
    [imageView release];

    [super dealloc];
}

-(IBAction)segmentedValueChanged:(id)sender
{
    NSSegmentedControl *seg = (NSSegmentedControl*)sender;
    
    if ([seg isEqualTo:segmentedHairBody])
    {
        chooseMode = (ChooseMode)seg.selectedSegment;
    }
    else if([seg isEqualTo:segmentedMaleFemale])
    {
        gender = (Gender)seg.selectedSegment;
        [self resetIndexes];
    }
    [self drawCharacter];
}

-(IBAction)nextColor:(id)sender
{
    switch (chooseMode) {
        case ChooseModeHead:
            headColorIndex++;
            if (headColorIndex > [colorArray count] - 1)
                headColorIndex = 0;
            break;
            
        case ChooseModeBody:
            bodyColorIndex++;
            if (bodyColorIndex > [colorArray count] - 1)
                bodyColorIndex = 0;
            break;
    }
    
    [self drawCharacter];
}

-(IBAction)previousColor:(id)sender
{
    switch (chooseMode) {
        case ChooseModeHead:
            headColorIndex--;
            if (headColorIndex < 0)
                headColorIndex = (int)[colorArray count] - 1;
            break;
            
        case ChooseModeBody:
            bodyColorIndex--;
            if (bodyColorIndex < 0)
                bodyColorIndex = (int)[colorArray count] - 1;
            break;
    }
    [self drawCharacter];
}

-(IBAction)nextItem:(id)sender
{
    switch (chooseMode) {
        case ChooseModeBody:
            bodyIndex++;
            if (gender == GenderMale && bodyIndex > maxMaleBodyIndex)
                bodyIndex = 1;
            if (gender == GenderFemale && bodyIndex > maxFemaleBodyIndex)
                bodyIndex = 1;
            break;
            
        case ChooseModeHead:
            headIndex++;
            if (gender == GenderMale && headIndex > maxMaleHeadIndex)
                headIndex = 1;
            if (gender == GenderFemale && headIndex > maxFemaleHeadIndex)
                headIndex = 1;
            break;
    }
    [self drawCharacter];
}

-(IBAction)previousItem:(id)sender
{
    switch (chooseMode) {
        case ChooseModeBody:
            bodyIndex--;
            if (gender == GenderMale && bodyIndex < 1)
                bodyIndex = maxMaleBodyIndex;
            if (gender == GenderFemale && bodyIndex < 1)
                bodyIndex = maxFemaleBodyIndex;
            break;
            
        case ChooseModeHead:
            headIndex--;
            if (gender == GenderMale && headIndex < 1)
                headIndex = maxMaleHeadIndex;
            if (gender == GenderFemale && headIndex < 1)
                headIndex = maxFemaleHeadIndex;
            break;
    }
    [self drawCharacter];
}

-(IBAction)randomCharacter:(id)sender
{
    //random gender
    gender = (Gender)[self randomMinInt:0 MaxInt:1];
    
    //random body and head
    switch (gender) {
        case GenderMale:
            bodyIndex = [self randomMinInt:1 MaxInt:maxMaleBodyIndex];
            headIndex = [self randomMinInt:1 MaxInt:maxMaleHeadIndex];
            break;
            
        case GenderFemale:
            bodyIndex = [self randomMinInt:1 MaxInt:maxFemaleBodyIndex];
            headIndex = [self randomMinInt:1 MaxInt:maxFemaleHeadIndex];
            break;
    }
    
    //random color
    headColorIndex = [self randomMinInt:0 MaxInt:(int)[colorArray count] - 1];
    bodyColorIndex = [self randomMinInt:0 MaxInt:(int)[colorArray count] - 1];
    
    [self drawCharacter];
}

-(int)randomMinInt:(int)min MaxInt:(int)max
{
    return (arc4random() % (max-min+1)) + min;
}

-(IBAction)savePNG:(id)sender
{
    NSSavePanel * savePanel = [NSSavePanel savePanel];
    [savePanel setAllowedFileTypes:[NSArray arrayWithObject:@"png"]];
    [savePanel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            //NSBitmapImageRep *imgRep = [[sheet representations] objectAtIndex: 0];
            //NSData *data = [imgRep representationUsingType: NSPNGFileType properties: nil];
            [[sheet TIFFRepresentation] writeToURL:[savePanel URL] atomically:YES];
            [savePanel orderOut:self];
        }
    }];
}

-(void)drawCharacter
{
    NSString *gen;
    if (gender == GenderMale) gen = @"male";
    else if (gender == GenderFemale) gen = @"female";
    
    NSImage *body = [[NSImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@_body/%d_%@.png", gen, bodyIndex, [colorArray objectAtIndex:bodyColorIndex]]]];
    NSImage *head = [[NSImage alloc] initWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@_hair/%d_%@.png", gen, headIndex, [colorArray objectAtIndex:headColorIndex]]]];
    
    if (sheet)
        [sheet release];

    sheet = [[NSImage alloc] initWithSize:NSMakeSize(96, 128)];
    [sheet lockFocus];
    [body drawAtPoint:NSMakePoint(0, 0) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
    [head drawAtPoint:NSMakePoint(0, 0) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1];
    [sheet unlockFocus];
    
    NSImage *thumbinail = [[NSImage alloc] initWithSize:NSMakeSize(32, 32)];
    [thumbinail lockFocus];
    [sheet drawAtPoint:NSMakePoint(0, 0) fromRect:NSMakeRect(32, 96, 32, 32) operation:NSCompositeSourceOver fraction:1];
    [thumbinail unlockFocus];
    
    [imageView setImage:thumbinail];
    [thumbinail release];
}

-(void)resetIndexes
{
    headColorIndex = 0;
    bodyColorIndex = 0;
    headIndex = 1;
    bodyIndex = 1;
}

@end
