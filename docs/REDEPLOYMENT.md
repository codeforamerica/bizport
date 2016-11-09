# Redeploying BizPort in Your City

## Overview

This is an overview of how city management, from a tactical perspective, can go about deploying BizPort in their own city.

BizPort is a business portal composed from common and readily-available open source code and tools. It contains a content management system (CMS) for easy editing of site content, as well as a rich set of features for customers starting a business. 

A redeployment of BizPort as a city business portal requires:
• Technical setup: BizPort is designed to be easily redeployed and customized by a single full-stack engineer familiar with a modern open-source language like Ruby or Python.
• Content development: What makes a business portal valuable for customers is the relevance and accuracy of content. A UX researcher, service designer, or program manager can help to coordinate across multiple business-facing departments in city hall to build high-quality content.
• Ongoing maintenance: Both content and code will require updates and continued development over time. While this will require less bandwidth than the initial site setup, it should be considered in long-term staffing requirements to ensure that the site does not fall out of date, become irrelevant to customer needs, or develop security vulnerabilities.

## BizPort's Components

BizPort itself is open-source software, licensed under the MIT license. This license is extremely short, simple, and worth reading: [MIT License](https://github.com/codeforamerica/bizport/blob/master/LICENSE.md)

It's important that BizPort is open source because it means that you or an engineer that you employ can edit the software however you like to meet your own needs.

BizPort is made up of several smaller open-source pieces, and can be easily customized to meet the needs of different cities. Any of these features can be included or excluded from the site with a few hours of engineering work. The key pieces are:
 - Live Chat: This is provided by a third-party service called Intercom, but could be replaced by any number of live chat options or CRM systems like Zendesk, Olark, or Desk.com. The core purpose is to give customers a way to interact with city staff instantaneously, which leads to better customer service, as well as more rapid feedback and improvement of the site.
 - Checklist: The checklist serves as both a map for entrepreneurs embarking on the process of starting a business, as well as a tracking tool as they set up their business.
 - Notebook: Starting a business involves lots of little bits of information. The notebook is a single place to keep that information handy, especially when entrepreneurs are visiting city hall or filling out paperwork.
 - Content Management System (CMS): The content throughout the site is managed in a CMS that allows non-technical staff to edit information. A staff member can be trained in the basics of editing in less than an hour.
 - Resource Matching: BizPort provides a search tool to help entrepreneurs find government resources that are relevant to their business. This includes financial resources like loans and grants, as well as other supportive resources like workshops and mentorship opportunities. There is a user interface for non-technical users to update the database with opportunities specific to any region or jurisdiction.

## Hiring for Engineering Work

Deploying BizPort with small visual customizations (color, icons, etc.) will likely take a software engineer a few weeks. Ongoing maintenance of the site will require a few hours per month. Additional feature development or design changes fall outside of this maintenance work, and should be accounted for separately.

BizPort is written using a programming language called Ruby, along with a common programming tool called Ruby on Rails. A software engineer with a couple of years experience working with Ruby on Rails should be able to confidently set up and work on BizPort. Experienced software engineers proficient with Python are also likely to be viable candidates for working on BizPort, as some of the skills used when working on Python are transferable to Ruby on Rails.

While the time commitment to set up and run BizPort is not extensive, it takes time for any engineer to become accustomed to working on a new project, and so having the same engineer(s) work on BizPort over time is ideal.

## Hiring for Content Editing Work

Content on the site will need to be updated regularly. BizPort includes an easy-to-use content management system (CMS) that can be learned by a non-technical detail-oriented employee in a couple of hours. To ensure the quality of the content, the person editing the CMS should be someone who cares about the content as part of their existing role, like an economic development or business-facing staff member.
