//
//  main.m
//  Redix
//
//  Created by Emiliano Mancuso on 11/05/13.
//  Copyright (c) 2013 Emiliano Mancuso. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
  return macruby_main("rb_main.rb", argc, argv);
}
