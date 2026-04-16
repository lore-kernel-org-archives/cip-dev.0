Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB5F433E5
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 05:29:38 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6807.1776317377149623678
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 22:29:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vxT9dPVy;
 spf=pass (domain: siemens.com, ip: 40.107.159.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7nY5UmqWFJ2/+0KM1wXCZEEFoxRbcCkmNb3i7SExw8INeUXqaCxNZkIpPFqTfGFqBFopueKTtXFzhKD0q/rFUc73cT7ZmaCCXz7YCrFoGz2v8SzMMq4VkdejFDN/cx9GbcB8E62hE+rXxYqvSwiIar9AGzFgMObo2ijgVlM3jVhqINc6tcQilyZV8pVRpzfws+d/vY4qLc3mZ60wmqnHYix0OHd8hS89hUnWETFG/Qb+7uge4EOdYSnqK/PZWlTuBk1KiYEkAV5Hzine/Sq9/vPQIRzk8j/bjs1mGY6mZ9v4CY5/edaZ5tWz5Ip+m9XjE41m+KRl9LdxowsJY79fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YrRhN/aKmaTJy5aYDKqhHlXh9FuyjZXloT12Rh62V4=;
 b=QTr4YMgtN5f4jvPYFJVBEQEC+9jyLb/tYsgD20AgmkaOQDhsSWWhCFdyaZtVMlCd//abiuhlXc+hA4d2ItZnfGYjZSAHH7BADTV6kltGuMFscWdvtca5tISdG5RqkhCLNMqcPva/jB66QZUo9hsgc9voUXj/h6eIVfKKAT864A/I8wTfWHewA7Wr6/5sfFKzlDe0lXC4BHhtNSvUYQH4Xj8g1MA+i7b26lXoeSB+9JMrUWyPBfeyEEG1pfPVsvMRRUMYu1mGktOg4qsfXGm20CdEHI9h94upo16jxRcVohtTyMEgmzUrahilam+6GEKktLuWxdYjPzzhzRP9eCEsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YrRhN/aKmaTJy5aYDKqhHlXh9FuyjZXloT12Rh62V4=;
 b=vxT9dPVyoP++NzsxXbu5rhJgjFyyBczHXnoFd2OtFxlRoSY5Z73K5qkAROr84xglFttp05EmYgDWlMddkG1i/mWaoIY3xZu3lWIbH76+Mmv/uc0bzkRaLdwEYgsVDWa0rQ3FiIfnUeSy36UBdE15SiC0oSjlfzdTwKQidaDplWX8ppmrrpJ79XjpdZl9qYkmRPPzG88XLSJoDkBZ88BpZsC9CaBw82Rx50jzcW7ySAZ1uuirfXMryCJ6OGvnme9INhPcWJCz5FJTvA1T4P8HchWOT49jqJ60AIGtqqpw/ne9Wz/DnUHUhn5Kh0XHWUhqS9+9+gl3PVDpzQaqjT1/Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AMDPR10MB9504.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:73c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 05:29:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9769.046; Thu, 16 Apr 2026
 05:29:29 +0000
Message-ID: <5c3575cd-85b9-4fc3-83e7-3e33bf8c059a@siemens.com>
Date: Thu, 16 Apr 2026 07:29:27 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AMDPR10MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: a0363484-0af9-46af-572e-08de9b792176
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	u8ryaLmZGQDGOOFNKo1laT62nbkOUJwLXe5IvO2E7f5zumOCC2yM0F3kT3TseKb7+mh3HYEXuZ8BUkWplj1tLaOkMvK/Kbjo/sjPeH9bTU0MMj2Vx1sXDI51KyFySj2+JlyO/DuU0Hn2VcPcfR/M18jvcQz5WEwoj23/a2AJgOjnXgcgx9NOdNCVyqPxL64pE2gmfKPpsx/NrF+KUmIzuQYdbPXeOhReMBWng10ywWMe8LQ9fqVODwW5rQF89BNoVC9V3dP2YHoJMo9A5f1NY9a2no+5hJ8rvUxOrPeQcinYBimvcAcE6BjBk9yn4E4C6LX7MJyoTf1+V5OfGR+HU1p74JeRVd1iwWaR/bjs51st10nqlEKez/VS4fHdgeqWPXw9fD3Ha2zNfKT9epcQkHlF/aHaasxlnfbCNtaSg8Gu4Zr1B0vgUYk0kdYAkx2g+wSjLL0uILWLOqdYmotMWupTL07+kZ5nWz94IZsLW/05KE4lHFyOeIEnCDMBM9t59Vj21vEJz+JgXjYnUysQEs+qTwhhvdS/3YbxjhbDATp1sWAAsu8bRbnbm67r+HdufXBwmQoGj7J+su/ODEHGCdpyv8BZA0bK5IChjz+8rUcRNXuAmJJyjghlj1iNuj3jEsrieLKX1UiMbR6JzThkgRUDyhwrK+g+YFXR8MPwpN0R+3BgpYr3f/gPvKHDhFm9
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1QyckhGakNwTmZWTEVCbWZlV0UwNkVmWHJnV0FqNXZBTVJkd1pqSEpUZVJG?=
 =?utf-8?B?RjRxVlpuSWxQUjY0TkkzTTluY0hDUmE0SDkwYUNyQXdpQ2M0S1IvWE9jdVR3?=
 =?utf-8?B?YmFYN0V0UDB0Vjc2emFPcGRrdU1GcFBWeUJCSndyQWtJNGFZTHNWV3BKc2lh?=
 =?utf-8?B?OEE0ZmhrSEo2c0J3UWcxN2VyR0hKNDlLR3lhT1BNUFpENGxCUDNIWUhybjFD?=
 =?utf-8?B?ZEFPWnhJYmZGUTYyOEhVbGlnUXl5VmppOHVCTEFiUDdaYkVXTzlzTkt0aysy?=
 =?utf-8?B?Qk5STExYT3lYUlVYZVVPVldmQU9RQWVpT1hqNEpTS3J0SWNGWlpTbHhMSENv?=
 =?utf-8?B?QldDZTlMcGFhb0wwbnRDaG1vU3hPYTVuQWpHaC85ZCtIS00yQk0wWlpER2Jx?=
 =?utf-8?B?VXNUR0NHQ3VEL1JRUHdhRGVXTHcvNFh1UnVTdkRmdnRMNjFUcHlwcm5PQXBa?=
 =?utf-8?B?QkVHK1I2YXVINU9UQ2lzcElDeTRJWU1INVRtMzE1eFg5RlZRU3JZQnFrM1k4?=
 =?utf-8?B?ZUVZeldlUHRzZm10V21VcGN0Z1RjUGZpT25nakdFZ3lxN29ZOStZMVJBU0R2?=
 =?utf-8?B?ckt5eDh4T3FDQkdYaFF3c1I3MzNsVnYzR0FRQzRCSHpCUFI0TFA3OGNzVFhh?=
 =?utf-8?B?cXRHdlkyWHBSRXdYQlQ1b2k1M3NJMkpOS2dMN3JVbWRkLzN5QUhqY1hwVCtK?=
 =?utf-8?B?ODgyNElxR3lvNVlGeDZDRFZwTm9nZVM4RndxakhZYlNkL2xmK25NOGxaUGJF?=
 =?utf-8?B?S0NpRFBxT3hBbUNxTWtsWDlLaU9TbFFLc0JLQ2wvSlFYVUJacXBUYkEwS3dX?=
 =?utf-8?B?b1k1akRNcXFaMkZ0c1ZENjBQVE94N3NOL0tsQnlBcHQ2QXM3VElGbW1Hdnh3?=
 =?utf-8?B?bjdHZG02cnh1Sjhqa04xNDhVT2xDQmZnSkdianpNVSs2U3FxT1k5MjBMdkZ1?=
 =?utf-8?B?dFdwVWIxd0l0Z3haSW0zamo0QzY2YnFMZW1NaXlrZFQyc2JRTWxaTW9HeVdF?=
 =?utf-8?B?c1hKUzBpMDFtODlPZTBSMlp1ZElvLzF6b1dDc2lYa1pISHgwUUwzYVhweWhz?=
 =?utf-8?B?OVc3RHVMdlpJV3gxbUtoMzVxZ3ZIZXFVdGJjTU52ZWVpT0RyandIbDQ3aXRx?=
 =?utf-8?B?Z0plWVVYNklYYjN1OE1LY2VCUjVKMnhoMjFETmlGRTA2UkRQWllXQ0d3RjJh?=
 =?utf-8?B?Y1o5a0FORC9wejZFM0JkNGNVaXloSk9XL2Q4RE96MEk2eU9QaG5Lajc1TUNm?=
 =?utf-8?B?cVZobGFaMEpVL3JaTU1QQm1GU1lML1IweEdvenJMbUFFS2RTMlNSb3lwODEx?=
 =?utf-8?B?VU1XYmxuZW94ZE8rdEoyd2RGQ01FUjhhbEVpNU8yaXdYSkF2T1BQNGVmN2xo?=
 =?utf-8?B?UVp0dGgwbm9CRnVkQnlQMlRFc3RmUU41NzRoL3l1T2FueEdzV0YxbVdHdGtQ?=
 =?utf-8?B?UFdIZlpKS0NZak1RRXZhV1V4NzQ0Q3Q1b2J3UDhBRTBLV1Q2dGkyVk56L3NI?=
 =?utf-8?B?dUVWVGRHVTNEaFZjRW9rUXJaeWdTSDAvOFhLbE92YVZlZUZsZXptVEt6eXpS?=
 =?utf-8?B?SG1rLzVNVzBXY1pQTWhxdWt1UUd1WStzVnpmYjBVa0pTaDZpcGlaMVBZRURq?=
 =?utf-8?B?LzVLdi82SnpsUXoyRktvNDE2UktYV3MwMDJZaElFM1owbWs3RGsxd0hqNVdj?=
 =?utf-8?B?VW1ZeWU1OTdxQXRDY2FHVDFKTEk5Skp2a1BDb3BNNi9jUWcyZFhnS2V6dEtv?=
 =?utf-8?B?dWxQRmlGdTdLZlhMcUh1S21wakR1U2xtdVlIdHZCYmxrWS9sV0JJbTdSZ2lv?=
 =?utf-8?B?bTNrV1NTaE80OWwyMVVoeWtmcFVGMGh4K09RY3JZOHVXeng0Q21BZzF5aGhm?=
 =?utf-8?B?eXZ5L2o1dEwyWHdlcGpzcURCOEJrQ3RDcUg4dVRsbUJnYlpHRWNyOWFJY2Q1?=
 =?utf-8?B?eGp1cDg5MU1DdXl3QzZhMnZKSlVqbFc3WWRSWFN2K1UxcjRndWhFcm1UOGta?=
 =?utf-8?B?NkxubDlqS29ma2xnanVuTmVKSXNNNFRxbTAxVXFSclJ5NnkzVWI5cHM2TjVI?=
 =?utf-8?B?YjJKcklOWDFBSXR3RVJiMUFhWXExWXlWNkpDMzJkLzdrNDREdlhaUVlIRzRN?=
 =?utf-8?B?bVNySFBXSG9tK0JaV0EyVTFEd24xcjRKNldLVzdsNHFiVkNEcFBqaElHVTlU?=
 =?utf-8?B?NFBLZzJ0b0phazRHYjFUWUQvMktrVWVIcno1NVZzZ2NFT240NzloNWxGbE1L?=
 =?utf-8?B?MnE0M055NTArTWl6cStMM081citNUmNWaGo3TTNaeVR1OThMRkhObm41RU9S?=
 =?utf-8?B?K3JhN2xmbC8wRXNWN0FpQjlackRIQnMrZlVKeVUzanBqV0JaZkVKdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0363484-0af9-46af-572e-08de9b792176
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 05:29:29.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dH6o/uZWjgzI65Cu48+R/+qI+bhUhd/7axB+p2OEcDangbYcunSToBjzs1KrfaDo0762CLTXwogzBLVbD2JriQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR10MB9504
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 05:29:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22735

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=4&day=16&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/04/cip.2026-04-09-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Apr 16 05:28:41 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Mar 11 03:13:57 AM UTC 2026
  limit date: Fri Apr 10 03:13:57 AM UTC 2026
  Status: *Late*
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Mar 16 09:03:44 AM UTC 2026
  limit date: Fri May 15 09:03:44 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Sun Apr 12 05:58:25 AM UTC 2026
  limit date: Tue May 12 05:58:25 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Thu Apr  9 08:04:37 AM UTC 2026
  limit date: Mon Jun  8 08:04:37 AM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon Apr 13 07:54:47 AM UTC 2026
  limit date: Wed May 13 07:54:47 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Mar 14 07:04:13 PM UTC 2026
  limit date: Wed May 13 07:04:13 PM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Sun Mar 29 11:55:46 PM UTC 2026
  limit date: Tue Apr 28 11:55:46 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Mon Apr 13 11:43:31 AM UTC 2026
  limit date: Fri Jun 12 11:43:31 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Apr 10 06:29:21 AM UTC 2026
  limit date: Sat Apr 25 06:29:21 AM UTC 2026
  Status: On track

