Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1602ED6ED15
	for <webhook@archiver.kernel.org>; Thu, 21 Nov 2024 12:14:23 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.44])
 by mx.groups.io with SMTP id smtpd.web11.9358.1732191257896226775
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Nov 2024 04:14:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LHVpk8+q;
 spf=pass (domain: siemens.com, ip: 40.107.20.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqtAQ1Zwv495bLdU3HIgxuavVzJY3fvxXw9rf24tZ8qt68LiZZdHsZFVNx4+TWscpCygHvAFlnR3NLXtAWLOdJJn+m6gCe4zcJSCEsxjh3S3y7YaSuaFLsNCA7rLqtZhtcsxt5TTy6wihE4up1tAzJC6g1DCF7bg3bl3qBvVvvbpqCoKjI3FoaPDwrzUInrO0h1jHxIeE2QTyegyfFy3fCjkWIPgIck9RmpeouDbsdcq3ZGJiOENrzShFZ4EDdLA4gqhRkX3V2uV9lPa7YVu5Qc//d0U8LrpbdQTk1+dva+7N1GRrB2JL1svpzyCtclvXDq4CykH2AJeb92n+x8ztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQT3+wcMblC+L73rMCwL/dUhN1kHs/PsfHY3lRogGa4=;
 b=pW9njXvdrqI9wUxpPvQQ4EoXMaqhDttNsD21dWcYFbHkeQKpSxpLh3Dk9ote4UVC40YAXa4RGP15HPv3viuOgZMvbzbqd+qNtbrcQANA+vjU/1n0BMcIVM6DiDrMqCvR14/Ng/BWyDfLHgPcGs1w/7oVPBzrYCaMYfYGBdNtR5/w1Vle2xLKoCRnMb1HWg826bRhaLL70xfHoxGL+1NiUO8VYPXm7EENYdtnztwvNlptJ09ltURo3XfVNYvAbP9tqWv6e2DowkOWD+Z2XMIWh7eRQZ2jfeivgr+9LZapiWmMruB8XibhRuztxvd6GVySb+uAz7/iusaJ0SQkCgZuCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQT3+wcMblC+L73rMCwL/dUhN1kHs/PsfHY3lRogGa4=;
 b=LHVpk8+qz+HBKf0nqH30AKkDamg/JEm3CdLxYGoQHPU5NVc8X7V5gU7xiSxRx+AWd1dAoaFhRtOS4hvqlYYE7XM4OoNpYs8f712YFPLfDjDL7N8SDZAP/92JEGYMkUJWhPPiJYcmr3rRrxJl+vkzfb497Doj3qbc5f45dYefzO64fuY8G+v+7yfdL/usyDJ2YopKUE1eq3QPaFS/qAH4wYJnPjgB7dSSkb5YKZt7QE/QZopPw6FkZL1e+WZdENMIa2gRRUwRFWuL7TkzIkrjBfv6oiSqyqEtuda9R6ql/9wDjlZ/GYRgsVzeBpgTBSU2TJ43rX7TW0TGGkepfOY22Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6314.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12; Thu, 21 Nov
 2024 12:14:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8182.014; Thu, 21 Nov 2024
 12:14:12 +0000
Message-ID: <f6906ffc-64a7-46be-93d8-fac0e55bcf2a@siemens.com>
Date: Thu, 21 Nov 2024 13:14:10 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: df5815fd-9a0e-48af-c76b-08dd0a2602bd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QlBxRTBKelpLd3FkQUhTUW1NeFFVWExSSFRpbDM2OXF6VHJZU0xETXBxOURq?=
 =?utf-8?B?ajRxcEVFZTBSMXVRNE5SSm1rL0JZVjh4ZTF2bnhjY1AxVDQ2ZGtnTVk1cVc1?=
 =?utf-8?B?S2pQcVdibzBlWWc3YmtsWklOR3F3R1Bicklac0c4bTcvMjFFWkZCQWNvZTkx?=
 =?utf-8?B?Y2RUdUU2YklMOEovZjdlZmFBRUFQTlVVZk1RczhhMGVVQmFHV0RrUFVCR21C?=
 =?utf-8?B?aSt3OWlxVVlJQlZsbi9kcXhsV0xwTEE2Qmt4VllhUzdyMlh5dTBuNUtlTCto?=
 =?utf-8?B?RnFqdm5TY3djV0FUQWpYSWtDK0xnYnhhOFpnVFdwZnMyM0JNRFErdVA5UDVO?=
 =?utf-8?B?SWJoZzgwQUtzN0E3SUhrdG04cGU0eFFKcnhJR3lhMDc0ZVVBbG9UcHgzK3kr?=
 =?utf-8?B?S1VEeFo1VHFJSFNpWE1PN2N4UDZPRklUZ1pwK0ozUzJkdm5oNTlKTXY1bS9r?=
 =?utf-8?B?M2hTWmRKM05YalNqSGtUWWIxbnZONmFndGdvemJuOFJETnZNN24yQ0EyODAv?=
 =?utf-8?B?K2NpQlo3OVJja3UyU2RJbnVMcXhJVFFGTS81TVRlQm9iWXJYNkw5eUpCbURh?=
 =?utf-8?B?S21aZ3J4UVpxT2E2dXNaU3VEcHc4Y2VWeUlaVGhSLzdZTXZvREdLQ1dDQ2px?=
 =?utf-8?B?dmdpeFROeUdOaWQzbFlPdktWWU5ISWZtTjRubkRRWHlWY0FvcjcxZm14ZlRo?=
 =?utf-8?B?cUpLZEl1Wkl6eHJQWXRaeTIwUzZvcXBnbDlCNkdRN3p1a0tLbXdPSGRuOHRs?=
 =?utf-8?B?akVpaGNBUnVpRGxlQXhqWlRNMForSTJtSTIxMmFaMGYzcUlOOGhzcHJ5Qkdr?=
 =?utf-8?B?VjNmMDFtOXFwTWo1TzdhTUJlWHp1NStoa0VGaVVZZC84NDlYTmdmakora3NH?=
 =?utf-8?B?OGlYaFJLRGhRajlxK0Q4Vit4S2EvYXlHZ3VwTEJmdFlNUk43Y1dFMmNtc0lB?=
 =?utf-8?B?WmV1YUtyc2ZRa29KQzJ6cnVZL3NEMUZSejRTNFRWZnpGZDJ5eEJBNjRWWnVB?=
 =?utf-8?B?TWtKNlhlYVpiQkVQQlhnSGZJbjFjOGw5MzFFUkl6Um9wMVMrWWNpbXRwL2hL?=
 =?utf-8?B?UG9aOUlEOGNPbm5xbVNRK2tsNnJUbXFtZGZUOXhsNkdBRndUWWp4T3V6WHFw?=
 =?utf-8?B?eHVyNzBzZGY1dDdkQTVuRmdqa0s5L2x4bGM1bzRQOHlGMEJWWnhINTVqVGt4?=
 =?utf-8?B?R3pNYi90ZlBSYUEwV1U4WmRMYi9pU1F2Sk1Wd21MZzFCZDlqQzlSY0l4TVhp?=
 =?utf-8?B?c2hOWjZxTEg5TGkxenZzMjJDaG1qVEFnSFV5dVN0NngwR1JCWGppZkh0Sm5U?=
 =?utf-8?B?YU53ZFU2a0dVNWR4OXYxdUNNbmkrYzR6L2lKcy9BR25PN0ZKOFJVZ1Q0bHV1?=
 =?utf-8?B?a1pVTE9yUUpKNThYWkhEM0FwakRDaDQrc0RCM0ZsV0h1cUVNYWpDcmtTQW5T?=
 =?utf-8?B?em1UZ3BIKy9BajdJeVh4ZzdSdUw0RllabTZGZEU3cVNWcSsyRWp4NFBHV3R5?=
 =?utf-8?B?TG04RjhXWEs5cXhoT0M0UjRyZkU0dHF0Um1BM3FLK05abTl5TktoT2lzd1V6?=
 =?utf-8?B?dU55TldZdEN5RVhYRFJsSkQ1amdxS0pmQXAyRWVyWElHVVl1QnNlb1dqa1B6?=
 =?utf-8?B?SEpDUDlvbU5zdWlhS1R0VmcyL2QxcmdNdVM0eHVSaERUZ3JFNUI0SEdzcjYx?=
 =?utf-8?Q?tP+k48USjmwlBnoDWdOE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZGZGVm9UUkpCbzIvMU9qZlRHZzFuZ2JaVFpiZno3T0txaGtYaU04Nk9PUjZy?=
 =?utf-8?B?VU9KcHFNc0FFSDJWOE54NlpoUmdrVzVuUW5mTzNtMzNzemRnV3dqS20vNE9a?=
 =?utf-8?B?TXhVc0JuN2tGRHJ0bG1oU293VEhhNkpNQmZxTzNsSTAvQjRGS0xBNk5pKzFi?=
 =?utf-8?B?YWJZeEo2LzlTN2l3T2tySlgvWDcwS2RGVk5wQklpdmUxelZGVm5LMWgvOWtx?=
 =?utf-8?B?bGw1cVZnT3BHYW04L3RZUTUzbDJhd05COXBkUElGNi9pbU0xSzcxbkhUY0hU?=
 =?utf-8?B?elJNYkFUaUJLYWZKdk0rUy92RE5NeWYrWHV1NTZROWR3NTZjNlp6ZkorVGtC?=
 =?utf-8?B?SGhTdThidDN2WW4yTUgzU0UybDV6NkFHRnp3VUYyMm5yaHBlOW1mbUhjeURW?=
 =?utf-8?B?YURCQUhBcWIvaGRzQ094Q1l1NnFEdmszNHpiK1h6bXVOdkRhYXNWOGhIZitP?=
 =?utf-8?B?NWhpWmozNlZUQnl5RFZEcTJJQjU3RWladk9FZk80aXQxZjJnTVVJb3F4ZnRl?=
 =?utf-8?B?RTBnSm5CREJNVFo4THpLc2pwOGZBQlNuTEJpQ1RGcVBiSDlzNGVDdTAvUjY1?=
 =?utf-8?B?ZUllMHptLzhWSjZPWU5iTk85MEpscjVxU2RtWmtuZ2Q3Y2RmWWZXY1ZyYkpH?=
 =?utf-8?B?R2xNUTBNVWV0S2dIcHV4TStuakUxbTNRT3FGY3pmeXVNODcyWkR5M1U4cGVo?=
 =?utf-8?B?ZUdxN2xjcFo3SVVDbnNldGxHUFRJeGpFYkllWmFNNkVINWFvWHNuYU5Ydldj?=
 =?utf-8?B?ZkZWbnBMQ0p5QnY3RDJpZ2VrcmVUeWVRNmxKeXk4RmhjeHVRK2U2cHVxU3hh?=
 =?utf-8?B?MTRnQXJqMExLcmsyeDVRbHNudkdEQUM0aWF2OGM3cTlXOWFqa1lYV3pQN3dZ?=
 =?utf-8?B?d2MrWi9UVnJVNFF5c3N4NERTeGcySTExK2dlSjFqVi81OERQSnpvLzlWd1NZ?=
 =?utf-8?B?Mk5DYmdKVHdoVmtNSXhBeGgwUTdoK2xyaVJ2UGRHVmVJelBDVFMyNk5EQ1p1?=
 =?utf-8?B?SVZ4UzJycmdTMGxLRGZtSFVCalhkaitUalpUOVNIOG1Mb25IWVhlSE5Nb21P?=
 =?utf-8?B?dXZCd3d6elhQTEVpRjdoZm52SzVvNDFBUlBpajBKUk1vOUVOajBNQXZHRkdi?=
 =?utf-8?B?b3RHK0Zlblp2dW1BVC83eGI1dTcraTlLMEJDYXVOdURBdnZhMFNwR29QTWZT?=
 =?utf-8?B?OUNRem1BeHNPQ2NsUVZYYWxiWUl1Mk5OLzNFbk5JOTdsMHFrNEtjbHNrOHdW?=
 =?utf-8?B?Q1ZEU0xvSVI2V2VmQzRVRG9YWlEwRXRQc0lwdCtPVmhDdWxuZlZnYzgvV1lE?=
 =?utf-8?B?NWI0TUJtVU5GZmRxcG1xcmVSRWZ6N2NLd3Q1VFBtaUtIQjFoSk5lUlFMYUpJ?=
 =?utf-8?B?bkpUTWFRUXB6WGNIRUQxZk5nb0RBODk1b2RxbGpmSUN4eUx5L2V0Sm02eHpH?=
 =?utf-8?B?eVJKVGxPbzJEalpZWUNBQk16Ris5NTBqTzAzc01TNEdwdG94a2lXYzBySmJt?=
 =?utf-8?B?Z25ueklhMGE4ZEJTbkw5MldqVmVIYWRSV3RNYTRXNExRYXBackxkUkwyZlN2?=
 =?utf-8?B?RHFWdC9MbmdtL0hCTUN5QkFnMXdYMnh4Z01PV1h4dWVhQ3MvMzZZVUd0QnFW?=
 =?utf-8?B?Mmxvd0NXa1MrRXFXMVIxTmZmZk84eFdHM041bTNqVkt0NjBxOFA3NzdNYlZY?=
 =?utf-8?B?UlgyUVVzYnFWck9jbTV4VkhVeHBBNW5vMUFoV2hBeGpNRGZUQkRVbmpvc0lE?=
 =?utf-8?B?eDZERjdWL29nRnB3ZjZ3U1Zhd0ZZc1dKQVRkZEdtNURuTHNGem9jd0JQcTIy?=
 =?utf-8?B?aFkxenNtNEtuck80alFkcmZrbjFkd0pXcklhd1krZURudUFPT3NJT29vb2Rl?=
 =?utf-8?B?RWliazZId3dnWnE5Z1UxVEtianEvL042dXI2eEowbVhUWUlDcHUwZVF2c2tq?=
 =?utf-8?B?eTFKTEVrM3BiS245SUpOVnNyVzBHOE5UaUxjWFpQWThtTHpYM0hDdXdZT2J5?=
 =?utf-8?B?MmZkNE9DNk1kUnZMRDBQWUNESTR0QlB4ZGo2TmRlVmRMSzB1MFJEWmpBZ0dv?=
 =?utf-8?B?UVI3YnpzZXlhZXArbS9uZWJRbDhwb0tjVHFrL09OZkdKQlRNN1B5b1U2OWp1?=
 =?utf-8?B?L0hvWmJqcWRGUjJ2S0o2M0VHL2pRNUxQd1N0RnB1ZHpQM2diWTVzc0lUYkgz?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5815fd-9a0e-48af-c76b-08dd0a2602bd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 12:14:12.8725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 75O1ZbzEffn6d5oUI+u5sOayMPGvLDhpHQewGrbeS8RyvUEK6Z/8L28vSHZ4IVMCOv78FsqvAIfcYSKmL4zyZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6314
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Nov 2024 12:14:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17265

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=11&day=21&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/11/cip.2024-11-14-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - meeting host for next week (28th of Nov)

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Oct  9 04:23:37 AM UTC 2024
  limit date: Fri Nov  8 04:23:37 AM UTC 2024
  Status: *Late*
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon Sep 30 09:48:28 AM UTC 2024
  limit date: Fri Nov 29 09:48:28 AM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Nov 11 07:08:57 AM UTC 2024
  limit date: Wed Dec 11 07:08:57 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 24 10:34:04 AM UTC 2024
  limit date: Sat Nov 23 10:34:04 AM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Mon Nov 11 07:28:28 AM UTC 2024
  limit date: Wed Dec 11 07:28:28 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Sat Sep  7 01:56:36 PM UTC 2024
  limit date: Wed Nov  6 01:56:36 PM UTC 2024
  Status: *Late*
linux-6.1.y-cip: interval 15 day
  latest version release date: Mon Nov  4 11:35:47 PM UTC 2024
  limit date: Tue Nov 19 11:35:47 PM UTC 2024
  Status: *Late*
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Sun Nov 10 11:47:28 AM UTC 2024
  limit date: Tue Dec 10 11:47:28 AM UTC 2024
  Status: On track

