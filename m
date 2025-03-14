Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9367EC35FF1
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 11:40:24 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.25])
 by mx.groups.io with SMTP id smtpd.web11.12303.1741952417290219167
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 04:40:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=bI7KWsaN;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VSyI3S6hqmf7QqJ5aRilV/sC697XhpAaz7OKyOdxee9k0CMOs+Im/HrP3n2ygw5yUpw8O79Mc5nXV4aS/bGfMkz4OM8tYcUBkoyx8YKpUT2WX4Y9MemdqzLofVGMD0m4xmRxZBm0hoQIFjhJzQ2uG91qJFARJpivRam2LpGumOfHpkFq45zucGPhXRX6EzPUI9uTCV7e7Tis+9G/A0xf14+4PDApjqEQJAZGx6vMwUDoLmdcD/Fem+5IwRf3AZ7MMmq5smQ9sn8OVRZGgoQi8MnHc0YfTo1AnN6L3BUyN1nLo03RKUJDOVwCZVahea61Q7zMZDoqTQJF7hxJQLzlvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+9mlP05KZgGyP6TGgthOGwL8vlcl8aDgwMCqeRkS6o=;
 b=c+99tLo8UtBQZ2X68Bfae0GS1rT6xmAW5sGDma5PYqJ0mMV0JX5eyUnusDz6BiFBeC0lhWfYdEutkvygDvw9DMvx7lbtK/X0EZJoy4l9Pnbhsd2d3n22tqwClWYpgJYixHNuLR+GdvGglw0fodQ4RP8iM1jRctzj2RHBb4WP/l3VrWBIRYhcirtYM19JHaItYz+RGST2CRgL0ejZ3D7SSHg4SqJpCVOmnV/FfOl6tv+TXaxOJIE4xHwYkKUicUbAD1DfZRMZ/ugl7EdEdtYeQGjWcwwYY9jm3fv1+25LPN3tWaHL7xQdYjXrFm4wT4ROOGHoPanf3THaPND5mCFBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+9mlP05KZgGyP6TGgthOGwL8vlcl8aDgwMCqeRkS6o=;
 b=bI7KWsaN3nn4zFkbI58H0uYnXute8HM6wVRz10Zx+RMTc8/pMnPFw4X3nribiWaKLAny5TE7WtsIWcUOhdESnm7aXMdhO2lQs9IkDDdlcNyi8tcYwQZZ2eqmwDkDhicWjE3if4jrph9YHd5pn/7QgE0MSKoWkKU7MT+I/2HfYDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13459.jpnprd01.prod.outlook.com (2603:1096:405:1cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.29; Fri, 14 Mar
 2025 11:40:12 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.024; Fri, 14 Mar 2025
 11:40:12 +0000
Date: Fri, 14 Mar 2025 12:39:59 +0100
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/85] soc: renesas: Add RZ/G3E support
Message-ID: <Z9QVjxYJH4OSm0sP@tom-desktop>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
 <Z9K4sW1iyC+0lJCg@duo.ucw.cz>
 <Z9LHJC92Bp3HxjT2@tom-desktop>
 <Z9P/qUzPfn368iGo@duo.ucw.cz>
 <Z9QTPtKb5Y3E3vqP@tom-desktop>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9QTPtKb5Y3E3vqP@tom-desktop>
X-ClientProxiedBy: FR3P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::8) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13459:EE_
X-MS-Office365-Filtering-Correlation-Id: d8be6e09-d77c-4940-b9fc-08dd62ecfb20
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pA9xngwS8LAxpQSwjvuP4q1YFUcdKcxxbaeYpzCHiskw/FwPQ22bxFXhzmIC?=
 =?us-ascii?Q?kyySzCxhWPTQq/LwCGKHhYSU2lmZwFH2h1XUUPAAXqIJI5uS8UwzkBgkg4yk?=
 =?us-ascii?Q?Wr5lRSYOO1HNyG86hQujfrL8zdzwIKZPMK6PUmDiHD7iNwzTVLND4nl3y5hv?=
 =?us-ascii?Q?dXYBioUAOPukzPdmQng2vx9fJOUtXYjS07XMu8JtEcfZuxhjByPG7xhcBknW?=
 =?us-ascii?Q?5aS6uce439IuA4QHqKrNLqaN7/FlbiQ1dEWb4FtHb/M/D0lmtKmIZi37BwAr?=
 =?us-ascii?Q?oCAzdtEr2iy77Vre0B3Md4L6mEoZPmsYTY8t9wEBQDuXbgmnQL0QEIJjNMvx?=
 =?us-ascii?Q?H5QiGx3i0yeTUAcHq8bNgi0+ij+XuhjMs8vEEdIjD1I6DbnHH6Seh5dzMohn?=
 =?us-ascii?Q?bnhppsLF+Th3UVwCTp8THcd0S4LLCjpsecrspvOF1rb34GbyVa+CPDu7odxT?=
 =?us-ascii?Q?TVPjb2TjjPcFBdUr296aDgCJC/DB7TH1EzCs66ydDdiCw3qY0yM+0b3KujEd?=
 =?us-ascii?Q?bbm2ctfKJ0ih4AjP1xLOn7QnAlxC42f32k5wVMjzfQhPVrnx0xxpCVOOdql3?=
 =?us-ascii?Q?tBiVKAGvqjAG2pmwa5eEW1efcChWa0HZVa92rTZeBH10tvQp2WPhhMteHRfT?=
 =?us-ascii?Q?9BmK5uoQZB18NAuf7cnKBvhi4o630UR2Kfr3q6qDetsRnnuDj4FWAmDy4yjX?=
 =?us-ascii?Q?mfZb6GOnYq/28UDDrJcEBMQqnY94n1DCpiN71TZJwLH6XwZ3bPD1NlPgkCEl?=
 =?us-ascii?Q?J9zwR6maID6Y4YgygbXI6Ke0L9akfTp5psJchNUqZYtXETzsw7ocNex2wgL6?=
 =?us-ascii?Q?qWYG7N0CvCjY7tKqcCUM22nLfdh+ut7nQ6rSMX7MAGnzvLRe7FcNKq6jQSj8?=
 =?us-ascii?Q?ltdFamgUjtDMKMyNgY4vpx1mM+ibTI5czXdnAe9wWZYQRE8USCoXng/vRSSM?=
 =?us-ascii?Q?hqxcQBZ7IkGJYrkeoZBOlKysmF8SYcLsEdH3hmoGTH8FZ42FtRK98FfTD12m?=
 =?us-ascii?Q?lEwX/ovQUzdKCDFOwUDzQ9nDGtt+6d6g4N6jJ+d25PgxfUDmuzcyEs6hu7st?=
 =?us-ascii?Q?X3matditEcByuZxPAYyYZt2sHOCj1sStCAKRCxyGFwsRwPzOqqakJ+IS8kXM?=
 =?us-ascii?Q?VViaFnO4Bnv+kuNRGn9R4xNlWOZI51JzvGCR76VUP76p8gq1MZSG+O/HwjEw?=
 =?us-ascii?Q?mYCVBAzhp5rwX4N/8aLpEKlnQX1RVjh+OTCrwMJj5gww5P0BVLlxrYXpGRvv?=
 =?us-ascii?Q?D115da3xUmN50ZCzeSvUUFyuVZexBE3ezduFXupKkpjL0xz4tRxtXjuynH6D?=
 =?us-ascii?Q?l8xYoT/k14RGyL0+4cDbQXWAfncb9i1a0gTanmHdFdJI8aBh5nJk0OYnO1Jt?=
 =?us-ascii?Q?pO7ZOsAI0WNrFD0gg6nz9gUPgUKLtuAcv86MFlffxs2YUy4VSIYC1yGq1Fk5?=
 =?us-ascii?Q?iBrMMnxQ5oOynU2O47gs8cQW3Wb4YXmk?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?yNiOL79/MrrJ9XTylestAMra0C7AEcsGPTM/96CiuVzYSV/hCWLYQrjUZdJI?=
 =?us-ascii?Q?9ZT4hxAf6j4K/1X6Oe+OoREhQMe1FSolX2PApAdOwebpU46C4606Do2JCKso?=
 =?us-ascii?Q?oie2jI8LZcEvNevBjYUWa2WhT5mnMYzt9QxJRUw2sp8juzk/dNjDhGCkdfIR?=
 =?us-ascii?Q?4VwCOo8X5qM9aXqjAazGOyiVr+JC4SiLrXJXEoZUES15xCDJiOpNH7X94yW3?=
 =?us-ascii?Q?pHQHcofKmnHefS4ZSJNkSoJlVuMGuzeZ001ESYYHcXAgmTpuzxwQUDF8jI58?=
 =?us-ascii?Q?bfEbdEyWfVilFeQXfzxESrIb2E+0GPefIdxjChdkfsZCQpVUOp+WT7TaTUl9?=
 =?us-ascii?Q?Kf6CQqnxK5LXmRtJWDtXYXXkZUPvE96Q3R7e7SxWeVnj4e9DuqI3KmQEU2Ls?=
 =?us-ascii?Q?iV6PKyv9SCyRbQAx7fMw+2V9OcE6UPAXF5txcLvTeK8kbjjqETFDwD63VTGh?=
 =?us-ascii?Q?OLSuC6nap0+i4/yJQR74o1iJoNaeWLmTGIC6nNIyEJ8iwJN2x8KD90H6mJSr?=
 =?us-ascii?Q?mkzZ/KX/vEcKL8RGSlglVpg3llkQC+l06w9edELcnZm0nUBfrXnwAgkESVU/?=
 =?us-ascii?Q?SGV/c2GaR2Quy0bG7vjXYmsFSwTh6BD89ZoUYNXhHerB8oLLwqVspjbFbgZ/?=
 =?us-ascii?Q?iPu7KXFVZc2/9g2eRi4BOMxonk8BiumZbG5iN5CvRDT8BmYtm4Xu8J36021Z?=
 =?us-ascii?Q?gFs4w5NcgnJeJGQuHW63WTXM8wwywRIYMUSTVD0U3XLlsszJEzRvthJLjjop?=
 =?us-ascii?Q?LAAr7OZxe01beBlb2FUfwyJ+VqGmbw9W1Qbons91TdnUdqLAhbX3fJfsNMOa?=
 =?us-ascii?Q?cLrXwFwXIj901IWmGwA7JNbZLkToemO7A0eG0g/PJ87KtyjKbpVvgUAvJD5k?=
 =?us-ascii?Q?uk1PuTBHCOsXEPK4UwLkR04KudNDvxSJxz2v/y5jxhCXSEHJb/9FzKwlp4pH?=
 =?us-ascii?Q?3W7swcjZTwhDjbwgWg7+BYUFYn5eayDQdbHvSk2LuHMFfevXqcrpoU6bkZJj?=
 =?us-ascii?Q?phLhclu9iVoGFrpBacwydn2h5IlPEBj58+Qn8E2eYWkr3aTDeL849xi18Z7P?=
 =?us-ascii?Q?7KFqRS3MexpKMhr2PCff4nqr3newd/SDrbJHqKg8hIYzgDxYxoeGzSpYMAgG?=
 =?us-ascii?Q?kx5z44nalH/0sJ2zDxGE3DiUAJXaDS1YybmKlBwuOw+h46clq+iBl41OFeuM?=
 =?us-ascii?Q?MsiXDXEBdT3pt8Z54W1l52qxTrlGvHYC1845pVHYTv+FLqW5K4vRfqR31Bdc?=
 =?us-ascii?Q?N7u0PAFAn6AIWjted+edqvs2n1EO1Y/xDy8sSL/wH+cHnq8xzIcgpLB4euij?=
 =?us-ascii?Q?d3pfpw2Fkerlq18XD0p4KL5DrjBnFzFkvxkHY3WHcC3Ti9ztDKNmKqxjBHXJ?=
 =?us-ascii?Q?zqPXHOtPV/djfrS888F6NBYYzmONjkU6d58Fb/7dYQ1BdOQ/VFkPy1H5rrgl?=
 =?us-ascii?Q?/DYdSwVbLCt2zt9nmUCh+UJWZC03nysVFtD0o7sDPEU+9YYeoSfcrc3WK/uD?=
 =?us-ascii?Q?n5b1W/6NFA2CeZZaRYITgIWDgLNVOqoT9L6EY31mgGMnltOUTC1WAyGT4lGa?=
 =?us-ascii?Q?Vk+Vd1rO0XmoDRakqy36IsXGiXTvUlqFyOTFqUdEvagSa5bKozmYlhHjegwX?=
 =?us-ascii?Q?5G3//AiSq1SxkISHdUTL0PI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8be6e09-d77c-4940-b9fc-08dd62ecfb20
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 11:40:12.5014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gB4puit3XIhmImroOp6P5pAW3VWMIHvq+pLxVwUEEEXa+nBL79bRDqWoO+TtTM65I3Jh8jM2L+ZO/dlGlZX4m2oLEBTPi89Y8atkIXQV8U3GYirmuDdCFGdnodVV3RoV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13459
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 11:40:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18216

On Fri, Mar 14, 2025 at 12:30:06PM +0100, Tommaso Merciai wrote:
> Hi Pavel,
> 
> On Fri, Mar 14, 2025 at 11:06:33AM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > What is RZ/G3E? Is it new generation of something? Is it used
> > > > somewhere?
> > > 
> > > The RZ/G3E device is a general-purpose microprocessor with a quad-core CA-55,
> > > single core CM-33, Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.
> > > 
> > > Here the first introduction to the kernel: [1]
> > 
> > Ok, thanks for pointer, that is useful.
> > 
> > What is relation between RZ/G3E and rzg2l? Because early patches seem
> > to be for rzg2l support, not RZ/G3E. Splitting those preparations up
> > would be good.
> 
> Thanks for your comment.
> 
> RZ/G3E and RZ/G2L SoC have some similar IP's.

Sorry, to be more precise: 
RZ/G3E, RZ/V2H and RZ/G2L SoC have some similar IP's.

> For that we need some patches for RZ/G2L in preparation to support
> RZ/G3E.
> 
> > 
> > > > Why is it important? Why is it important for -cip?
> > > > 
> > > > Does this add complete support? Or just enough to boot?
> > > 
> > > At the moment mainline supports only boot. So same backported here.
> > > Going foward will add complete support.
> > 
> > Ok, 85 patches in the series is really a bit hard to work with. It
> > seems dts is merged quite early in the series, so that should be good
> > place to split stuff. Could we get smaller series (perhaps 15
> > patches?) with only stuff that's already in 6.12?
> 
> Fully agree.
> I will split backporting in smaller patchset as you suggested.
> Thanks.
> 
> > 
> > Best regards,
> > 								Pavel
> > -- 
> > DENX Software Engineering GmbH,        Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> 
> Regards,
> Tommaso

Thanks & Regards,
Tommaso

