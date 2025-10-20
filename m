Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CC9CCD199
	for <webhook@archiver.kernel.org>; Mon, 20 Oct 2025 12:06:36 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.34])
 by mx.groups.io with SMTP id smtpd.web11.16547.1760961988384784227
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Oct 2025 05:06:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xG2XGJEu;
 spf=pass (domain: siemens.com, ip: 40.107.130.34, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wspk4IFGLS056JY6DKyW3iTnme2S1op+4W/f5vGa4jtbZEPGhY3LJZw6u/eCtrxwn5FACKZdwcvu5dBpF2uM1+NvV11eS1zMDbPqXnQjRbExbPyBfhFrf2NfxoSxy0KFt1KlEJETP0EbzuBGXrRQIecRiu0m0OcwyLSpklIGVAPcwiaXsoa9iT6+Btv5T1CjiOcdE6SmXBCoD9pJXwoQLxnEAIu5wQxef/44FZyoo8YrPtOGpET/rLp4I/+/6q1quiDSWoWfRDhqc8tVgRp62Mpy2WISxqls71EAGY8CRdyv5ZlKCTiuLFeBKre9gtwnUx77vs8eZM8Q0m7cEWBqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GV+o+5JcOxWtowICGskaG1hkYKSy+I535KXAyEwE1ls=;
 b=EJYguOxC+kACvN/0IdJnMAj0DwW/csV2yNmIbHNv+AF7Nf41y3b/grtJXSSWUh9IhUMSJkby3EZ9XLr7r221QSTuvz95ItWejDKuligtiytAmN+ALq+dD26c0ZpAOWOOaN1HORcUUQXi5V1AHYIBvAN1VFlWruPrTOd59gbVIyuh7anVeUR09tkRGGwgNC6mQ0seVUkmK2w320r14IY/Sd1Z+Zk10JtwrYmXfag4GBD2qxS4tQeRYUsocCLYJAIQXC8Hg1+g7mVtK2rPnYQklFubZb/BlxllvbQhaMC+yVpqMasAa0g4jxkVsgn41Ri2uDaUqyVCvcooO3m90ynM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV+o+5JcOxWtowICGskaG1hkYKSy+I535KXAyEwE1ls=;
 b=xG2XGJEu9HvvW+BYxZEPn/8hroZhlqwTUB9efCSZ28kDASByFnZD+Jaih6yV87SQzOuA7qAfv3twPyQxFULIwSWeoJaa7SCm3DWX9eRS8QzEpqHI3bhxOewuMA++1A+CBC/XrvTyJ2rcMKQdUB0bmTAEd71grgJzV1udQPOvndK0FAvmVL/FQ7TbjSS5PTidAn72a8oFzQcg6CsIogzdAuFLkpLwoUtS1Blo3j3yKbUEbxap230jzdH0AWcQaQHFJY5km2MAcNQ+q+AyotH6ON122GC+vcODNDy81KKpergcTJMXCD8V+UScZe7XHy/+7W1M97IXDMfj30CNPavarQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4133.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Mon, 20 Oct
 2025 12:06:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 12:06:24 +0000
Message-ID: <c4a955ac-d3da-4631-bcc7-ef0e1f5b645c@siemens.com>
Date: Mon, 20 Oct 2025 14:06:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] v6.1.155-cip47-rt25
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com
References: <aPXvod6tgxfsFIJI@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aPXvod6tgxfsFIJI@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ccd0c7-3ce8-4748-3a60-08de0fd11730
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dnQ1a1VFdVNaZzZsK1dzeUtvRS9zcUtZeVNNeStsUCtKYmZSV0xveWdTOUJQ?=
 =?utf-8?B?NTdyMXoyZVlsekZ5Q1luYWpuWjVDdW5jbUlTeE9TM0g4dFJqTXhobGJKRjFK?=
 =?utf-8?B?dURUZHl2S2QyQnNpS1pueGZ1dTJoQ0NRK1NVYnVzSnc3aXJ0dlcvS3AvcW56?=
 =?utf-8?B?WnJRT25XN1dESW1LaDZwRGlSV1B4Tmt4L3BwcjlWOFRUZkVQMERNUFV2N2NY?=
 =?utf-8?B?VFdySTFYK1BubnJzN0RKNU1Wbkx0WTAyNEhNL1BiRmhsZnlBT0pkYUcxSUNl?=
 =?utf-8?B?T0ZJQkpYSGZ2UUdaZVFMWlFYSDd0d3cvbnM2R1hySTQ0ekFRVjhRQk1DVWph?=
 =?utf-8?B?YTZOVFZwY0RhWEVOLzFVQ3YrT2dFd3ZhK1N1eFBzYi9VSFJXL0E5WUU2b1pz?=
 =?utf-8?B?Ny9hTzJCOFJZekxBQ3pBNzJHRGk4SXpmMkVsQWpMZlU0RHUzdGFRSEFETitG?=
 =?utf-8?B?ZGF0b20vTld1WWY4N2Y1Z01tYWlkek01MU5JZHpxR0tseUhSOW5ESU13aG54?=
 =?utf-8?B?Q2pnd29sclM4NzEzWnVkeGx5aENoUDQvOEludERnVUtZa3BjTUV4M3NmbUhF?=
 =?utf-8?B?ZUxwWGlZS2tGUlY2VmV4MVlyc0dNNW0xV3RCVnpjYTJZanI4VFJoN2VXQXR1?=
 =?utf-8?B?U3YyQ3ppK2JDTXBlK09yS25UOWFTN1hidHBjaVVPWWlxZC8rMTBWK1RPZHdG?=
 =?utf-8?B?cU5NTXRuMHhCd3AvK0VnWkRiSFZhczlrb1k3Y3VTb3FQNnhMb1hFaGZLd2FB?=
 =?utf-8?B?Q1Z3bzVnMW44NGJ0RWZjMklzMzJPZDhNcDFLTUZaMHloSTVZaG1HU1BuQmpL?=
 =?utf-8?B?azFrTVVtQnNLcWdGekMzc0JLQWJFRGo2M29XaTAvQVdMcGNXdXZ0YkRoZ09W?=
 =?utf-8?B?UFVVY3pjNGw3blpVVDY3d1JBZE52cC9lQ2xSVkh6OTFDb3owRHdDQ29JS1Yw?=
 =?utf-8?B?WnpGY1JsTkZ2ZWk1WWhadW5mTFNKa1I3dStIajh4Q1dGK1BUNjNNTjdpblJs?=
 =?utf-8?B?UllIM3E3N3FGOVdrd3YzSGhWQWNHalFwTlNIZ1UzSFN0WWNkUk1qTDJSeHZ4?=
 =?utf-8?B?TE1GdmVLeXpFdzFmeE4vTkgrSzRKNVIrdzFwa2lEKzd2RGNrZ3l3OGc1SGpk?=
 =?utf-8?B?b0lhNFY4RjRiREFIT1h1WFdBK0FxRTgrMjZ2ZzBoNVl0cVRpcnlzcWdxMlp0?=
 =?utf-8?B?b0dZNVJMV3ZHblVHRzlFK2lyaFF2N3V5MUpFdTNlSkVwUzJHOHM3d3k4b3Fo?=
 =?utf-8?B?WW5FSjVZaGNWNzZFdzRHSjZlemY4RFF3bi9KQlFmT0Fhek0yTUVycnc5VWNZ?=
 =?utf-8?B?OStYWE5UOWNLV3RFQjVXcS9hMGlLOVp5eHVOVkVnZ3VUdGNXa2t2Q1VYbHVF?=
 =?utf-8?B?dmRublpSN1hnNjk4aTMzNjE3emlGL2R4MU85dXhkMTQwQkVCTEIzaTJSWjNp?=
 =?utf-8?B?bnRtc1lQOEVpbGpMY3pNd3A4aTRqd2tOMVRGY252Q0tWQzZuWWZCK3M3NVE1?=
 =?utf-8?B?TVFUenc0M2YxellmbnlSZWM3YXlBaEJ4Wm5OOWtYcG4rM2xyNHh1YlIxZnox?=
 =?utf-8?B?T28vc2N4WVBBY2ZTeDdTcVMvZTB6YW9MNHNyYXovaVB4aURhbzlFREI0c2Jh?=
 =?utf-8?B?MzgrUkJsSXNoa0wyNnlobDlJY1diaUZlR3lFZVlxMjU3Y3Jzb1pqMmhoZEJz?=
 =?utf-8?B?cW4xSDVHd1BGd09MVnJ3VG51bGdKb2NZcWcyVzloMGlDWGNaZGhmbUNzRlhS?=
 =?utf-8?B?UDUvUGlUS0pCSUZKZ3pINHAzK3RsSW9xWnJnVVVhVnhCSDFRQjRxakovYTJO?=
 =?utf-8?B?cWRIeDdMWjEvc3l5TW0rd1FHZGNNalR5RW1XR2UxMDdkNVJ4Z3RwQVI3UDlC?=
 =?utf-8?B?OWlsL3hMcnZBanM1dnp1NkxSSG84ZHVMUUlhSWw2ZXJWWjQ5Y0lmR0xVa0hv?=
 =?utf-8?Q?60oLxbbORqQe3m0x9YKTP/oO0Dba5s53?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2lSV2QyL1c5L1VWcTczSURRcVlIZUlpQXhpcWljVklnTVMyQXloYzZoNFZW?=
 =?utf-8?B?RS9hclpxVUkyejJ3RWY0UjBIc3F0aXNYamNyL1gxSHZkS2FNd1ZNcTN4KzlF?=
 =?utf-8?B?NVFHeHZhWWp3amkvcnpWYWVxVWRtaDRVb0xqNkxYRUVRbEpIQ0lnNmM5aDJa?=
 =?utf-8?B?OE41d3Z6UXIycEJVWDg3eDcwVFNqMHp0d3poNC9QNlRjV1NKMUM0M0lCOHQ5?=
 =?utf-8?B?OUhQNDMxZ0xTQUlPSDFlTjNMUFo1azhkUzVEelcvWXU1ZnVLYnV5Q0thbFRy?=
 =?utf-8?B?eDdwN0l0T0hDblp4ODViN0tOemN5Mnl4bVVsNFJUekJQakpOOXkvR21LS3Nu?=
 =?utf-8?B?WXZmZHpsTStneTZuOGhVWTQzdWZ4MDI0NzEzaGl5MHRJcUVjTWViMUd4bVNX?=
 =?utf-8?B?NE9SUU9rQVZINDRQd1VMbm1uL3l3QVlKTmF0aGtseHZ5dmU1Tlg4cXNleDNi?=
 =?utf-8?B?a29LR0lTUFZTR2FkWi9SYlR4L3NXVmJiWUdpM2I4OHpIWXNBdGF1TGY3Q1R2?=
 =?utf-8?B?SkJJY1VJWDZQNEVDUlpmeGxRU1RKMWQwckdJd3cyc1lCeERSUUhMUlZkVXFZ?=
 =?utf-8?B?TGRnYU9HMEQyUDdRR3FsMGtDdzgxZGc3SjVzR2E2UGcydHlXelhzaG5lT3Vy?=
 =?utf-8?B?eVNaZ0lPOEszWkxpMTNUeEJhUlc3RTM1YVV5bklyWFFEY1gwWUJFR1FzK3Fr?=
 =?utf-8?B?VG9WeWNrUGplaUl1czdEL1A1YVgwRE1aMDgzTDBacUpKWmZzQ2FTc1VmRVNQ?=
 =?utf-8?B?TXRFUS9aRVIyQnkzQkpjZmpiYkU5NnUzd3FZbE0wS1UzT2l1b0dSZkdWS1k0?=
 =?utf-8?B?UWpBVEdYZjZPbjFxTGlISkhGQXRhQVF1T3gzN1d4eWVydy95SjhkOXFITndk?=
 =?utf-8?B?amNIZWxNRmhUOEtLUHhNM2lFTXUrVGFHY3l6UkpXajhrRjVlTXVzbVFBREMv?=
 =?utf-8?B?U05kZmljWnJJazVLTXJodGJucTRmZ09lK1lyYXNINklHVHdDSUdMOTc1bDA0?=
 =?utf-8?B?Yk5VWGx3VFZUOEdJMHZYUTR5UkdURHlFYmkzWDR3bUZXYi9sek1ZUUhxR2pN?=
 =?utf-8?B?aXNTMjU1SkxPNE0rVDVzZDNJN2lzZndBZ1Uwdm9ONUNKZVZ2akhQcXQwd3lz?=
 =?utf-8?B?eUplUVBDNytVQVhleHZLUHRzQU1obkhuamE2UFZVd2ZWWDhlUWQwekV3Y0lO?=
 =?utf-8?B?SzB3c05BOTgyenlPcXAvdnk1OXN2VXNtR1pPSW9YVU50bE42M3JLbkdEVTlx?=
 =?utf-8?B?VHF3MVB1TnR6b0ZmQW41U2ZXdWF6elFUUjhtTVJZc3ZJd2IzTGZmVjl4c21N?=
 =?utf-8?B?ME1QMFBHaG9nYTRxbGxBRWFDKzdrbWxYNmQrU0lWTHpTc1pkWitUOHZpMGZD?=
 =?utf-8?B?RmRuYlJ3bi9oclhhVmlIVTdQM2RaTEZCMWFIcnU1QnRoNkFqU3RKaC9QL3Vx?=
 =?utf-8?B?RkhHRytBcmxzQk4yLzRrK2EwcS9HaVN4MmdTcEkxamJzY2FzM0p6M2FwaFN0?=
 =?utf-8?B?ekNuS3RKQjI2UEQ1NUQramh2Zm9oOXhaMXBBc0JFTE5lQzJ2MFZKWlYwbUtR?=
 =?utf-8?B?NmsrY0t2Z09kVjk3SlRYd2RETEtoQm1MMTl2OEluNVVOZjJVMm9xVlhYN1lh?=
 =?utf-8?B?c2tQaElDT1NJM2wvWlZ2UWV0d2RSRkVEalB4R3JGVGQ3dVF6aUxKMjA4TGZW?=
 =?utf-8?B?WXA5aGdvV0lMOWRFalBGUWZCNzJQaXJrRFJQRHhFbnJMc1dQRTNYS3BxODRT?=
 =?utf-8?B?WnM4aklnS2Q5K0kxZ21pL2w0ZEMrUU5HT2o2RkthZFV1SEZHVHpESUhTSHFw?=
 =?utf-8?B?WDQ2Q1IxNEZoUStVWlF2TjBBcHBnekpUK3RCQ29iVmVqR2I4TFdQVWpCZk1l?=
 =?utf-8?B?ZHcwWUFzOFJMZngzWlRPbXR2U2lhQVNIbDlRSno2RG92NG56N0ttdVNWWHNo?=
 =?utf-8?B?MDlyRHV1cXpTWjhacTRwVDVLU3ZRSDhDV1pmQ284bXpsaXFLMFg1d0NHMTV2?=
 =?utf-8?B?dVp4aWZLWG9QK2VYcTRIbmtybmpKazZKMG5IeHo4UmYrdmk5MnVKMURTMVBk?=
 =?utf-8?B?UXc2eFRUR3J2K2JZUHYzbWFidTIxRGM5NVFRSlAzU3lTOVB1akh1TTRHdm5m?=
 =?utf-8?B?MVE0YTFOYWMzV2Qyb0lXYXhnUFY5SzJsVUtCU3V0b1Q1WjBMM2xIUEZLQjA1?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ccd0c7-3ce8-4748-3a60-08de0fd11730
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:06:24.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /A/k9Tv4AZhkQQRx2Hd0svSh/2A0p7WiKlxC3QCVfyf6kdfjUAQcbxdojZExuM5zkn1hB+QFpKQ8zJ/NZX6tFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4133
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Oct 2025 12:06:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20199

On 20.10.25 10:15, Pavel Machek wrote:
> Hi!
> 
> New realtime trees should be available at kernel.org.
> 
> Trees are available at
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-6.1.y-cip-rt-rebase
> 
> And their content should be identical. There are also tar archives, at:
> 
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
> 
> Best regards,
>                                                                 Pavel

v6.1.156-rt56 was released today - already checked if it contains
something that justifies an update for us as well?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

