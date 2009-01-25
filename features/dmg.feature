Feature: Can build a customised DMG image from application build
  In order to reduce cost of building DMG images for each release of an application
  As a Cocoa developer or release manager
  I want a rake task to generate a DMG based on custom settings

  Scenario: Build a vanilla DMG
    Given a Cocoa app with choctop installed
    When task 'rake dmg' is invoked
    Then file 'appcast/build/SampleApp.dmg' is created
    
  Scenario: Build and mount an editable DMG for design purposes
    Given a Cocoa app with choctop installed
    When task 'rake dmg:design' is invoked
    Then file 'appcast/build/SampleApp-design.dmg' is created
    And folder '/Volumes/SampleApp' is created
    And folder '/Volumes/SampleApp/SampleApp.app' is created
    And file '/Volumes/SampleApp/Application' is created as a symlink to /Application
  
  Scenario: Freeze the designed DMG by storing the .DS_Store
    Given a Cocoa app with choctop installed
    And task 'rake dmg:design' is invoked
    And a custom .DS_Store is designed with a custom background
    When task 'rake dmg:freeze_design' is invoked
    Then folder '/Volumes/SampleApp' is not created
    And file 'appcast/custom_ds_store' is created
    And file 'appcast/background.png' is created
  
  Scenario: Build a designed DMG using files cached from frozen design
    Given a Cocoa app with choctop installed
    And task 'rake dmg:design' is invoked
    And a custom .DS_Store is designed with a custom background
    And task 'rake dmg:freeze_design' is invoked
    And task 'rake dmg' is invoked
    Then file 'appcast/build/SampleApp.dmg' is created
  