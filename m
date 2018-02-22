From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Thu, 22 Feb 2018 15:41:53 +0000
Subject: [cip-dev] How to develop on the RT version
In-Reply-To: <4d0bdf7a-81db-ee4b-4846-cfdde236b201@siemens.com>
References: <SG2PR06MB1165F30CAFCC145F81AE021E8AF20@SG2PR06MB1165.apcprd06.prod.outlook.com>
	<001f01d3ab83$89b7b5a0$9d2720e0$@toshiba.co.jp>
	<SG2PR06MB11654A3FF485063C01FFC5C58ACD0@SG2PR06MB1165.apcprd06.prod.outlook.com>
	<4d0bdf7a-81db-ee4b-4846-cfdde236b201@siemens.com>
Message-ID: <SG2PR06MB11657EA2D59CBCDD60ED8DDC8ACD0@SG2PR06MB1165.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Daniel,

On Thursday, February 22, 2018, Daniel Wagner wrote:
> In short: linux-4.4.y-cip-rt wont be rebased. linux-4.4.y-cip-rt-rebase
> tree contains the extracted patches from linux-4.4.y.cip-rt. Some people
> like to get a patchset which they can apply on top of some tree. But it
> looks no one here around is particular interested in this.
> 
> The linux-4.4.y-cip-patches is just a variation from the rebase branch.
> Probably not really useful to anyone. I just archived all the a patches
> in that branch. It was useful for me when I started with the scripting
> to have a backup but I don't think I need it anymore. So if no one needs
> I can drop it completely to avoid further confusion.


Thank you for this information.

I admit, I had 2 purposes for the question:

1. To be able to guild RZ/G customers on how to develop on the RT branch.

2. To get an idea of how to maintain the public repos for the RZ/A BSP with an RT branch. The 'rebase' branch thing didn't seem to make sense to me that anyone would want to follow that.

The current official RZ/A1 BSPs are 3.14, 4.9 and 4.14, although most of the drivers are mainlined at this point. So, maybe on the next CIP cycle, we'll support CIP for RZ/A as well.

Thanks,
Chris
