From: wagi@monom.org (Daniel Wagner)
Date: Mon, 29 Jul 2019 12:23:42 +0200
Subject: [cip-dev] [ANNOUNCE] v4.4.185-cip35-rt24
In-Reply-To: <908ab2f2-b31a-948f-b8e3-d2fb9391cb0e@monom.org>
References: <20190723124015.GA13044@amd> <20190723211219.GB23154@amd>
	<06bacec2-fc43-f208-45e7-07d02791d162@monom.org>
	<157e1ecf-20eb-7fd0-2441-5eb91490cec9@siemens.com>
	<24afcb80-66d6-c745-057d-5459c1eda78c@monom.org>
	<908ab2f2-b31a-948f-b8e3-d2fb9391cb0e@monom.org>
Message-ID: <c47d2ec2-9f5a-83cd-91a3-19048e0d5431@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> Let's see what's going wrong.

Identified the problem. It was a missing dependency 587198ba5206 
("vmstat: Remove BUG_ON from vmstat_update").

Need to run a few more tests before sending Greg an updated series for 
stable v4.4.
