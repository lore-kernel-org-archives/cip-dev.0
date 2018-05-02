From: wagi@monom.org (Daniel Wagner)
Date: Wed, 2 May 2018 15:17:39 +0200
Subject: [cip-dev] Linux 4.4.126-cip22
In-Reply-To: <OSBPR01MB210351466FB6BAFF9EB81977B8800@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1523476441.2951.8.camel@codethink.co.uk>
	<1523477437.2951.10.camel@codethink.co.uk>
	<90f2920d-abbb-affc-35f7-54161a13173c@monom.org>
	<TYAPR01MB228513B0546B4029878033C9B7820@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<OSBPR01MB21030BA75D24294F1D731CC5B8820@OSBPR01MB2103.jpnprd01.prod.outlook.com>
	<b552bb6e-df2a-9a0d-3f24-430435886246@monom.org>
	<OSBPR01MB210351466FB6BAFF9EB81977B8800@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <be2dda8f-f9c2-0ea3-7307-a9cc11937ee3@monom.org>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 05/02/2018 01:57 PM, Biju Das wrote:
> I have reproduced this issue  and  the build issue is fixed by applying below
> suggested patches as mentioned by you.
> 
> 1) 4f71a2e0a2826 ("serial: mctrl_gpio: export mctrl_gpio_disable_ms and mctrl_gpio_init")
> 2) 82a3f87f6e80e0 ("serial: mctrl_gpio: Add missing module license"

FYI, both patches are already queued for the next v4.4 stable release.
