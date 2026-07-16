Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCACC43458
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 05:14:13 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6153.1784178838384539367
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 22:13:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nQ6OMANM;
 spf=pass (domain: siemens.com, ip: 52.101.65.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYRj/9dQXR2asSbGp7FeIlrLUOScOesCRISJ/cFiolchuX96xUD8OKpVtLJw5rUp1p1Ay5fqf1GRmP3O7aUL1PPPoLyv+07H8Gx4zC/bD7fOhdGfwFqUoq5iTO8zcBOqtGI7wMvI4jg5RTeWWUmFL0ntByzQJA2TgIYIxg1rH7Ie2t1LNV1ELPKHWUqapgtHDLP7M/fblKckXE6zB562w4PVc3iIwkVrNvet+HStkZSLBgQ7rwmY0XHWjqJNgvQvuuYxD7mtZm8YiuWafA7mEXMKH3uqUCNPrGlyhKV0d4mvXPnMHtipTkNO+q5FCBAiC1obdRC0Ohmoz0zB0eBfnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fl27hYVtzmmuMu4cESwbkP1pIHJM/M+bCpVTpHC5mhU=;
 b=MouAQOGCcwFQlEfy4owqvmlL75LRltyMSRPbLX257BNhMF4paxyFO78safNg3wmxRrO+qu5OeKRg/EHVXqCVlAuVAnjo73CCReIe0AEZoRFSISO46mrepc0R9mtUTytmCWiV/rmn9OEKFgj7aLS05bH+Wp+HDhhFu4GS2hyoX9jKzCYkRI56/18wwhsuPqrMDnkdEV+2yA8gNMZsowtcsEHoW+Xv2IWI8OAVzqA54s4ci2j8Rg8ouoUB8jDrMbiL0K4OdxeNNSy8SORR5dQJHUKDBi7fls7kyl50r22+Wp4bYBl3aHVt3hoE0a9Qorrplefrq6sGXRc54fQ+m5ldDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl27hYVtzmmuMu4cESwbkP1pIHJM/M+bCpVTpHC5mhU=;
 b=nQ6OMANMcPDBUqeKjQXW1ohU13qeorX1bO7wFsGjURG8wVOR/R+q76g6qSITjPyLt8jkcosB3VW2uqQOKEJ8bmw69p4nC/1um3Iz6sJw50zwNhOI54FbpGhAjm1KMKA+JgMd/QEQ4PkrqWYZKWfsX5GOwgnzVAj3a1jHCOfmk/cVst7LCKEQ+Qj42WzU7JwAAHrF/ixZKoAn6v2P9Q/1eQ24dgLw2ehb1yWT5kmanVNObS5OcCYkuVL5YOeg/A2/uJDCNaHNOvTEhy6+/hrQ8wBneB5rku8Sg9vAe8Na6vm/PiVQlb1r/mGkfwWJPgmASVI2JcJ/CUoc3BqGghatbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5629.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 05:13:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 05:13:51 +0000
Message-ID: <44b446fa-a7d8-4ec4-8157-6959a83bfa01@siemens.com>
Date: Thu, 16 Jul 2026 07:13:50 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: f28c7d5e-fdfa-4ea5-be5f-08dee2f90620
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|56012099006|11063799006|55112099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	ZB07PXHIXwuMWW4XvfKO+vYQXIt6OAHeiwO3nbcynq+PoXO8fWgqmlgVgUoHQ8IE6D3C8oMDqVkiPfTnN1406YLl+pQ19qtap2hKT/jDZMhnQYMeABSSxeD+pu/2QdyoemtBcwaPgaIo1F8fyHU4r0e61eMSP1i50Os6L9gg9v7rpb0DsJg4jzqdGEl5guNL2wmAXQSS4LRP0CD2IFluDPU2NlmT7K7HgqyvFmGXP3Yk+a10xA0PLhS2IQZMplgaKcSU2pe9KonJmmRxoUm+PLTO62EYj3mhHn25PCMqEE6rX5dqebxF3PnPACIZZVN8z0TM2VMheo3C3yfWRvG+dwo5XYqiEWssCCWk77lczoEKim2qjMPj1XDveqBbsrlssZwoNmCVBhTGWu5Ic8KXlbWqe6mpVjY+mT1D26rDjOgDno+exQxealXBHcYHBHND1Y+CFrjaevA0Nmm7hgqSzCckKGIyzsz3NdSTtee3TXv0IbDa+LTeF+ddszD6SI58bJxFeB3L6FEBHA+hdvDcyqkWl4n0BqVyD6K3e+Sjc6FAtJniSn1ql/OWvBeKAmagQ63JZbKjxHzgtHq/duWfFART/mbUGOFe9uT5XW1/r8RBb6jvs/b2iUMzPh/z/SCJ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(55112099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NXpZWmxWVFBUYlhqTUluNlNkdG5sRWRQM08vZUVVT09Nck1DNDVmVFJzY2ll?=
 =?utf-8?B?Qm1EVXFHaXJnQ1B6RjhkSEI5am5sN2RIY3BBZGZwWWp6UlNGUGF1REtaM3NZ?=
 =?utf-8?B?bmJ3UW1uVkNub3FmOS9tWkpiMlJublhZU1dXWjdzdHlDU3Z0RHRkYUNZVks0?=
 =?utf-8?B?R0dkVXl6dkJibDN3ZDFzZ2h6MkhGMWZVTURJbFBUVlNoeWY1WEdlWjdjT3pY?=
 =?utf-8?B?OHhvWjlXdk5obDI0S290b1Q3a2ZBREhvZnVsY0s4WkpDd2Q4aTR6M1lpZFU2?=
 =?utf-8?B?VnB4ZEpCM05DelliMnRJYXhSQWFBQ3ZEckRpakllcElydkdreG5ZeFBDUHNp?=
 =?utf-8?B?aHprVUFKWWdERW9HWG15Zjh1WGFDMnoyZFBna24vem9PeDNsbFJQVmt3Z0pZ?=
 =?utf-8?B?aXQ2S0lDZlA0WUR4SnZabUNGNnhoZUltR3V0SVh5clJ3aUVKUzk3TkIwZWJa?=
 =?utf-8?B?eHd5NVl3VDRDODJnRjV1cElhTUZYNjc5Z0txbWJFbWE2eTFyaTNPQ0g0UnI4?=
 =?utf-8?B?UmdNQXNWeW9kQmhvK3FmTXloYzN3UlRTSjBYYnJqZkhTU3BnQk9sbmkwV08r?=
 =?utf-8?B?N3lEbjc3SDg0cGZ2dzJQZUk1SnRFbjQwWlR2bXNpR3hWSGJmYno3SHJtY09o?=
 =?utf-8?B?TkxEcC8rTGZVSFowbWJrNjlTS3c3OGNMOGVnSUdneDJIaWxrMzRiNWJQdWVo?=
 =?utf-8?B?S3Y2K05yd0pWaHZEOEY4NjV4WURUWWhjV1J3N3ovTFFUNjNMem1vMzg5bU1n?=
 =?utf-8?B?OTJnbDF3YnJiSU9Tb3RGOWhaZmxtakU0Q2xKTXNjRHlMNUwxUFJhd2JseFdF?=
 =?utf-8?B?aWNlNW56M1Rra0hDS1NSVDlMSG0wUk9BZmpaSGMrYUFJd25VYVdoSjUzS3Ji?=
 =?utf-8?B?VUdvQWxuSU9mT01TblVzbGJ0TjVEUHY2c0JnWXdmcFJKZWxBV2E1RnVZMGJs?=
 =?utf-8?B?K2lOQXhwMmF3T2RhbkFNRHIyRWtDV09qaTdlcFkxbkN2eWxCQ2ZKaThoYzNu?=
 =?utf-8?B?UFJGMUtSMmxodFZUdmxveFViblJLUFlxUkFFMkRUbEtmSUtHNlMwREpNQ2g5?=
 =?utf-8?B?MXZCKzBYb3E2eStCeXppL3RUSXgzUjRmREtkL0pvUDcvY2tXZUdIT05IMXRM?=
 =?utf-8?B?ZlF0azdNOGRLZG9RME1GK3RReW5hb3pERGZWQzEwTU9uUUhzRWZUU0U1OE81?=
 =?utf-8?B?WHZydklaSExvSmw4VlBLQ2JkZ1BnZU1CUG9NMThqcFg4bnMyZDM0NFVydGxo?=
 =?utf-8?B?RnRyU2JXVDAwTUh0UVVnS3kvUHZpQjV1WmVta1JDUHpwWmdER1lMTjNOOGNo?=
 =?utf-8?B?TXA5R1oydjFIcFNEZ29MR0s2SzNXYlJpTkgwQ1gzUEljcXFwdy9ZbjVQdk1x?=
 =?utf-8?B?akRKcEVnUTlJYzl1VHhzV3ZKSmJRWFFoVlZycU9RQ2oySER5aHBYWTV1QzRX?=
 =?utf-8?B?anoxclg0N21jcHhreENzeVVCamVIOGNUVjJGOFBJZWhvUGZKeGtlOHY1NHZh?=
 =?utf-8?B?ZEQ5RCtqSmVwaE1wQnJQSkFieDZJZXp4bkk0bkNvWFMvR0tjc2JTWm1hbGJB?=
 =?utf-8?B?RFhhVWNyaWNDWHZQSHJjcGRSc1RScXRLUGJLT2ZjZ0VKN0J5M3FnRU1JeUhM?=
 =?utf-8?B?RXlOYmtYWkgrdzdnZXZPcHNaQzhNeitIbXgyaTlZVHNoNjIxT0ZuQkk2Nlhu?=
 =?utf-8?B?czYwbENGYkltMlFEZVB2VnArck01NTVUWFp5VWplRmM0REdia3Z6K2NSajFW?=
 =?utf-8?B?b0U5U2hiemttTDVFVjUxdTV4eDNaM0pYNVVIY0M4VUtPbStUMWYvb2RBaGV2?=
 =?utf-8?B?WWJkZ2VDNFNZVVFWT2RmQVlsanlGNDlyMnAxTnR1SzlVRE83TU4wNGMxcnk4?=
 =?utf-8?B?RjU1UFdqQXZHdTFFcDhod0RHQVJjanVrdnpmaG9ITU0vaVJIdlY5dFMyRk5U?=
 =?utf-8?B?Smtabko3MGFZdlA5clhpNkhsNzNXZWMwSlVqYXNGU2F0NzAzL2kxc3NqKzF4?=
 =?utf-8?B?bW9wejlEOFpEaU9meTkxRVRmU0x1TFRWVlVsS29VM0V6RkVEUlcvZ1RQZGxS?=
 =?utf-8?B?TzJKdE5XNEcycHljQ3ZkMmUxL2N3Nm9qQ2hBeU5JY29iaytFdzBWZ1JlSU9m?=
 =?utf-8?B?dWtiSDBLcUlQUkQ4RlhUT29hS2tUaS9veU51d2pFUVhITWNaRUpDNkVSeWdx?=
 =?utf-8?B?U1VqTlJpNk40VW1ja0ovUnVWQkpWY2FYVU55WE4rTTJrc0gzL2ZuekJyZzZL?=
 =?utf-8?B?UXNxSkxjcTk5L2sxRkVSVmxQK3lTRU5WbnBEenVXN3A5RHVXVGFqRUVRSVdt?=
 =?utf-8?B?LzhyRnRzUVZPbVhhc0EwWTlsdU8vUmZoZmpYVkwxUU9OamtIUU9Mdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28c7d5e-fdfa-4ea5-be5f-08dee2f90620
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:13:51.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4DJp4AVxu10wSm/EdkkAy+Jr91Q9O9+xdKU0zbkKxphrQZ5uFamPYG1qf6zjg9h4j8qDrjXkFsDoIlC+8rt1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5629
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Jul 2026 05:14:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23602

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=7&day=16&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/07/cip.2026-07-09-12.01.log.html

* Action items
   - start blogpost draft [iwamatsu-san]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - status update AI-based backport review setup

Jan

[*]
Date the data is created: Thu Jul 16 05:13:30 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version release date: Thu Jun 11 08:34:12 AM UTC 2026
  limit date: Sat Jul 11 08:34:12 AM UTC 2026
  Status: *Late*
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Mon May 25 11:40:18 AM UTC 2026
  limit date: Fri Jul 24 11:40:18 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Mon Jun 29 09:22:22 AM UTC 2026
  limit date: Wed Jul 29 09:22:22 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue May 12 11:56:37 AM UTC 2026
  limit date: Sat Jul 11 11:56:37 AM UTC 2026
  Status: *Late*
linux-5.10.y-cip: interval 30 day
  latest version release date: Fri Jul 10 06:12:25 AM UTC 2026
  limit date: Sun Aug  9 06:12:25 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
  limit date: Fri Sep 11 07:40:40 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version release date: Tue Jun 16 08:11:47 AM UTC 2026
  limit date: Thu Jul 16 08:11:47 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version release date: Tue Jun 16 12:51:56 PM UTC 2026
  limit date: Sat Aug 15 12:51:56 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version release date: Fri Jul 10 09:06:07 PM UTC 2026
  limit date: Sat Jul 25 09:06:07 PM UTC 2026
  Status: On track

