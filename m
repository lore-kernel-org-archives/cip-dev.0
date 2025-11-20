Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A0BCF8552
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 07:43:24 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.29629.1763624603169966126
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Nov 2025 23:43:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LdnZL9eN;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.70.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsZUPIp+/PbmYl3vFWZQLn9onSTmMAgR3keh+IMQ71Rj4x7eCMwrr0uYXNRAS+eAGRLcgOLxpLR9qK2FlF+/uac4FoVFObVryfzRC09GMLeXf1TcKv2FG58PAOlrUwkjbI/HALIc8t9eK2EsRSr6kUPuR/GPCNmhe4KaA3GosAXGjIZzNC3pjJcZA5CoWytwGGwDczk1lC7qPnELgy0W5Du5rppWb4fGy7oXJPD8MSoiXoOIZ3NIMVqDHXRgaEp5fXfzY0BFyR5IHpIL5X58eRyaRhlxCclQIjtjUM40gRt5NrbPhY3TdxMr1Kt59XitZaxtY1nA4p2KWrQ4AyOmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Doj32p+XkwciJNJV2c7P5Ft4RzS874enOd3XQ2yNKC8=;
 b=jmjZI2mEJNyucluvUIhxiTIk7ljWjEqSBE+O4PrsxRJP+opgGY2pDd3RYFzYkSqZ+KQdCB5VU4rdDXsUmfKG4cEBjChRu5dooN/4v2ighZBMFQegmJrfs3XGGMJ9XQ2SuMO5m372dPhPr/5jZ923frHfdNqP2OHmoO8q+JwHbdMtxFT/3qiGoNQlYbJ65oYBfJwsRBBpgJ3JzVxVx09DEqnEj8hjpH6NQjRs0u8iRMDtCD36nayQyRfFwrfUHB3qqnyoWXtxbsznvppxyjAGctAiiio8ImgpakgL/o7aZkVYv07CCUVgMC1P3ml/WHYyKlbaSjtsQfSDdpCgrvftWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Doj32p+XkwciJNJV2c7P5Ft4RzS874enOd3XQ2yNKC8=;
 b=LdnZL9eNPfsDYhwXTX65lh/Czz4vOYqb8CtdBEFci1inlWSlCbpHlxDkHTMCIumI/ZZSdDvl00HaBZ7I3jCH3Ao+S6QEbN4B5BPOGHrZ6LzgbZyREcRS1gZjweTWAv2snLQ0L14CYWd2qXqet47H/2tYf9c3PP4rCK6WVfaYq0u1LtXpNl6655/cNwhjkQxG6KfdRm4BaqNw5OUb47qQxt/yYLmkobZno9BpE/0yoH75dNrqyWM6A1wtqJ+GmbcUfehRxOyBoFTpmqyjkMGVLb68zTcgIgjTCofzkRnJ9/sMZAhEyMfGZ4AgX4wXkmortshlzlgH9w+9uKPpc/5f0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5349.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:289::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 07:43:17 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 07:43:17 +0000
Message-ID: <9fbe79d9-fa18-4e66-a742-e0b37e184abb@siemens.com>
Date: Thu, 20 Nov 2025 08:43:16 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5349:EE_
X-MS-Office365-Filtering-Correlation-Id: b360a233-fa38-440d-365a-08de280877f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VEJ5SXljaUhlYTdJNTN3cTZmajJTK1ByNHlkQS9sN0J1bVVTYWF2V1ZjZVRU?=
 =?utf-8?B?SXIrRnZQemRLZ3RSNFRFSmdyM093bWJ2WGtqQ3N0ZDJYVm9jVXQwcHgxSktD?=
 =?utf-8?B?aDRKdys3eWF3R0tSUXJWV1dZcEY2UFlPU3JQeDVLUzdHdW85VUowb1ZiamlQ?=
 =?utf-8?B?MDFlZnZjNklpTStCTmhyNXc3b3FrRERISU1VSU8yd09JaDR4L2dKNlJ2dXBS?=
 =?utf-8?B?Mkp4Y3hiMEQ2c09yUFpwWlFSS0tEVW02akowNERYOFNpclBnVE5MTm5zUy9h?=
 =?utf-8?B?ODBnaVhVUlBMNzVybVF1eHM0cFpMd2h6L291WXJTZHpOeUN0Z1ZPazNFUjNr?=
 =?utf-8?B?ZGEwb0VuSGMrOGxDY0VCbEtkTlR0bmJvSjhBOGxlMHNEZ3VxeVVOMHhDR3RE?=
 =?utf-8?B?NDd4N2JIaUxNYTk3UXlKcVU4ZEZxcGtvaTFvaGdHT3RxQWoxNjBOdHBTZ0Jv?=
 =?utf-8?B?TTZCQjIzVEZRSGZ3OG9rS044SklLZ0FIbit5a0pWNmY5aWhtYmZiRzdoK2tt?=
 =?utf-8?B?ZkVQcGdOc2o3Y3dYUVdyc1plT1FucnZxVnJRcDlpZkF0eWljeE9OTThmWDkx?=
 =?utf-8?B?QzZiUXJzb09qMGN0ZVA1NlFnNmJ6YW9VZyt0QUs4cGJuNnJVRzNUTEx3Nk1r?=
 =?utf-8?B?VVhwQlRVNXJoNEo0VFdqR2hKNGxxZERndld6dXlMODlRQ2ZvRmR2THBTMTRV?=
 =?utf-8?B?ZS9EeFFwelFaeEczLzhudUcxOTBYc3RqV1g0NzB5UkNIWVJ4QnMzQ0dJTTFB?=
 =?utf-8?B?MEJWY0ovSWVRK3p4VDNNS2ozb01FOGQ4eTYzOG5RNDYvNWxWVWNpd01TaXF4?=
 =?utf-8?B?aDZ4UFBKTlNQZDFobkx0cmhOa1Zzei9rS2o3T1JPK0wzVTJBOXA5TXlYeEhz?=
 =?utf-8?B?Szc3Y3hxei82TTZOUFoyV0V0MkhkVVlDR3FXSDRIdENJdkhSZWdCbzY2RUp0?=
 =?utf-8?B?cVVkNVg3SXZyWWo0eFdZLzh4MTZvV1U5cTNlYm1LYXlDQS9aamlmME1KN3hW?=
 =?utf-8?B?UVExREl2OUxZWFEvWVVWT2hPcGRjM1hJVFVrRzZuNlRQb0pmV3dnTWhkaWVo?=
 =?utf-8?B?WWo0WmQ1V1BDWlFzcWlseHBvNEpiQ3BuY093cDZYQngzME5qRVZWZ2VlSmlL?=
 =?utf-8?B?bkl3djFMV1JCV0tVTnhjdVVGbkdkRVhFTkZ1TCtOVGFaZ05FNlVaN24rZXRv?=
 =?utf-8?B?RlJPMmJ3ckxwOStEajZJRlJCWERCcEgyMHVLVGRUdDRPbDZBb0RIclRQMkdo?=
 =?utf-8?B?K2svc3Y3USsyNkhqb1ZOK1ViZHBIVUZ0czd3bUxWSVdrZHBONUlOZjNvbEhR?=
 =?utf-8?B?K2Fsam9IWFVidWU4ZlVqKytOZy91Z2RWam53UFpvblpzOFBua0ZWWEdHZ2JD?=
 =?utf-8?B?Qjc3TUtLcXB2eU5DbHYybnJIT2plUEx3NmVlbjluMG5jZWF0SDA5UjIwLzda?=
 =?utf-8?B?OURPRkxJcXFPVkJ4VE4xMjJpSHRRNXN1ekRNTWZiMU15eUhqaGdYWk5MTzVZ?=
 =?utf-8?B?Z3lFWk54a2JWQU8va0tuSytkQ1BtRkx4VHRkR0VtN2UvWDRpUDFUYWNhOXJh?=
 =?utf-8?B?L1RFZHppQXhmSWNMVnFOdVNja2dQdE8rK3o2ZXA2U2dKZU5aRThLZWtQUTJh?=
 =?utf-8?B?cDQvYjlrZmZkQUxYZmtzUHRYdDNpUENDaGM4RTFuY1UzYmt4Q2cza0IxUThC?=
 =?utf-8?B?aDVZWWQvZk5kd3JMSUM3MWw3ZGNIa2M1YWViUGJiYlVRZkcvWGh1VUxLL2JJ?=
 =?utf-8?B?emJzbnNZWVFsWEtMbDJSRVF6QnFTSW1HcG9vU0NLeFBwM1RkeVpRNDlzVllu?=
 =?utf-8?B?Tk9nbWVBNWdlUGczaUxzY1hXUWJTMDdXTUVETWw2VURPSU14dHJoUjY2b3I3?=
 =?utf-8?B?cEh1SzBxTUNnTWppM0xrTzlLbFc1RDV4OFJqdU1BSTJhT2c9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTF6UFd5dDd0bGcwY2hEcFlvNVEyd0xzMUhvYzlTdW1iYlFWTEZaRndNZGtE?=
 =?utf-8?B?MFZCYWJxelQvaUMwcUF1azY0MW10UGMycWswRitZRkdxTVVzUEhPektQUXg2?=
 =?utf-8?B?OHNWanF3Y1FzelIzbHg2dk1BSm9BTUtKK1QwSFNaajdqUnFYVlZObmtiUTFC?=
 =?utf-8?B?MTlEaTRia1dTSFN6eTRSU095QkZPRUhBRVNDamQ3dFdpd28zeGhHajIzOTJY?=
 =?utf-8?B?MVRNVllzdmRBWVNHZ1l1ei83NUFsRWNsbWUrS0E2bDBEQnZGQUpCUDh2b2s4?=
 =?utf-8?B?VVpvRi9wQmhsbDU0UVM2eFZSNlhiMy9wMVdVcUlveDFxQk02Q1ZCTUEzZytW?=
 =?utf-8?B?U0tTMXRxcGxIN1FNNzhsNUV3eDNWUUYrZFJrbnNtRVpVYlJGbFBLcDdEcENl?=
 =?utf-8?B?UitpYmlQUHlGK3p0WlJZMnlkT3ZiUXYwK0hBQy9yWUtJWmx6RDBhenpoc3Vt?=
 =?utf-8?B?U3JDdnA2b2tvT3BUZkpOcFVKYlAvdHRtTFBWSFNsd3JVOHV6S0xyeHhMQzFQ?=
 =?utf-8?B?UFdwTklVdG1vazhIdWVlWllxelhRUk9WbG0zb2Z0bGhILzJ3OGFTd3JUOTRM?=
 =?utf-8?B?SHRGTXNuZWVqdy9WeW1leEsrVWJ4V0g0eWZFTGFzTmZneXlXZ0t0TEVVLy9H?=
 =?utf-8?B?RlQ0R3FzU1Eva3lCVjdyUUNuN1l5SExjMEphUDdYQVliejFERkZaMEwreU96?=
 =?utf-8?B?K1NLVFlmb0U1a2taQldOZE00OTh5WjBGME5kSmR4ejgvK1VCSXZ2cXF5cWtp?=
 =?utf-8?B?UVJEUWx3SVJ0TU5ZVG1QYXNpb0pubmZ5d09lSnAvQnArRzNxc2N2bitmTmdv?=
 =?utf-8?B?OEZjdWkrRnBsVk5kR0JIMnRrVTJTanpXckJTc21kV3JWNE5vWU1idkZTU1Jp?=
 =?utf-8?B?UllyM2NYakRFOEFyd3gyTXJqbFpZUGlRVHI5a2FtZmN2Tm8zbndZMmM1bHk2?=
 =?utf-8?B?N1k2VmY2SitaRElBaGt0RG5mTnhhb3JwdFRwNmVoOUhxUS8xQ3A3QkZpdGc5?=
 =?utf-8?B?b3hRVkRheTU0eGJiRXVMQlEzVkxxZTZIb2JvQnpUQzVYZDJVRVgyVW9Bejls?=
 =?utf-8?B?MXZ1UWQ4bmNnUWpmRzU5MkQ1aXNLaFJQb2Q5ZXZId2ttbXpzTmFDc25MRnJq?=
 =?utf-8?B?aFVjSkNQWGJ2dnhuZ1hNSzJzYWhqb2N0ZnA1T3ZWV1JscVNqWEZab2E3WlRh?=
 =?utf-8?B?Zml2cmY1YmNhN1FZbTZBUHQ5QVVWZkJNR1ZyTWpwMU4zeDJYM3p6ajhOenRy?=
 =?utf-8?B?V0VxK1pCYU1wd1BRUjVFSFV4WFZaS3RUeldWR3hYaU1NMEwzZTQ5MzZjNThY?=
 =?utf-8?B?enJzMlB2Y3psNzdxbVIzRktiWXZHWUx1WFlOU2RKcUcxZmZ3YmhyR3ZhOHAx?=
 =?utf-8?B?WkF1SmdxVndlSEFKeFc4T1lXbVNETHNsK3pWeHVyL25HNkRjQ2ErVVNSSzJl?=
 =?utf-8?B?ays4TVNLUjdpV2p1NGVkRU5EQllnSU1WNUJ0ZElDaWh0ZXJPWENQZGVYbi9p?=
 =?utf-8?B?RUpqdGVJZ1cxK0ZEbnV2azNhNGU0dlR6VHZJbHBtK3RkRVhERkRGR2ErdWNz?=
 =?utf-8?B?eUJjQ3VULytTeFovNHNNbldBc2RkTmdUcWwyYzZueU9YcnBPejR1TllmazVI?=
 =?utf-8?B?SjhaRGNQTjU0YTh1Y1lkUktRZW9aSEhMSWhsWjloK0IzVGMrSjAzU2xRL2ds?=
 =?utf-8?B?OVNnUzU0cUpUY1E1eTMzZnFBWCtzNmJYQTVROHN0b2VIejBiNmRFcVV4ZzIz?=
 =?utf-8?B?cytydit4NC9zZTg4ZE5ERGZQZzdIOVI3NHhGbXZuL3Y3cVhOZzVqMkJCL3Vs?=
 =?utf-8?B?dzVSZ3o5Z1NoL0VtYkpIRDBRZjJobVVHWVEzamY0WE5BT1A5M0lkZFdZcGN2?=
 =?utf-8?B?dERwa2Q1RUYrVkloZFBiS1M3UWV5ZituczM0QlVUUnpjQ05MS3FIRlNpSVh5?=
 =?utf-8?B?ZXI2R2JKSnVYOWxDSDlYajgybm91ZURKREtZKzZ1UEhScmF5MmoyU1h5b2Jp?=
 =?utf-8?B?d2w2bnBjeWJodDY1L3k3T2NEckV0Y2daaStUa3hsSXM5RGdkeERSQkc3eGVQ?=
 =?utf-8?B?RXh4Zzgxc2ljdHRwUEVkYmhnVi8rSWw0Z2JycXErekhZYUVGc1p0U2ZOU0g0?=
 =?utf-8?B?NEpyWWF0Y1hUdGJ2c1V3R0VMZ1MvUjcrNGZwOFBkaEJDWmlOOUFncnZqS0F3?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b360a233-fa38-440d-365a-08de280877f6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 07:43:17.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgMv3uMveQYnSzWjyi3VGoDnh7RVEA1QlZ3es3yO/ffi61qhjZVY8v6+LCxV4Qf3q6PnpTBzvZb0tkr2J2buYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5349
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 07:43:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20633

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=11&day=20&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/11/cip.2025-11-13-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - riscv reference board demand and distribution

Jan

PS: Half of my brain will be at an event today. Please start without me 
if the other half doesn't wake up in time.

[*]
Date the data is created: Thu Nov 20 07:41:41 AM UTC 2025
linux-4.4.y-cip: interval 30 day
  latest version release date: Wed Oct 29 02:00:44 PM UTC 2025
  limit date: Fri Nov 28 02:00:44 PM UTC 2025
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 10:07:00 AM UTC 2025
  limit date: Sun Jan  4 10:07:00 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Oct 20 10:22:11 AM UTC 2025
  limit date: Wed Nov 19 10:22:11 AM UTC 2025
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 23 10:53:07 AM UTC 2025
  limit date: Sat Nov 22 10:53:07 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Thu Nov  6 09:00:25 PM UTC 2025
  limit date: Sat Dec  6 09:00:25 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Nov  7 09:45:57 AM UTC 2025
  limit date: Tue Jan  6 09:45:57 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Wed Nov  5 12:32:45 PM UTC 2025
  limit date: Fri Dec  5 12:32:45 PM UTC 2025
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Wed Nov  5 06:50:13 PM UTC 2025
  limit date: Sun Jan  4 06:50:13 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Nov 14 08:26:39 AM UTC 2025
  limit date: Sat Nov 29 08:26:39 AM UTC 2025
  Status: On track

