Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD08CF34A8
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 12:49:13 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.54])
 by mx.groups.io with SMTP id smtpd.web10.10450.1727959743821680191
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Oct 2024 05:49:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=o2T45ab8;
 spf=pass (domain: siemens.com, ip: 40.107.241.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRkF9b80VzTU4l2TUfnqce8IeSh0qU9/Gcz/YnUM1Vhd5+zdTFHT1LjfKKR/2j6hQkw2sdLqrbynoNuq9tLJS6Hs3liRVNhHVT31fAK9bOKzi0M83H/tgzijAgzusbXpwNvj6a/AOtnBUDa8LoVfU34vkWevEr/xhYluo05MIBw7Qh0szjUtsJdHXcyF4BdL1GI3Br2ZR+paaXKqXAjH84iXu153qAQt/70wrk5gDGV3c13QQcEW+u+EN1sCgG8Tjdn6LLpAmEUCSIa8UrL8BMMrTk0eN8nl+O2s7jshg2QvPfZf4+jB3UIL2jUF5hEw5YtJmxRoZFFC/fA5PDYnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSD2NxerPhqiTE+Q9dIZpExKuK/+t+UrX8u3905bG88=;
 b=fkse/MoKL4Nrn8cMkROLnzp32Xfw1JFnMb1n/9LUkYK9idOADrHQX1zhvPLDUy7xWCaWxc3bGdqPHpjB4Kp65QEp8TIBTDCYb1dtZXlVSmf5wELCPrmTL6r7451nK0K0TjKZ3Ntt+Ed8tobYoIdtIui6sVUbNM3hD75dpID1YUaIHsLSp8oQ236gobPykkQEhhy2J4gHN4YFwtsFFeti6fsuQxHNVhMLyVmQJX9WUES9FUBrh0Nhdyhw6zAWPJB/GZN0h9q2herDyC0ZceAXhjy0X635h87kwPddToeLKv6JciSu6I7LINikk7hjuX5j7z8B32PpiUh9ZhXYFyMrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSD2NxerPhqiTE+Q9dIZpExKuK/+t+UrX8u3905bG88=;
 b=o2T45ab8eYtdda9f+4aO2OvCpfVbZ3QEikPuPLDVrWH4hCXcvQ7U7E7uqAsfSoBRxOeYmGE+EjO9sxIQ/bcYa9sgSoOC9KwKxv+HpgbGBQWXKMgd/J4VSK5e2DwQus+6y5L79Gxz26uUY4WROOL7rebo/gGp8fruqvGZU7qDybekhbDTln/DDOzIwzqyIiwvB3/ECi3V/4k/t60dBo4OTMqphRpw1TN+IGAe+jl2c0bYaH9TZ+bmPGiTwG4voH6mBbFezSywz3dKNxAr7YjPriOjmu6sMbqmk0ylmzBw9ByBkGOFm8kYF/tUEndKTPK2TcYfAKzs9bXgVZsoqyK+sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8516.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:560::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9; Thu, 3 Oct
 2024 12:48:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8005.024; Thu, 3 Oct 2024
 12:48:59 +0000
Message-ID: <27d5bcae-7b62-4f5b-b047-8364feb1cd92@siemens.com>
Date: Thu, 3 Oct 2024 14:48:57 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Pavel Machek <pavel@denx.de>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8516:EE_
X-MS-Office365-Filtering-Correlation-Id: b3618b32-4cc6-493a-3b01-08dce3a9c020
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N1ByZzJVUkY0TVQ3cTd6dkpmbklqdHMxdlk2RFk3c2JncUJxeU9yVGVRaUov?=
 =?utf-8?B?U29HUk1VY2lzUnM5NEVLTVZlcDA4eVFnSEx4YitFTWF1ejV4N2V6NHRzUi9Y?=
 =?utf-8?B?R0JYemdkZk95K0JlU25SVnU0SDlzVzl2eGlRcUgyWUZoVWdJSW0xUDkzZ2wz?=
 =?utf-8?B?WVNvODVwMFB1bnpzRVpKS2g4Uk0rVTVialRPWXpTSWhJU3NFbm9IVU52SWhG?=
 =?utf-8?B?MFJLV0dkcVk1cC9vcFpnL1NxbDFkZUFhRnpzT1VVNmE4d2VDbldCaFM5UTZH?=
 =?utf-8?B?ZUJoa2RQeUdNelhGYUR6U21HVHRPZ0N6a1FMNGZKWW9vQ0pxcU82M29MdEFt?=
 =?utf-8?B?M3VvajZSclJQdTJCVVJaWHNPbkdxeXB4NFFTS3Vrckh2RWdPVWw3Y3Vhd1BJ?=
 =?utf-8?B?NDdQSzFkVWIxc2VnM3AyY2lCOTB6NmREMGFaZkZLQUF2dHZnSk10VWdjTFdB?=
 =?utf-8?B?SUFHRzdJS2VQQitqNTgra3phbHk1R3dGN1krcHN3czdDTTdIazNBa2Q0WVYx?=
 =?utf-8?B?aEZxU0lwN1F0eVFvUUljYi9wY0xIUzdVMmRvRHpBMmRtSjVLaDl0b0hmaE9v?=
 =?utf-8?B?K2d6N3RXN0lVTFZLNFRlVXJQRHV1Z3JTeEpUN0tmZFVMZytBQ0VBVlM1Wm1q?=
 =?utf-8?B?ZGRsemtLNUl1K0xubGVNUzR0NW4ydlRKVGdqeXFicXRBcDZRNXlPNDAvb0I3?=
 =?utf-8?B?RXZWV1g2UkNJTmFmZGIxMUdaWjh0NDE3YW1ibDFydTB5dlp5WjlpY1pnR21F?=
 =?utf-8?B?cHJMZ1pyVFdReklXK1RMdWZmbStEd2pSSlFPNGZ3Z2VDd003U2R0VGhNVGZr?=
 =?utf-8?B?QTFIanJyUEc2WGVRT0JNaUIxYjc1WnVEUWU5c2dwMTdYKzlEdSt3c3NrTnFm?=
 =?utf-8?B?KzQyZW56QlVDTUh4SzZFR2dlay96c2ZKOHF3YU5FcTNPd1EvNmg3OFFNdXIz?=
 =?utf-8?B?Z3M4bU4vM3hON3ZsdUZ6N0tSakJKaUNCWGVPdlA3b3B4TDFFWVQ2QXFZY1Y4?=
 =?utf-8?B?ejltV295M0NmdVJGRTRIMWNoZmxJcjk1bjR0TlBaeFZNb2puMGVpOEo0bE82?=
 =?utf-8?B?Z1hmRllqcGVlekVGaVNIV0k4eXNjYnIyNlVMd3F5QjRPalFNVFdyUVhLQ0pq?=
 =?utf-8?B?WWEvSnc4cXdFcGdwVjFJdW1oS1lUTGhIclZYanJZSnVSQ2V1NzFpOE5RSm5o?=
 =?utf-8?B?eS9CVERyQ0hIRVNNU00yaXFldWNTZ092NWtVMGJCUXNUN1VwcGtGYnowb1Fo?=
 =?utf-8?B?TXlLK2ZLNXFZZWRucWJsa2NUNlU5TnVzMW5qamc4Qm9KeVdtcEhKU2Y1TVlM?=
 =?utf-8?B?clRtRklDOTZHMTBZeGJPVlNESEhrbXVjYjQzZDVRcFVLdlpWNlZLMWFJNzZs?=
 =?utf-8?B?VE1LN0hOdXRacmdtZDVHL2paakgyY2JpREtWM1lCcDVWcWJkSHNEY0lzeUUy?=
 =?utf-8?B?TkpkeDVjbjFoR1IvUzBJaWorTVNCamFJaVpPeitzS2hxM0pNZzE0Mm9GQXg2?=
 =?utf-8?B?OGQzS3M4bUUxam9NM1ZlTDB0UTljNDF2ZEM0MHNqT1dXZm1HQ01OMFo1ZjFY?=
 =?utf-8?B?TjUzTXhIRThid0RSenhUdmZwUmRQWGpPTTJIU3ZteWliUjV6enM1OHc0Y3Ro?=
 =?utf-8?Q?pS5LWShn8tOX4HNNNeJuSCMytEiWN+C1OnA67uDNjQb8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RElYWHlteXh2YXFOcHZsd3VIVCsvMkJ3eU9ZZEhSanZtM1BNTkFRNmlOTkVv?=
 =?utf-8?B?Tm5nUWZhKzFhRGJUNDgrY0VhTVpXZ2pqUWtjZXlOdGxaa3FKMkVHQXg1R3ZM?=
 =?utf-8?B?dUZ4S0Qva2xiSStKalZxWU5GOFJmdjRhWWF6MUp6M05KUkg4b09YeWh5Yml4?=
 =?utf-8?B?VVVDSU14d2dvdkZSV1V0cWRsamgzQXBZcGVvU3crbFROR09EdmhPamEzeW91?=
 =?utf-8?B?VVdmMFIzekFMMTZyaE9tRU8wV2ZvWVpSejdJbUNsYS9ZczFEYUJzNndRTmd2?=
 =?utf-8?B?Z2VMSlZucFZtbmdkK3lBRVhrdE9DeHBjU2ZHUU40elJDMEhrM0JCVit3Y2tt?=
 =?utf-8?B?ZXg4MEZEdk94c2ZSY1pVRzZxTlpxSUxLSFFsQ1I4VUI2VndtSzdUcHZOMWVG?=
 =?utf-8?B?UmdVTWNyZ2VXbFFBaWdpcFBtTElOVGREKzA5SzF3cmh0emJ2dXg0akhoS3JO?=
 =?utf-8?B?WUJVRTJ1UWhmTVRETnBBUFNRRGlNNi9DQk91eFBVMHVHSlZKMWV4d2tiVzlV?=
 =?utf-8?B?TUl6b050NTI0Qmt4UDlGYWFBVjJJK3Z3M1RSWVYxMGNJbWEyK0NaeDNQVkxl?=
 =?utf-8?B?SWUvL01QdjJsa2c5WWM3N2hGUjY1Uzd3QlpjOTVEK1orcU1zMEZEcjV6UTNS?=
 =?utf-8?B?VExVdFpIWE02YktFQ0g2L3FLTE51L3ZmSDB2U2czUzZab3JYOFRXQktuYnQz?=
 =?utf-8?B?WmRaNDhWcCtyVVo0aUhPNWhoV1RMMGFLU3BtcVlNd3oyNU9rZVBMT3c0MWhy?=
 =?utf-8?B?bHIzT3pKU1hYQmdEWHdqaDc5R1NmcXdaRXlBUUM5MWJ4OEpnMXJMbEtKYkw2?=
 =?utf-8?B?N2lGYktoYi9UTTFWN3RVK1Y5SDhMOXY1MHRRMEVBMWJ4cXcrYVVMUmc1R3JG?=
 =?utf-8?B?WFl2elRDNjZ4VjhreGxoa21IalIzcFpHejg2UE5wZEU4UHc4anJwYzNRUVF3?=
 =?utf-8?B?ZlRQMnMvZXBndDVYZUxRbWVXbHREZlNpbElZZjJZclZrcHJMbEFkRy9reitv?=
 =?utf-8?B?TTBGeXNKbUhNQTZkY2d0OVBxSEN2VEFrci9TRHgvWk53eWgwaW5tVXUyMFhD?=
 =?utf-8?B?M08xRUNzbG5WSEdRb1FDK0IzZTJlcVcwNVVXanJYYXE5NnkzWlk1NnJZTG5u?=
 =?utf-8?B?ejRmWks4emxkWkw3RGpYYzVuOWoxdUJvQVJGOTFCaDRHUGJaOGc1R2tMMlR6?=
 =?utf-8?B?SGtOTUt0VXN4MWpQcTFxZjh4cWdEcUxYcncvTWNtTTRTN3pDWkF6MllKY2hV?=
 =?utf-8?B?ZzQwN0RNU3Y2L0Q4WW5tVng2ZnhHL1ZYYk1nVjh1ekNxZnFEOGJ3ZnByYnlK?=
 =?utf-8?B?aWxTR1BIWHZzMDdYNDNKS1J5NjJzTGJOdUlsQ1BJTU1xY09uazBySmpxV2xW?=
 =?utf-8?B?dVU4Sk1mb0Zydzg5THJRMU9rcVpwanpmRkp3Rzgvc0ZTMC9lSFV2amd6ak0r?=
 =?utf-8?B?NjhBVEV2OWhOTzc3czVIWWRBUWhnWHNZelN4d3BDd2lSK2ZkQnF1Rk5VY1lS?=
 =?utf-8?B?NmdxWDNkb2g0VEpzZlFCUnV4QXFURlN1UFVya3h0RWNpOENuSkE1VSt0SDMr?=
 =?utf-8?B?b0l3VFBzN2tsOHdKTnZSNFJOa1p4elNUVzNiWU5OSXlnZzBPQ1orNkdiMWo0?=
 =?utf-8?B?R1pMbHhzRnA5WkpFL2ppNUJHb3BjR0hnQUszc3dJOHZNeTlEa2tGcDFZSFpt?=
 =?utf-8?B?L2NCem9aNlpQc2dUTzVBbGQ4VEU2QXdWNERXWmN6eGFCQU5xYXNqVzdVa1FV?=
 =?utf-8?B?RHl2ZTRMcnB5ZHpGd29JQlpBQ0lSMDZvTDJ3M1ZZUlRMU3lQOWM3TEtQM2Z0?=
 =?utf-8?B?aGJ5WDhnanJob1JXNFJjNis1ekZWSFgxeFlQV1BRMnZBQXJmNVlCTVUxa1Rn?=
 =?utf-8?B?RlZ3RFlkci9KS1dxQnVkNURuV3NaaVlPMmNVOU9iblB0ZFhHM3ordmNJb3g1?=
 =?utf-8?B?Vms1dkR2eW8zbDJOck41OHNwQ0haOW9EdlZ4TjVQVDVnTWM4VGxiL2ZrN1lv?=
 =?utf-8?B?WnptNkZ6d3RpSGVITE5vRUViM2NMK2hXS2F6cVN6M2J3V1VtRFB4UTYvQy9C?=
 =?utf-8?B?UTk4NEx5bWZGWW5CVkNvdDlhek1XT1pDcE12Mjd0R1lKZXdDWmpTU3NuSWJG?=
 =?utf-8?Q?pncruBk4uIEhe/bhUiOxlhrfP?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3618b32-4cc6-493a-3b01-08dce3a9c020
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 12:48:59.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihUg9D8Ap/VZtxVgUHYovwqX6KdPmQLShypbdlkPnUyRYIZQUGL6th1gzs8Z7BGoeBclS33AX+AZ9Q+RFckodg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8516
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Oct 2024 12:49:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16992

Hi all,

NOTE: I won't be available as host today. Could someone take over? Sorry 
for the late notice.

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=10&day=3&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/09/cip.2024-09-26-13.01.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Fri Sep  6 01:15:20 PM UTC 2024
  limit date: Sun Oct  6 01:15:20 PM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Sep 30 09:48:28 AM UTC 2024
  limit date: Fri Nov 29 09:48:28 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Sep 24 09:32:37 AM UTC 2024
  limit date: Thu Oct 24 09:32:37 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 24 10:34:04 AM UTC 2024
  limit date: Sat Nov 23 10:34:04 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Sep  6 10:08:05 PM UTC 2024
  limit date: Sun Oct  6 10:08:05 PM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Sep  7 01:56:36 PM UTC 2024
  limit date: Wed Nov  6 01:56:36 PM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Fri Sep 27 09:03:28 AM UTC 2024
  limit date: Sat Oct 12 09:03:28 AM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sat Sep  7 01:00:42 PM UTC 2024
  limit date: Mon Oct  7 01:00:42 PM UTC 2024
  Status: On track

