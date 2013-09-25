//
//  ANPuzzle+AttrSetters.m
//  Qube
//
//  Created by Alex Nichol on 9/22/13.
//  Copyright (c) 2013 Alex Nichol. All rights reserved.
//

#import "ANPuzzle+AttrSetters.h"

@interface ANPuzzle (AttrSettersPrivate)

- (void)attributeChanged:(NSString *)attribute;

@end

@implementation ANPuzzle (AttrSetters)

- (BOOL)isNewPuzzle {
    return (self.ocAddition != nil);
}

- (void)offlineSetName:(NSString *)name {
    self.name = name;
    [self attributeChanged:kANPuzzleAttributeName];
}

- (void)offlineSetIconColor:(NSData *)iconColor {
    self.iconColor = iconColor;
    [self attributeChanged:kANPuzzleAttributeIconColor];
}

- (void)offlineSetImage:(NSData *)imageData {
    self.image = imageData;
    [self attributeChanged:kANPuzzleAttributeImageHash];
}

- (void)offlineSetInspectionTime:(double)time {
    self.inspectionTime = time;
    [self attributeChanged:kANPuzzleAttributeInspectionTime];
}

- (void)offlineSetScramble:(BOOL)scramble {
    self.scramble = scramble;
    [self attributeChanged:kANPuzzleAttributeScramble];
}

- (void)offlineSetScrambleLength:(int16_t)len {
    self.scrambleLength = len;
    [self attributeChanged:kANPuzzleAttributeScrambleLen];
}

- (void)offlineSetShowScramble:(BOOL)show {
    self.showScramble = show;
    [self attributeChanged:kANPuzzleAttributeShowScramble];
}

- (void)offlineSetShowStats:(BOOL)show {
    self.showStats = show;
    [self attributeChanged:kANPuzzleAttributeShowStats];
}

- (void)offlineSetType:(int16_t)type {
    self.type = type;
    [self attributeChanged:kANPuzzleAttributeType];
}

- (void)offlineDelete {
    if (!self.ocAddition) {
        OCPuzzleDeletion * deletion = [NSEntityDescription insertNewObjectForEntityForName:@"OCPuzzleDeletion"
                                                                    inManagedObjectContext:[ANDataManager sharedDataManager].context];
        deletion.identifier = self.identifier;
        [self.account.changes addPuzzleDeletionsObject:deletion];
    }
    [self.managedObjectContext deleteObject:self];
}

#pragma mark - Private -

- (void)attributeChanged:(NSString *)attribute {
    if ([self isNewPuzzle]) return;
    NSData * value = [self valueForPuzzleAttribute:attribute];
    OCPuzzleSetting * setting = [[ANDataManager sharedDataManager] findSettingAttribute:attribute
                                                                              forPuzzle:self];
    if (!setting) {
        setting = [NSEntityDescription insertNewObjectForEntityForName:@"OCPuzzleSetting"
                                               inManagedObjectContext:[ANDataManager sharedDataManager].context];
        setting.attribute = attribute;
        setting.puzzle = self;
        [[ANDataManager sharedDataManager].activeAccount.changes addPuzzleSettingsObject:setting];
        [self addOcSettingsObject:setting];
    }
    setting.attributeValue = value;
}

@end
