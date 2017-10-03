Feature: Login Functionality
	As an admin user/Master User
	I will be able to login to my account
	
	Background:
		Given there are following users:
			| username | password   |
			| lito.dagodog    | Y493SrNV |
			| masterUserStage003   | test12 |
        And I am on "/"
		And I click on login "Client Login"
	@adminUser
    Scenario: Login as Admin User
		When I am authenticated as "lito.dagodog"
		Then I should not see "That username and password combination was not found."
		Then I should be on "/admin"
		Then I should see "Clients"		
	@masterUser	
    Scenario: Login as Master User
		When I am authenticated as "masterUserStage003"
		Then I should not see "That username and password combination was not found."
		And I accept the term of use	
		Then I should be on "/master_account"
		Then I should see text matching "Hi,masterUserStage"
		
		