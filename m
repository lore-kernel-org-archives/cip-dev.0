Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98758CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 06:07:33 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8780.1762409244439877799
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Nov 2025 22:07:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OjNlzPYw;
 spf=pass (domain: siemens.com, ip: 40.107.162.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsGfin0waKsyy2Etr/BJ/OKiMPHc02OHWPzVZbgvnMlCp7oswouS7RmkIcbX3z4JGSPv2rtRKRXR4tfm1CTJTdQwIJ83stziPO2g4FRvkz8aWKhGP0mcs4zJDLmO+GiaZ/LMwyKlC59eI1UdKIIPblCp9fFtysg6t9B/e6UJyeRFU9cnMegOwNVJ8jlW2jgyi1C3ywlIO66oUokZf5KpunyjK0BkIjnqA/uPar8s9gunLwpfip1IPjiVP8K0KysN9UCXRgIhCisgbXb2OpCZvNLrVzYMtQlMfxieM7NrtxFtxYSbzEi820fFBh7U0ButSJyTqai1d3ykcjG13YAVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IxoZsARlcJXnvqsyxSaxq9rF6b6yzRq6hQ4AofzDx8=;
 b=h1ZWXgrBOes3ryeu55ejj03brLoOCiGz4/jKOSL1Okm/bkwv/gIUvo9Zcnal9Z8tiedIpR0XumV3hNwdT8Q6e8Up0qESsj7KV9MYCVyyepzrP8sEHudfqHa52BCEzZLXTl1KYKSmtmafi3fWxzwLUmnJogpF50Q7n4yz3sS8/4aSOFdqi6lHSxsNd45dqWfKzBpenmQgfbi/bHOpm0vX6hUvxEcMmDlL7ZaEXnSPnOearC5DBPBA4zGGZ7or2qNW7D9ETIyh3H4o6oNthUaaHRtXGnsDb9I4ZATU/54+FY7KY8JUSGkasVQEBDCXAorPuKlcHLOoZ08U5jBkiLKe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IxoZsARlcJXnvqsyxSaxq9rF6b6yzRq6hQ4AofzDx8=;
 b=OjNlzPYwxOmGCJTebHeF4RHDH5IWfORm9bpX0ZnJybCmev1vQ7hpDNxsv8nbOuA497j0Own670R+/8bMNVxSLVtbbAxxf4cRIdj2OWKo3PoWIpCkboPko5DIunxFsvp6XwMwHhFS3zeEw2nKLKvYqY32EVzBjlz6SNj4HIsMAdIOZK8KFVIJtOgLOLvFjecR56KRK34WsOBLMuNB3ibTRGanK/5KJM03+BaS1E9GyWneJo/CuaFucN9HPgXqYFsQ/hIrVwKjaMcXgUPU0jCTSJDqeX5iN7Wk8bNoBQ6pMcnmiVCc8TfvFI5Ei9tlp6oNxf8P3tsz4vOOb0hh+sf3lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB7968.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 06:07:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 06:07:20 +0000
Message-ID: <0f8315b7-b9a9-4790-8526-f113e5cd9f08@siemens.com>
Date: Thu, 6 Nov 2025 07:07:19 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ae7279-4218-4fdc-6b1a-08de1cfabea5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UlVhcVIvSFNsOTFZc3dvT1VGRXFvZE00MldiUXFYcFB2QnFPV3krTG5mdWtr?=
 =?utf-8?B?Skk5T0tETUVFeTdnYmo3ODJPMFdCU0cxc3RCUDR1SlczeTg3R0FUVGVVRzNn?=
 =?utf-8?B?NmFuRlgzeEUydlQyNmxvcFdWTGRPQS84VnlGbHRHMHpKaDdEcG9QQVM4czhP?=
 =?utf-8?B?Q1ZuVmhZNXh1SFIzeEdkSjdNMWxKaG1QYXVMN3Z6OThEV3IrUmF6K3ZzWDIy?=
 =?utf-8?B?dEhqTFZ5Y3BIMWFDQmtocTMxUm14STRLTnM2V2VPSHNPZEVxS1ZCZklEM3hK?=
 =?utf-8?B?ejU5S0JONmMzMUtWKzVsOEpZWS9NRUVKemtXOU40VHA4L214TUsvTGluVEVl?=
 =?utf-8?B?T0tmem1xZmxTcjA3T0FRT2VvMXdwek9NMDR5ZlRzZkxxdFZXajNVUDFEK0VE?=
 =?utf-8?B?MmN3Z3RFUkxMZCtpV3pPWERFWUJkTE5lQ3dBeFY5OWIrMDVPNFh4SlVUVkhT?=
 =?utf-8?B?akVQZkxoOGZ4dkQxeXRQNmRHVUVVSEs4WEhkOUFLZUZsSzVqc3V0MUJ4RXV0?=
 =?utf-8?B?SzZlOWJ4NTFuc1BXWDlCaHZZSGJqQ2VMVmtwMGJ0V3VRZGdoSUlzRlRvY2JE?=
 =?utf-8?B?YWpiYWl5WWFDbGNHM29ibmJaS3RWckRoVy9wUDg4aWVRenVOUGgycGgwRHRU?=
 =?utf-8?B?bUdpVTA4cmR0eFkxeHFkOFduSGd3djUyWlE5b2h5UzJFdVpHOHQvcm9RVUE3?=
 =?utf-8?B?bFVuejREMEt5bmx2QVUxS0VpTUlTWGNxNkJvZ3JYT1RJbXdna0VhNnVCOTRD?=
 =?utf-8?B?b2wvVlNIOUYySllicGkxWjBSOG9KdW5GZXg5eHA1ZTUwWHJNeWF1ajJSOFBM?=
 =?utf-8?B?RE0vTyszZVI1bFFudHB2bkxzdlFCaDNkczBPdnRFU1JabytTSnkzRkpySVBR?=
 =?utf-8?B?bEcrKzlldFhYMnlaSml1NzlrcldtNVZTVVVFQnhFUDk3OER1RGt5d1RjaUph?=
 =?utf-8?B?ZmxPTEJlempwbTZKOWtHR0hKLytGejg2ZUcwRHZjeXphZ0JOUVZYZ3plWUk0?=
 =?utf-8?B?eUc1WE5FUENnUGp3V0dQdTVYdU85NDY3T1pTdFNsS1Bxa3BySGZEQXFXNW14?=
 =?utf-8?B?YXl3WDhVZElXekc4K2JDeGw3SHpVdlZFU0NUbnlJRWxZVnZLZmRDSGRhTGNl?=
 =?utf-8?B?U3dGN0JiZGlJV0d2ZzVvSCtLbWxDd2g5bzl0aDNlUW52ZUlsK3FkclAvVk9h?=
 =?utf-8?B?R1c2RXNkQ1VUUkk2Y0xoVTFtc0QzeDJiYzNiZFBaRHY1b1pyMUdBNHhBTkt0?=
 =?utf-8?B?NEtkWjBlN1E2c1ZJTGRKRG9zWVZSSjdGREVsQlBRVjZtWmN5Y3NYa0pIUk5Q?=
 =?utf-8?B?aU11R3RPSy8wV2swdnF2K0tLOStnM1FsV0hvYnZ0Mk1HTXNRSGVuQWJ4R2Rr?=
 =?utf-8?B?Q2FXdm4yWGpCOHZoSWNKS0ZaeEZpRVlWb2Q4Qk84WksySTBaLyt4SXA0RENC?=
 =?utf-8?B?bnhLTUNIVXFIekdCek1JU0IzSHc5LzZRUEJnK3hsT2c2bzRBL0FqZVNEQ2RC?=
 =?utf-8?B?TTJ5R2daUzkvS0lCdUFGZ1dWdXJrSlVwWmw2OUkzOHB6ekJlVEk3b3dSbGQx?=
 =?utf-8?B?dFBOMFBWZG5IZVpGR3RaVzd0cDUrV2l6b2FiYXBJdUlvUVpWNmtCaXJmWHVK?=
 =?utf-8?B?WTk3Nko1aGdLVzdIci8xN3p2U2pqVVNTeWpqUVZkMXdJWnpXaFRVSU9qblNG?=
 =?utf-8?B?TmJQWkcvV2I5WGdXSS9Ua1g5YXFGSlhLQ2pvTGh3OXdtVzFkalp6ZWdFZytC?=
 =?utf-8?B?NzNtcFh2TDVzVWRmWml3ek9BZVJ6OXFMbTdJdHVwWnEzekpiTWhJcUNMbUE3?=
 =?utf-8?B?Qi9JWjl4M3pYWitxa2ZVZTdOY3ZYZnFnamk0VzhIL1grTnVFSzc0UnZocVA5?=
 =?utf-8?B?OFJUZWpsL0V3YmlMUWRGeHRiSHhZam9MeEx1cUM2a1NGOEE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWF6YThJanNnWERER25SUlJsc0dmS1pSaWQyVlRZMFNMbFVRRkFkSndaU0lP?=
 =?utf-8?B?STZlNjZIdG1iM0kyK3NIelVmRHdrTzRIWEJjZ3JMcTZvU3pZS2RWSXBNNi9E?=
 =?utf-8?B?ek1CYjRwU3RVT0h1S2QwRllMNFdRdTlmMm1Fb0xYYUQzclY2b1hIMVpndytv?=
 =?utf-8?B?aXJHa2JwWXRPcGFBeVNIUXVJcHN0SGhWN3dUSjB6RUlqaXVKT0NwaDVJYnRr?=
 =?utf-8?B?RmNWOHo4Ykl2MlRTYzA1V1lrU1kyNUJpbnYybTZEQ2ZVbC8zK3Z5NHJnSWVB?=
 =?utf-8?B?NjhVNWFlSVlrOG1RQ0UzaFNrQUFKMGZHR1llU3lDNzV6eXczWHI1Y0JHV0xI?=
 =?utf-8?B?Q0RGa0ZSSzJBdlozNTUvelVPM3BJZXdUenIyQVg3ZXF4Z1B6MTRHYUZRV04r?=
 =?utf-8?B?RlNIcG1TWHh1VTdPZ3RGdm9qNm43blZkNkd5dVNZdXlHU3M3QitaR0FsSEpi?=
 =?utf-8?B?dWY2L1RQUmYrYWdTWGRza2UyWXBheXRCVEg3R2d4ZHZMSGc5YUxTYndwaFdN?=
 =?utf-8?B?cHdGWTZXdndORmd3bmN4azMwdnMrNms5WDVUVE1FWDRaWlo2YzdrcHltc09I?=
 =?utf-8?B?RUtSY21salVKU25lL0tSa0tPNUJrR2dJR1JPOWZFNFVVU1lFZ3FmaWZ2ZlBt?=
 =?utf-8?B?UHRkQXZMT2J2bHZoSHNVUklkRXJKU3BwWXllZnZzUWVOR1dyWTZGTDh0SVRP?=
 =?utf-8?B?MzRLblcrQVorTG1HWXlwOGs0a1hrNGJOY1BENnA0NDVPQnpUSjY5VjFVWkNo?=
 =?utf-8?B?Q0JicVZMQWhlR3lGL0t0a05xME9RU1JWQS9TM2tjbTludmtXR2pWS3ZnRlpq?=
 =?utf-8?B?RlB5QXZtRk5Qb2theUVvdldiVENTcCtqZkpHYzE1Wm8xZXhvNVk5bTYvZTR1?=
 =?utf-8?B?bVhibCtuRHZVeFhPNW9GQ1hLQXVEaFhCUXNyL0dYa013UjdxSGFEcjRaMGM0?=
 =?utf-8?B?VlNaQ0NnQzdQTTFxa0JTQ1lMUnpqWTExb0Jid0hVR1crcGdCbUx0Zms5Zjh5?=
 =?utf-8?B?U1ZvcFE0T2tCd3ROMUVqUmtnRmhzQmNWOC9ZWVphQUd3aEtOakJBTnFDM3VT?=
 =?utf-8?B?N3pFbkVsNStZTFo0eEhmaVJ3a0ZLVlMzV3hHaytmN2ZWVFZ2elBuL2c5eWJO?=
 =?utf-8?B?akIvdzB3d2lOM1d4U0FQa0piL1BuckE5ZHp5NE4wSnhKWTNPNDJ4THNmTEFZ?=
 =?utf-8?B?MXJqdWlMcDNEVTBqMkVTQkdvazJZNkVpRzZpcTdOZFJwYXdlS253R01tMmxs?=
 =?utf-8?B?MmdBVm96TjFVWVVqUVVXR2tsTHBJZ25DREpyYlgwMzdrQTFuYVR1anByVEt6?=
 =?utf-8?B?bjhTUXhEdFFrQ0owTC9yVDNDczhyZUE2WWhtVzhpYkhkVy9xVGNRTitGZnk5?=
 =?utf-8?B?K1duYU5icTNxZXJwT2hyZkQra3dnL1A5eXpZYnZlL1V1ZEl4OS9yY2dhR3Vq?=
 =?utf-8?B?dFdhVktsajNja2ZwOTdiY09vaUxSMUltclZpMWFLU0ZYZEdlSmFKaEVaSXVM?=
 =?utf-8?B?RWR4ZjhBYUlmSVB4VzVrOEhjcmVlYjNhc0NxdERFQ2hrR3dCRWE2THlYOGcr?=
 =?utf-8?B?Z2RGclI5RjBYMUpsTHd0TmZLZDByM1BuWUhJU0Z3YWs2WDBHRUlEN09mbUF0?=
 =?utf-8?B?cWJXbmM0UnkydDY2aFVnSTZtc2FpcEdkTDRwNlZWc2dvbjFRNlFVVWFhTmlt?=
 =?utf-8?B?d2dqYkRiUm1FTTZVaWNvU0xvUWg3ZzNxQndyc0MwbTdlamhhYnI0N1hKOTVR?=
 =?utf-8?B?aGQ0OUJRL3VNWkM1SHdEQTlhK0hFTkphWVA2aE44cnVoVkgvelgyT1F1TVdE?=
 =?utf-8?B?bktHQTVIUHdxM0toR0dheGdxbHIyN241cmtuVWJEM3BsSC94MTlJYVJEK1VG?=
 =?utf-8?B?NFFvcHRTbTZCYnBHM3VhaE90NmtDb1FCaldvWGd1M1NkQjRMK3NFNE9NaW4v?=
 =?utf-8?B?ZEsyZUxQNkpWelpzVXFyWUp5enZ2QWxObTBwaG9HOGtueGhDUGl5MFo4QnJD?=
 =?utf-8?B?VHdRZ3NUSlVscnQ2OVZuRmJCazZEalE1aXFYT2ZNOVFqc2NJUHM0S0hyZmRh?=
 =?utf-8?B?UVJSVlJkdTRiTU96ZFZuVGNWbDF3UUVJUzlsV0dMUS95a0kybkZwZHJhTHdi?=
 =?utf-8?Q?rjeiJ596NddmtKZ/hE9sfS89M?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ae7279-4218-4fdc-6b1a-08de1cfabea5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 06:07:20.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /corbcqqfCy7fP+IcrbCu/gKBiT+F9ZWj2Ys4G8Drczrb3TIeK5tfr2Z33kWX5+DdZow2KNSAwr2CxSSv0D4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB7968
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 06:07:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20368

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) *12:00*:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2025&month=11&day=6&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
04:00     07:00     12:00     13:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2025/10/cip.2025-10-30-12.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Jan

[*]
Date the data is created: Thu Nov  6 05:48:50 AM UTC 2025
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
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Tue Sep 23 10:53:07 AM UTC 2025
  limit date: Sat Nov 22 10:53:07 AM UTC 2025
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Oct 15 11:57:26 PM UTC 2025
  limit date: Fri Nov 14 11:57:26 PM UTC 2025
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Fri Sep 12 01:11:18 PM UTC 2025
  limit date: Tue Nov 11 01:11:18 PM UTC 2025
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
  latest version release date: Tue Oct 28 05:10:10 AM UTC 2025
  limit date: Wed Nov 12 05:10:10 AM UTC 2025
  Status: On track

