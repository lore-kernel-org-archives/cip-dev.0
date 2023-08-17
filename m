Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B266C2FC04
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 06:04:47 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.88])
 by mx.groups.io with SMTP id smtpd.web10.181058.1692252278499539528
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 23:04:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZEKxpGaZ;
 spf=pass (domain: siemens.com, ip: 40.107.7.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yx9lbYsLGgW9fmJ/5YnUOqyOqrQ6Qm9y5N1czzeZzvbq0sdTdVeiCezvA22rjfpeupGw1OuY0UKtpQxcGyTiT/QhMUv25b0ThGRbclbeohH6egSk/vnGZArYFu3JAyzFkW0FVCmQukuX4hCAJn/HGW97uVUbRrLpMgNlma6wgMThe15MaAeEwQ+iE4MT2pOI7Ka3xpjnXPkZsrBuLFRI0ia7hoWnAIsRKyJTwb+H/LTLBR2aw5p3DdIreZytSxib/VEo+5PgmQBBBO45ssROVgW4ol6cUMKEgqduPp83oyRbhTriM7IJYLx88EpjQFpvwNz6SKLbXoOQVCkGXmlMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcBZeCqpd2nKmxOequpT8wMzxcEv3J96sXQm5NCHwsQ=;
 b=kafq2gIuHnKsfYz3SEHv+8RKG4UAsMcsHxedmVkHrcBNtsNFXtRTutOwtAq3O24kqKoApyPjDWTQ2RcdcvY7aAuxBeP7vzztlHI33/eAOHCZkvIhxZH4yEll8kiYo5QCJeRSqkYfJN8kY496Gfot9N9FNA4dsYdDJ99KWwOB9CnBikoFvNaEyp5SEOojNNU/U7/nViASPuch+kqd0DD6m9/BZ0cRaPsXIieIh2byiYbIRKuaAt/8J1HJxbRpGMupx94BL6PRt02iinWi39x73XfhKZwAz33CCz3G/Xud4v18yD7cYi7U6etXJvan34bQUkmCK5jbOlfoIRC+WpFd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcBZeCqpd2nKmxOequpT8wMzxcEv3J96sXQm5NCHwsQ=;
 b=ZEKxpGaZFFQlttaip7llhp0Qn8ML113bpoBR6kMGShXAhZqWda8+XKZ5DBGUBKWmLz36wxQL+IcIupjOGImWK9TX1OHIEPe40/XiiwxEJb9gXis0T0KXwkmMpFtu7aNEXtgXY0XVUIcQ50xsfRyRxTTTPb+sT4ICR08biBvx9artjR2VRpBZOde/D9KvSUd32i1bLfyvaBsRdypZ+FjiYwE4qhY/d/DCR2QnKtnhH0wxi6qYhSpFgINoUuGDBHVTFKEer9JbqlKEPH8xUGjT78J6xBRkWGOLF+KpYFGVfhlc4z1JFrptF9pzNTmQTe31OPvJsyAb+G4HvCiYJLjzKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5875.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 06:04:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.029; Thu, 17 Aug 2023
 06:04:34 +0000
Message-ID: <77f53f58-41c1-43f1-9fa1-a1f1e0861925@siemens.com>
Date: Thu, 17 Aug 2023 08:04:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: b21b6228-eb8c-4d9d-ee4a-08db9ee7d44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	LUJouczqcwWg65Ks+DlqU+WmWuA59DQN5FXYiu7hlDtngjUCRT+bhDO1Zn9fh2kxCjFLj+rcCxff6IaQxc0lWaw9il/U++06D8ByKEHR1k9ExPQZa4aP3dbQe0XieFzKTFqEvrll4HNxw0Qu8/y4Zi4icfZ9g7y1MW9osLxO4+M6SB2YmY0/hSgom9ffnSD0b3Dcusx6bm16mzyG8AHgLHWdoDuVIsqEAVI5oWdnDRh6x+OIMhHeWrJgDjjW1VNzDX5pM3Y23uNdJKvW4A3iHB5CYTGYkjw5bfru4jmPCsNxFllLXXKn1MmrGOV98RWZRJxcf5A5lYMHPPg9hx0QuARr3P3YA96E0PRLi/9DeHThweeMJdejS3SYnVjT3A1G4kNw6uRVEMp9gHrIhXNBHQjVM7JQqZDoBBJC06/FFKf0RG4/QcfY6xiTkPLBiV8izu5+BXsl/dU73wAao/K4/W+5L35aVl1Lq5OXlSUbKJvx/FFbuLFZc3w5evrvuF3JIb8fYSkHScwpCXGz04n0/NYGiaZtbnamuWXyEtuQmD3Zi6Lrm8/2xqkXPkXH0qA8KHJtrKzA09jWtnRDJL1jJ1b+Iq4TYhvgZYZW3ZOgnyCYKIRQn98qeHrLG2JKN6mTtambc2njztu5fsKtHE5stQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(316002)(6916009)(66556008)(66946007)(66476007)(31686004)(966005)(5660300002)(41300700001)(44832011)(38100700002)(8936002)(8676002)(82960400001)(26005)(2906002)(4744005)(83380400001)(478600001)(86362001)(6512007)(31696002)(36756003)(6506007)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1R1UDV4V1ZhQ0xlTkRaS3lmRlJQZG1tVnA4bTJLNkVyb3RZR1dVR1JsYnJY?=
 =?utf-8?B?VGVOL3VBYlc5ZU9MRXdDaitvTGloWHB2NkpSbmpORnI5VVhBUGdyYzdDNDhq?=
 =?utf-8?B?akZCdm9tYy9vOE9zTmpmVlJud1VYY3lObno3bERsVUd5c2JPc3M4NHJRaXpz?=
 =?utf-8?B?M1N5VHJZV1JuUlVoSkhHWUIzNzBxTTdqZTFJVm95R1dGSi9BakNEWUI0QkNa?=
 =?utf-8?B?WWJLTVFmcXdiNnhwRWZ5c01xbXFXVjdudSs3T1hjMUtWVGE4NzFXdkViRitZ?=
 =?utf-8?B?Sm81bEdTVzZMN0VROHRISTFacjFxTVFCeWFjMjMwMXN2SjhuQk00UzVWSk94?=
 =?utf-8?B?UGJSRGlDTDYvMmgzNHZMWnNPWm1jZ25neUlWM3NaZEJHOS9hOU83SGtDdnpC?=
 =?utf-8?B?WWU3Qy8zelRqd0Z3L0RZQjlrWDZlL216cHJxSFk1WWpHZjVoVUhLWHZnU1pN?=
 =?utf-8?B?RGxuZG12bkd5RzdoQmY1NXdabTNQTVNna3Fod2xmaE00VnVGeHZ4cXhHOTky?=
 =?utf-8?B?MjlDZkwvRU1wSHF5WUY5QTgraFRrNmw0U1grdS9YYmViWkJLUmRHaGh5WWhF?=
 =?utf-8?B?NlpRTjIvSVNqVndoRERPQTNHemxZZlJVMU4rRXlJZTArdllxZXBJOUFkdXRX?=
 =?utf-8?B?UEI5OVZhaHhZLzlwVlBnd0FEVG5CN093RUFsdUVyWEpadXFHOG1Za3Y0d05t?=
 =?utf-8?B?bGxVWU4yd3lxa0sybU5UQklwV0k1OE1oSUpVblg2NDJ5cERwbThpell5cnBI?=
 =?utf-8?B?MjNPTXQ1bjNWWGRYU0JacjJVL0c3bStEMDhLR2dYZ3B0VXdwZzZjSThYdkdL?=
 =?utf-8?B?WEloRXgxN1lCbW9DVzBHWThDS2gwWUVMV0UzY0duTUk0SEQyMjQyWmE2VnM2?=
 =?utf-8?B?RHJwVE82NFE0b296QTlOLzJsS0dlSUJJUmxZRFdSK1owZEQwNmRLVmREUVdQ?=
 =?utf-8?B?V0l6dDZiY0JJRElJR3pvbFpFV0tna2pWQkNaTkZaVHpuTndwOFFhTytVdGox?=
 =?utf-8?B?QktHQmRKeXZwYWdWZlFuM0dFWVEyZ2tOZk9TREFjQnNmMFBmRGNJa3IrL2pK?=
 =?utf-8?B?eTlnUDFwd0dDQllOSnc1R0xZenh2eXRmYWIrQnQzM05kalJDL0s0VFBabFND?=
 =?utf-8?B?cllYMk0rK3RqdzhUbmE3ckkxNjA3T3Q3M25hVVFDdDhRNTNULzd0VjlOQ1Vz?=
 =?utf-8?B?ZVRUcFBySXlBVEd1RnFBa21DVDFWYmZHL3ZaQkxwYVEvN1VCU0VSVXBxc0JQ?=
 =?utf-8?B?Z2IxVkIvU3VyVFZmRVI0MEpvRnRhS2h1RzhrNnpuTGI0R3pwNzZnUFFUQWFB?=
 =?utf-8?B?Q0oxRWsvbTU4NFR3WGhvcTNGVjNOWEpOK0MrVVlMTlVTdnNmM2g1enNBWm1F?=
 =?utf-8?B?MU9JRFRxRFM2K0ZMLzBKU2FwNnVMc1ZGd3ROeVFoT2k2c2tnUk41UHJoTVcv?=
 =?utf-8?B?bE5jQnJ1eHZmVlE0dlliSU1XazJ6aFlCR09qcXMrc2FPemlCTmNmMzY5dlR1?=
 =?utf-8?B?b3l4QVBoSmRyTjBiQ3M5M2UzN3c2TnNnYUJWck5DL3lOYVNJcUFqWFR0dkh0?=
 =?utf-8?B?UVh2eG9LY2JHdTZ5U2FibzVwUFAzcTRIUEFHbU85d0J0VGpHNmZaajUrbFRi?=
 =?utf-8?B?MzVDL0xIb0x1NUU0Y3JFcnlNTDBGZHpRQ3REbHhBL2I1MVUzd3ZEWnFONGo0?=
 =?utf-8?B?NTVZemk0OHRGbWhOTUdXTWVXclRieERVZmYwaWt6eGhTOEtOb0pPdVJQSlhj?=
 =?utf-8?B?TW0wcWZ3SnJ5d1NEQnh5SXVmc2ZDbnkyWC9DRFRFNEREVTFtQ2lLN2dGdXF3?=
 =?utf-8?B?Ri9DeGpTN3Q2MGhUUnd5RjByd21OdWdpUG10UEdIdm5aZzdlZ1huaUpmbUYx?=
 =?utf-8?B?QXN6a01abFFmNkNNUjZRazY2bFMvVUhocEMrek9Ea1FESTg2NExlNmxDTHZm?=
 =?utf-8?B?Q2pjeHd3ZHhtYk95NUlNaDh3S2F4QVJmRTVRenVkWTNna0RKY0tKUDE0VE04?=
 =?utf-8?B?MnhsaTQxdWlJNVh6N2g1eHp6REpVSUwwTzBlMHlyU20ya2JxWlk4NUZaSmVF?=
 =?utf-8?B?UTdBRkxkQlhZYUlzRjhJUytGY1VBUVRXcEprUVR0OTBid21IbWJxNGVrMFh0?=
 =?utf-8?B?a296U2xBS0lhRFVVVU5DY3VOWmhqc3ZDVFZrOFk4WGJ5dW16OURvODZWaWtP?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21b6228-eb8c-4d9d-ee4a-08db9ee7d44c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 06:04:34.2118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jn15JtW5kB3CFA/xDAMyxEl9erLgVgtHEtSCPqM3zGlmL1fB+zum8eEOkAu115U5tUEcD6ETUJ538IGatrAu4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5875
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 06:04:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12748

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2023&month=8&day=17&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2023/08/cip.2023-08-10-12.02.log.html

* Action items
  1. create kernelci pipeline for buster images (arisut)
  2. draft press release on 6.1 release (jan)
* Kernel maintenance updates
* Kernel release status
  - 4.4
  - 4.19
  - 5.10
  - 6.1
* Kernel testing
* AOB
  - /me needs a substitute next week

Jan

