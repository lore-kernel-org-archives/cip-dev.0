Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80A3CF07BB
	for <webhook@archiver.kernel.org>; Thu, 10 Oct 2024 07:15:27 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.69])
 by mx.groups.io with SMTP id smtpd.web10.37801.1728544521576339579
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Oct 2024 00:15:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lBwhZCGe;
 spf=pass (domain: siemens.com, ip: 40.107.22.69, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHGczmRc5Y40/qh1GK7XnnKURtUN1cXKH/zWNhYTKSEi3XFem4I9WahvDjf9we4GDrDjSpvIxH61++XZVyNECxQDj0880USvK3y3IOPFMoTlsUm6Gb9j7cw3PveOzj5ajc5kHc27w62OcpAzA4jkGfW4y+jsWG8iDY/IuAaEpv/i9zM4JWU0zrbNvw1SRLDbrebRoBhfr1XdZju5Fq2Dsflo3Zyed52t1ekbGCWTFhcCG9i4KoYQ9Yze6r4fn/HYMhP2tIj4vNc3bbxIDLsOaHhaPyOTmz1kmQ6O630sBGqZoc8/ZutBW352/5aXWFGTkjRTxJ2RI8PacLEvGGlp6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yFM9lMYlHYYsfaRH5AjUDWHJkcMyNpdNQ5TtKv8hLQ=;
 b=m7vqHtnOkNUHEzzR6lTrnCayB8EoAN8F9bqC9cwXhuRDu0A5dWqDnkGbrl/Po12iVIPT34BH6JyOWtDNUcxK0EglzH3xmi1h8xU8S+Ot7jBwLti5LZIcJIyXbn1vt2u8bB40tn9MXHJsndyOz2U1ZBNeVDyrvUpiybzJ4mpoh82nt9sJJlbWzE/6XZ8J1vJBYPpQlNxPeI6sguFvL4dNu7AMAobLE+frh2G1FiBjXli+sDSQa+SO/6ozBwmWzGCr6NwLKkJjkpcnXj14ZGeg29JMZWLPhPjZ5G6AEHA3Kar1uEwdKxIeJqs6MypwQwj5IcjiBKZN+pDAQi/ki2UTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yFM9lMYlHYYsfaRH5AjUDWHJkcMyNpdNQ5TtKv8hLQ=;
 b=lBwhZCGeZc4PIH1hxo15aXxkWXPcw3578Jt09HC+WjcHSMuiC8PoNiUwFnSkz+hxFgoSkL5x0VsJIn42xhwx3ncGHDrlGIXQLckgShLVcKIvBTL3Pb79Hs6veEdYsnSIljRjMAbgZX/usSBK0zGoTQ0Tto2HE9cNzStRVtSKtE85HjZbDVf+sKXcBSamqORz8VEk4aF96+JFdRvU86FNjqsJPSOu7jklYgeAtuUU8cwTAQeBri6psq3aC0Avl3szfvF2XT57nQ2W2sVcdbFnX7OLw6N0HHIpR4fEYKipvnH54aRzXeO6etM6uVqgFhL6SoAqNROq/FY0zYKBTCDIuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB7230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:61a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17; Thu, 10 Oct
 2024 07:15:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 07:15:17 +0000
Message-ID: <114a7d54-edf6-482f-a5de-434108c27174@siemens.com>
Date: Thu, 10 Oct 2024 09:15:16 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: 9daf6c44-75b8-4644-6a7f-08dce8fb4b04
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UEFQN2xHTzYwSVlRSEJhWWlkdS95OExpSktxSiswRkhSSE9HUXozeVhNY0N6?=
 =?utf-8?B?QzBlNFdWU2NWMjI3S05JWm5lazVZUGQ0bURNYmVwUnRBVFZ5aSs4SjNvMmc3?=
 =?utf-8?B?UXA3VFhLUkVkM0pGSG84aWJsRjB2TXQvWFpwRzZ4UXgrTC9vc0tPYzQ4bnFZ?=
 =?utf-8?B?Zko1QmJwR0FqR3ViMEt1Vk9QTHV6U3lDdmVUWHFXWXBlL2ZBNzEvdWIrYnhL?=
 =?utf-8?B?MFBDb0pmMWU0VzRXNFA5elJNS09XQlg0STB1MGc2K01xa08yN21uaFRaQUxG?=
 =?utf-8?B?eE1LT0dsUjF6MzNDVjB5QTA4NFhuVjBaWEcyRWdLNXNzc1Zzd1JGUkZEMEJS?=
 =?utf-8?B?ZVM1czNpYjNscjlid2dFd2xSM1FsVCtrbjhvWFRnd1YwTnp5bmtWYkhOYk94?=
 =?utf-8?B?RmtVcFZwNC9RU1hIYkVWVTkvSUIwWFQ4cGNVL2ZaQUJTNzJKU2ZWaEVnWFdK?=
 =?utf-8?B?c1MycnZaRCsvN3pTbGNySmZNWTkwcTl4WjMzWERmcXduNXVzaHNKMDhVY1Bj?=
 =?utf-8?B?cng2YUwxazVKb1JlbUdyb3hJdERCMk5SQ3RvRXpuQ0VwMzFUclA1Rnd5cHB3?=
 =?utf-8?B?Skx5ZXdrODRYOTc4NisvSDQyZFJzMVN5Uk91NjdrNlc1aXZZQ1ozNFFxQWNW?=
 =?utf-8?B?VCtFNHN1SGZFQ0FwSXBQckU0bllWUEp3UVNjL0Z6ZThOQm1PbVRLK01QTWhq?=
 =?utf-8?B?cTl2dnBHczhWcUtjdkEvN1hqaG0zVzRCT2JjMDk1WmVWb1FzTFNzaG1tMzBW?=
 =?utf-8?B?Q2xaRHZvM0h5TmtRdy9jOXg3TGtvSUNDUHdselhWWkExNFVmSDdGb0ErV3dS?=
 =?utf-8?B?c0crV0RlRG83djVHeG1udlgwN0tMT2ZWem1CblFDVFE3M2hoeFhrS280N0Fs?=
 =?utf-8?B?Zk5MQWxaREVobUZBekROK2gyZ2RYQThLYjVKWGFqY2F3VGVIYjIyUUlCYXRK?=
 =?utf-8?B?MExYTXdvRWZiNkk5NlRlZzVqb3BFRFpYcDhJR0ljdG40bGhrRy8rRERCUWZ4?=
 =?utf-8?B?Z1VEU0VtNERPMzZpbklJTlJJMlhsWlp2bG1WTzFqTlRYbUhzaXJncFFOUGVk?=
 =?utf-8?B?K0k5ZTFGaUk2RWlWbExlSkM1YzY5K1VtWkE1Q29EdHE5eXR4akkyMFBSRWp4?=
 =?utf-8?B?SitsQ21sNkVCU0RwU3NlYW1GbW9YWFRnVHlVY2VqaUlkMklhUklmSUZhU0I5?=
 =?utf-8?B?UXZZSHNwdGN6SFBLenEyekRBV1ZlaFg1c0FlRi9BSU9hdDllKzQvYmRpV1Bn?=
 =?utf-8?B?T3ppV1Rra0ZaNlJPaTZWVlJBTWF2WUw1dzl3aERvbk5ibmFEUWpMMndTUng4?=
 =?utf-8?B?N2oydlhTR0ZiS2lLSFcxd0YyVVN2R2M5V0tIbzFjem93ZnJEZGg2TmR5VWNI?=
 =?utf-8?B?VitlN0hnQ0FsbHZBRmhKTEV0SWxpRXdwTDZ0NmtYdEtXTjR3VWZOWUdZVFFk?=
 =?utf-8?B?WngyWFZ6YU1jSmFVSGJvV2hPNVE0eXJnWERUQXNabVBoVFhvZi95bXlTYUVP?=
 =?utf-8?B?dWRRYy84OGFIRlAzbFcvOFJuT0thWGIybW92Z1BPejJmTm9za09XMlhWa3oz?=
 =?utf-8?B?YlF6NHR2d2N3N1FoclZRY1lieG1DTkZad2tDam9pMmYzeElGelQzL0orWHJy?=
 =?utf-8?Q?81nBh/Hfa5JnYEUVTPFQcTgC+CaxKFz4LO9/vlZlj7CA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cG5NR3p0RnNkMkZXRlNETk85Y1pmQVd5NjY0aDlmZTJKR2JLSU1jWm9WaGll?=
 =?utf-8?B?T0lXOUJXR2JNSUpLVmRYeDUxa21nSWEyY0UyVDdiVUJpdENHRlhNT1RhSlRq?=
 =?utf-8?B?QXYyK1RtN2ZUZUxNNFgyNG02RDhVNUh4WUhTaUVVUlkzMzZNTXNIWWg0a2s3?=
 =?utf-8?B?aHd6MGVkV29jZUZGaW01UkIvR0lxNlBsRWJCTUhhaS9XNW5pNmFxYXlzbTNa?=
 =?utf-8?B?V3pPU0xVdHZZQVk4S2lMNW1GdG5tVVNlcElmSXFpTTFXVG8zT1VCQ0Jaa1Zs?=
 =?utf-8?B?Q3hZNFdRNnMwbUVkWXhwNTd1Ym4reXhzdTl4NDE4eVJjRTNKZzBnb0pCWjNW?=
 =?utf-8?B?VjNVcytydGkwYnpFdFZvdTV0eUpja1NCdkZqMHQvb2VNSjdWNnVpOVpGSTly?=
 =?utf-8?B?NW9JaHlSZklIOHMrNE9qdVJ6bm9XbEhGOU9ZNW0zSDk1Uk1ZWTIzbWtSSTVM?=
 =?utf-8?B?Mkk5MzRPdnVNNGFLckErbWtVaTlPOXArb2VHaFpxblRnUDFCakNBdFVTY0hs?=
 =?utf-8?B?ZnZ2TXNTRXlVUnBiZFptRktma2w5VzlzQVR2bS84OGJVdXBydkovTUFJV1FF?=
 =?utf-8?B?VkZnMWZUVlUwTytGN3QreTM3TElxSVk5SWhxUEp2MGNHU3JudHJhVlBVZDlV?=
 =?utf-8?B?QU9WU2RybU5LUXVBemo4SW00RlRtWVVCNVFGemoyZnRBeWE5UzlONzJHL3ZQ?=
 =?utf-8?B?TGl6VS9ER2R6a25VbkcyT2pXeGQ5eE5PQTlGQWIvb3liMlNpRmF2c3FsSEpC?=
 =?utf-8?B?NmZHaFVqNjdTT0RMaWRBbjNqb0NuUndkRWNPZUdERDl5RzlJWFdwVG9QaWlz?=
 =?utf-8?B?MkdYN2ZaTTl0SkNCckVjcWhqVTRPWGRHM3B4aHU1ck1GRDNENlBMSklndW03?=
 =?utf-8?B?ekUycjdBZDU0Y2JrODdpam15ckRGN1pzK2EwYzZOWlFBalZWUzV3Uk04dncr?=
 =?utf-8?B?Yk01akhNeWx3cXZPcll5RzNnRmFGeXVHNFpoNmJITDZMRk5RM0UyenVUdWt2?=
 =?utf-8?B?MTNCSWhXWGh6VjcrQWUvVndBdXhLeG9yYkhPTFVOcjRvb3YyTjBIM0ZPcXNO?=
 =?utf-8?B?SHY0S0xLN253SmV4TGJkNEx3T2dWaHh4VitVZnFycklBRGpHVEFGZlJxMWN3?=
 =?utf-8?B?Q2ZlNzZpbFZ0TE5ScnRQYnBBVll5RnFmdHRmVldmVG5qSGgrNU9vek9LcDVB?=
 =?utf-8?B?dFNVZnB1YUFHZWRkYmdPenZaek91RkVxdzVLL0t5bHE1SGp3WDhEY21mRUNp?=
 =?utf-8?B?QjZmVXo2SWZWeDlndVRTbTRKcFhKYkNJZTJxc3NzS0hmZTFrMXBxbTlGOCs4?=
 =?utf-8?B?eXB2QkFGQUYvV0Z2a3U2eTVZelJXUi9vbGxETTY1K1ZuWFRlZlR1QTNIeHdK?=
 =?utf-8?B?NTdQVTNsOXl2cFE2VjVIRnh1bEJlQ090OC9YODhkUkZFSE42cmhsMm83QkFP?=
 =?utf-8?B?WHZIUmdzUERTNnFkdXBOSGoyQmRaSGdMR3kzMGpFZFlvd2R1T3hWaHZLVDdM?=
 =?utf-8?B?L3NVUUc0eDQyeEpOdjlDbXpHbG5hOFF0TDdoWHNOV2t4ZGFLTnRKb0lvSUVK?=
 =?utf-8?B?cE8ybW5jNVRzMW9EQmc2NFVrYTVQREZNNGtYb2c2MzVxTG9XOW5KL1hCQjRa?=
 =?utf-8?B?eWFXOWVFSWVsdEVaKys5Umo2bG1YanRibGJXenlPZlI2cWYxQUtMZExiK1BR?=
 =?utf-8?B?d0RVRFNiSDBSOThsOThPRXhEL0hSYWlEZEQwUGV5TEFHZUg1VEpEZ216Wkwy?=
 =?utf-8?B?bGdZNjlrckZ0aUZHRTZXayszdXdNc3ArWjJjckRycDlQWmEraXowemo3aUZp?=
 =?utf-8?B?SER0YVRFWU1rdFArMnZ1UE5vUE14QVBkUHc5ajhlWkdaejdLdVhGL2I4S0Yr?=
 =?utf-8?B?QnhTOHBvTDl2alM1MUpYV3Nsb1ptaFk4bHlBVlFlanZNSUthUTZhMlc5U1Fv?=
 =?utf-8?B?MHFuZGlGdC83TTNyM2NKKzFXUExJVHBaaUtCR1ZXanJLS2VnMGFOR1ZaMUNi?=
 =?utf-8?B?dFd0eVJlNVdLWFBkQXpNbExBMXRlUVIwdksrLzY3RTN2b2JOTzlFd1VPeklT?=
 =?utf-8?B?UEgrcWs5Q2J0aGpxWTNHUlhzVFNnakQwZ0VDUnVqRGNnQUhSK2tMVHEyRmVJ?=
 =?utf-8?Q?yXvc7kAsqZBcHiyzsI+ROXVY9?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9daf6c44-75b8-4644-6a7f-08dce8fb4b04
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 07:15:17.4240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VkP2Eq3bnOQ85Nmn3n2GXpZA2DPYGHsiFcxa+m6QfnPufqMiQoiQkrfKK/aBO5zxmtYB9sOb4UENkw4I3ZhBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7230
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Oct 2024 07:15:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17023

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=10&day=10&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/10/cip.2024-10-03-13.13.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - meeting host for 10/17/2024

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Oct  9 04:23:37 AM UTC 2024
  limit date: Fri Nov  8 04:23:37 AM UTC 2024
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
  latest version release date: Wed Oct  9 10:54:23 PM UTC 2024
  limit date: Fri Nov  8 10:54:23 PM UTC 2024
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
  Status: *Late*

