Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28090.1793857475970533573
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2026 21:44:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oFNtxHLB;
 spf=pass (domain: siemens.com, ip: 40.107.162.30, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+jVek3u2ivQUZV3r4zC9p/8k9+rzIhTkixYpD3FKFbRTaCJsgMcGJ++uETik70Vwgzm5S40ajraxZZHpYCmRueNMLAsE/gLT/ogRwackpI3T08a1AZLhhS3XR53AL2KygpIFoeJBKczVQcE1U1Bp98upN/V5jTZ3j1VteUk+8EBrkGH3/g7hpqnbv6RObAYHeDEF2TPHbWzTm+nKTfxx9f35N9SdLrceumLJ5f1xe9BC5xZfE1SsgC6y4JL5Q3FVOECj3Csf20nKwSjys53QJslWpCAm+JGJvvSHXP2RUQQAX79u0SL35kJejA9hlWPO58+vubCo5e1bImdjINRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVx6LajCRqc3UdouqyDdb+ma7gqlZ0oft16Rk2UAQoQ=;
 b=FuLJVn94u2qa5lcgfmu54CwYGwrQ9wbxLRecpoZyijQ1hLTyir6AgjIUPPY3W8Nqk3vfB/MiB0NNKzoNVnfd/i8YORbfwCYlRjKYS0cqm6D7Q/mcYHIsBVn0HnIQL3I3r46lGfij0l1GuMz7I/XNM+sK+Ui6albm2Ttk2STKCWMYT+dyoB3gmZfoaWBDn/yU0lwR/K2aj0FTnIFaXWgcewwD98zYq2VvdfExXaUup9G+Yp/rqn+eVJ+QIttk6CjAsQpsTxxf1GdvT17t3UbolstQK3h6VTkEDKqFwT5WOUQXklVh7+Po+T8XZjXJDR8lg6FTGBm+MRLT/rMCq/+Uvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVx6LajCRqc3UdouqyDdb+ma7gqlZ0oft16Rk2UAQoQ=;
 b=oFNtxHLBL+uosEuxw44+C0KyWq3R4JBIyZBQfl/t48X6zB4i1nExUrd5rVAVuVQ3kIslWQFX6sRMwBBB2Rx6Lwgww3QxLasJhpSkLLzxiasWZWgEULmYLV0YgFwykm2TIynRJCXr0h5Fc3UJfx9621rm0fBAMrJz4xxlnzeGv2/HhURC/6S04zVPgOSPDQDQ7P06MdKjigvvir61QRdbV9c+F3Vx5CrKg19PFx0JsrK9Bbo35NUvW5Tt88GowR8npD+yXZfKsUOeMX97aQLucrP6h5FaM3r0VWVGuvXrBB4Mst1dr7hKYbOlgTGwuWE4syBG5h189BXBM3RisSPKcw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by DB8PR10MB3689.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:13e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Thu, 5 Nov 2026
 05:44:32 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.003; Thu, 5 Nov 2026
 05:44:32 +0000
Message-ID: <f42cc882-7a2d-4eb2-907a-afecc051a688@siemens.com>
Date: Thu, 5 Nov 2026 06:44:31 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|DB8PR10MB3689:EE_
X-MS-Office365-Filtering-Correlation-Id: 03c41f13-b836-460f-72fa-08df3affddc2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|261021135927099003|261022075727099003|261009223027099003|261028144727099003|261026140227099003|261022105027099003|10067099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: muggzO40O6vkJaGdSohb18pplHOElZv7unMDH9gep+mBLTFleKjUvqPd0aSTyxJomsihhh1NzpfJ8zYs+j4E6+ktww71C8PojxIzZJ+7g33eTrsy4xYztY+bXaVvVZ6JhwVOD3b1bl7wjKGjr+5gF1NO4pp6ruZmbad4zKgVCghzwjSgtGUpbJSu5nJ8K4dWd//KbWkp01eWPj0zVo4oTja44aEmchO42VYyDb2YTaceQAUqSir2b67FiJDR30fZqXdRaWwlcwBuEAls5lda3FZFIZc8itTX8W/dKoQgZy/424KNJg+3dwGD46Hor6YmxOh6qCiOa8Z2v/LsIrEwEKFz2w/M5itwTlsmP3oKz6MQFes2i4AS3LIm9oOgT6dl4nSoIBsva1Jx2lkHzLfSxtr6e0djAaqPB9akyZl11wZkQoSkfjMPo40/a1FTEwPgSfwH3vmqwpVTNdRhnz5X4sYgYG2IagxBXLYb9zzQBsdVu1S0AGsAi5Xy8a1e6xTjZJ7b44PB2y923b8DwhS9eYkta4jSv2LG/tfiemVgn/ybGVg5cnOX3e9fD5M+hGst6KjQclJsLXZA/c7K4jlg9rfHZvZAjeaRdos5VBKK+HaHEgc6vNaS0GzCdqHNRSDE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(261021135927099003)(261022075727099003)(261009223027099003)(261028144727099003)(261026140227099003)(261022105027099003)(10067099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnFGUEVKZWovSmFZNG1BYUlhZmlQWHBFSDd5RUg3V1UwRVpYTXlhZ3h3ZHVk?=
 =?utf-8?B?MTBHU3NCRUM4YXB0dnVaTmhPeC91NDlMam00WWdKRjRPaXJsQUtUTGlRYnBm?=
 =?utf-8?B?OFVIMm1yL0doc1pic2JxMWhydVA3c2lObHN3NjltMUFteXJjMGpzWHkyK3dy?=
 =?utf-8?B?SHgzSW1CMFhxMGVxTHdIUHIrdWVKWFM2eldacVcxb0d5NEJ4NVg2WCt1em1P?=
 =?utf-8?B?MDhPS0xXZ2p3bGQ0UnJqNU5LNmVYOTVXYmZ4RG9BOXh6RkFxcWYrYVlZMTRX?=
 =?utf-8?B?bGh2OHNRUkZQMFJtbms1NXBRUWd4QW9MLzdoOTZocldIN3NQUkdZcW9wUFlK?=
 =?utf-8?B?cTJLNVBVcERYc0RBWEswOFFwL0ZIVFZMSFZ5SFZabE1SRjRwdmg5SUJ3MmNW?=
 =?utf-8?B?d1ZpcjU2cFh5U2M2UXFSS0pRdUJyeFNyMzdINERiUGRsZnJhMWtFTnA1U29V?=
 =?utf-8?B?SmtHY21sSS96S3FxemJrOWVHMEJzeWtmTUZueUhUWmUzS0szbEF4a2pMUEgv?=
 =?utf-8?B?cm9FcnlUZWpEc0pMcUlQRGlPaGxBdHVTUWpWWGI4bW9vYW8rR1VZTmhnMG1v?=
 =?utf-8?B?Ky9PWHoyKy9KZHJqM2JMUUM3OSthd0UySmRDdXV1dk5zU1M2azNCSG8yVitJ?=
 =?utf-8?B?bVNKTldMNmhMZmYzUHdPVVF1Uy9nQks2N0dnbjBwWGpQNTNYUVBHZDlxeXNj?=
 =?utf-8?B?YWF3VHJxVXhKVUJTL0RZMlpmY1hUaGhpSXNWWHpOdmNoT0daa0l4RStOUXdV?=
 =?utf-8?B?M3Mvd3FZYkxFZEZmNXJ6dlRscTNQVi91eWhJenFENHdPNXZid0xsc1Vha29w?=
 =?utf-8?B?QndERlQwN2hWanl2VVk3NlpYWUhuSmZ5bjdvREkyTTlidkk3Z1FzWjh5cG5a?=
 =?utf-8?B?SzVRUlhpTnlNOFpVdFNuRkxHRkptT3RzMWREbk1qUmRGNEZFMzhwMXJTZ0VI?=
 =?utf-8?B?cmYyL0JTSjljT3p4djFBVExJd0NiZkpmU21jU09ZM0hQbVpiakw2S1hlcTBv?=
 =?utf-8?B?UmZ2T2o1bUcwTGxWWStibVBySll2OHM1d0d0M1RNVUs3TFBDdmpCTHZqekZp?=
 =?utf-8?B?aG1DT2pVMXdDN1NwUTc1ZjkrQWg0U0NzMmJ0TlpPaUZlc0tRclByT2xYNG9m?=
 =?utf-8?B?VWNud3U0SGJWVWpQVURxRk03UVBlTG9qVnBvZmNGQm1HNTgwQ1MxMk1zS0Mx?=
 =?utf-8?B?ZnE0TzhpTnY0aVEwNENZTjQvOE9Wa2hUK2l6c2RKWEJRUXo3WTZEemFjdCtp?=
 =?utf-8?B?eVFCN3pTUHFiT2RZcGN3bENqQkNSYUNXcXBYSlJDMU8vRzNDUUR0cm4wSHp4?=
 =?utf-8?B?M1RMMWwwY2VTbkNqSWlSWGpqaWpkVXdzT2JhS2k4WGpRYVRkdXRJSmhYL0lX?=
 =?utf-8?B?TGJQTk5pWEhjUlUrd3JSdkpoVnRwcVJEZExBS1FYNmtVV1N2ak9BSjdhZTl5?=
 =?utf-8?B?QXBhM0RheTc3Qyt5YnkySEdEbk5ETHFlYWRIWitGK2ZmTldUd2RrSGZSYkpP?=
 =?utf-8?B?eTNpWnpOTndJVjB5WDdKdDJRaGVXMnRUSHd5WVVzaWVqcWs0bFh5dEhBMzVs?=
 =?utf-8?B?aDVDemlpVG5CcWI4N0VsYXZySmZhaFRoOWFmdzM0NXorYTVNZmVFelUvQVox?=
 =?utf-8?B?ZGdFVGxieXNKQlVEM2dqaVRLMEZyb3Q3N3l6SFNadzBzU3lEditCdnd0RkNn?=
 =?utf-8?B?N1R4THhtSEdrZEdLYlRtY0F6NlZzajBBU2N3THJqY2h6SWRaczZiSFpQR2FO?=
 =?utf-8?B?NjMya3pLUUZZeTBkdUNZTXVFcVIxTVF4VVFUNDRTWXBqQk5CNEhsa09OYVg4?=
 =?utf-8?B?OEVxS1BmZFIyLytMNDdGekplVXBWdWZYYU5XY2NxaEtJemI2bjQvRGN0aVEw?=
 =?utf-8?B?c2RHb3I0anpxTXBiNkVsamZzZ1lmRTJFOE1LaTBPbFVXbDRNOXNtN3JibHdN?=
 =?utf-8?B?RjdlM3dtMFM4T1NHSGp1RjQ3YnQxWTRzbW1obisyeFVxVTFvdmlXRkZOTWhv?=
 =?utf-8?B?T1phaTM0UEtGcG1MZ0xXQ0hsd2lrWWJNaW1aOWpkbjRHMVZPYzA3cUdCakJq?=
 =?utf-8?B?aG1xb0VSS2k1UnByTHd3eHhXdmhobXcyMEhheEFDZ01PZXlKeDFyYXFzVzgy?=
 =?utf-8?B?d25WSzJ3dkM0TU43eDc1d0tXRnhTbk5qZUl2S01PMXhZamxOL1FEMlhrYlFu?=
 =?utf-8?B?NXc3Uk8wMllYNmFCVU40UDZmQVloa2RnSXFtVkxZSFo3ZEFCSW9mLzZKZ3Jl?=
 =?utf-8?B?bm1ndlk5MjA1TzFaYjR5bFJUNVJvZnBTVzg4aVZqai82MncwcFpwcVhBWDFB?=
 =?utf-8?B?TTJKL0tCeUk3VVFnTERDS2tFYU1LZ05sbUhMWUJTaVdrZ0dJaFVyUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c41f13-b836-460f-72fa-08df3affddc2
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 05:44:32.2091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAdsFpHUsoG0D9dRTiyhvVc4fxY+79kplCuTWfBTDNkdCKLEvrrVkAVYqlbx5p2W1OdkJJcmREMD9nNLI0mKRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3689
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 05 Nov 2026 05:44:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24635

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=11&day=5&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/10/cip.2026-10-29-12.04.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
   - status SECURITY.md

Jan

[*]
Date the data is created: Thu Nov  5 05:40:37 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip115
  latest version release date: Mon Oct  5 10:29:52 AM UTC 2026
  limit date: Wed Nov  4 10:29:52 AM UTC 2026
  Status: *Late*
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip115-rt63
  latest version release date: Mon Oct  5 07:16:38 PM UTC 2026
  limit date: Fri Dec  4 07:16:38 PM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip136
  latest version release date: Fri Sep 11 08:53:07 AM UTC 2026
  limit date: Sun Oct 11 08:53:07 AM UTC 2026
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip136-rt50
  latest version release date: Wed Sep 16 09:32:17 PM UTC 2026
  limit date: Sun Nov 15 09:32:17 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.272-cip79
  latest version release date: Tue Nov  3 09:48:41 AM UTC 2026
  limit date: Thu Dec  3 09:48:41 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.268-cip77-rt34
  latest version release date: Thu Sep 17 09:59:47 AM UTC 2026
  limit date: Mon Nov 16 09:59:47 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.190-cip62
  latest version release date: Mon Nov  2 08:01:07 PM UTC 2026
  limit date: Wed Dec  2 08:01:07 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.189-cip61-rt32
  latest version release date: Thu Oct 15 09:34:39 AM UTC 2026
  limit date: Mon Dec 14 09:34:39 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.114-cip34
  latest version release date: Fri Oct 30 09:28:17 PM UTC 2026
  limit date: Sat Nov 14 09:28:17 PM UTC 2026
  Status: On track
