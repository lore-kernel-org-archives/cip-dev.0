Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70765C77B7D
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 11:18:36 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.43])
 by mx.groups.io with SMTP id smtpd.web10.14515.1684408711376886404
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 May 2023 04:18:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DZzK3veE;
 spf=pass (domain: siemens.com, ip: 40.107.7.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwP0tfWmYEjJPqU9QSbkUr7Fh/AtHs5aFpQI4HtDstOy/U3gFxFJD1GfhQU4/P7pTnDDBtiYrsNEy7wbriu9IHT75LKXRYegEmQaWma4DTK2/1uIce1sddoxM04jmwzwNR77ZOskIIG7cV2Vc7mIkccRNFOgRDM8SRg3gpb1EFuws0T6aGM8OcIHNxSbOVgStw20cgksj8LuSk4NCRBgyMTZtx/usRRlbtcCuCUGv0hN+X4ybVs9Gfpobmd3x7zLsgUBgg+hNBMdboUc85m6aa79tSMhfop2JKQNM0K5CuVNlFFm436KjLZFwops+3JZsEpineDumE43l5BAXGLoHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYPl2iHWFK6g05t4VDFXyeUcAIQCja78UHqDIbAJAWY=;
 b=fDvJu8vBf5/ytirzzCpIWsqi6WpJE0nL23fK1k703bFIRaQAR7ZDK1zZR9mdc2iw557FwuNp5L1WGowcDrMVB4sZqsJFQIvJ37omj2nJU97K+Gl4igH3KkLvhMYOvC6Knq0opyLawPueaXjaiUdOULhrOYaKRmLZRvTbR4RLp/kI3S+Vex+1KC0IxpbARB2ZUzQ081cHS6z8GN9oXAsYVW21HE3ptIu0jsxIyQyhsXpPSxFXjt9J2eCy53z6n9zgqRebyX9pCI8r1Da+zJ9glKl4U+wfAtwT5t9S9Kx9Ly/V/s9vDGPQPo3KosXoouk6JkH9qS6cddSP/mHN+4Rshw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYPl2iHWFK6g05t4VDFXyeUcAIQCja78UHqDIbAJAWY=;
 b=DZzK3veEAxNngb7gA1i9zYjYePNLdfGxezuDG93nLBqnYfzosgXUwd15UkxNPKF9FfuIzE1cXKh1cCy79H64gZPLi19v3LOiMeD7/c6brnWqQMh6jIbVpfUYjYkZPR+CGYctMbct1oLOzOxhLY12/DMW+41oFBTjDhjAZ3FHbxMDS6/TSBDTq5moT/CQsa/BiN9gE2eL6eL+2tIKmD/AoNkfNG4167rA8E8apsVkbyHcdpSof64HJhv0/mV8q7Z+/mwZWflFGCp/X35WnrDbpgVAAbt9kI3LDA33Ni+woh0KgwEvwCqEaplWYQ99XcwSJ2vwVXoPT3/RnOUbNOT8jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5363.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Thu, 18 May
 2023 11:18:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6411.018; Thu, 18 May 2023
 11:18:28 +0000
Message-ID: <54d7c225-2a38-257a-c68a-0a1fa20b26fc@siemens.com>
Date: Thu, 18 May 2023 13:18:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 426922d2-2631-4482-cd1f-08db57919a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sOzh16HnJ+wjPA1l9UmOtYb5F27f+8ojc+5F1JQFiIodn6OPxFOraABWY/DTXhM7pGVMKXw6qM29i896i3XcCyVIenPlkzJgpn8Tvt8az2eqIRkhVvuxk0sqkMZTRCf5bX1eIU/nj8d5OUsPH5LDEyMjcqft6d/P0zQfJKI9/AZdIhGdZfNzomcYzw6RFOxaRBHOAwF/agDXfQQJAecHaD9As8zfVGoR/n4Me/QyHR+UX8OkFb3gu3fTNi6ePNX1gHJeMXUdX+Q96B5X9xSGsSTwLQfArzLk3SnnuAVEMRRORVlP4LU1r1bpog4FJABho8fAOPBTGUs+gd1giq8GX5htGCQuOXTn90+kjVJckd/5Q8yv08ZB13XLHYwYf/7XTRYXtnsnaWe6kz7bi15eVdKfHZxDWFwe3BNnb1mxaiggdAY/96fc7gQ5gLerpM3Q+ub8vOFjBygye4r6pbB+uCpTVrhFdodkmsaFRgeBKRXIaokKj2oDNYnukTo+MpsYdf6HdxgLeHKjischwE6uqMpU4t1NmZTmsGfssqxVOkhA25ZH0+V7SCUyrCslDYbrgLCwBrPiiWADlnaKrvSavMxXqDxMfD4L9/ZUizOuLkOTOorWfrOygYrG3aI00iwnnrwpeVR69BeCpoGLq5oWlQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(451199021)(316002)(31686004)(8676002)(31696002)(86362001)(66556008)(66476007)(66946007)(44832011)(6916009)(8936002)(38100700002)(4744005)(2906002)(82960400001)(41300700001)(478600001)(5660300002)(6486002)(2616005)(966005)(36756003)(6512007)(26005)(6506007)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFI3V01HTzRqck9aWTVZbGlJWW5TV2JxeEVuazZnMUpUcmdWRHYvMGZrVWVL?=
 =?utf-8?B?bTRjTlQvSGdIeWJHL01lSFdGL2lxMjRKUFRwbWsrcTVyOHhENnV3M0gwTnRn?=
 =?utf-8?B?YVZzRXRqaUI1WUZmMEpJUjNPSFZuakptN2hEZnVjSnN0UnhQdVhvdjMwcHd3?=
 =?utf-8?B?czRZQkYzOTZXWGMvcjhXWnBNRHpKTVA4UkpmV1lEV205SXZSV2hZRHhWeGI5?=
 =?utf-8?B?em1lcjBYNUZzSDZIQ2E2V3hhZ1BqSy9VN2xFclJ2QUxXTm96cWJEeW5mU2V3?=
 =?utf-8?B?RmIycUNUb3ZiVUxBVjZLbVJqM0Fra05KODJMKzlQOHB6amw1QllTSjNBT0h2?=
 =?utf-8?B?T0FyN2owc09oUEhxakY3UnRWOTVKVWJoUTVEYm9WKy9HcVZwM1phakhtaWV4?=
 =?utf-8?B?V0JwVndZQklCK1A4dnhiNEcxd0o5OTJZaHZHcWlmMEFuRGk3L0pxU1ZMdDU2?=
 =?utf-8?B?ZUhWRE9DcHpMS21PUCtCcXFXeEpTbW1tQlBjOWIzQWF6blg0UnN6c0F3SHZI?=
 =?utf-8?B?ZDVYNEJMYlBMVmJ6b0RUNEtrZG03NGl4SG5COVd4OWVpNWs4TW1jNFYwU25H?=
 =?utf-8?B?S0d0VFd1NUZjMGtWcFgwRHoyOEI0TkVFT28yWktnNDBwa01xN0c3djNLaUdX?=
 =?utf-8?B?TERZQWtmdVJEL3hwWWIwamVrQnF4VnE5NTZJb1ZJSURpbDNrNlFiQWwzVDFa?=
 =?utf-8?B?T3VQRWdSaEt1L0RuUDdqTVhVZURnUmN1Ry9VZTl2aTc5VjRsb2d3aVltU3hE?=
 =?utf-8?B?ZU91N2xwTE1SM0ZVNzVqNTFPTW5vQ1d6M0gwZndGazFTN0xZSTRtMnNhVHYr?=
 =?utf-8?B?Z2ovaWxkNWlRTEFXbmR2OGdodEphSHlZSHJzTUVHdHU3NUNubm1Pak1sV2x2?=
 =?utf-8?B?d0xRQ21wakJSclpyQXhxNTJLUW5hMkkyTFo2ZnlzR3N2UXlMYjM4WEN1eUx3?=
 =?utf-8?B?VkdZNGJXcHUzcTY0cFJxV21hZjBmUHYwQk1BL1l5SDhWREZCc0JxcEdscEZL?=
 =?utf-8?B?dUdhSFdxZHcyOGp2Wnd1VGdXc0hwUTgwV2krWFZadXlqSkVxMVJmVWpBMGdG?=
 =?utf-8?B?Z0JjbHdyalcwdzl2cTJ3VzRYNGFhdjNCa3ZIcmNVTVpYcndiSjkvVVdCWXZR?=
 =?utf-8?B?SDdyb3o2c05lZ2QwQWszNnBKQkZXQW94eTNNT2p5VjVJTVFyZHBIRnFOd1VY?=
 =?utf-8?B?VnRhUUNOaXFPeXVCY2dMR3lsQ2xWK3NpeVBsM210aS9WckJCaUhvY1ExZ0JT?=
 =?utf-8?B?UElyMXNreUhORlEzNHJpQjZvRkwyRXd4bi9Yb3Vlc3AyS0dYanVrZ05MWTRB?=
 =?utf-8?B?Qm9McXUzcGNoK1B1T3BQbU8wdlJYa2UvVTV3ZVRUZFNHRXM4L2tGWGJ3MjRF?=
 =?utf-8?B?Nitva0dlZXBPN1huTXI1ekNoaEZsK0s1TkQ0Z0NZc2RLVitjM2Q3clM3OVhV?=
 =?utf-8?B?V1ZEQ0V6dEdMdmszNlRJeTJpM2p2Y09COGp0WTVqM293MVZGaTRRc0Fjc1ZD?=
 =?utf-8?B?clk0MWhiUUtBMGZqeXVUUnhFK1ZFcnRnVEN6Wm91VFZUQ3FneHBvaEZHczN3?=
 =?utf-8?B?RWYyMjFoeGFYOW9LbWhwdUJMZDVvdkRCRTNZeENLbGs4ZUxKQlliU01Mczdx?=
 =?utf-8?B?RTJjRG9ZdmJUMUIxcnV6S2NpTWtTTkNwRWMvc0JpdG1Tb00xRWNOdldjeE5B?=
 =?utf-8?B?WVJWdmtrZjhIWWxISzQ5M08wZXo4VHVsaXNsdVpzWENsTXBrOENOQnJDL2ow?=
 =?utf-8?B?aFhRNW1yUUF2eDYxRW5WMVhlZ21LM0p4NXBrUjF2bUFBUExEYTAxSGxMYUNh?=
 =?utf-8?B?STNJKytaTER6Q3RGaHZSeGV4MFNXclNheFplb0JsSGE5UCtyNDUzL2NxSFJh?=
 =?utf-8?B?emVzMDhFLzdwUzcxZi9XaUJNY1FCMXZjOEszOTErbjFRZHVkRi9tWXp5VEcy?=
 =?utf-8?B?cEtMYzNVVXE5MmxjY3hVanZXSUdUNE1MdW5zMWlYL29oZlUwNEMramVCM3BE?=
 =?utf-8?B?SVN0Y3l1OVBwRldEa1k0MGk5aytxUE1JZlBhTitYcm9aK1pFV0lOVHN6UGRl?=
 =?utf-8?B?M2dZRTlMRUJkVUVEQUNWYzY4RFU3aHBKTUxUc3pmNEJMeHNkUUlQSlR1cmRu?=
 =?utf-8?B?VHhVa0ZFNGE0bFl2V3pxdHBONkhBSDZXUTZSc3BiamlxQldPN296dkxUOFRy?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 426922d2-2631-4482-cd1f-08db57919a98
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 11:18:28.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qzG1cwYBlKUdoyig9VNAERhGr4CYY4QR+r4c9xS6Y1c6BbWMnOgQlqRgq2VjJ/OV0q+BWjLcV+RHtUs84n3PpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5363
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 11:18:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11514

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=5&day=18&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/05/cip.2023-05-11-12.03.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
* Kernel testing
* AOB

Jan

