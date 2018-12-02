# Test scenarios for the forum

This directory contains the test scenarios for the behaviour of the service.

## Login feature

The [login feature](features/login.feature) describes the behaviour for logging in.
This feature requires a test user on an identity provider in the list trusted by the CheckIn IdP proxy.
For testing purposes, we have created such a user.
The user name and password need to be available to cucumber as environment variables.