## Client use "sampleClient001" ###
## "Enable Review Request" should be enabled on client ##
## "BragBook" should be enabled on client ##
### scenario to be modified ###
## @ClientMngrCreateTechnician
## @ClientMngrDeactivateTechnician
## @ClientMngrCreateCSR
## @ClientMngrDeactivateCSR
## @ClientMngrSearchforReviewsByDate
## @ClientMngrSearchforReviewsByEmployee
## @ClientMngrPickFeatureReview
## @ClientMngrDownloadBragbook
## @ClientMngrDeleteReview
## @ClientMngrUndeleteReview
## @ClientMngrReplyBuzzboxReview
## @ClientMngrSearchSurveysByDate
## @ClientMngrSearchSurveysByEmployee
## @ClientMngrSendReviewRequests
@managerRBDashboard
Feature: Client Manager Dashboard for RB
	As an Client Manager User
	I will be able to Create Technician
	I will be able to Create CSR
	I will be able to Delete Technician
	I will be able to Delete CSR
	I will be able to Search for reviews
	I will be able to Pick Feature Review
	I will be able to Download Brag book
	I will be able to Download reviews in Excel
	I will be able to Delete Review
	I will be able to Undelete Review
	I will be able to Reply to Buzzbox
	I will be able to Search for surveys
	I will be able to View survey Data
	I will be able to Preview Template
	I will be able to Send Review Request
	I will be able to Send Review Request for feedback
	I will be able to Send Survey Request for feedback
	
	Background:
		Given there are following users:
			| username | password   |
			| adminUser    | test123 |
			| sampleManager@stage.com    | test123 |
        And I am on "/"
		And I click on login "Client Login"
			
	@ClientMngrlogin
	Scenario: Login as Client Manager User for RB
		When I am authenticated as "sampleManager@stage.com"
		Then I should not see "Enter Username or Email and valid password"
		When I see welcome message I will close it
		And I accept the term of use
		Then I should be on "/clients/reviews"
		Then I save a screenshot

	@ClientMngrCreateTechnician
	Scenario: As Client Manager I can Create technician user
		When I am authenticated as "sampleManager@stage.com"
		When I see welcome message I will close it
		And I hover on "Settings"
		And I click on "Team Members"
		Then I should see text matching "Team member list"
		When I click on "Add New member"
		And I fill in "users_first_name" with "TechClient001"
		And I fill in "last_name" with "TechClient001"
		And I fill in "email" with "TechClient001@PeterPiper2.com"
		And I fill in "users_password" with "test123"
		And I fill in "users_password_repeat" with "test123"
		And I click on "Field/Service"
		When I press "submit_button"
		Then I should see the newly created user "TechClient001"
		Then I save a screenshot

	@ClientMngrDeactivateTechnician
	Scenario: As Client Manager I can Deactivate technician user
		When I am authenticated as "sampleManager@stage.com"
		And I hover on "Settings"
		And I click on "Team Members"
		## just put the fist name of the employee ##
		When I deactivate the user "TechClient001"
		Then I save a screenshot		

	@ClientMngrCreateCSR
	Scenario: As Client Manager I can Create CSR user
		When I am authenticated as "sampleManager@stage.com"
		And I hover on "Settings"
		And I click on "Team Members"
		Then I should see text matching "Team member list"
		When I click on "Add New member"
		And I fill in "users_first_name" with "CSRClient001"
		And I fill in "last_name" with "CSRClient001"
		And I fill in "email" with "CSRClient001@PeterPiper2.com"
		And I fill in "users_password" with "test123"
		And I fill in "users_password_repeat" with "test123"
		And I click on "Office Staff"
		And I click on "Employee Access"
		And I click Alert Confirmation
		And I click Alert Confirmation
		When I press "submit_button"
		Then I should see the newly created user "CSRClient001"
		Then I save a screenshot	

	@ClientMngrDeactivateCSR
	Scenario: As Client Manager I can Deactivate CSR user
		When I am authenticated as "sampleManager@stage.com"
		And I hover on "Settings"
		And I click on "Team Members"
		## just put the fist name of the employee ##
		When I deactivate the user "CSRClient001"
		Then I save a screenshot

	@ClientMngrSearchforReviews
	Scenario: As Client Manager I can search for reviews
		When I am authenticated as "sampleManager@stage.com"
		#And I hover on "Feedback"
		#And I click on "View Reviews"
		#Then I should be on "/clients/reviews?rs=reviews"
		When I press "Search"
		Then I should see text matching "Reviews"
		Then I save a screenshot														

	@ClientMngrSearchforReviewsByDate
	Scenario: As Client Manager I can search for reviews by date
		When I am authenticated as "sampleManager@stage.com"
		And I select "January" from "start_date-mm"
		And I select "1" from "start_date-dd"
		And I select "2010" from "start_date"
		When I press "Search"
		Then I should see text matching "Reviews"
		Then I save a screenshot

	@ClientMngrSearchforReviewsByEmployee
	Scenario: As Client Manager I can search for reviews by employee
		When I am authenticated as "sampleManager@stage.com"
		And I click on element "Display All"
		And I check "sampleCSR"
		And I click on element "Display All"
		And I press "Search"
		Then I should see text matching "Reviews"
		Then I save a screenshot

	@ClientMngrSearchforReviewsBySites
	Scenario: As Client Manager I can search for reviews by sites
		When I am authenticated as "sampleManager@stage.com"
		And I select "Google" from "sites"
		And I wait for 5 seconds
		Then I should see text matching "Reviews"
		Then I save a screenshot					

	@ClientMngrPickFeatureReview
	Scenario: As Client Manager I can pick feature review
		When I am authenticated as "sampleManager@stage.com"
		When I press "Feature a Review"
		### use firstname of reviewer"
		And I wait for 5 seconds
		And I pick "sample3" as featured review
		And I press "featured_review_confirm"
		And I wait for 5 seconds
		Then I should see text matching "Featured review Linus"
		Then I save a screenshot	

	@ClientMngrDownloadBragbook
	Scenario: As Client Manager I can download brag book
		When I am authenticated as "sampleManager@stage.com"
		And I click on element "Display All"
		And I check "sampleCSR"		
		And I click on element "Display All"
		And I press "Search"
		When I press "Brag book"
		Then bragbook for "sampleCSR" is saved

	@ClientMngrDownloadExcel
	Scenario: As Client Manager I can download excel
		When I am authenticated as "sampleManager@stage.com"
		And I press "Download Excel"
		Then Excel file is successfully saved

	@ClientMngrDeleteReview
	Scenario: As Client Manager I can Delete a review
		When I am authenticated as "sampleManager@stage.com"
		And I delete "sample3" review from list		
		When I click on "See deleted reviews >>"
		Then I should be on "/clients/reviews/deleted"
		Then I should see text matching "sample3"
		Then I save a screenshot

	@ClientMngrUndeleteReview
	Scenario: As Client Manager I can Undelete a review
		When I am authenticated as "sampleManager@stage.com"
		And I click on "See deleted reviews >>"
		Then I should be on "/clients/reviews/deleted"
		When I undelete "sample3" review from list
		Then I should see text matching "sample3"
		Then I save a screenshot

	@ClientMngrReplyBuzzboxReview
    Scenario: As Client Manager I can reply to buzzbox
		When I am authenticated as "sampleManager@stage.com"
		And I replied "sample buzzbox reply" on any buzzbox review
		And I wait for 5 seconds
		Then I should see text matching "sample buzzbox reply"
		Then I save a screenshot

	@ClientMngrViewSurveysData
    Scenario: As Client Manager I can View Surveys
		When I am authenticated as "sampleManager@stage.com"
		When I hover on "Feedback"
		And I click on "View Surveys"
		Then I should see text matching "Surveys"
		Then I save a screenshot

	@ClientMngrSearchSurveysByDate
	Scenario: As Client Manager I can search surveys by date
		When I am authenticated as "sampleManager@stage.com"
		When I hover on "Feedback"
		And I click on "View Surveys"		
		And I select "January" from "start_date-mm"
		And I select "1" from "start_date-dd"
		And I select "2010" from "start_date"
		When I press "Search"
		Then I should see text matching "Surveys"
		Then I save a screenshot

	@ClientMngrSearchSurveysByEmployee
	Scenario: As Client Manager I can search surveys by employee
		When I am authenticated as "sampleManager@stage.com"
		When I hover on "Feedback"
		And I click on "View Surveys"		
		And I select "sampleCSR" from "techs"
		And I wait for 5 seconds
		Then I should see text matching "sampleCSR"
		Then I save a screenshot

	@ClientMngrPreviewTemplate
    Scenario: As Client Manager I can Preview template on Review requests
		When I am authenticated as "sampleManager@stage.com"
		When I hover on "Manage"
		And I click on "Review Requests"
		Then I should be on "/clients/review_requests"
		Then I should see text matching "Request Reviews"
		When I click on "Preview"
		Then I should see text matching "Write a Review"
		Then I save a screenshot

	@ClientMngrSendReviewRequests
    Scenario: As Client Manager I can Send Review Requests
		When I am authenticated as "sampleManager@stage.com"
		When I hover on "Manage"
		And I click on "Review Requests"
		Then I should be on "/clients/review_requests"
		Then I should see text matching "Request Reviews"
		And I fill in "emails" with "customer115,customer215"
		When I click on "Send"
		Then I should see text matching "Incorrectly formatted email"
		And I fill in "emails" with "customer115@customer115.com,customer215@customer215.com"
		When I click on "Send"
		Then I should see text matching "Feedback Requested"
		Then I save a screenshot
		
	@ClientMngrSendReviewRequestsForFeedback
    Scenario: As Client Manager I can Send Review Request from Feedback
		When I am authenticated as "sampleManager@stage.com"
		When I hover on "Manage"
		And I click on "Feedback Requests"
		Then I should be on "/clients/feedback_requests"
		Then I should see text matching "Appointment and Feedback"
		Then I should see text matching "Search for customer"
		When I click on "+ Add"
		Then I should see text matching "Enter Customer Data"
		And I fill in "form_first_name" with "customer100"
		And I fill in "form_last_name" with "customer100"
		And I fill in "form_email" with "customer100@customer100.com"
		And I click on "Show Calendar"
		And I select date "November 22, 2017"
		And I fill in "team_users_names[]" with "sampleCSR"
		And I click on "Continue"
		Then I should be on "clients/feedback_requests?type=pending&success=request_added"
		When I click on "Send Meet the team Email" button for customer "customer100"
		And I click on "Send E-mail"
		And I click on "Job Completed" button for customer "customer100"
		And I click on "Send Feedback Request" button for customer "customer100"
		When I click on "Sent Requests"
		Then I should see text matching "Feedback Requested"
		Then I save a screenshot