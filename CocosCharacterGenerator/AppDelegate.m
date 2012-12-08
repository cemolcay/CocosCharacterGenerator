//
//  AppDelegate.m
//  CocosCharacterGenerator
//
//  Created by Cem Olcay on 12/8/12.
//  Copyright (c) 2012 Cem Olcay. All rights reserved.
//

#import "AppDelegate.h"
#import "CharacterGeneratorWindowController.h"

@implementation AppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    CharacterGeneratorWindowController *chwc = [[CharacterGeneratorWindowController alloc] initWithWindowNibName:@"CharacterGeneratorWindowController"];
    [chwc.window makeKeyWindow];
}

@end
