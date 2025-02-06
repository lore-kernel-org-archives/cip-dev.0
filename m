Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66BCC0219B
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 09:15:43 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.54])
 by mx.groups.io with SMTP id smtpd.web10.36378.1738833340924728137
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Feb 2025 01:15:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cSQHa46s;
 spf=pass (domain: siemens.com, ip: 40.107.20.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ondat2BgkeZqnLCLtUd0gkYlJVcKz+dtyDIJundCQk9x0TUP07mhtvthT/P7468TGQiG5Df4rISAq+B8p9itISdFUGcwHwn8JNmh0NG5sEnLFM7gwRQhp7pPK0Er2NfWlNc+3FJ4qsDiaHzpvnFEu3hg3sx5eDRKifLLy/FEQ2SkozKMUrLASvR71HRnF7vt+2mnhClZaUFNZ5BLxCvsULxJE/zXHu6DG1Sjb1hPkaGnLl8yEpsJIP8gAgjToHktCv+IDn6GrlCEpwWOMeyQrOSTc9L/8diTYzRE51xqd+7cOLfiIRhEQ8HT7ViTz7Q3TDmncifZIWvYAEzP6tWVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIHMUV9dNpf3iz56FUsTNtUf8A2AmB0qtynnaBMAbHI=;
 b=bEv0YmJeL9wxv+XLE5bExAh4srjgyofr7XBAFw7WeT268HuNshoMBs/QywlE7V5unPiBA3mD+OvaHJkfX8pDy4AYx8vXs4R1LXmy9YdpSI3LbSfYhYY7m+Hi+tPbroGdGUNVBGWZnD7V6DepSEUDvrB6XkoTk6+koc3gBsChNk7pCVuHzrEe3p8xO4Gp5wklBPJLwOLs1TWBS/7UeO6nNZrvMzrKF6zXlAvVrra0nj9odxOuOxzjnC0H84jwWD6sU6lus1wLx6Vp0Rma01Kq5oZbVVrm2CVQ/HqjVlvStqcNf2drZN20U3yqm/zf+A0m6ykthqyheRv7xzVcWinofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIHMUV9dNpf3iz56FUsTNtUf8A2AmB0qtynnaBMAbHI=;
 b=cSQHa46svnSAOAM2XBMN6gPB1XbmaIlGliaZvN7HoWujpZ5Rjxt+aYekriaTlnHpUe8utBB7rKEgQ23F7Y85D1iTAt+D4JaS6tJ45oEG/LIR5UNkWZOVYd5BYjWEY1CSNPEtM56boCaJ9cXr1qyg52r0JrwD1dxeQbAFfd+BT7ypB/W9S0dr0v92l8JKev/I4ugCGtJF4NIBbwTGUK0qikY9L7H4O0zRFQACXvDoBFnp6i6cpQJt+Q4YJ1zx6VMZuPiUfU1nXKoHgKZqh/CrBtgLeDHhGtXjDgLcrzeabjExmhMI4iYyVT9g5CGRwsE+zAAp9qNW/Tx4pzwKBvYXIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 09:15:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 09:15:36 +0000
Message-ID: <ea12bce9-7ea1-49e4-9536-4849289e4c1b@siemens.com>
Date: Thu, 6 Feb 2025 10:15:34 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0279.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: a81fd651-996b-4b91-2304-08dd468ed0cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dys5SUJPaEVwOHFvSk5pMTZ4ZFg5UGE1SXlQTnJjZEl4MzZjZjM5bUpNM1ow?=
 =?utf-8?B?UFdDWStRdHZUeDlhMWFZVHlmSDlOcG1DZmNTbXNBQlZzOEtWUUN5Z3RlTW9H?=
 =?utf-8?B?enhXdSt0OGhaU1FHbjY1dGNiQ21tUWo0REhRTGRaMlBMbHphNm1mZjlQVHBW?=
 =?utf-8?B?Zys5ZFd2SXJabGV6Z3ZjSzlVWFQzTHgxaFQxdnBDbEtQS0RMa1hTdHFRVDR4?=
 =?utf-8?B?MlpjUER0TmRxVkM3emtKeUk2ODlhcXQ1QW5jZGdVeXRKZG1jZ3RBR3QvaFNH?=
 =?utf-8?B?emozMjlTSm5CYVY5R3RFMlM0cE9tWkJMMklzTW53dUxkOHg4T2lwQ2UxRHNi?=
 =?utf-8?B?bEJIaE9xK2Z2Qlc1aG9OTys1aVpoeVY2VHRhcWZDUnpNOXJkVUQ0dk5oT212?=
 =?utf-8?B?aHZ4VzVMOU1uY2RTenZNRUtLN1QzSFF3cDRoWXVNZS9LS0ZsUWxEb01DUk9M?=
 =?utf-8?B?MkJXNDQzUVRMelI0WFR0NEpXeFVFSVUxM0RabTJ3S2kxbVVZRkNRRTVOazlI?=
 =?utf-8?B?aXhLTmdsTkdtZXN1RVZMK3lGSnlHK2phM28yM29hQkpZaVo5RzhYdHBRUW1E?=
 =?utf-8?B?bXhqRU14QlYwYTdiMm9xdkVNa3VkZ2VVdTQ4RGNTMU02RTJSMnBrUHg0OE41?=
 =?utf-8?B?VFc4YUlvSTJNQWtQRHhmemd6TzR2dEpkNmlTYkh0elY0b1F5eUJUWkZGaGNC?=
 =?utf-8?B?bllHamdDQk1INDducTZDbEpWNi9iS3g4dll2WHRKck51SFRYSVJIZlFFV2tI?=
 =?utf-8?B?M3pOV3RnUEFocmk0VkJBQ2lSaGpmVDVRZEFiODVRaEZJL3I1TncvdzlJbDNO?=
 =?utf-8?B?SXdjQm9WR3dyUWxNQmdhVzdtNURsa1I3Q2tRZmRaclBjV3BnVVFsOGZzQ3dV?=
 =?utf-8?B?OEFDVzBybkR1YlJOeTdhNFp3YW56b3JuUFpzWVhiVWtUVHRkZkFNYWUrSDNK?=
 =?utf-8?B?RVRFUWV3SHNkL2pkS1NMOFdBQnpyeW1HcktsWkdkS0VTV2dGS21hcXBTZXNt?=
 =?utf-8?B?RnpRelIwZzcwZmhpZ0ZZL0dxTi9yNk45blE1VGZWSXpMNFBOY0ZrQjZqck5V?=
 =?utf-8?B?eU1ibER6YktVZlYxd3NQTlpXQUZsMHpWcldjYjc0T0NoYWxNd1kwd3BwQWVy?=
 =?utf-8?B?aWE0YTdBSHI3MkFQUU9CUTVNMnI5aGZwYUJuWVdaVW5JTVI1bG9mVWJSNlpL?=
 =?utf-8?B?c2N3c1lJTGJza1ZZQjFJQncvcTNzS0wvQ0ZRbzRsdmV4YkptYzJxeWhUdDdH?=
 =?utf-8?B?dzY5RmRUVmEzdTlQbWZ5SUdpeWxCaFdLajBBM0tQenZyT28xOUZNejlhWjBR?=
 =?utf-8?B?N29kYTdyMkdXb3JEZTJ4MDA0bWFveVUxUU16NmczRTNHY2NSUjlPNnBieFVl?=
 =?utf-8?B?WHJBemhxOFRFTmZVckdzMkp5S1oxbVNUSEdkdlNlWXp6a213UzloUkI2UDIw?=
 =?utf-8?B?RHZZbFhORDZwWHVFdlY0VEpwNVBiMjM5UGYwcS81ZG5JUnIvOU02Y1VvTzhx?=
 =?utf-8?B?RjZQeVRxT2YrVUNMSEdsRWtrQnMrOS9aVEJ2RFBrb1N1dGlyNXpqSnZ2L0dV?=
 =?utf-8?B?c3VEVG1iNU5vcGJUNW9hQ1BYcVBiTFAyaE5JbHhTSFhQZ3lMYzVKOHp6Y2pM?=
 =?utf-8?B?SEdFWU1XM1E1TVdqVUZZdktHS1Y1RlpFTGpFd0FmWTY4ZnRhaWxObUhmQjVW?=
 =?utf-8?B?RDE5K05UcXVZWXdSVmhpWjZwV1R4YittamtWaExjdUI3d1cxdWFUNjJpNzEw?=
 =?utf-8?B?akd6RHVGSGtRNmVDeXU4N2pjbTlzQ3p2aHBtVTdWMkc3YmpleXloMmQ3UkpS?=
 =?utf-8?B?eThNUHB5ejNTREFaa0ZGdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ME55cHcyT2s4Nk1QMWE5QVVnODY2VVhXcmNCU3ppMFJ5RkxoNzI4OS9IcER2?=
 =?utf-8?B?ajIvQkN3THVNcUJCNjJMdkVJWkRPM0JoeTNjMHlCS1RFbzYzbzdZSzZENmcw?=
 =?utf-8?B?dVlydlR3Z1orMGJhTnB1QTY0a0tzMmR6cGxBSFF1RnIwcFA1aXJHbFdDcWNX?=
 =?utf-8?B?K2JxUDUrY1JTYWhUTGhJMUYybDZwLyt2c003RFNqOUN4L1drL1p0L21qQ3kw?=
 =?utf-8?B?SVBYTkM3TkFualBaSmJDM2VGbEVRYUxGTHBNUzlCQjFUSmFGZWxCUmVHMW5j?=
 =?utf-8?B?MnBra2tzSVRqd3AwSlRPcFBHeUIxWk9acDUyQ1VhR2VjeHZpKzJwTUJBaDRr?=
 =?utf-8?B?dS9sNjUwOTUwZy9ELzJ1ZmluZXJFK2M2Wm0rSysxU3NTbTdEL1V6VHkvVUx0?=
 =?utf-8?B?SUtoY2V5SDFWTUtXNXhWTDNpYytKOGpvRlVKbG00Y2VjVjNFdjl2ZXExbENP?=
 =?utf-8?B?VWZ6RHR1STZZMDNFUkZLV3VydXNlV2MyclZJVEVlcnBLZUl3dUdOSzBoTkFN?=
 =?utf-8?B?NmRtVlJvNGJVNG5oWHN6aVZRUVJNQTZCWFMrcjY4bnlQanpKb3NjbzRpdXl0?=
 =?utf-8?B?WWwzeWJBVi9IV0I1cTliVUExbHVmVXpnRmJhNHpRNXpjdE82cnU1MUdZL1Fa?=
 =?utf-8?B?Y2g1ZllnM1hUdzdYa3VuNGllQ3IzeGNQRmVXV1YrZ1pwWkZBak1qWmFzU3FJ?=
 =?utf-8?B?bldmWk8wdDF0UFNQTDRBVlhBei9Ld1lxcEkrNDNkLzkrbjZZK3BsVXRPbDhP?=
 =?utf-8?B?SklvUnp2OGdiZW96VGpIOW5oY3dYSGE4T2ZMelhYQVNGcDBaci9LYWpTWm9W?=
 =?utf-8?B?RlpGR0YxYVFoYXBJLzRvQ1NJN2dMU2kxaWQwTm9LYmNYS3FQeWdQVDVFc083?=
 =?utf-8?B?RkIwd2pVdEpDVC9uWW51K3RyeThaRHE3OVlXeUE3THlqNVF5TnJ4cjNPYjJk?=
 =?utf-8?B?c2dCL1ZUQmlMVGFyTlp3S0FtZmpUMmZjV3BKZTh3ZmJBckM2NFIxYUNHYmdm?=
 =?utf-8?B?QjYvZEpuNFJxYVBuMVlVL1AyY2ZmZWZYNEg2Z1lQbEMwY1h6cXBvZXdnRmN0?=
 =?utf-8?B?dGV5YU1yNDNHK2pXaWJQelNHcnlTT0lvVFZxdjhzZWQ4SnpVM3hZalNBZVUy?=
 =?utf-8?B?L2toZ3VIM1pGMlVid2JpNlNxRW42TWQ1dFV4MlFOSnpGQXljSEhucUtPSzBV?=
 =?utf-8?B?dnlOVnlKci9UM2gvYU5rSWRDNUgwckZpZ1dLTGcrM1lTejNnMGcwT0hRNisr?=
 =?utf-8?B?ZkdQVkgxU29xM1l1ZUlta1JPUmYzVzVqOEozVEJCeXM4amZWKy9lemlUWVZw?=
 =?utf-8?B?L3Nyb09sSmZZQi8vMGpjMEFxTm9zN0pVaHJ5UmRhNGVrNE1PVmR2YUFKbWFI?=
 =?utf-8?B?KzJoV29oN2dTYk5Xb0UvWm55VGpBYzkrcTYvaTdtUk9wRzlYbTZFT3FzcjVD?=
 =?utf-8?B?NkNHQmFDYUlZcDgyTkpOZDVoaFNpc09sVTRkRTNQQzF6UmFGbG84ZTZYc2ky?=
 =?utf-8?B?MEFraVUzcVZNSzRvNEZUWmZkbWs5ZGlUeG1Fbk5IM3liaWNDRS9uRS8rRHlr?=
 =?utf-8?B?dzJDMWJBUmZGUjRpNjZoS0lwT3c1NXB0SzV3eExRclhVYzJZa0l1a3hMeE5h?=
 =?utf-8?B?QXBQWXViaVBaZi80SStyZFpHMkhUajdPdjQ1VXhkQVJUaGt1NGU3RXJKUDV0?=
 =?utf-8?B?dlNpNHMxcHV2a1BnQmI1ZnZ6d2Y1VXdjaC9JdjcrYk9HQ1VtQUQxUmhGRGFK?=
 =?utf-8?B?dDgvaTc3S0hYblRrZHNHN1Y1dXlhS0tPTEZtc3BCekplbUZPckJWV240Y0d5?=
 =?utf-8?B?bzZtNHBjemE2amNDdmtpYm54SXJpM21DSnduRC9sNUdsU1h4a3d0NWZLQk80?=
 =?utf-8?B?UjhFMmlaSENOL1dJY1V3U0FpQXZiYjBrZjc1OGlmUFNBSU0xd1dsZG8zdTZ2?=
 =?utf-8?B?NDhlejZGSEM3NEw5aDFoRVpSZFlaUlRVaytjT25JRmpLZVFxR1h2VzZQT2U4?=
 =?utf-8?B?TEQ0djdOc3JucnhaUjdHMU8wMEViSTZNamlTTnZ4NVp6M3E2K2hmVlI4dWdI?=
 =?utf-8?B?U0RJOEVHRkFPcWYxK2RWRk1rdVVWMm4zK1A4VVhXV3JNbTlQQ1h0TXYyUzBz?=
 =?utf-8?Q?1TDZmZumwkFbIpcVwC7n0aD9T?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a81fd651-996b-4b91-2304-08dd468ed0cf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 09:15:36.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbCz75PHXn8WRU86D6mCHr9b15HMwK60KP1o0SgESJQIdTPESqQra+vocyHByA2K/Xod1GrcNF9Yu/TGceF1zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7992
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Feb 2025 09:15:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17758

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=2&day=6&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/01/cip.2025-01-30-13.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
linux-4.4.y-cip: interval 30 day
  latest version release date: Sun Dec 29 08:41:22 AM UTC 2024
  limit date: Tue Jan 28 08:41:22 AM UTC 2025
  Status: *Late*
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Thu Dec 12 10:45:41 AM UTC 2024
  limit date: Mon Feb 10 10:45:41 AM UTC 2025
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Tue Jan 14 02:33:46 AM UTC 2025
  limit date: Thu Feb 13 02:33:46 AM UTC 2025
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 14 11:41:15 AM UTC 2025
  limit date: Sat Mar 15 11:41:15 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Tue Jan 14 02:41:29 AM UTC 2025
  limit date: Thu Feb 13 02:41:29 AM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Tue Jan 28 02:45:55 PM UTC 2025
  limit date: Sat Mar 29 02:45:55 PM UTC 2025
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Tue Jan 28 09:48:17 PM UTC 2025
  limit date: Wed Feb 12 09:48:17 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Wed Jan 29 09:12:10 AM UTC 2025
  limit date: Fri Feb 28 09:12:10 AM UTC 2025
  Status: On track

