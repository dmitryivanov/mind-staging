# encoding: utf-8

VALID_MC_CAMPAIGN_STATS = [
  :syntax_errors,
  :hard_bounces,
  :soft_bounces,
  :unsubscribes,
  :abuse_reports,
  :forwards,
  :forwards_opens,
  :opens,
  :last_open,
  :unique_opens,
  :clicks,
  :unique_clicks,
  :users_who_clicked,
  :last_click,
  :emails_sent,
  :unique_likes,
  :recipient_likes,
  :facebook_likes
]

GA_METRICS = {
  'ga:exitRate' => '%Exit is the percentage of site exits that occurred from a specified page or set of pages.',
  'ga:percentNewVisits' => '% New Visits is the percentage of visits that were first-time visits (from people who had never visited your site before).',
  'ga:searchExitRate' => '%Search Exits is the percentage of searches that resulted in an immediate exit from your site.',
  'ga:avgTimeOnPage' => 'Avg. Time on Page is the average amount of time visitors spent viewing a specified page or set of pages.',
  'ga:avgTimeOnSite' => 'The average time duration of a session.',
  'ga:visitBounecRate' => 'Bounce Rate is the percentage of single-page visits (i.e. visits in which the person left your site from the entrance page).',
  'ga:bounces' => 'Bounces is the number of single-page visits.',
  'ga:exits' => 'Exits is the number of times visitors exited your site from a specified page or set of pages.',
  'ga:newVisits' => 'New Visits is the number of first-time visits (from people who had never visited your site before).',
  'ga:pageviewsPerVisit' => 'Pages/Visit (Average Page Depth) is the average number of pages viewed during a visit to your site. Repeated views of a single page are counted.',
  'ga:pageviews' => 'Pageviews is the total number of pages viewed. Repeated views of a single page are counted.',
  'ga:avgSearchResultsViews' => 'Results Pageviews/Search is the average number of times visitors viewed a search results page after performing a search.',
  'ga:appviews' => 'The average number of screens viewed per session. Every view of a single screen is counted individually, including repeated views of the same screen.',
  'ga:appviewsPerVisit' => 'The total number of screens viewed. Repeated views of a single screen are counted.',
  'ga:searchUniques' => 'Total Unique Searches is the number of times people searched your site. Duplicate searches within a single visit are excluded.',
  'ga:uniquePageviews' => 'Unique Pageviews is the number of visits during which the specified page was viewed at least once. A unique pageview is counted for each page URL + page Title combination.',
  'ga:uniqueAppviews' => 'The number of sessions during which the specified screen(s) are viewed at least once. Multiple viewings of a screen are counted as a single Unique Screenview.',
  'ga:visitors' => 'Unique Visitors is the number of unduplicated (counted only once) visitors to your website over the course of a specified time period.',
  'ga:timeOnSite' => 'The average time duration of a session.',
  'ga:visitors' => 'Visitors is the number of people (identifed as unique browser/device combinations) that came to your site.',
  'ga:visits' => 'The number of visits to your site. If you\'re creating a visitor segment for a remarketing list, then this is the number of visits to your site over the previous seven days. ',
  'ga:visitsWithEvent' => 'The total number of visits with events.',
  'ga:organicSearches' => 'The number of organic searches that occurred within a session.',
  'ga:socialInteractionsPerVisit' => 'Total Social Actions divided by Unique Social Actions.',
  'ga:socialActivities' => 'The count of activities where a content URL was shared/mentioned on a social data hub partner network.',
  'ga:socialInteractions' => 'The number of social actions that occurred.',
  'ga:uniqueSocialInteractions' => 'The number of visits during which the specified social action(s) occurred at least once.',
  'ga:goalAbandonsAll' => 'The number of times visitors entered a goal funnel without converting.',
  'ga:fatalExceptions' => 'Number of technical exceptions, or errors, that caused a crash.',
  'ga:exceptions' => 'The total number of technical exceptions, or errors, including crashes.',
  'ga:goal(n)AbandonRate' => 'The rate at which the goal was abandoned (the ratio of Abandoned Funnels to Goal Starts).',
  'ga:goal(n)Abandons' => 'The number of times visitors entered the goal funnel but did not complete conversion.',
  'ga:goalAbandonRateAll' => 'The rate at which goals were abandoned. Defined as Total Abandoned Funnels divided by Total Goal Starts.',
  'ga:revenuePerItem' => 'Average Price is the the average ecommerce revenue per product.',
  'ga:itemsPerPurchase' => 'The average quantity of this product (or group of products) sold per transaction.',
  'ga:revenuePerTransaction' => 'Average Value is average value of e-commerce transactions.',
  'ga:costPerConversion' => 'The cost per conversion (including ecommerce and goal conversions) for your site.',
  'ga:costPerGoalConversion' => 'The cost per goal conversion for your site.',
  'ga:costPerTransaction' => 'The cost per transaction for your site.',
  'ga:goal(n)Completions' => 'The number of conversions to the goal.',
  'ga:goal(n)ConversionRate' => 'The percentage of visits that resulted in a conversion to the goal.',
  'ga:goal(n)Starts' => 'The number of entrances into the goal funnel.',
  'ga:goal(n)Value' => 'The monetary value of conversions to the goal.',
  'ga:goalCompletionsAll' => 'The total number of conversions.',
  'ga:goalConversionRateAll' => 'The sum of all individual goal conversion rates.',
  'ga:goalStartsAll' => 'The total number of starts for all goals.',
  'ga:goalValueAll' => 'Total Goal Value is the total value produced by goal conversions on your site. This value is calculated by multiplying the number of goal conversions by the value that you assigned to each goal.',
  'ga:goalValuePerVisit' => 'Per Visit Goal Value is the average value (based on goal value) of a visit to your site. Calculated as Total Goal Value divided by Visits.',
  'ga:transactionRevenuePerVisit' => 'Per Visit Value is the average value (based on ecommerce revenue) of a visit to your site. Calculated as Revenue divided by Visits.',
  'ga:itemRevenue' => 'Product Revenue is the total revenue from product sales. Excludes tax and shipping.',
  'ga:itemQuanitity' => 'Quantity is the number of units sold in ecommerce transactions.',
  'ga:transactionRevenue' => 'Revenue is ﻿﻿the total revenue, including tax and shipping, from e-commerce transactions.',
  'ga:transactionShipping' => 'Shipping is the total of shipping charges for ecommerce transactions.',
  'ga:transactionTax' => 'Tax is the total of tax charges for ecommerce transactions.',
  'ga:transactions' => 'Transactions is the total number of completed purchases on your site.',
  'ga:uniquePurchases' => 'Unique Purchases is the total number of times a specified product (or set of products) was a part of a transaction.',
  'ga:avgDomainLookupTime' => 'The average amount of time (in seconds) spent in DNS lookup for this page.',
  'ga:avgPageDownloadTime' => 'The average amount of time (in seconds) to download this page.',
  'ga:avgPageLoadTime' => 'Avg. Page Load Time is the average amount of time (in seconds) it takes for pages from the sample set to load, from initiation of the pageview (e.g. click on a page link) to load completion in the browser.',
  'ga:avgRedirectionTime' => 'The average amount of time (in seconds) spent in redirects before fetching this page. If there are no redirects, the value for this metric is expected to be 0.',
  'ga:avgServerConnectionTime' => 'The average amount of time (in seconds) spent in establishing TCP connection for this page.',
  'ga:avgServerResponseTime' => 'The average amount of time (in seconds) your server takes to respond to a user request, including the network time from user’s location to your server.',
  'ga:avgUserTimingValue' => 'Average time of user timings in seconds.',
  'ga:avgEventValue' => 'The average value of each event.',
  'ga:entrances' => 'Entrances is the number of times visitors entered your site through a specified page or set of pages.',
  'ga:entranceRate' => 'The percentage of pageviews which were entrances to the site.',
  'ga:eventValue' => 'Event Value is the total value of an event or set of events. It is calculated by multiplying the per-event value by the number of times the event occurred.',
  'ga:pageLoadSample' => 'The number of page download times received over the given time range.',
  'ga:pageLoadSample' => 'The sample set (or count) of pageviews used to calculate the average page load time.',
  'ga:searchDepth' => 'The number of pages visited after the search and before the next one or end of session.',
  'ga:searchExits' => '%Search Exits is the percentage of searches that resulted in an immediate exit from your site.',
  'ga:searchRefinements' => '% Search Refinements is the percentage of searches that resulted in another search ( i.e. a new search using a different term).',
  'ga:searchDuration' => 'The time spent on your site from the start of the current search until session ended or another search started.',
  'ga:timeOnPage' => 'How long a visitor spent on a particular page in seconds. Calculated by subtracting the initial view time for a particular page from the initial view time for a subsequent page. Thus, this metric does not apply to exit pages for your website.',
  'ga:totalEvents' => 'Total Events is the number of times events occurred.',
  'ga:uniqueEvents' => 'Unique Events is the number of visits during which one or more events occurred.',
  'ga:userTimingValue' => 'Total user timing in milliseconds',
  'ga:userTimingSamle' => 'User timings measurement volume.',
  'ga:searchVisits' => 'Visits with Search is the number of visits during which at least one site search occurred.',
  'ga:adClicks' => 'Clicks is the number of clicks on your search ad(s).',
  'ga:adCost' => 'Cost is the total amount you paid for clicks on your search ads.',
  'ga:CPC' => 'Cost-per-click is the average cost you paid for each click on your search ad(s).',
  'ga:CPM' => 'Cost-per-mille-impressions is the average cost you paid for each 1000 impressions on content ads.',
  'ga:CTR' => 'AdWords CTR (click-through rate) is the percentage of ad impressions that resulted in a click.',
  'ga:impressions' => 'Impressions is the number of times your search ad(s) was/were displayed.',
  'ga:margin' => 'Margin is (Ecommerce revenue + Total Goal Value - Cost) divided by Revenue.',
  'ga:ROI' => 'Return on Investment is (Ecommerce revenue + Total Goal Value - Cost) divided by Cost.',
  'ga:RPC' => 'Revenue-per-click is the average revenue (from ecommerce sales and/or goal value) you received for each click on one of your search ads.',
}

GA_DIMENSIONS = {
  'ga:browser' => 'The browsers used by visitors to your website.',
  'ga:browserVersion' => 'The browser versions used by visitors to your website.',
  'ga:city' => 'The cities from which visits originated, based on IP address.',
  'ga:continent' => 'The continents from which visits originated, based on IP address.',
  'ga:visitCount' => 'The total count of visits to your site. If you\'re using this dimension to create a visitor segment (e.g., for a remarketing list), then you\'re identifying all visitors over all sessions who match the criteria you apply; for example, all visitors who have more than 5 visits. ',
  'ga:country' => 'The countries from which visits originated, based on IP address.',
  'ga:daysSinceLastVisit' => 'The number of days elapsed since visitors last visited the site.',
  'ga:networkDomain' => 'The fully qualified domain names of your visitors\' Internet service providers (ISPs).',
  'ga:flashVersion' => 'The versions of Flash supported by visitors\' browsers, including minor versions.',
  'ga:javaEnabled' => 'Differentiates visits from browsers with and without (Yes or No) Java enabled.',
  'ga:language' => 'A screen through which visitors enter an app.',
  'ga:metro' => 'The Designated Market Area (DMA) from where traffic arrived on your site.',
  'ga:isMobile' => 'Indicates whether visits were from mobile and tablet devices (Yes) or not (No).',
  'ga:mobileDeviceBranding' => 'Manufacturer or branded name (examples: Samsung, HTC, Verizon, T-Mobile).',
  'ga:mobileDeviceInfo' => 'The branding, model, and marketing name used to identify the device.',
  'ga:MobileDeviceModel' => 'Device model (example: Nexus S)',
  'ga:mobileInputSelector' => 'Selector used on device (examples: touchscreen, joystick, clickwheel, stylus)',
  'ga:operatingSystem' => 'The operating systems used by visitors to your website. Includes mobile operating systems such as Android.',
  'ga:operatingSystemVersion' => 'The operating system versions used by visitors to your website.',
  'ga:region' => 'The geographic regions from which visits originated, based on IP address.',
  'ga:screenColors' => 'The screen color depths of visitors\' monitors.',
  'ga:screenResolution' => 'The screen resolutions of visitors\' monitors.',
  'ga:networkLocation' => 'The names of the Internet service providers (ISPs) used by visitors to your site.',
  'ga:subContinent' => 'The sub-continents from which visits originated, based on IP address.',
  'ga:visitorType' => 'New Visitor (first-time visit) and Returning Visitor.',
  'ga:medium' => 'The mediums which referred traffic. Includes mediums identified via utm_medium.',
  'ga:referralPath' => 'The URIs that referred traffic.',
  'ga:source' => 'The sources which referred traffic. Includes sources identified via utm_source.',
  'ga:socialActivityDisplayName' => 'Social activity display name.',
  'ga:socialActivityEndorsingUrl' => 'For a social data hub activity, this value represents the URL of the social activity (e.g. the Google+ post URL, the blog comment URL, etc.).',
  'ga:socialActivityContentUrl' => 'Social Content URL --- The URL/content that was talked about in the social activity.',
  'ga:socialActivityAction' => 'The social action that occurred (e.g. +1, Like, Share)',
  'ga:socialActivityPost' => 'Social Activity Post --- The content of the activity shared by the user.',
  'ga:socialActivityTimestamp' => 'The timestamp of when the social activity occurred.',
  'ga:socialInteractionTarget' => 'The page (i.e. URL) or entity that was shared.',
  'ga:socialNetwork' => 'The social network where the visit came from and/or the social activity occurred.',
  'ga:socialActivityNetworkAction' => 'Originating Social Network/Action: The social network where the activity originated and the type of action taken.',
  'ga:socialInteractionNetwork' => 'The social source or network on which the activity occurred (e.g. Facebook, Twitter, Google).',
  'ga:socialInteractionNetworkAction' => 'The social source/network and action that occurred (e.g. Facebook-Like).',
  'ga:hasSocialSourceReferral' => 'Whether or not this activity resulted from a social source.',
  'ga:socialActivityTagsSummary' => 'For a social data hub activity, this is a comma-separated set of tags associated with the social activity.',
  'ga:socialActivityUserHandle' => 'Social User Handle --- The handle of the user who initiated the social activity.',
  'ga:socialActivityUserPhotoUrl' => 'URL for the profile photo of the user who performed a social action.',
  'ga:socialActivityUserProfileUrl' => 'URL for the profile of the user who performed a social action.',
  'ga:date' => 'The dates of the active date range.* (Same as Visit Date (YYYYMMDD) in Advanced Segments)',
  'ga:dayOfWeek' => 'The day of the week. A one-digit number from 0 (Sunday) to 6 (Monday).',
  'ga:hour' => 'A two-digit hour of the day ranging from 00-23 in the timezone configured for the account. This value is also corrected for daylight savings time, adhering to all local rules for daylight savings time. If your timezone follows daylight savings time, there will be an apparent bump in the number of visits during the change-over hour (e.g. between 1:00 and 2:00) for the day per year when that hour repeats. A corresponding hour with zero visits will occur at the opposite changeover. (Google Analytics does not track visitor time more precisely than hours.)',
  'ga:month' => 'The month of the visit. A two digit integer from 01 to 12.',
  'ga:date' => 'Visit date in yyyymmdd format.*(Same as "Date" in Custom Reports)',
  'ga:week' => 'The week of the visit. A two-digit number from 01 to 53. Each week starts on Sunday.',
  'ga:customVarName(n)' => 'The key name of the custom variable fro that slot.',
  'ga:customVarValue(n)' => 'The value name of the custom variable fro that slot.',
  'ga:affiliation' => 'The affiliations assigned to ecommerce transactions.',
  'ga:daysToTransaction' => 'The number of days between users\' purchases and the campaign referral.',
  'ga:productName' => 'The product names of items sold.',
  'ga:productCategory' => 'The categories of products sold.',
  'ga:productSku' => 'The product codes of items sold.',
  'ga:transactionId' => 'The transaction IDs of the ecommerce transactions.',
  'ga:visitsToTransaction' => 'The number of visits from referral to purchase.',
  'ga:searchDestinationPage' => 'A page that the user visited after performing an internal website search.',
  'ga:eventAction' => 'The actions that were assigned to triggered events.',
  'ga:eventCategory' => 'The categories that were assigned to triggered events.',
  'ga:eventLabel' => 'The optional labels used to describe triggered events.',
  'ga:exitPagePath' => 'The pages visitors viewed last on your site.',
  'ga:hostname' => 'The hostnames visitors used to reach your site. Typically, your site\'s URL.',
  'ga:landingPagePath' => 'The pages through which visitors entered your site.',
  'ga:pagePath' => 'The pages visited, listed by path and/or query parameters.',
  'ga:pageDepth' => 'The number of pages viewed by visitors in a session.',
  'ga:pagePathLevel1' => 'Page Path Level 1, 2, 3 or 4.',
  'ga:pageTitle' => 'The page titles used on your site.',
  'ga:searchKeywordRefinement' => 'The search terms used to refine internal searches.',
  'ga:searchKeyword' => 'The search terms used by visitors to search your site.',
  'ga:searchCategory' => 'The categories searched by visitors searching your site.',
  'ga:searchUsed' => 'Distinguishes visits that included an internal site search and those that did not.',
  'ga:searchStartPage' => 'The pages from which visitors searched your site.',
  'ga:userTimingCategory' => 'User specified category for user timing.',
  'ga:userTimingLabel' => 'User specified label for user timing.',
  'ga:userTimingVariable' => 'User timing variable',
  'ga:userDefinedValue' => 'The value provided when you define custom visitor segments for your website.',
  'ga:adContent' => 'The first line of each AdWords ad and the utm_content tags that were used in tagged campaigns.',
  'ga:adDistributionNetwork' => 'The location where your ad was shown (google.com, search partners, content network).',
  'ga:adGroup' => 'The names of your AdWords ad groups.',
  'ga:adSlot' => 'The location of the advertisement on the hosting page (Top, RHS, or not set).',
  'ga:adSlotPostition' => 'The ad slot positions in which your AdWords ads appeared (1-8).',
  'ga:campaign' => 'The names of your AdWords campaigns and the utm_campaign tags that were used in tagged campaigns.',
  'ga:adDestinationUrl' => 'The URLs to which your AdWords ads referred traffic.',
  'ga:keyword' => 'All keywords, both paid and unpaid, used by users to reach your site.',
  'ga:adMatchType' => 'How the keyword was matched the query (i.e. exact, broad, phrase).',
  'ga:adMatchedQuery' => 'The actual search queries that triggered impressions of your AdWords ads.',
  'ga:adPlacementDomain' => 'The domains where your ads on the content network were placed.',
  'ga:adTargetingOption' => 'Automatic placement or managed placement.',
  'ga:adPlacementUrl' => 'The URLs where your ads on the content network were placed.',
}