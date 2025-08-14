Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A23FCA0EDC
	for <webhook@archiver.kernel.org>; Thu, 14 Aug 2025 06:23:40 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.22])
 by mx.groups.io with SMTP id smtpd.web11.16646.1755152619425248579
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Aug 2025 23:23:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lqCdfBJP;
 spf=pass (domain: siemens.com, ip: 52.101.65.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+qaTLb2+dMetuYN8JIpd7x/pou6C7F+wUT1eyrqY8HVY4lSHmwnPFV5TiXatBcTz0WMCPxmTk/oXd8dDu0k+XoySmQcWgi0x6bJEIyi6KJ4d7K9HDA3P0i7lx4lyeFBAXrYs5SrvojQcQWezLBFcL9kIZorMFSQwmxsLMWO3E1VywwI4MfJNShbEAY47C1K/4gkeyMkBCCWoOb/n+aOdgCwm7r8dx2qcas2Kcgq2HVg2qkG45v6UM9iuoWBXJxa0hIDuAcU8CGSFmfdofXOpGGTgm+xTcBouIFsKgrQ5Q223pQfYzotidH/M1tUmRLhS4tRSBY68Bna6bY67TdQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5F3bjuloBgdAg18n2zEvD9h7/RSoc42X8CuMWfuhyQ=;
 b=EFoHuJf/0xHN0TLgu/eB8gyS/XK/D4IYq4kqivJeP1XlKPY8eHXS4mnPCobcPzwYFHIoo6S2G1CQ4X2ZTJgqp/W1Gy1sqhynlInprKFawvwu9383Gbf1HrZggkZBNO+fkZm7hTVDIJDBpjha3bLxhk/4C2WIDP7vfifjUDv8I7tp1Nm8ODlWM+XQcWs1d4eECXj+XDhpK3bcJ8HRzW1dhIVhO7SzOwTCnnmmx+ZKQq8TmOM++RETU9TBkg2LBw22nUETnccIetD7KDJ2+HdH1P09lx8y+K/dO1IxDGuiPS68vK1dLbN9f1fi6ULACwKZUx9xN1J8ioR8m2eVtVIGLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5F3bjuloBgdAg18n2zEvD9h7/RSoc42X8CuMWfuhyQ=;
 b=lqCdfBJPKfTnkHXTZU5FZQowcawJ+YgJkCVYNHozc7el3E2DWioKU1ZTS7InQSdGKdfvLqA3alZ+T2RgcNPTURwdLtoLIbJTj8xAihtvAssiDKnuq8DOUaGZEADgAh4MT0nW0vwtsqF5IrwApx//EF3Ug0Sq8TzhoSBpmvETKAUBnmLJGtjCaKeF8Pt5M6hP7b8r+zBhGTN7aNBluzIwevRLCZ8tDjycug9j+nK0cbXrAuBoJhHXgXHa4RQcu9Ff+ENzyCFMz5eO9nUSPvW80SVXc59plF+jpLkB7qCk4MYBuFrq0yRqEDr2+AjCvnYP+eHoaCrRRxaEBuRjNJFkRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:82::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 06:23:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 06:23:33 +0000
Message-ID: <c2f3c57b-e434-4f85-af9e-4db9ddc0c856@siemens.com>
Date: Thu, 14 Aug 2025 08:23:32 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0178.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d19e67-df5e-46a1-9d98-08dddafb183c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NTJZbXhzWGxobGwvRXlnSlZZZURWdDZjR0txa2lCdE9ZazI4OE4xeFZUZjFt?=
 =?utf-8?B?R3FCRUREbGpLS0hORTFFR04ySGI4SkZvNEd1bXBsMi9IRkxuT01TWkRXSnNh?=
 =?utf-8?B?Ump1N0o3UnRWYjVWbnFkRkczVWdWU0RZOUNsckw2a2NHdi92Qk5Gc3lRaE9Q?=
 =?utf-8?B?dTBQdlptS0crWkZWU0p6Zmc1NWJNUHhnSFg2bUM2OWpVM1hwcnN0UnpDcUtW?=
 =?utf-8?B?eDdoNVAxREd4QlJsd3ZaS20vMkJTaEhxbFJUUk5yY1g1UllrY09jWTNFYTVQ?=
 =?utf-8?B?QXN6YlJPM0ZCTktSYXI3aDRzNktmN2RFcXgvTml0d1NFbkJORkhKcy93UFdr?=
 =?utf-8?B?NTEvQU8vaEdSd09mTkFDVEMxd3BmT2JwQ3pLMVRCSXVzR3FBa1ZYUjRFZ0pu?=
 =?utf-8?B?dFIwQk9CK1RTdjFYUy9HbXN3TWtNUVlYdEx3QU5kUFhwTzJPYzBTR1Y4bkpx?=
 =?utf-8?B?VzVJYk1xbHhqakUwYm0zTmZvVnNrTWhJVXlwZjN4VEhlVXhqdGpzQlN6cWtD?=
 =?utf-8?B?NTJYWVNiNE1UeHZ6ZzNoZi9Gd1FmM1J1elpVZzhmcTlmQlRvUkNkeW5LdjF6?=
 =?utf-8?B?M29RTUU1Z0Y1ODlGc3pBNmFCMUg2T29KS2ZSekNPbk9ka0k0OFdlZEp0UW0z?=
 =?utf-8?B?KzMvQmhpTXY4bGd3dlVSMG4yTnZHVjFGWDNmSnc4U0FOeTdhTkoxNlJ2ejhq?=
 =?utf-8?B?Ukd1YmQ3WC9kVWdZdDRCUDZ2akFhMTNBYTRzbGRySmZhaSt0ZFNMMTB5VVRH?=
 =?utf-8?B?THRTa1FMb3ZSTzBEdUF0ZWxvaWFJbU40N3AwNVdFUVFkWHpkdmJYNitzb2s2?=
 =?utf-8?B?UGtnTnNiUGl5L2NhZE5DU0w2VjJmZHY0elBWd3VIdDNQSFlhUXZDOURxNmdF?=
 =?utf-8?B?RE5RRytXVVpXTU5jQjZLZjNIVlgyTXFNZ2hWcEwvNUNEZyt5ZlUrYVNNN1hk?=
 =?utf-8?B?cE9qRzJxUlpacjN0bWE0YUJJcjZ1cVdSTUFVZkNaaEdCUnE1NlhFZ3hKVG9Z?=
 =?utf-8?B?U1Z5VGlGWkhkeVdZVkZZVzhBcC9kSUZnSlRZamptdEN6L3pxVVNZZitsZXdp?=
 =?utf-8?B?UkIzSFlDbW12a3dVbHliTHhjbmM4b1NwQVltTFlaM0F3UDRvNmZGdDdyOTJ5?=
 =?utf-8?B?MUx4eS81Slc1eWdpbHZnL0ZOU2tINXRML1BLejR3bVYrc014TTA5S1ZPdkpE?=
 =?utf-8?B?ck5TTzFrS055eDhST0IzVUhzdktFQWZuYUV2WlBEaHo4bjF5eC9LSGpIWEpM?=
 =?utf-8?B?QlczU1hWK3BBN0J5blBaNU9QdWs0bDVEb1VFV2tsRWMwenE4ZzdUQm5NZExa?=
 =?utf-8?B?MG9HYWs0N2I4ZlladnRBQUtKdmxKaGxnWklIcjRJQmM4czhsUmpuU1BlZnZy?=
 =?utf-8?B?aVVRM3o2SGk2UlM1VzRtb0FYdVJZYzBjckhVT1dEMHhla0toZGNYenR4cHlC?=
 =?utf-8?B?NGRmbXBzeXhKbjl6K05aZ0lQU1dhZFRuZ3QvaDh3aUx4NThmNkFhSXhvZFRq?=
 =?utf-8?B?ZXBCb1V3dGdQMm9sbWNMZ3lqbXprMklyMkw3OEZTc1Vqa1dKWmZpZGFUaStW?=
 =?utf-8?B?QnZpVmovbjNrbzZJZEVRbis1L0J0R1RlcUNpSzB4NXp4M3dMclpZUTRUZmYr?=
 =?utf-8?B?ZmluR0JYTk1PcXVlVmpFM084dncvQ2VyNGRCQVA2VmgvSEx3eVUzdDJ4dWpJ?=
 =?utf-8?B?QWxLRVpLa2wvMTJHREpDemdYanczUTVQVjdhU0NaMW9UTFdSUmpuOVE0L1lt?=
 =?utf-8?B?RHZhb0F2RmoxWVc3T0RWRkJ2d3VEdWZKQWhydGEyVkpndzI2YzVoWXp5cEVJ?=
 =?utf-8?Q?7AqlJZIvrdNxJvrnlI/oZkS7PRqo95c/ZSOxs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bHJkeGpib0Q1dWFVZWlGWVRiQktuY2UwYm9WbUNqdFBmUzBOZG9aS0V6U3h0?=
 =?utf-8?B?MDF0OGpIZTFMQ3ZuUENUN0NqMWZ3cXIzNmRTcnRTcDVtVGxpUkxPL21JZXls?=
 =?utf-8?B?TjdLUlhHYjcrMFFYL1NOODBvVUhBSlo2MnNlRS9HTE9VTmNBMzArMHJmU1pQ?=
 =?utf-8?B?aWU2MDN0VFU1QnoyWmdkekpvTmJ5TW4rOFhHbG1LYW9mQ0k1c1NsREFRSWNh?=
 =?utf-8?B?U3ZEM0VSQlV5RkRLTWQ0UGZEc2hBQnlkVlRYVThLRGtDdTVaZVN2NS9vdHFj?=
 =?utf-8?B?dHgzb0tsejBzTWFYRWZGYWdTck9YN2JjdzcwVUowRVR0UmxsUWx2OHBscEtT?=
 =?utf-8?B?bzNoMXNxRTQwVk9MSmdPNDRqNUJoVmY5VysxU1gyMmkrMDZZcHZ3c3ErYTVu?=
 =?utf-8?B?ZGtMa1dpK3F5MFIzbjFhRFFMUG5nTkxRL0kzZDZWZjVxR0VRcUtoR25hRzNP?=
 =?utf-8?B?VnFiWWlFUzlPWE9aUTU4ekNDMWxpT0lDNS9va3BDbUFZbTUzVzhhVHZzR2NU?=
 =?utf-8?B?ZjVwaDdPT2dxb3pvTWx1Q0FjMWdIMnBBckNIMElZQnFaSGdta1lkUGgra0Y3?=
 =?utf-8?B?NUVRQjFBY3JjR2l0aUVZVndlREx5M2pwMENwVjBMaGUyTUFjVnM2Nyt3alpW?=
 =?utf-8?B?Vk44RTY0TnB5ZmF5V2M5dzhwbnFLNC80R3JvSmNFL3lIc2JIbVVSUmtWaXJV?=
 =?utf-8?B?U0NBU1BYRG53UHkwblkrdHNJV3hyN2JyTVpQbmJEWCtnb3VDckoyaUxOMDBX?=
 =?utf-8?B?VjhNMGNEejRCL1JkY3UvZkJlUDVvOGIyWWlYTmZlc3hIOTFXZm9GeVcwdkwz?=
 =?utf-8?B?SFlVUzY5d2prcElRMXVsU1lnMXJYMjlSTURMRGZ0S010cWRKT2hrL3ExYkx5?=
 =?utf-8?B?VEpqYWpOeDZWZ01nS3BITDFOcytrVnVpckJMNzZIUFNTKzcrZkpkRFN6clkx?=
 =?utf-8?B?L0xORENNU2o5OHg5ZkpvUm1KYWxpS3pzMjdRdHc2SVpvNjhTa1JwbmZ5RXha?=
 =?utf-8?B?S3U2aC9hMXFUV20ya3ZUZ1UwbTR5d21YUHlqNUVkMm1RQW1DVnAvbU81UlY4?=
 =?utf-8?B?VHg0NERnWXY5MnN5elBsNldEeTRPUGRUenlCdjR0TGRvZWE1SFZLOTJMNGkr?=
 =?utf-8?B?VG1PbkMvZkw4a2FCekdHeHNqNkh4aThZMi8ybmNxL1Urc2ZBaHJpaDZYaEhO?=
 =?utf-8?B?WHY3WW45MmVCY2tTcC95R3g5NW5jMlMzN2l4clNpbVp2MDhQejRPbEY3QzJ6?=
 =?utf-8?B?NWhRdjVDRTRrcXRhUDdpUnR5RmdBWXhWNEdTNndVZnY4THZibS9UcDFNdFE0?=
 =?utf-8?B?emcvRVg3TUFkK2srMk16c0N5MEsvRUU2WCtYc29sQkJpbytYaUxsWnhzV05u?=
 =?utf-8?B?enREVldnY0Q5dUUvK3NXUi9IVjc4eVd5NUFoNjlyUlVUcythYXBRbjJMMEIv?=
 =?utf-8?B?bW5JOWVZc1hRd01pWjFjbUZzcXZkaW5wSXgrcHdlbzdXUEpBMFN4SlJhQjJm?=
 =?utf-8?B?UWRHMSthWDRObW1IdWhhb3o1TFRSRjdjQTJjQzl4S0pkZVpnUWMxMXN5SWMr?=
 =?utf-8?B?dmZNUTVWV3Q1dzF5Qng2YW9ad2EzUlF4Wmo3cTNwQmhKcHJHVkNlNjFwbUpx?=
 =?utf-8?B?OU1rMEg5VGVHZWFVUkVjSjlVemU1SFI0SEFxWFJzVDNzWXpCbGczS1c2b1pR?=
 =?utf-8?B?dXdVUWZWNGpSMXFJcnRwT1hrdlJ4QlFXN1c5WUoxMWQ0UzZ4ckx5VVN1c2x2?=
 =?utf-8?B?KzJjMXM2M0Y2N0hscDhseEEwdXd0TmoxVXdvK3NQMkE3NEVnbGkrYmFDekVp?=
 =?utf-8?B?cWVQSTBkR2FTVVlBT3lEdWdqRTdncm1hOXJjVEF0MmNoQ0Y1MzBBVVdFWkwv?=
 =?utf-8?B?WllkUXRWZHoza3U4OUhpWGl1cGs3Q3JYV3Y1M2pQTk1IOStVa3RoYVVhWUgx?=
 =?utf-8?B?dXlsckdQZXYwVVgwNDNGSUVrNnpEellCeTVvS1ErTmZFaU5ZdHJRWXp1WFlr?=
 =?utf-8?B?RVY5a0kwNlpCeHJWL3NHeG5MT1h3YkRvNnVxYjByTU5vOFRROWdJYXVGb0h3?=
 =?utf-8?B?ek1KVFV4NldsYnQwTDlVQU41YkpndXY2am1OYXhkc1REQkdMSDNHMlpjbWZs?=
 =?utf-8?Q?NXhe+f9GxWK2z/PAygmfNSx1W?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d19e67-df5e-46a1-9d98-08dddafb183c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 06:23:33.6896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDS7dlY10t0xj5uA3v22eTSAwH7xJcrlQ3o1pIt+cZ9DEHHAW+UEQ1QOvYlNIJ2lzhRTyhcPUx8zUbG6irFVbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6705
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Aug 2025 06:23:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19738

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=8&day=14&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/08/cip.2025-08-07-13.01.log.html

* Action items
   - draft CVE handling process for CIP kernel [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Aug 14 06:23:13 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Jul 30 11:27:27 AM UTC 2025
  limit date: Fri Aug 29 11:27:27 AM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Jul  3 11:41:37 AM UTC 2025
  limit date: Mon Sep  1 11:41:37 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Thu Jul 17 08:30:58 AM UTC 2025
  limit date: Sat Aug 16 08:30:58 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Mon Jul 28 11:47:40 AM UTC 2025
  limit date: Fri Sep 26 11:47:40 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jul 16 05:30:11 AM UTC 2025
  limit date: Fri Aug 15 05:30:11 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 18 08:16:28 AM UTC 2025
  limit date: Tue Sep 16 08:16:28 AM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Jul 15 04:51:02 AM UTC 2025
  limit date: Thu Aug 14 04:51:02 AM UTC 2025
  Status: *Late*
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Thu Jul 10 07:45:38 PM UTC 2025
  limit date: Mon Sep  8 07:45:38 PM UTC 2025
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Aug  8 12:49:51 AM UTC 2025
  limit date: Sat Aug 23 12:49:51 AM UTC 2025
  Status: On track

