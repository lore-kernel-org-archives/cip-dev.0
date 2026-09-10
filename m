Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA13AC79F9F
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 06:50:33 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.29])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8008.1789023032111502304
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Sep 2026 23:50:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lwOJouY2;
 spf=pass (domain: siemens.com, ip: 52.101.84.29, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwKsg1OCsKkE88KTr8KjnxtGEV399NQ+KGJQbYVtr1QZifx+qUT7JbCrkmZBDFAUSiioYth14hboLA8Co8mUUnXHYNIpBb1nF4sHpEexqphqeubQHcC6AhZ6jE1zQE8UdxXimrpUnHkfzuThaTN9sxaf4VMy5g9To9kDpijjeogcUe07YGRyFhQU1deTYtDEQ8ssN2XWhyOhIRsmaRVRn2U+fVXavQGDYObqKUbKK73riC0G0McBAGFbU5UOMm6A9yrRBqzxbg1HQYnTtxMwzPSxflnFxxdBJc8oDPwPgh6Wy8DNmvEwJebszd52Le1u9BW//j+zainbBHk1OeLKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQRtWRBj1bQu0csGpO5AC0d5hlSa/kBrfvpOyEZb9K0=;
 b=Mt5tu98EW4BRBlW/NLeMMrrqLr3CWH7Khu8MRYp5DbVs5L0yc3oI7B5SmF9Ct+4Di/Z6iPhZmTOHtw7dAAY6do2gFCD3d0deb6SldDpORAQyzqO6Y/69NhREjRKItCGcl2B0vOj8NxZyyLMNXaGj94DXMxhAxsytpkN9RcZjknuJSeVIumZb1CaDrjWDD4Zy0iFPl7Esy6v0nghEG7HecDwezcHSefXucD0aA71L52jK3+aRdTr5h2RCQPH+2kfIJSTU0ZyJ/Li5EKyBUMubAiSwkMfHbXVHTEupPF2FEt4goEyxZfi+/sqxb8I+kjO/GSjKyX9dB4IiDQ32owcDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQRtWRBj1bQu0csGpO5AC0d5hlSa/kBrfvpOyEZb9K0=;
 b=lwOJouY2e6p+9YUlsekb0itUCKQ8hP2wJglrsemdSZIz530e36upGyHhyCGOpRiz7HLsUfNaK1rC95UrVERvui2ghxXSOYsg9d6GKSga9Nw1NemrbSkGi2CCw8iz9ydX76ezXzex6qZZpqPmQQoT++xrYbjADfKr6p9QECtGXL7hDsdH04z5ZT+Bo7qYJLZ4W6wv5gwWwauSTnuJc7Rupc3HK1LWErQYBUcUHzx8ljaX3syAs5BL71xwEIJr37d60jhFJqza50CsZDOtVsE6JGvxEgHac8ypyKDmkaBhEo6FBiOMFbCA7vLEge9Bn8/4srMhWrH3uDIc2+hMSZc1Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7713.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 06:50:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 06:50:26 +0000
Message-ID: <cfc9d16d-c8b8-49d4-85f9-29939348f8b8@siemens.com>
Date: Thu, 10 Sep 2026 08:50:25 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a3bf61-77de-482d-8d26-08df0f07cb7f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	fkWqrcu6u6qojvB0H5mbYCDRYGrCBJYd8EYoSGCP90VZ6ww+m6FsfSqqa4zxRzxBGVEiwtqnQy/DJgkwiqL9qJqybOln4s2/95hYPQLm1nMRXVjFJNd8ZP2543ElZlylNsd29O8xZoQTqxPCzmOXqY1WsibDxJtM1/0srrx5f6mFqQ0EnjVbhpGXtDwezUCX2uAPJQ5HKFBvV0sB02iQLFTsEu4XGwBZ1k4/NpxB27wnoYeig+qXSnOKH36v2nQA+q07oxEyi6qo5yEfcPIpvsHn6LwFkUTNoClul/PUkR6k+denqcVnkKTJFaNQGpIalGDjMrFQBZx3mrlbXzHZqjKM46ToBcCNUQgeNMCwpSo13YK0pRKCQ8MBNV+CLogh+5zr7o55yR6f8MPndKIvGzUenrqLXiqICmYN8nvtSqGcuSPfCX2ajVsLDgpAlU4r1FJTCAYze5/hHq573Q+f71eToi+zcWgTSlM2bpSgqUhAPV4nStr3d3x67s+vImJl+UhHR/hWdiZKrcRWewBZjkBLDnlRQSUWPsyIvR9gB4u/JCOD806YjeOjwQJQVJSCzKSsGSWQCswyKggJJfLtba6oCrjW+b7heHTKPQP1t+o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U09YcFV0NkFaTFJCRzdRVk9Oa2d1Y2RjL3MyUEZMb2RUTEQvM0VmQnUrQ2RZ?=
 =?utf-8?B?UVdIVVAzcGEzRUdNQTY1UDhmZVlLVUNvRVRrMml1M044MWE2cFEwOUdUNHVK?=
 =?utf-8?B?cU9HV2x1MWptMzBmcjdMRVBoWmhEQWswRUFVc3UwcU1KV0VkWkd0d1ZQVk02?=
 =?utf-8?B?N2xMY1I1VmlUNUw5cStxYjFyZTJ2TE43c3B4bVVZQXNyQVIyN3A2bnA4NVg5?=
 =?utf-8?B?ajlMVlFzaVRNTVhUWUFncnh3SHdHNDd3REliUXpyNzVWVWFnRzFFdXh5Ny9C?=
 =?utf-8?B?L1VlSFB6bTdMWEd3QmZ1NjdsOE5jTGJWMFNEZ01NdGFwRVB2YktVeDJaUVIx?=
 =?utf-8?B?QXk4ZlMreUdIeWE0bFRDVTNGR0oxQ1hQVnlFZnN3ZHBSSWFsdGVQWkhwZ3Ns?=
 =?utf-8?B?dWdNT3B1Q3ZMRk5jMXJ6cHpjUDdiYnVqZklBa0d6ZXo2Kyt3djl2ZmFvdGFh?=
 =?utf-8?B?RlFsbmpuaDhMZlVDMyt2NCtHNFlJUnZwVkNPbGZDd2YveXE5NHVWRkRvZzl0?=
 =?utf-8?B?bEZzM2NGWWhtdzVtQnd3dm1QckNFN2MxODhwS0RXYm9tUlNweWpYa0hJWEMw?=
 =?utf-8?B?Sk9zbVhnU2ZGNVdhcjE0OUQrbkc2MjlycXcrVVdLS2t5N2dqZHBTLzVqSFpP?=
 =?utf-8?B?eW9zQnN6Rm5oMVllczJZM01HRDhBTmp2UWNmck9BQ3h0Wk9IOHV1ckRtZXM2?=
 =?utf-8?B?L1R1S0d2Nmx6SlVXaXBaUTQ3dkhUc1pmQ1VLYmZCU2ozU3h1SXBJbEFtZTY3?=
 =?utf-8?B?VzFXdGZPd25SYk1wRWtLTHJ2TG1hSVJ2YnF6QVJxb2JoTytaYmFKS3VBT200?=
 =?utf-8?B?OXlNZDJpdUFPa2JoTm9IZWtMdHNBWVlqL2Q3WTJudXgvTERzeEcyMlM5MEt1?=
 =?utf-8?B?UXBvVm4zUURiL044SmdCQ1FFeDcrWDdab2duUVFXNTQ5VlIrd3NLbnFCUlZW?=
 =?utf-8?B?a0ZhOURwejlkNzEwdzhPWlEwOXZoZ0t5eTRNMzdLTWM5RG9WNkZnUEgzUkta?=
 =?utf-8?B?aWVvVkJYbktxK2hBcjAzdDlybC9sSzQzM3I4bjRNV2ZCTnMydjV5czFXWXhZ?=
 =?utf-8?B?ekpVRWs4VXBmZ1JsNUdHUWlmL3lWalRJYnluZ0RNb3FrckordXVHMTlwTTU3?=
 =?utf-8?B?cjFOak56Q3JncjErL2F2OHF5TklldFdmM1Vxdmg1WnVRVkJYUDAvY1B6SHpl?=
 =?utf-8?B?a1p5TnhXSHVmdkYveHUyYndVTmhCSk5ueGwrZnNodS9rY2Y4WitkRW5LYjJL?=
 =?utf-8?B?b3Z6dmpBdkRMVmpXWHlsazlZWE1QUU8yZ1gyVDI2ZlV5WEIxYmU2Q0pVS3JO?=
 =?utf-8?B?THZabHhscS9hUXNrNFpoVlJMUlRNZmhkV09MRG5hZjBVMXBCbzEzSGhLZERB?=
 =?utf-8?B?dWRRR0c0bS83NXlvaCt5REVyclkya3ZtQm8xV0RvWmJNeU5yTVI2YVBHRGFz?=
 =?utf-8?B?L1ROMFViSy9icXZ1VnpUbU0wRW1HNmFVZDByWThHR2h0bnN1Zy9MbHU3VGRG?=
 =?utf-8?B?OTgxRkt2WUxlTGkvS0NFWVpQNytJTzR5RzV5bTA3cTc5NXdMY1pRc0hkWEVr?=
 =?utf-8?B?QnlRMUR5UHN6bEJoSmFNdkNqZTBEY2k1NkhHS2FnY1dJUTZxSXFKaExhRE1J?=
 =?utf-8?B?ZUxZZm0vNkpURWttWlN6bzhsbXpOVjVRZ0JXMkY3UmZoUytzcEYrZHdNSUIv?=
 =?utf-8?B?M3JEb2F3TFAxaUl5Vmw1Y3R0UWZldXhoTGNEaUppb1A1amJCNjRyNC82d2lx?=
 =?utf-8?B?TWhxeHMwcVNVVWNZanFzWE5mQVJ3V2d6NzBxdEV1WDR1dXVadUN0UkF4Sjg3?=
 =?utf-8?B?bklmNlBQdGJuMUVtd1BSNHJvNDJ4Nldvc3FzVzU0eDZFY3BGVC96S0NvaVFo?=
 =?utf-8?B?OWc2UEdsdUpkV2NyK2lnVlRERjNJSjhXdmRsYVNYYjY2TTl5Tk8vTC9HWmdw?=
 =?utf-8?B?RG9ERmRKMEF3a1FsSmVSek1VU1BvR0JEVXZ4ZEpRL3dqRUdSdXRWSkZmbEx0?=
 =?utf-8?B?ZVAvMFZ5V012NUdoSnlVUlozVkt0aEwzaHQwUHJOSGJHYncvS0lkRFJPL3Yy?=
 =?utf-8?B?dVdhUldhK3dlSnk1WXFOUkNuMVlQMCtrbjFpYmVRL3RQaVdWVkpLSnFEL1BJ?=
 =?utf-8?B?VU9raWZHR1k5Y3NhclBLTkd3Wnc1c1pVRkt1dk9GNjc3eGp1UkxCZHNUck5I?=
 =?utf-8?B?Z0M5MHRwT2YxOHJKWm9RS2N1cTZUMXNTWjcwdmdzM0QzM1lQUmp0S213WVFJ?=
 =?utf-8?B?cG9kdFB6aGpqeEY1NGk1N2NFMjVyVWVldHRpYUduNml1bG1nT1JYNWkybjFI?=
 =?utf-8?B?OTZnbTcwdmJBazhlZ2N3NkhjazIwc1c4QytTWnYrL2hoNWJEaC9Bdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a3bf61-77de-482d-8d26-08df0f07cb7f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 06:50:26.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKtnKQtWlEjttRY84dz6dSPbAgZtex+G170VTx2bmBEW/WMtTnBu5yVn/2ShY/UXJA3exP1zKtqGEGn+/tzrGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7713
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Sep 2026 06:50:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24113

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=9&day=10&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/09/cip.2026-09-03-12.01.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - cip-kernel-config updates
  - LLM review tool: updates, feedback

Jan

[*]
Date the data is created: Thu Sep 10 06:49:56 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip114
  latest version release date: Wed Aug 19 08:54:45 AM UTC 2026
  limit date: Fri Sep 18 08:54:45 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip113-rt62
  latest version release date: Thu Jul 30 09:07:13 AM UTC 2026
  limit date: Mon Sep 28 09:07:13 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip135
  latest version release date: Tue Aug  4 12:34:28 PM UTC 2026
  limit date: Thu Sep  3 12:34:28 PM UTC 2026
  Status: *Late*
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip134-rt49
  latest version release date: Wed Jul 22 07:47:57 PM UTC 2026
  limit date: Sun Sep 20 07:47:57 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.263-cip76
  latest version release date: Fri Aug  7 04:22:30 AM UTC 2026
  limit date: Sun Sep  6 04:22:30 AM UTC 2026
  Status: *Late*
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.260-cip75-rt33
  latest version release date: Mon Jul 13 07:40:40 AM UTC 2026
  limit date: Fri Sep 11 07:40:40 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.182-cip59
  latest version release date: Fri Aug  7 08:15:19 AM UTC 2026
  limit date: Sun Sep  6 08:15:19 AM UTC 2026
  Status: *Late*
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.182-cip59-rt31
  latest version release date: Wed Aug 19 06:16:01 PM UTC 2026
  limit date: Sun Oct 18 06:16:01 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.108-cip31
  latest version release date: Fri Sep  4 12:46:01 PM UTC 2026
  limit date: Sat Sep 19 12:46:01 PM UTC 2026
  Status: On track

