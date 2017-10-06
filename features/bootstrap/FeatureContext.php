<?php

use Behat\Behat\Tester\Exception\PendingException;
use Behat\Behat\Context\Context;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\MinkExtension\Context\MinkContext;
use Behat\Mink\Driver\Selenium2Driver;
use Behat\Gherkin\Node\TableNode;
use Behat\Behat\Hook\Scope\AfterStepScope;


class FeatureContext extends MinkContext implements Context, SnippetAcceptingContext
{

	private $users = array();

	/**
	* @Given /^there are following users:$/
	*/
	public function thereAreFollowingUsers(TableNode $table) {
		foreach ($table->getHash() as $row) 
        {
			$this->users[$row['username']] = $row;
		}
	}	
	
	/**
	   * @Given /^I set browser window size to "([^"]*)" x "([^"]*)"$/
	   */
	public function iSetBrowserWindowSizeToX($width, $height) 
    {
        $this->getSession()->resizeWindow((int)$width, (int)$height, 'current');
    }

    /**
     * @Given I click on text :arg1
     */
    public function iClickOnText($text)
    {
        $session = $this->getSession();
		$element = $session->getPage()->find('named', array('link', $text));
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Cannot find text: "%s"', $text));
        }
 
        $element->click();
    }

    /**
     * @When I click on Login :arg1
     */
    public function iClickOnLogin($element)
    {
        $page = $this->getSession()->getPage();
        $findName = $page->find("css", "#header>div>div>div.header-line-login>div>a>span");
        if (!$findName) 
        {
            throw new Exception($element . " could not be found");
        } else 
        {
            $findName->click();
        }

        sleep(3);
 
    }

    /**
     * @When I click the element :arg1
     */
    public function iClickTheElement($element)
    {
        $page = $this->getSession()->getPage();
        $findName = $page->find("css", "#header>div>div>div.header-line-login>div>a>span");
        if (!$findName)
        {
            throw new Exception($element . " could not be found");
        } 
        else 
        {
            $findName->click();
        }
 
    }

    /**
     * @When I click the loginAdmin :arg1
     */
    public function iClickTheLoginadmin($element)
    {
        $page = $this->getSession()->getPage();
		$findName = $page->find("css", "#login_form>table>tbody>tr:nth-child(4)>td:nth-child(2)>table>tbody>tr>td:nth-child(3)>button>span");
		if (!$findName)
        {
			throw new Exception($element . " could not be found");
		}
        else
        {
			$findName->click();
		}
    }

    /**
     * @When I click on logout :arg1
     */
    public function iClickOnLogout($element)
    {
        $page = $this->getSession()->getPage();
		$findName = $page->find("css", "#admin-topmenu>a:nth-child(2)>li");
		if (!$findName)
        {
			throw new Exception($element . " could not be found");
		} 
        else 
        {
			$findName->click();
		}
    }

    /**
     * @When I press on :arg1 button
     */
    public function iPressOnButton($arg1)
    {
        $addPage = $this->getSession()->getPage();
		$addNameClient = $addPage->find("css", "#add_client");
		if (!$addNameClient)
        {
			throw new Exception($arg1 . " could not be found");
		} 
        else 
        {
			$addNameClient->click();
		}
    }	  


    /**
     * @When I am authenticated as :arg1
     */
    public function iAmAuthenticatedAs($username)
    {
		if (!isset($this->users[$username]['password'])) 
        {
			throw new \OutOfBoundsException('Invalid user '. $username);
		}
		$this->fillField('username', $username);
		$this->fillField('password', $this->users[$username]['password']);
		$this->pressButton('Log In');	
		sleep(3);
    }

	/**
     * @BeforeScenario
     *
     * @param BeforeScenarioScope $scope
     *
     */
    public function setUpTestEnvironment($scope)
    {
        $this->currentScenario = $scope->getScenario();
    }

    /**
     * @AfterStep
     *
     * @param AfterStepScope $scope
     */
    public function afterStep($scope)
    {
        //if test has failed, and is not an api test, get screenshot
        if(!$scope->getTestResult()->isPassed())
        {
            //create filename string
            $featureFolder = preg_replace('/\W/', '', $scope->getFeature()->getTitle());
            $scenarioName = $this->currentScenario->getTitle();
            $fileName = preg_replace('/\W/', '', $scenarioName) . '.png';

            //create screenshots directory if it doesn't exist
            if (!file_exists('report/screenshots_' . $featureFolder)) 
            {
                mkdir('report/screenshots_' . $featureFolder);
            }

            //take screenshot and save as the previously defined filename
            //$this->driver->takeScreenshot('report/screenshots_' . $featureFolder . '/' . $fileName);
            // For Selenium2 Driver you can use:
            file_put_contents('report/screenshots_' . $featureFolder . '/' . $fileName, $this->getSession()->getDriver()->getScreenshot());
        }
		
    }	

    /**
     * @When I wait for :arg1 seconds
     */
    public function iWaitForSeconds($arg1)
    {
        sleep($arg1);
    }

    /**
     * @Then I accept the term of use
     */
    public function iAcceptTheTermOfUse()
    {
        $addPage = $this->getSession()->getPage();
		$addNameClient = $addPage->find("css", '#agree_button');
		if ($addNameClient) 
        {
			$addNameClient->click();
		} else 
        {
		}
    }

    /**
     * @Then I should see the newly created client :arg1
     */
    public function iShouldSeeTheNewlyCreatedClient($arg1)
    {
		$td = $this->getSession()->getPage()->find('css',
			sprintf('table tbody tr td:contains("%s")', $arg1));
    }

    /**
     * @Then I save a screenshot
     */
    public function iSaveAScreenshot()
    {
		if (!is_dir('screenshots')) 
        {
			mkdir('screenshots', 0777, true);
		}		
        sleep(1);
		$scenarioName = $this->currentScenario->getTitle();
        $this->saveScreenshot($scenarioName.'.png','screenshots/');
    }

    /**
     * @When I click on :arg1
     */
    public function iClickOn($arg1)
    {
		sleep(3);
        $session = $this->getSession();
        if ($arg1 === 'Reply') 
        {
            //$element = $session->getPage()->find('named', array('content', $arg1));
            $element = $session->getPage()->find("css", '.reply-button');
            if ($element) 
            {
                $element->click();  
            }           
        }
        elseif ($arg1 === 'Continue') 
        {
            $element = $session->getPage()->find('named', array('id', 'submit'));
            if (null === $element) 
            {
                throw new \InvalidArgumentException(sprintf('Cannot find text: "%s"', $arg1));
            }
     
            $element->click();              
        } 
        elseif ($arg1 === 'Send') 
        {
            $element = $session->getPage()->find('named', array('id', 'send-review-request'));
            if (null === $element) 
            {
                throw new \InvalidArgumentException(sprintf('Cannot find text: "%s"', $arg1));
            }
     
            $element->click();              
        }
        else 
        {         
            $element = $session->getPage()->find('named', array('link', $arg1));
            if (null === $element) 
            {
                throw new \InvalidArgumentException(sprintf('Cannot find text: "%s"', $arg1));
            }
     
            $element->click();  
        }

    }

    /**
     * @Then I should see the newly created user :arg1
     */
    public function iShouldSeeTheNewlyCreatedUser($arg1)
    {
		$td = $this->getSession()->getPage()->find('css',
			sprintf('table tbody tr td:contains("%s")', $arg1));
    }

    /**
     * @Given I click on employee :arg1
     */
    public function iClickOnEmployee($arg1)
    {
		sleep(3);
		$session = $this->getSession();
		try
		{
			$element = $session->getPage()->find('named', array('content', $arg1));
			$element->click();
		/*if (null === $element) {
			throw new \InvalidArgumentException(sprintf('Cannot find text: "%s"', $arg1));
		} */
		}
		catch(\WebDriver\Exception\ElementNotVisible $f)
		{
			$checkElem = $session->getPage()->find("css", '#peoples>div.next_arrow1>a>img');		
			if ($checkElem)
			{
				$checkElem->click();
				sleep(3);
				$elementNext = $session->getPage()->find('named', array('content', $arg1));
				//$elementNext = $session()->getPage()->find('xpath', '//label[text()=' . $arg1 . ']');
				//$elementNext = $session->getPage()->findLink($arg1);
				if($elementNext)
				{
					$elementNext->click();
				}
				else{
					echo "element not found!";
				}
			}
		}
		/***if(null === $element)
		{
			$checkElem = $session->getPage()->find("css", '#peoples>div.next_arrow1>a>img');		
			if ($checkElem)
			{
				$checkElem->click();
				sleep(3);
				$elementNext = $session->getPage()->find('named', array('content', $arg1));
				//$elementNext = $session()->getPage()->find('xpath', '//label[text()=' . $arg1 . ']');
				//$elementNext = $session->getPage()->findLink($arg1);
				var_dump($elementNext);
				if($elementNext)
				{
					$elementNext->click();
				}
				else{
					echo "element not found!";
				}
			}			

		}
		else
		{
			$element->click();
		} **/
			
    }

    /**
     * @Then I add :arg1 star review
     */
    public function iAddStarReview($arg1)
    {
		sleep(3);
        $addPage = $this->getSession()->getPage();
		$addNameClient = $addPage->find("css", '#rating_stars_new>div:nth-child(' . $arg1 . ')');
		if ($addNameClient) 
        {
			$addNameClient->click();
		} 
        else 
        {
		}
    }

    /**
     * @When I hover on :arg1
     */
    public function iHoverOn($arg1)
    {
		sleep(2);
		$session = $this->getSession();
		if ($arg1 === 'Feedback')
		{
			$element = $session->getPage()->find('named', array('id', 'reviews'));
			if (null === $element) 
            {
				throw new \InvalidArgumentException(sprintf('Cannot find text: "%s"', $arg1));
			}	 

			$element->mouseOver();
		}
		elseif ($arg1 === 'Manage')
		{
			$element = $session->getPage()->find('named', array('id', 'manage'));
			if (null === $element) 
            {
				throw new \InvalidArgumentException(sprintf('Cannot find text: "%s"', $arg1));
			}

			$element->mouseOver();			
		}
		else
		{
            $session = $this->getSession();
            $element = $session->getPage()->find('named', array('content', $arg1));
            if (null === $element) 
            {
                throw new \InvalidArgumentException(sprintf('Cannot find text: "%s"', $arg1));
            }
     
            $element->mouseOver();
		}		
    }


    /**
     * @Then I select date :arg1
     */
    public function iSelectDate($arg1)
    {
        sleep(2);
        $td = $this->getSession()->getPage()->find('css',
            sprintf('table tbody tr td[title="%s"]', $arg1));
        $td->click();
    }

    /**
     * @Then I should see :arg1 button
     */
    public function iShouldSeeButton($arg1)
    {
        sleep(2);
        $addPage = $this->getSession()->getPage();
        $addNameClient = $addPage->find("css", "#request_buttons>li");
        if (!$addNameClient) 
        {
            throw new Exception($arg1 . " could not be found");
        }
    }

    /**
     * @When I replied :arg1 on review
     */
    public function iRepliedOnReview($arg1)
    {
        sleep(2);
        $checkPage = $this->getSession()->getPage();
        $element = $checkPage->find("css", ".reply-text-textarea");
        if ($element) 
        {
            $element->setValue($arg1);
        }
   
    }
}
