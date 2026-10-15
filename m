Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807ADCC6B34
	for <webhook@archiver.kernel.org>; Thu, 15 Oct 2026 10:28:48 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.36255.1792060124196527930
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Oct 2026 03:28:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IaoBBg9E;
 spf=pass (domain: siemens.com, ip: 52.101.70.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ny7r8jA5MDPSdNkSwdnu3ZaKkNaCsLIiHAg3Zu2JmDUJ9XvpWvW3GHIOS/Cd7znRToWm0Oz2qF9YV4rBrSlo4rtg8HkbU3FWte8idN7VwBAebdK9o4jmzhV45Od0tlfNU4tyG4pmkkWWDOP0unJw1ZpMkf5iRMzy8V5/p2++o6CA8s4ZoNqGYnXfIloNDFGXUXAqL2XgLU4GQA/fXz5fIpT8fa819urIVEkO0/XpQJ/9ZzZUIZUp1y6pmU+riWcIyvvIIZ0SvrNQ/2Dacg4yMyx3Mddvpcj8Vff8Qpewmi/1ZUXsZDlWY0NsO+O3Je4r25kRWN7r2npzBzpwdnK58Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMB6kzRyrbOXgABtBK52kRlNK6tfAkgjuLfHWqDQrnI=;
 b=vSvmiu3LnCuJyrZhflPtemfFtBmm2doct76EOgQUMWGhhnI9GyRBI9xxPpPWr667GB88+eyDg9R3gP3zqhS/xwRv5SHDdbkrsU/yUVqCEuOTET7AC1Ulr9Ic49N52jVBsw0uesg4K2eKYy3unntukmjbBMKifFjB57EQkLWdUcbxx1MupLFCCUnk3OxtBlRTP39shZpmdK5rTffvFHXQvAVLAcdY3q9nvAiGpORiJNgRWPQ6D4tH9/1moB+Rx0ZStaEF86xw1AOymrzAm5dLYXfhI4WmmFT6C8ieHl4/fxkyI6K+l8mrKGE8ibKpaV1ySPxT803KB65I1qrWzPtQ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMB6kzRyrbOXgABtBK52kRlNK6tfAkgjuLfHWqDQrnI=;
 b=IaoBBg9E2+aLg9zgfWVE49plNKaCDGjxud0G3sIggIYVFAR2cAttWZLipP0B0wm8aBXXCw0xyXN9+w7k/pptCgLcL1bm1vGiZV5R3G2H46HaesBAZnJUkmzNsSMkIcocCvh+0PWImhkpWd3r/uY7hOKPdsi42fux6KLb6LQXHVZ77o+5HsNf7xtLoCPcw+P5Eto7z1EHiKXndn4NkX+bkXVqdRZ4Je3fA2uwi0OAMl5A65W7k3bYReG7yUjeCv3RfWOFPYmtG5l+Yq6VpidhzbBozumXQ7P3Z8ibRf1edg5D5eJxCdwwlzErzbP3OVfIzIupVWt9CGgla8eLGkvl6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB9PR10MB6423.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3d9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 10:28:38 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 10:28:38 +0000
Message-ID: <105c7490-4ea4-41e4-a026-4ecba953ffe9@siemens.com>
Date: Thu, 15 Oct 2026 12:28:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org
References: <76b4f5f4-8e5f-49dd-b5fd-0c35f36a5740@siemens.com>
 <TY7PR01MB148181C7FBC82DCEAF514B697CD9C2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY7PR01MB148181C7FBC82DCEAF514B697CD9C2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::9) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB9PR10MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fa2716-5cf4-4ce2-253d-08df2aa71329
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|261009223027099003|4143699003|11063799006|56012099006|22082099003|6133799003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	jiiuzTuBD6Tp1IWAQ0uIT46hHyTmNsnEF0Qg/E0XoB26jlRmqs+xZevdyhonCLef7KRdBSIk4eOM9NuJXdDk0eJda1EgQ9EoyECH+6MblIMopgBkmVOz02j43uNnpAgzcGxGDsO1o7a2HUaCEeH+AZstoBGRuV9TEJcGur4VcTjBWKLcAH18+0z0A7LGqOKPl74246Hh6j9L5mhOGebXpdYRHV58XyQHvFm/Y4PBJ2ITX2ZCnN2h+K61pfMvY3XHhyRwN6wQNcNG0F8Mr3yVgCSmy1h2Jg7AA23pgflz5wFJ6MnJ/BIgMh0v3MYguZc474ZGx/5afuObxvAEjyF1BQYViqEswPXIUBL5EFcET8x6+zTWQkiDh9IZB4pL0eVpEsgbCEk96dI5CD+KNpNtE6hLNxxxjunIK4rdhYAhzJCseMIHtRGybdWIh0YZ7haEn2KHIpd3VmGwaIuOeQ353EoqYNyF/Y3R2BZin0huVgaxkIXI48TPARHdMbjr2Wp+2lm4AloNmzG4V5K64nRfffTn+ukxTYaFpbHdDjReAeHxmybvGYEEde7rkZEqlZB0oJjv5e9bqpRxXpq5hlmgzXVxolql4VgBK/3K4hljDsU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(261009223027099003)(4143699003)(11063799006)(56012099006)(22082099003)(6133799003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UGJtdnUremhaUzBzMVJIM1pIb05Yc01xTjNMMXk0cHA0YU9DNStJOHFsMlRJ?=
 =?utf-8?B?dzdNbmVKbEpXYlNNUjJiamtvRnc2d25lVTV5RjdvRmZmbXIwcXZGOFFkT0Ja?=
 =?utf-8?B?QW9DL3lJNnBYM1FyektJZ1BnUWs2L1REMVhpMytrWFNpMlhmYUtuZm1yUHl6?=
 =?utf-8?B?UmpaSGZPN2VkWHZsL0ovU3h1bDcxVHAwWElWeDdxSXhOcmtuT08xcVkvK3ln?=
 =?utf-8?B?cUd2YXRadkl4cmkrbng5bG9ReWVnSTVPSXpTNWJHOXZWM3hHblN2cTVNZ0E5?=
 =?utf-8?B?VENMUStTNGZvTE16MWhwMTN6aVcva0s1Z1htalJvM0dhRVRWbDJrWmtaTXFZ?=
 =?utf-8?B?dXE0STFndVBjT3EzMVFqcDBET0VXWUR5R3cvejBWVnYxbGgwY0lkVFlaeWw3?=
 =?utf-8?B?WXRmLzR2Qi9UQUg1UGFEY2krVWo1dTRwWTNkSVE3MzJ6WDljbnd1UXAyY0hL?=
 =?utf-8?B?RnZoNUdrZW5aQkxRRDFXZUo3RitzellFNmJzOVQxYzZYSlVGMlYvZ29mZkdk?=
 =?utf-8?B?UFFVT2ZtYXE3MjY1czZkMXcyOVpTbUt6cStmTjRyZmtEU2x5UjI2SGtsWGtl?=
 =?utf-8?B?YWFiQ0RWRHZtQmExMmVyVk5yK2JOMDdUMmpBQ1d6bjJHQit0bWhWVWExeW5j?=
 =?utf-8?B?d1QzME0wT21oUEQrL1RnVzZ0NGlvQ2thQmdQSEhEbWFhdXgwNFBndDR6a3hs?=
 =?utf-8?B?ZTg5SlhVZW05Mml5cjV6MmFpNmpSdWxXV1ZBVTRnckFrOFZ6Z2pOd3ZwSXkz?=
 =?utf-8?B?OU9XZXBmU0FydGdXWFpGZDRBMTI3OEdGWWhOV1E0R2NwM3NJTWRTa3F0a2E3?=
 =?utf-8?B?Y2dXY0k4VlhRelhVbnJaWXlJdSt5aWZUbDZrMkVzckR4Q0NvbVNEK253cVdC?=
 =?utf-8?B?NFBZRDQreHo2K3FsejhaS2xXY0JaVHpycU9RTGdOTmp5dUFNeVI4WTVUbjVn?=
 =?utf-8?B?M3FiNzdEUWhtTFN5SmFBcDd0ZWgzTDNMcm9QSU92TzJqcWJPdWRNeUZTMHRt?=
 =?utf-8?B?V1V5d2U3eUZiRjdKY0dnbTNyNGJvVkdaZ2JvaC9jSlNzRklvd0lqQVplV0FC?=
 =?utf-8?B?bnJ3QnNaSUlMMmRSM2lyQTg3VEhHZDI2QTVNQTJ2ekl3S1g2c3d3N0UyUWJL?=
 =?utf-8?B?Y1kwR1NhRS92ZUF4aVRYWkJUeXdEU3NxYTNHQVJBVzVpWGtTZ3BQRi8yRTVV?=
 =?utf-8?B?dCtWQWs0ZjF2WEFOcWl1UnZiYTJ6R2pXYVhFb1BvSHp4YW94Y1ZqbEVHQlhl?=
 =?utf-8?B?UVd3UWh2Sk82Y3dBL2JSWVZGcmF2T3Z0TkJzUnZwRTNmblMrTlJ0WVNEbnBp?=
 =?utf-8?B?NG9kamMza0pvOU9xelNHTHhtWGp3UzN6NHVPaHNkWkdkdFB0WUdVY3NMMkZF?=
 =?utf-8?B?SE1WNzd4YlJadG0vVjhsR0hMYUdoaEp3QzROVFUyVk5sZVhHNHRYZ1Q0MzFw?=
 =?utf-8?B?WnV3eXI3R1dHSlhwdzlZbWlMYVpUeWhaSnRkMlBUZFBSWDVRdkpmOXovWWo3?=
 =?utf-8?B?dHdxbnMxcEJyRCtWZVJHOHVVYkFwK21KYVdRdEpueHU5bDZaT2o2SERHblFI?=
 =?utf-8?B?YmlFL1h2SEdTbFkwZEJrRkpNOGlueFBEYmdBWTVabENZUzl3WVMvd0FPdHRr?=
 =?utf-8?B?K1BTRm9Eb1NLOW1FVWVUbUZEVHlNcEI1VEF5MTFtQnlINlFkWHBBK0twRCs5?=
 =?utf-8?B?SlNPSWZiOTl0OWhlSitINThrQlJqeEU0NjRhU3NyVWhWVUlpcUNjbmovMGha?=
 =?utf-8?B?S1RyQ0lJUXpham5OclBJV0N2Tkk1c0RnN2E1c1B5ZXNsWlIrbmk2ZXlpaUxF?=
 =?utf-8?B?eTdwN0pjcFhaL3dLZTRjYU5TdUtSSFViZTdCY1Rzb0RKY3hGU21YenhreFB4?=
 =?utf-8?B?Tmp6MTZ5aFJNU3pXT1VsemRGT1h5S1I5VjlZRGw0S2RXbGtRZlNRdTdSY2VL?=
 =?utf-8?B?Qm5xaTZORWhjVEQ3elFWTHBqWHpZemZSanhWR1J1Q1lxVkt2NGp6RWNvTXdu?=
 =?utf-8?B?OWRISnp2OWZRaU5OQXVJcVYrVjl2aG9yb1QwVUpTT2FuQkxCNm1Bb0dRcWxY?=
 =?utf-8?B?NklJMU5kYVQxOXp0TjRYMjVnRXluUWJqUUc2QVNWNFNuQ2VDR1U0WVI3K2hi?=
 =?utf-8?B?bmJTbVFaSGExeStZckdDb3J1NnV1WWZKbkpSTFRtTWdyNEMzY2NLMS8vZmc0?=
 =?utf-8?B?czZrT1g5NXZwU3k4WERtT0p6SFUrUHVjMjFKdFBPVUczaTJ6V2N3N21kaTVG?=
 =?utf-8?B?UW9wNjczNEh6Q2FGbTA4dmp2WVVWUW42VTNwMjFvUEVnY1Z6a05ZMTYyMUR3?=
 =?utf-8?B?Z2lVak02bEt6UVZGOTVGME9TZ21VcDZkMjBlOUcxRXR3K2thMk5qZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fa2716-5cf4-4ce2-253d-08df2aa71329
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:28:37.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZjhfAJuFMLblrMljXMvRX7Zscqi+mIZYmjYSJdYN2Ynh6uZ1+JuMQ61IjR6w0eYvtZen/kIPoHwBhfPt51BE3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6423
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Oct 2026 10:28:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24474

On 15.10.26 11:27, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
> Hi,
> 
> I cannot participate today's meeting for personal reason.
> 
>> * Action items
>> * Kernel maintenance updates
> 
> I reviewed v6.12.107,107 and 108.
> And I am reviewing v6.12.109.
> 
>> * Kernel release status [*]
> 
>> linux-6.12.y-cip: interval 15 day
>>   latest version: v6.12.111-cip32
>>   latest version release date: Mon Sep 28 09:54:38 PM UTC 2026
>>   limit date: Tue Oct 13 09:54:38 PM UTC 2026
>>   Status: *Late*
> 
> I am working for Linux-6.12.y-cip.
> I am going to release it tomorrow.
> 

Perfect!

>> * Kernel testing
>> * AOB
>>   - /me absent next two weeks
> 
> I can takeover two weeks.
> 

Great, thanks in advance! Maybe I can at least participate in two weeks,
but it would still be best if no one is waiting for me.

Jan

> Best regards,
>   Nobuhiro
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Jan Kiszka via lists.cip-project.org
>> Sent: Thursday, October 15, 2026 4:09 PM
>> To: cip-dev <cip-dev@lists.cip-project.org>
>> Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat
>>
>> Hi all,
>>
>> Kindly be reminded to attend the weekly meeting through IRC to discuss
>> technical topics with CIP kernel today. Our channel is the following:
>>
>>     irc:irc.libera.chat:6697/cip
>>
>> The IRC meeting is scheduled to UTC (GMT) 12:00:
>>
>> https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&
>> month=10&day=15&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4
>> =37&p5=241&p6=248
>>
>> USWest    USEast    UK        DE        TW        JP
>> 05:00     08:00     13:00     14:00     20:00     21:00
>>
>> Last meeting minutes:
>> https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/10/cip.2026-10-01-
>> 12.00.log.html
>>
>> * Action items
>> * Kernel maintenance updates
>> * Kernel release status [*]
>> * Kernel testing
>> * AOB
>>   - /me absent next two weeks
>>
>> Jan
>>
>> [*]
>> Date the data is created: Thu Oct 15 07:08:28 AM UTC 2026
>> linux-4.4.y-cip: interval 30 day
>>   latest version: v4.4.302-cip115
>>   latest version release date: Mon Oct  5 10:29:52 AM UTC 2026
>>   limit date: Wed Nov  4 10:29:52 AM UTC 2026
>>   Status: On track
>> linux-4.4.y-cip-rt: interval 60 day
>>   latest version: v4.4.302-cip115-rt63
>>   latest version release date: Mon Oct  5 07:16:38 PM UTC 2026
>>   limit date: Fri Dec  4 07:16:38 PM UTC 2026
>>   Status: On track
>> linux-4.19.y-cip: interval 30 day
>>   latest version: v4.19.325-cip136
>>   latest version release date: Fri Sep 11 08:53:07 AM UTC 2026
>>   limit date: Sun Oct 11 08:53:07 AM UTC 2026
>>   Status: *Late*
>> linux-4.19.y-cip-rt: interval 60 day
>>   latest version: v4.19.325-cip136-rt50
>>   latest version release date: Wed Sep 16 09:32:17 PM UTC 2026
>>   limit date: Sun Nov 15 09:32:17 PM UTC 2026
>>   Status: On track
>> linux-5.10.y-cip: interval 30 day
>>   latest version: v5.10.271-cip78
>>   latest version release date: Wed Oct 14 09:30:59 PM UTC 2026
>>   limit date: Fri Nov 13 09:30:59 PM UTC 2026
>>   Status: On track
>> linux-5.10.y-cip-rt: interval 60 day
>>   latest version: v5.10.268-cip77-rt34
>>   latest version release date: Thu Sep 17 09:59:47 AM UTC 2026
>>   limit date: Mon Nov 16 09:59:47 AM UTC 2026
>>   Status: On track
>> linux-6.1.y-cip: interval 30 day
>>   latest version: v6.1.189-cip61
>>   latest version release date: Wed Oct 14 07:07:26 AM UTC 2026
>>   limit date: Fri Nov 13 07:07:26 AM UTC 2026
>>   Status: On track
>> linux-6.1.y-cip-rt: interval 60 day
>>   latest version: v6.1.182-cip59-rt31
>>   latest version release date: Wed Aug 19 06:16:01 PM UTC 2026
>>   limit date: Sun Oct 18 06:16:01 PM UTC 2026
>>   Status: On track
>> linux-6.12.y-cip: interval 15 day
>>   latest version: v6.12.111-cip32
>>   latest version release date: Mon Sep 28 09:54:38 PM UTC 2026
>>   limit date: Tue Oct 13 09:54:38 PM UTC 2026
>>   Status: *Late*

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

