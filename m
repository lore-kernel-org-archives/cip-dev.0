Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0DEC531D0
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 06:09:57 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5578.1785391791432147159
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Jul 2026 23:09:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FGwQZDWr;
 spf=pass (domain: siemens.com, ip: 40.107.162.28, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0Y9STUq9GRLRuABT64yGr081NL2i61FxFPpD2Ps9V2nGytsZGdUihZruXYt3/fOALgazl4EGqtIk2uIEkswjwJ50/ycvyVq7bMZ5TYkTYYYfdRVsnSZt3B3hBixqfObJUCxnfBWf/B6aqxH8ETNYG8XazBxQGJQZCPTLfDj/AwD88n2CfXGIx3U9tFfxVGsIYSW4jMNmt13gbHzNkqlo3rOCAwg8D/e6FoGBwNHHF5716SZnTrB+CYBSvnbs91MD3FDsPX8AvVm8Cp/HgrjaUSCYX+Fn/DdO+6iGK2F3b4dyBwY5GXLxmV090it79Uvh5DiWH+4vCV2dPxj9607yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD0EJPbSbi8hg9+wo72Urzo9KROgYpXiKErETLRlfyg=;
 b=M7us8QcgsN7TODcXt1/NL2/siWSOVxGtB+il5uiyq3dxuYDb7BnZoL8LbknJ+vm7GhxX7HR5UyX8fYRnvzj/RtRn/zL5Oy9u7HE1FQPGzVOKfIOAuEWPKkSm5Sf+Vje+HzzTnI1S3UXtBc02ZJpClQ3vm57kCgPs+UL8FV5rgylQBdQrKF3MMg7mnLrR2T4N441bLqdxIyUmCh9bdrdAVt7SUEOfB/Obt3PFII3MiWDn56nPEBdr1uAvWQ7OEtZDPFni2gsdGjEJbWHji9TeX8Qi1gV1ZNbhNPxZacdScdpdkf1AJkR2xCJ4fKHgZTkHjNxL8CB7VnL5L51Np5/JhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bD0EJPbSbi8hg9+wo72Urzo9KROgYpXiKErETLRlfyg=;
 b=FGwQZDWrtYVhCKpHMt3D7UFfDjcnzAKsF81nAR39kHGSPFxmYtH765UVIdlUkWaooBRoa1192oOwkBLhZm85Q7Kgl88gtufO+9/8DGdpizuSG6KWPxF1cnyXqOoVqo2zRBIMOwit7fCPw8bVNBZ4NgYPjAs4SQF7WBbYSo5jZHq+/OPCZZgh/A1p+B/dkSkKkIDXBPU8zX7yy0S9BLCzJiXYVd34c/6fR9Icc7RL2rgTnKOAErHPwuhz2FOLdp51p1usxU4lfK2+h40A117+mwDeDFInhcP+agdy0wx0kwQeC5N+3lC9Sb5/P0+BWxoA3W9nOIuQNKvQPTyrVZrHRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ee::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 06:09:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 06:09:47 +0000
Message-ID: <d31d937d-91b5-456c-85ad-3d63ca3df5d8@siemens.com>
Date: Thu, 30 Jul 2026 08:09:45 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5fe89b-f3e0-446e-2d67-08deee0127ec
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|56012099006|11063799006|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	c6gil0ec/DdDJ5lwUWEQxgBUiwHvAyDnfSg4nNOprtoB67zTg20BOwc8ElOBHPc0XMtgemJTtJ0fw+MUPrRfCMf5i2Kl7Fq/Y2A+y9xqEVvmGRZxHaKbKbw7kRa4BVC/JoboLWgzGizjn3nvGtevqaSh+ku1lraXSzqm5ow8y1Pl2UblL8Yn5/aJiogSoG3P9/Hwh/0d0EPjIViupX/7SoaOVOt0XW43+B+k4vaQ7GydRvDsZlp9VqfWojGsqgk2lMSc5GqZI/PQ9FU30H92bjLRZDxBT3hOX6t3eJOaXsvkqZVlKcCwdoH+grFJlYNV2Zm7wwoBsWx63fNQmGmQtnlSUtBp1aIA+wYBzrnjTS6Wvlj+X6XK5uSahH9vD/CHaXodyvrovcKN5KdmJbifalyZOSuKKEQ1n1E0d4lzrOgcTcn3oxkuq60iKNlAYmEn9dIc4ywXXOIamcvYg0txsR6heq3vQ31E3F9uAXpPVk64mrK8/48vpGQ8U0dq1sxOOLKe3L5hWID3wPPQPvVXu/T0h/nyioH7kUv1Y5f2EUPzxAK8Ni+TLjHxCSTHKJoAcvSz4B3nP7jBkg4SffK+Wv3YOYUoUDD6eb6Nk5jMXGA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dWZJdDdTUHVtNGs2Rm1RUGxrVW5SSTZicWhIK3d4b3Bxc1FVUVQ5SWlRMFkz?=
 =?utf-8?B?UUdHUEFVSGRsYUdwYWNlaUo2UERaNFppUkZjaWY3eTZ0ZFByWHJSRnN0dWp4?=
 =?utf-8?B?TFVqSE5GdG5kWHI5L0ZlNkw2Z3ZxY3ZhanpXRUxCdUMyVDlZS01reWxNSHJh?=
 =?utf-8?B?aE04ckdPUGhVZHZGN0o5ZEpHc1dlSitHYzdwbG1VY25QbWI4MHA1cEh6QmVN?=
 =?utf-8?B?aksxSktJNTJSR0E5NVpyblNuZm5qcnNxZWRlZzlzVjBoV0s4YkU1R0NpdHJS?=
 =?utf-8?B?dEVia08rc01scHZOZmFkQms4NE9MTi8zb3VhNG45Yms2S2xVTEpESXdaRnN4?=
 =?utf-8?B?NEkxeTZaNEZmNDc4Q2YveEh6TXRWWHI3YlNuV2pVSUxhQVpxK2lIZ0xRWDlt?=
 =?utf-8?B?T3FsTHVBWlhqR1dSTTR5ZCtmSkVLN3hjZzVjc29qeHNKSlAwWk5rcVVjdVE1?=
 =?utf-8?B?OUo4Y3dsYXJMUXZaK2JkZm5tR1BuazJxc0wvQnNSZUtxSytzNmI5bUVhTkV6?=
 =?utf-8?B?NUN5aWJoeWRrUE5EWXhZWlphellqeGFqL0l5V0VlbnYxRVB2ZldQM3Q2WXhO?=
 =?utf-8?B?SHAycmJlOUVib3Q2emNGNFR4cDlQQnA1Wm9mdnBWT1drVlFuNHkzRmkzOFh1?=
 =?utf-8?B?V1FxOC8rVTY0WU1STVpxL2YxbEhHVmovVkFCTk9IM2VvZHlsM1hDa2lrYW9k?=
 =?utf-8?B?emJNbHRNVU5FQll3QzQxRHhTM2tYK0xrNFIwT2laWXRKYldqbGhEOE9tb0Zv?=
 =?utf-8?B?TUk1NG9YZHhYQXJUNHFnaFJJZC93RFg5U3RyYjUvWUdtaEtsRlF2alN6WWxa?=
 =?utf-8?B?NWowNTdvbWFNRlNtb0dkNE9SUFVvc0YvcWhYemlJSDh6aEIxb3ptUEpOaXhu?=
 =?utf-8?B?S2hKOHgrKzVUVEZLTGdiSldYWVBjOWw1QkZUaHI1dG1GQjhnYTd4cjBRZzEz?=
 =?utf-8?B?NHgvOGlpK3BKZmlBYVpBV1YzdFBGYWU0Smphb3NRUUExM25QWWhWRHMrQU9O?=
 =?utf-8?B?aXNGL2NWSk9xNTIwck4wTjd4SmJLcVhPS1pBMVltQWNBT1dNQzBycnRzaFd4?=
 =?utf-8?B?a2dtUit1Rm5wakxhTTFzTkc0Q1VWWTZGY3RtRmEyWGwrTEM1OTJubnJLRXhJ?=
 =?utf-8?B?b3cvdHhJeFg1SzVHZ0dGMGF3RjFGbFJjc3d2T2c3MjBtSjlZVlp5bncrb0J2?=
 =?utf-8?B?VGhDL2lNZUgyNUNaZFlIOVNnSndUWTN6MVJPVFpOSC9WSXJ0anMzdW9uUFln?=
 =?utf-8?B?dnBJd3N5SGNDMjVhdXN6NGpYM1lHRTlSeU1ibmx3L0l1ZkE0WG5TNjhWSVdk?=
 =?utf-8?B?a0pQeVhuMnNRdnA1UllWRUo1MG9QTFZNM2U2eHhEZHgxRm1MT2NxTlV3dnVD?=
 =?utf-8?B?QWd4UVR3ZThkTWs3cmc1SWhRaDNwc3Q5VUJjclNCNUVmZ09RckVsenRGNEhU?=
 =?utf-8?B?ck4xVUkxQTJ3QW5tZmc3RUFHSmtrM1Jmc0orcmkwWXQrY09vOXFYVXhMVG11?=
 =?utf-8?B?K210RkU1eS9JQ3l3Zng5NWtCRmw0Qkd0bTdmNzZ2TUd0YjMvOW43RUY4cGg2?=
 =?utf-8?B?b2ZJWXlhQytlODhXaVNRSTU2eEZMZk5TQU5ZNEs2TFVCWUxQbG8yUHFIUlpj?=
 =?utf-8?B?NWNacnpwcys4NUdDQjIxaURzSWVCZURPRnVaMVZodmhXcllvY01MaWQrZGwz?=
 =?utf-8?B?UVRqSlVxVWtCQ1h3R0JrYkd4RWxsTDF4aDJVd0w4MDVyalFXeXR4R0R2YlFQ?=
 =?utf-8?B?KzVweGVWTzhKZjFINDJkODkxZWI3R3FrZ3l4SFhVQ2l2TzIvaFBFZG91b0tS?=
 =?utf-8?B?TG9TcmFzbVRGVEplc1AwaGMvck9sbGVGODY2dTNJZ1dlZ05ZM3ZZMEI5K0Va?=
 =?utf-8?B?V0x2L1NaU3RJZlArSjVRMGFBSFZTM0pTYzNTc2hCcEg0U04vYVQxc3Jwek9I?=
 =?utf-8?B?QTMrSUZoRC9yZXB4dklQY2thQUFXZnpjKzdLYk5KOWxIODVPeTZ2QXo0Z3NH?=
 =?utf-8?B?M1NZVTFza1ZaUnIxNEhQRjdTWVl5QnJPUWsyUjR3WU9kODgxT25vY1dhQ1JH?=
 =?utf-8?B?L0V0WmRXQTc5Y1lWYUFkcFI0eitTWStTYm1OekcvaWptQjgxVGJVRkJrb1By?=
 =?utf-8?B?N05MQlFDaUNPV2dhZno1dS9lWm8yWVJmODlYdlJNTzNkODBZSTEvNkxnd2hw?=
 =?utf-8?B?d2RNSk8zbXNPOUtPSWNoWUNGR1NCVURZai9ZV1VJMmFnaFhzMmN4VzcvK244?=
 =?utf-8?B?WVFQZFZ5eWhVYmYySWNlSHZ0SGk1RXR6S3E3NHB4NDRpTkFjajVmTUs4blhY?=
 =?utf-8?B?RHBoMWgvV3h4bC9FRTdCMnp3WkprT3V0b0tzdFRabERPVnZieXZldz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5fe89b-f3e0-446e-2d67-08deee0127ec
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 06:09:47.3787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9n5UufMOotvcMzbxv/tUkcqTQB4uwi/TZPdRG5Fb8D22ec5I31gCAO/LBdEY5wh29StM1f9ObAUhVSID/kNog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4113
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2026 06:09:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23816

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=7&day=30&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/07/cip.2026-07-23-12.01.log.html

* Action items
   - blogpost draft [iwamatsu-san, feedback: all]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - status update AI-based backport review setup
   - /me absent next week

Jan

[*]
Date the data is created: Thu Jul 30 06:09:20 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Jul 20 10:00:31 AM UTC 2026
  limit date: Wed Aug 19 10:00:31 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 25 11:40:18 AM UTC 2026
  limit date: Fri Jul 24 11:40:18 AM UTC 2026
  Status: *Late*
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Jun 29 09:22:22 AM UTC 2026
  limit date: Wed Jul 29 09:22:22 AM UTC 2026
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 22 07:47:57 PM UTC 2026
  limit date: Sun Sep 20 07:47:57 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Jul 10 06:12:25 AM UTC 2026
  limit date: Sun Aug  9 06:12:25 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
  limit date: Fri Sep 11 07:40:40 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Jul 21 10:45:07 AM UTC 2026
  limit date: Thu Aug 20 10:45:07 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
  limit date: Sat Aug 15 12:51:56 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Jul 24 06:35:21 AM UTC 2026
  limit date: Sat Aug  8 06:35:21 AM UTC 2026
  Status: On track

