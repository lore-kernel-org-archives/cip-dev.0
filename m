Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331AFCCD1BC
	for <webhook@archiver.kernel.org>; Thu, 23 Oct 2025 06:56:40 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.8])
 by mx.groups.io with SMTP id smtpd.web10.14328.1761202598158489140
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Oct 2025 23:56:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MefcLgxR;
 spf=pass (domain: siemens.com, ip: 40.107.130.8, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k71i1kH6z7rD1w+pTu1kOBx0B5gfR6+UCC/vQqbQhiUyljtT+DLUEprrCxB0RmfGV/r37Xx5+ltitqeIMV/KmT2VL7fpwzo8WO02gjfB3/GVNHbLZydRfglsKiW8RkRvY8QraL1l4I634kekt9XEvLcsKzV3Kw/XYq5Itp3UpfeZwsRhSLIMwXl4DxNGtjgjx6p0X4rQF+JICOFyUPPrNgTllnTW+jZRshpK4jAoB7n6YAa5JJfUykeKzaZF09oYKdVuCww1UgO8EDa8/muds3Dg/e8+Ns17VNIPvXiedTEnrNnJqtWnfMu16Xuu2d1x5KZ+1HtPIDqCMSk5Yg4S/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8YpKYn23aYn7OJNhlMtsenVKtL2itLpoI7DtWL7KIE=;
 b=qCdRtHx6HEuohedGWiK75tZ3ekjH9CsC+F69JhJ1sGbcZNZHg9Nv86/uF+BAgMb2GEzDMGQCjBH2b+14AgxdGN1+0mcinSx9+PSxd6W/+Y1t9Ad3EAC7mwVrAp7eM/L6JUTXCkrfUgDEcqta+JTWhZ0Sj3S391WqAcVpbrEWBLkTHkeWy/ypNXjt4YH1BxVMkdzNt0YOYkalmCJ0D45HawsAkmXL6mQOZoRO6C+YX4CIVOe4MtqB3AATQjNgAGopuxxAfpOXkuIIV3xlj4SGy/3ZQfCAe6IPvBHlswudInm2IsPqb5Cljn0376X3YtF8t5nmgrUrd3lO4m1RFk/ooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8YpKYn23aYn7OJNhlMtsenVKtL2itLpoI7DtWL7KIE=;
 b=MefcLgxRgWrqcG5nYwo1SF9XQI708kz7Cjtd6ZbhOuqQCkvLjIgn20GvXFG8OI59JTBkwsSQSa3l93o/aPNX/zLpplJ8lGRI0ukVlqB84xkMO4sMaBl0+VPz4EBEf3mz6Oj5/NwmxOVejgr8fJvuhKEaKSW5VJs2Cd+AwnkHNMJrm0XpVUhn6PzutyGwtKi7oOnXkQWfDv01sdBedXwjIgqLVHBA0EFSxRj3bDnjYnLsLAf02QHinpXkKXcHeyIOM1YNRF5ZMjqvqIRXku/AKT+2FmJGVDr+DwXif5NtNcPguciCphFSxmt1+HtfQr5AbKR0zhrcxutvZgiSQhTWgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:569::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 06:56:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 06:56:34 +0000
Message-ID: <24f5064a-d7c0-43b2-b2cc-a297fb405256@siemens.com>
Date: Thu, 23 Oct 2025 08:56:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: 055be602-e5ed-4b02-a78c-08de12014d88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OU90UFY1R1J3b3NDdjhiWUg2UEZqVFFTQUFwQlVjNkhFbFluazk4LzVaKzQx?=
 =?utf-8?B?eWlWU2NTOFlFVlFXakR3U3NTY2pDODVPU1ZvOUJFeGtQdkoyY0p0OUFsMVVm?=
 =?utf-8?B?dUppNzZCelhWTk1RYnk0Sm5FQWo1aVJtYUxMRVZ6MHR0V1JKL3BBa25Eb2dM?=
 =?utf-8?B?emxoVVFDZ2JaQ20rUTZLK3lsMXN1NEozc3EwTHV1eExkclEvdjBTMTc0dDh1?=
 =?utf-8?B?dzRaL3VqeXliUXZ3NE9DZ1NNNGNOeXF1OHVQRFpmMHduZE9NOFZpcHAzNGlD?=
 =?utf-8?B?SEh2Tms1MG9Xb1hGbEM0c2p3RFZGMnY4cW13WVpBQ0NqV1JWekFrQ0pMTFVq?=
 =?utf-8?B?UkEyOUM1dXpSdGFUbndvN2xiTkg0cWx5MEdIOWN6RStGZlZ3WFhoYUtWRmpo?=
 =?utf-8?B?MFVCOW5wUjFyWVRML3BydkVjc3lRbUxMcDRjV0oyeDQ5RWlsMnBnaGx1QTJp?=
 =?utf-8?B?VGVPM3IvRkw2OEc1ZFMwM21EQXk1K3FoU3c1emdHdEYyMUJsb2xmeU81V3Rj?=
 =?utf-8?B?ZlFsenp4QVJoY3RXd1p2VFNRVzBLMER5U2s3ZWVLcWp1alZ0Mmh6VjR5Umxy?=
 =?utf-8?B?akxsbFE3b2NSdjZVZytpWUlUK2s3RGhjK1d0eFNqTkh3VFpwdW15OE9GMDZr?=
 =?utf-8?B?REdzaE1GaktER1Y5N09WZWxQZEVjdnVocmp5Ny96R2tHTVBqVnhxVkpMSEZQ?=
 =?utf-8?B?UVhkeVBkeDFmRENIRjNBZTVvcWU5S0ExblNFTCtBWmhRa0VhbGhGUVZaNGdM?=
 =?utf-8?B?Y1hReEZzMW5oY2ZKUmwyUTk4dUUxRFVCdE9xWDQ0M2JkS0UwR05yTDZNSEFR?=
 =?utf-8?B?cG9sd2pBNG9MK0l3ZXFBRnVsSmo2UFlKcmxGeVFlM3Mydk1rdjdUcUpudFBt?=
 =?utf-8?B?eW1nMXR5UElmaGtiMUdOZ0VyQWhCMFdNZ0ZQYXAzakY0KzVFdk1UOUFmUkxk?=
 =?utf-8?B?WTBEaU5wdkNJR01MenR5cDRZMitsRU5FRUZYYWJRT09pY2s3S0x2NUVtaFZQ?=
 =?utf-8?B?cXVsUlc5UXYvK2tHV3pyV2YvRjBqSDVmZ0llclgyR3JkRmtrcTVacER5alZk?=
 =?utf-8?B?dUo0VlZ2ZlUyQ3NUaFIyZUNGWUZ4UFNvU3dtdExiSTVtMUs1VERhWG1Lb0Y0?=
 =?utf-8?B?WjZ5djFjWmlYRXl6Ym1zYkRoNzNsdWcrU2thb1lLN0JBOHpPazNkZ0dJYU9m?=
 =?utf-8?B?NU1VdElPRnlRa05xb29md0krS21zKzh2Ky9LWm9mNUtTeFBpaEo4dW1jZzhL?=
 =?utf-8?B?V0NqUTI4Q0NlYmJoT0ZTV0xsanplUHlKREFqdWtvLzYvVENZTUpydTRBc1Z6?=
 =?utf-8?B?WFNmdG5GTXV6aDhSLzBTMlRPZys1NTNnRTY5TWxqR3dsT1BTY1NqSFBwdXYz?=
 =?utf-8?B?SEVoQ0hhR0wrc0NXS0dvc21hS3pRR2VkREpUUGthMXZQNmJWOGxmaFlXV1FN?=
 =?utf-8?B?WG1MV1VnOXZHbFdtODE5cVRUL0ZFSloxZ2RQci9NcDExcU51QWlyY2dxRUYv?=
 =?utf-8?B?c1g0ZVJIQmhwRG9Mc3JLdEJyaDFNak5tWmlYRGNwR3VDd2hmZjdVbmY0YXVD?=
 =?utf-8?B?dzlFaUZXVWFTVGxlVUZtZ1FqdTJmYktkTi80NjI3ZzRvK0J3UUN2R2FNeGJS?=
 =?utf-8?B?N2dEVlVPZXE1elpmVTRMVXhtbEpLM1ZpMVdHcnEvR29hTjRranZWeXdaTXF3?=
 =?utf-8?B?dlk2U0pSa3hxQ1lhMUdRWDNtenhnK3g1V1FaOGlXaVVTZ0YrTEpMN3k5V2x3?=
 =?utf-8?B?NkI4OWtaRERzemkzKyt5cnNZaDBQeXdrZktaUWRTQVJ1b1ROamwzTU9TWUZ3?=
 =?utf-8?B?M2ZmN1pUdUlOMUh1MWZIaEZadGhxQ1FLb2JWMGtoakoxc3RoeEJrRnpTNWU0?=
 =?utf-8?B?NGNPc3ZhMzlIMlBMMXczVzcwTEN4ekZyMGYrQlgyVithMGc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z0RpOFh6WWRmVHVOZ3JBTUVDNU5GamFQYTBmcjBTamV3ZUNwbDVsVkl6eG01?=
 =?utf-8?B?M2hMTUQyR0svOXNMVDNGa2JzSStpRVdacHNINEpRVmVGODNOYnRGaE9jM1VK?=
 =?utf-8?B?RjhYQXU4dkhOQnIwQ3Z3UGdaR2N0c1BlQ2FWU2hoQUpPK2pNYmt6Zk8zTlNv?=
 =?utf-8?B?aFJRd2RBc1JyWTNnYVpUcElOYU1RQWtZK2tkbE9DQ1dTYk5aLzV2cjNSUzNS?=
 =?utf-8?B?clNkYjc5Z3lTVHB3QjErejI0bHRqWUhlb3FRdFQvQTg2dVczRHRPMGp2VkEr?=
 =?utf-8?B?V28xQUliRXNOZnowaUpHVmIzVkN6SmxKMlYvVmJSckhRd0pIOE5qSkxrcXcv?=
 =?utf-8?B?NkZqcWVDRDZ2OFFKeFhxWExqVmV1ZmU1MnZpYURJQjJQemYwQ3Fzakp6Z290?=
 =?utf-8?B?NGlzRTFrQWQzUkJZaGpQekRtNTduSzUzUUF5WGdmUjNlVGlvOC80YWJPL2tL?=
 =?utf-8?B?Z2hUQmllNjJ5R082OFFONlR0RWpBQ01iOWpZbkl2Z25uOXBMNVZUN2lmSm82?=
 =?utf-8?B?Y3JMWW9QRzRJaUtIK3dkWlJxaGhzNEN2eHNRQnd2NEcxWWErL2NZaVFHZTRt?=
 =?utf-8?B?REVRWGRXVzdDQXBHUDNUR1JxVE1zTEg0RFVqaDE5YnhrQnl0TkxFU09HNUxn?=
 =?utf-8?B?RXRuMWlCQVNTWlJuaDRQRlhLWFhNR1FHaDVJMnlQcDB1bXExMDhuR05WNlh1?=
 =?utf-8?B?SkFBaytGUExnZElDM3hLUVUvSG1jak9rSnphbVA1SS9FTXlXQndzSTRieWNw?=
 =?utf-8?B?M3cwMjVEUXVUam00NWJkRVI0SzR3R0hPa3RuUnpPN3h1c0FBWkFnRlNZdnJB?=
 =?utf-8?B?a2hhc1lqVDNVdHF0dXRHMU5kL25lb09XSU15R2R3NEl2MHAzY2F5b3Bmd0V1?=
 =?utf-8?B?OHZQNnpPQXBHdnZhd3dXeTFOMiszdGU5a3hkclVLUzVvR3pHcUFGK2x3SlRi?=
 =?utf-8?B?VkxzQnFoN25Qck1FcmM2cS9CYW9ySVRiL3dsRTJjcWVOVXREcWpOQ1I1ZTFl?=
 =?utf-8?B?KzJQbjc4N2FhMW1CSTRxYnhYcHErQ1o1M3FTYVdZbzJXa3NzVHNVVjkzcjl3?=
 =?utf-8?B?N0NpcmlaanlJL29CYXMvRklkTWI3WHFQblpra3AxTTIvZy9Pd2pYOVdXWGp4?=
 =?utf-8?B?T0tqa0RiTmlXNmJ4NlNiN3JiNmJLMDNqUEl1ZnR6RGlaQzdWNkRMSEdNOWRH?=
 =?utf-8?B?RXdDOGc5T3lZbjBKQ1N6QlpSYnNUNlBONldpWTRxTkVQbEQrY2tKb2RRQ2lm?=
 =?utf-8?B?WGlXeGhzRGV2V04yYkM0STlNT1A0RnVZVWVDM25LUElQSHFzZ0NVMWdaVzBS?=
 =?utf-8?B?MGJ4RHB5UEVzU3dWSDVNamVPOUtUQnNha2dUT0xya2Q3WU9VWWtnSGNFa1Jp?=
 =?utf-8?B?ZUIzNVJJZXlkRWI5LzFQOVNCMEp6S2g2Sk5JMmtnWlNwUU9nMFdzeDk0RXJa?=
 =?utf-8?B?S3YxOTY3WFQ0UkFTRFNHRmxEbjRERWZYcnR6cUZ6VG9BL0s3K1hxM1Exc01i?=
 =?utf-8?B?UUgvYnMxTXVVRmtWWHg1WFA2aUdjSS85b3E0QUo1L0gvRERjcDEyVitBUGsy?=
 =?utf-8?B?eGpPT2NNU3FjcmZxUmdzVHBOblVPVjduQzJQcUt1YzZVdFBMZ1JtY3RwTjRJ?=
 =?utf-8?B?UnJXMTBjTS9DR1JUWlh2YjlGVVROclRRU3BpQURaMXJEbUVJdVcyd05jbCs4?=
 =?utf-8?B?VlhERXkrdWVCYzg3WnlJZVVDZWExRUJ4Ni83NWYxc1NzYnQ3N3pGZldLQWM1?=
 =?utf-8?B?cU1naUMzVDU5UHorYjdkUnVUY21yRnZyQm03a3dBaDRTbTQ0eFJVU2JEZlA0?=
 =?utf-8?B?ZldKdytEQXAyOG5ndmQ5V0xkbnJ6V1hqUTRmMXd2d21XTzZKK0VGNm5FdFZw?=
 =?utf-8?B?NHdNZ1I1czNhR1hHUE9YSnExWXhibGVkRUZDb29qM1ZQdHV3UTFJdHlxYTdx?=
 =?utf-8?B?RE5ETXBBRG5GVTBTby9oVjByOSs5dTNuTDErQkNxS3psc25oemNwR2liSGpE?=
 =?utf-8?B?RXkrVktRRFB5bU4zZzc4dVpJWkYzL2YxcG9lc1F5anNEQzhnSm1aZ3RjdDNO?=
 =?utf-8?B?Y2J2VlZIcks2MHNBeURJRkxHWEZnNExvN2wzSFIvbWsxOWRJN290Zi9ZcnBO?=
 =?utf-8?Q?NEWFsg7V2QhTeiMhEVM+/0uHd?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055be602-e5ed-4b02-a78c-08de12014d88
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:56:34.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSSaPleDbnVSYkGYJIy0Z+Ox9GLpCDBxva+8YgJOiBZ8+zfjl+EAd0sn2hR8Zylk5EngNysICJUFQyR1b+V5Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8759
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Oct 2025 06:56:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20215

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=10&day=23&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/10/cip.2025-10-16-13.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Oct 23 06:56:15 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Sep 29 02:11:50 PM UTC 2025
  limit date: Wed Oct 29 02:11:50 PM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Sat Sep  6 09:10:31 AM UTC 2025
  limit date: Wed Nov  5 09:10:31 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Oct 20 10:22:11 AM UTC 2025
  limit date: Wed Nov 19 10:22:11 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 23 10:53:07 AM UTC 2025
  limit date: Sat Nov 22 10:53:07 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Oct 15 11:57:26 PM UTC 2025
  limit date: Fri Nov 14 11:57:26 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Sep 12 01:11:18 PM UTC 2025
  limit date: Tue Nov 11 01:11:18 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Thu Oct 16 08:01:41 PM UTC 2025
  limit date: Sat Nov 15 08:01:41 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Fri Oct 17 10:54:36 AM UTC 2025
  limit date: Tue Dec 16 10:54:36 AM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Thu Oct  9 07:01:15 AM UTC 2025
  limit date: Fri Oct 24 07:01:15 AM UTC 2025
  Status: On track

