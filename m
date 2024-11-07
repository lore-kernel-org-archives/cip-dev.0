Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97CDD5AE7D
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 09:58:53 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.58])
 by mx.groups.io with SMTP id smtpd.web10.68724.1730973529278417266
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 01:58:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xH86kACj;
 spf=pass (domain: siemens.com, ip: 40.107.105.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YV+Y/K22vbO8nTq94qwd2kgG0YotA2uMa4vX6eR3g0oFzZyCjAs5W9SbzCjuhBoPfH3PkyknbfOIPIuAjLUNbByAaPFKU76VG3Ep1QEP62nu6Oh9/Im6XyUQFn+237bZwTunOpePWbNMsOwuN3B6rcAZNz4sn5UEgRjNsZMHNCaovDmoX41D4wWpAO2Gib1vzb9JpBLp9qbn7x0nfJresNF+NqeGwgQZNKtgIlU4MQdxlA4rxy6FoJ+wysrLWEvfSd1KlZBWr3yqlC1+ysmoRlA7aqBncVmctLTLTKW8a+3qripFFPqG/Szn3hQQsffDQ7Wo+kyYXIkAaJl/BEbvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjUB0GhHV86q1H/uT8o1V79UyF3TDuVg8H5CwKznFRc=;
 b=vidrzuzB63fcALL3H+WeYY8YR8hauZeuvn780hiQbAskmpeJKRtU9b0V77JiMftmvD7BlZPqDUEWNmcNRmuXJMWTdZ0+BB+Dpw0nGB9VyhxEz4J0La7L1IjmDUfYy6uha+Qdk3EJnhgDFM47lkTv1D1TPQ//EIkFiCv1OhD9RTHIF0FNKndQgzVmjgAt8jjwK9gpg+xSnYNpjXreiiKo7vuk76RcD3gwO5lUkmehUP0bZ1/ktg1FLadB+hdW93fEA67x79Bax1i8cIQo4+85a2yBZdbOzbpR49JwJI5P0E+xfz/lgFVJH2f6tWAz2Lq+z5SIefLVosrdf0jeStyhSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjUB0GhHV86q1H/uT8o1V79UyF3TDuVg8H5CwKznFRc=;
 b=xH86kACjYWBnmjf8k02y+M6eklt2gVDgL7mxYS6S5rrrB1HiqLf183uEOp32f/zu8J+RDS0ua59BJCC23L/MVdnuLyTnxaMQMpKML8KkG6HvzHvgS/wKqq/K2hEpSzRJFLe4yB5xbG3Em3888DKS5hbdHxA1CVVPCJdSb+FZQKRcdRofL2QQlwA445ZsD1ZVURPbMal06t79ZSHQWAuZ4y4LtFSOVxJWpWedGxe0jcEOHtZnWc2cwAv1mMjvos0i/GudtKja1wbDcohhUz/y+6JDpv33xuL0TQ2YGwEvUHvKEMBssNmN/HDZi4i/LnP8O/s9RdajoakVlolt9+IH5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5497.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 09:58:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 09:58:45 +0000
Message-ID: <309f0ac5-e2fa-4c2d-ad37-af1de0dbe853@siemens.com>
Date: Thu, 7 Nov 2024 10:58:41 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0450.namprd03.prod.outlook.com
 (2603:10b6:610:10e::28) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd52db8-a300-4673-a46f-08dcff12c496
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?emN3MHVIV28xL0lRVUY3ZkpENWNuM0VqS3JTTHJRK3lFMU1ZMnN4bjhwS21M?=
 =?utf-8?B?eXJZRzZyYTBDcFdQTzloWmJMaU9BdEVmL21MQkt2U29nV29oTjRQd3Z3WnEx?=
 =?utf-8?B?MmRFS0NTRS9iQU5RbU5xb2poVlBUQXZodlI1eW9KMDB5Sy85a3VMbUpFall3?=
 =?utf-8?B?TUNHUWd4OUpxdDl4U3lwcU4yRnZSL3pnRjFlM2I4UDF5ejgwb2paeklOMmpL?=
 =?utf-8?B?Q1h4UC9DNjdIOHpFMjFpUng1alBSTlplMS9HVHFySXpMWFJYNDNTc0MrL1h6?=
 =?utf-8?B?c1NsWm9vcSsremRheFF0cUlKSW5ibzFZVXM1YjFrY1E0bVFlUFo5ejVHY3hl?=
 =?utf-8?B?M1E0YmsyS01TVW5BcDR2dG85dVFIUnVQNkVGamZmWFBRWGt0cytYM3ZVWWRE?=
 =?utf-8?B?ZmtGays0b3owWkNuUUZSL1dsdkpmcjJUcFNJZ0EyN290aEN4K2U2MlJvM1ph?=
 =?utf-8?B?WmI1T3p6QXF1SmhySndDUGFWK2xHMnl0MlluQlN6NEtQSlVSM0tTMjZPS1RL?=
 =?utf-8?B?YW96M09Sd2ZXMFVBTGovby84OHdrOEpXOWROSGFyem9pSmwwbTcyL3FTWXBy?=
 =?utf-8?B?YlIyNlhuMHFyNmNycytOOGtER2dpQmFreVBQSm9tWmNGUEJWM1VFOTZNYzc1?=
 =?utf-8?B?aklZR1hxQjd5ZXF0M01UMFVFclFUOGU1MURJamFhQUFnZGJXUWkvN1BUR21J?=
 =?utf-8?B?M2JPa3RlcktwbUFSMjBtS1ZvRFJ6QWhNem1ueG1NYktMQ2xkWXY0RytsdVN1?=
 =?utf-8?B?R3RQS3N3ZE1LNkZ4blNQVWQybU9KWTlRT2lXTGFYVTY4ZG1EbmwvdHBBaFdK?=
 =?utf-8?B?TzI3Y1ZOdXQxb01ud2tLakhRSDBTVUdsT09iQzlFdmlGLzZsQlU0cVdzTmF3?=
 =?utf-8?B?eG4zQk52YTdPeXEvTUVqcDNiLzJ1a2ZCOGdRSFptNjZMVW02b2IrdzB5dkFS?=
 =?utf-8?B?TkxZa1Z6OVI1TkxIL3hPRjYyU1c3WnhYbmtENEp6L1FXRm5XcHIwVExUOVV6?=
 =?utf-8?B?cEt6bW9ERFZqOGFXY1dqa25GNGppU1dvNmZrbzhoTDNwTUp5cUF3Q2pRNlQz?=
 =?utf-8?B?cmdLRGZzVnN4eElVOXozNzNIR3dzTmlRNFBCMHlYNkJEbGlZckhhbHdLMXVn?=
 =?utf-8?B?c1hLZ1ZzYlc1a2l6QXhnYWlnbnFBT0xhbDJnVnBvcm5NaW80V0xTc2E1Sy9x?=
 =?utf-8?B?ZGdBR3F5aThaaHJUQnBOL1pNdzBLMk1mT1hwaktHYVNCZGFuZGhSRHdnKzdn?=
 =?utf-8?B?WUtQdW1DYXlRQVRaNFBubWJBOVF5QjNRMlEzc2kwRTBmdTlOK0hEMkZWbzY1?=
 =?utf-8?B?c2I4MUd5Smd5aGxURDJjaWxsVGlwY3RxQW1tcnBnQXNnQmhpR1BJVWVocWtZ?=
 =?utf-8?B?TitrRjZjQVpQcHh4WWhMOWNzdURwVGxadXMyaTZJcjhKMndxM3RGaWZyZTBs?=
 =?utf-8?B?WEo4OStqYUh3TDZocmxJRVBPMDZTVlpQenVBMVFEeTlZcmdyY2NVQ3dKR3Nr?=
 =?utf-8?B?S3I2c3BWSWdPTXRKTzhLZElkOFVjUUpja0pFWVpwRk1UWmNiSVpYZDhkZHlu?=
 =?utf-8?B?ZFEzVkRYTlloUmxoaFJ5eG54TDlKQVNNMlI1Z2lINVYydE0wTS9uVCswQUlM?=
 =?utf-8?B?VE1XNHk3OFBGMWtQaEQ3bnBhRkR1VXNGbjBsK2VOdG1TREdmNDVWanhuNndD?=
 =?utf-8?Q?zTl0Qt+2Ra/uDksXTek1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eDI1OTlXVFp5K0xWQnZpbkJSeU5FMFZTRFVraHJOeWxQSWxXYktRS2h5Z200?=
 =?utf-8?B?eTBNT0FIT1d3M3FleHkzZWZUZEpmUzlOUEhQN3V6WmNmVlg2N2h0N1g2VXpT?=
 =?utf-8?B?WnBZRWl1UFluUm1VczIzeFppQ0pmcmhPUndENkNobDBmdGI1dTZ1b3hoSjlQ?=
 =?utf-8?B?NFlBTDdERi9rZ0pUNG42OGlMSlg2RGU4SUhNQnpwT2N5cnl4ZUdCc2hxNDJ3?=
 =?utf-8?B?SmFwYWVwY1ZzdHJBWG9Fc0cwYzFBMHROTGg4WndRMlVibkJzU0dBNTh5cGJW?=
 =?utf-8?B?a1hpSmxGZnpXSCtiamN5RHFsYjJCNFNHTWlJWHNNTmtLQWlkMWIyWTlkcklp?=
 =?utf-8?B?cDgvbldUM3lPc0hhWlVqcHhWeldoTjFZNElEYzM1Q081aTBiWFVSSjZWb0pF?=
 =?utf-8?B?eU9CTXB0THBCVG9PK2w1NVRGUGF4M3l4R1doSG53SmgzUW9NblMxQzNGb0lZ?=
 =?utf-8?B?b29aU0xSd0tzZzJubHUveVRtZnpkNUlkMFJ2YnpFeXVhbUtHNVBGY1N3MnBK?=
 =?utf-8?B?TkpjUkwyRFdDeHYwTkxmTTAzUjFoWlo5OE1BYnoxUElDMXZ4OGFDLzBmK2ZY?=
 =?utf-8?B?MEJaZ0R6eTFWNXBSZGFGSittOW1qY0JXMTFidWt5amhaeVBFbDBsVDdPK29t?=
 =?utf-8?B?N3ZRZmkxTjQvQmZ4bjNETTVJL3c5Tm1USlNDZEFmOW8vdU9XZldCa1JVQkFD?=
 =?utf-8?B?UVB5U2hPZVpMZ1I3ZS9wY0FvTDNCbEZ1RlQrZGZHVDNWWTRDTnFrRW0vMXRp?=
 =?utf-8?B?aWw2eEdRdHFIZnlPVUo4Z0V4MGRPWmR3V0lPNnlxZkZDazltVDZ2SkIydjRP?=
 =?utf-8?B?N1NDd1NvSDBNNE1oR2hBZk4vTmhzZHRta0haKzBaWHlyVCt1elNXaGJqSkpl?=
 =?utf-8?B?ZXhpcUs1MTVaQjc3TkxDdnYvckJSN2lPZW83emVXNlJRMmJ4aE1peVgwOTlB?=
 =?utf-8?B?cXpWem1idXZrQjRPMnkwdHJ0ekxJQ2NLMWVlQThuM0lEazRMaHFRQW5rSitR?=
 =?utf-8?B?UERtekFHNERWOXpwRkdlV2JRWUJIQ09UYlFhYWhqYVJuTXA2ZjRCT1FONjRo?=
 =?utf-8?B?U3J2S1RnbGd3eENNOE9lcG5QSDdQZ0tkWFJWTFZpUXNQTm1HdU5kZTl6M0FP?=
 =?utf-8?B?cnZseDh0SXl2WVhIalBKc21Nc2hzWUlZN09mVWFsTDZZSUtOdzBXWmZOc3JR?=
 =?utf-8?B?NFp1Ny9nMFg1ekVyejg3Q2lGa1JBM3Ivd0I3N08wdktxOVJVTjZvcEY5bGY5?=
 =?utf-8?B?aDNTUUdpQ2ZTeXBSVzhmanZpT2ZtTkhxK0IwMjE2S215Z1VxbWovM1VBVHor?=
 =?utf-8?B?cTVrd3pXZG9pU1J3NEo3cUVrSFFQYUlDbjdBN3Jib2NGMVhuOFVCLy9xOVVG?=
 =?utf-8?B?dHU3aStneVpaV0pub2hsVHlxS2RmKzZxV2d2NXRzcEZ2NWdjSWdQU3V2ZlpE?=
 =?utf-8?B?bDZaRGFaT2tHa2p5dGYvNXNkUUhIaHRHR1hPdDV4QWFHdFRyK1NxbjhGbEVi?=
 =?utf-8?B?RytaSi8wMXFma0x4YWpDbGo3SGo5UjdJQ3cxQ096ZXM2aUVudXU1aEcrY3Mv?=
 =?utf-8?B?TmFKZ1M4VGlQbFNqeGVOQVFJMFFneEVwZjNJTEFQRi8yei93VG5ZNE9VM05w?=
 =?utf-8?B?VHM1UjJjQmtGY2NoT043WXM0SjdHenlEYlZkaHJ5dXFhQmNaSjVRbVN6NnVo?=
 =?utf-8?B?R1dmNnB3UFZseWpIeHVleWNUUktmcUE0MUZPSFU2Y3FnbGk3RXM4WTdlYXRt?=
 =?utf-8?B?SnYybGdNb2JrOTdod3NTY2QyL29rd2JBOUd4dHJzR0xYc3ZrTmJuSzZpaUEv?=
 =?utf-8?B?RTNYTmIxWDVJR0I5QW4rQktEWldzOWlRYys3L1lGZjlMd2UxRjdtS2tGM2FO?=
 =?utf-8?B?bFFocGJ0cDVIK21tUDhqTXNWUExEeWQrQjBPMXRVN21yRFFGK280V0g1elY4?=
 =?utf-8?B?azFjcWdHWk0wd09ldW5nSnkwQWl1TlNzWWc3VHh5dktSRDRIczZHd29MVVQx?=
 =?utf-8?B?QlJlcE01b2QreGJ4ZENnNnFSY0NIeHZWWkR6Ym5LUEkxNytkWnpMWndJMDFE?=
 =?utf-8?B?U2FxUW5oQTVPVjkweVA0ZGUrKzBHZ3V5S1lyOFNXV01HNm1rZGc3U2RrODZ5?=
 =?utf-8?B?azE3dm1iMXY1WmZaYmJXa01scnUySENDQkhBTmR2dkN2elp4WS9EQXFidGgv?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd52db8-a300-4673-a46f-08dcff12c496
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 09:58:45.4426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWHvsqaWJ0i6VDXE4rdpFX/iNg+oBQPg7Z9kTYfhlA0zN7f0/4BaLb3XPr491qpbX2rukTaew83IJElHHs8KxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5497
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 09:58:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17203

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=11&day=7&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/10/cip.2024-10-31-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

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
  Status: *Late*
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
  Status: *Late*
linux-6.1.y-cip: interval 15 day
  latest version release date: Mon Nov  4 11:35:47 PM UTC 2024
  limit date: Tue Nov 19 11:35:47 PM UTC 2024
  Status: On track
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Thu Oct 10 09:13:53 AM UTC 2024
  limit date: Sat Nov  9 09:13:53 AM UTC 2024
  Status: On track

