Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D40C98310
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 07:03:20 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.3])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2227.1790233399769012265
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 00:03:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hvEr2Vwa;
 spf=pass (domain: siemens.com, ip: 52.101.66.3, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVwvM1FaoTVqodrpdJqSQRlJww7dkhSN7d8oXvDo71vSkH3fZEsyHPHxOwmFlVyYuTR3j/RyRrnYbHat4kAjTq1zAlHHkfVNIc9os91vP+dJZ1VvkFGhiB3x/+FG4W5gQ6+HXevnSEh4jQ72Ib3TBHX5YgHxW1yDvQE6Lv0E7cKgv3nqguvdUCiqlfXtOKzEWQbQJE0/nuMCIYdklXV/hCA2FKiizYhS3QqvfgxAknRmyJoSLxGpqZNqXzowkhDLfeKyLdXOvauCb9nQ1sv8Vj6OIs/OASq4LlwyvbNy6e8cdA1CU6f4FkRgtakuH31UeGUA/+RxadH37yy+vkkXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aldzT6Xm3BTNFpjYRYbR26yQvK0El1ntCFFkElkQ6/Y=;
 b=IpEvPhOH1icGdtqWe5zAmU+cPb5dB6JPtyl2Eqic7GsilWCGdgNEhreuMi3Xq/hCvwZXNb9y7XyHV/o4/KEJWhGODrNnq0dSdZ+NHr/R/WxxDNPtdjfqAVl2iqrkJrP/NVBdq55wnP2tQdk5Ts37R5TtEpPWUSG6JKmiX/uRUiSTjjTaMXkPn6l6sI/eddufU/XnyXBfwnQuD1WE17axtWD65uQopbCd4VCazgWn4wZS3FYp72hNcYjCQ1MomGkKCi9xsvS98xcSRnQ1VNuTIy1T4zhdE+Rn9Nw28hX99gYrg7kLpQXCizK+cz+tMqNuFJlnC8QYC2oYYD57aNHdvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aldzT6Xm3BTNFpjYRYbR26yQvK0El1ntCFFkElkQ6/Y=;
 b=hvEr2Vwa0PA8iEeHfVh59/opMMTOnJeIB7JsVQWvj3EpO/DCtgtIEBVeClOeiCnkaQaOROpKQduAPOsIEb+nMWk1IeXV7KWTxR4KaWnMqUoYiRd5v0iVKTWViAIwoMROuT9wPk+RONq8PnKkXwsb0fGyfHqZfzpCIBuyUTpoSzqfu6PcZpoNlryqheC1dN7n1dCieXfmJbJceZG4M/uFqMZ+4jm24YvRkvrzvzk7TZrcHqGQKZN2oArLNddnBBDQjvWJBf1cYcHmSX71RsboDtLocFCZL8bLICYLnx3i2r34d9frq3javQ0yUdMwzdu9tQmN8DCm0gEEYNm6liOe4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5446.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:295::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 07:03:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 07:03:15 +0000
Message-ID: <1859c4aa-3da8-4a00-be0d-7234c6db0076@siemens.com>
Date: Thu, 24 Sep 2026 09:03:07 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JN3P275CA0147.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:ce::13)
 To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6eebfe-d735-4266-4518-08df1a09e75b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|10067099003|56012099006|11063799006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	iuKx9nUsPvGSzxXetPOau4qaFh7ED3cdXN4HbHDFLbcLUxK1OaZ7y2zHKcQdWE3g4qHh9KuIwCWaKguQ6gUNeBsZBOoZAcHPfSBHb3b/7gBiBW2oAVULsGC7ijdhx3qUM/ktxXREDQuK5bfizTVqce0ofPbPJtfNM7IvwPRlSZncu7QFOmnUQHwbqIjmUW/iHRHvTpd+zotdeQ853fAjOAY3cwLlzlDHzDUu1bXXYq2g9WLddCQ/DZbw7TuTH0cXJXSdD0nIn1vj5/qtGEoMYbiTfAyETt75dLUOs2qvG5Qwa05dIU2cMhPI/mFFy0XnWoIF5ubQ2teDWqBtL/4G9mQEk/3+3WcAY04kwXtNY0gN/uG0xTZCMgzyRVHUVNFi87JvT64a1r/K7100FW23Nwo+p5GY4C54eX2Gupf5oj2VG/fYsUJIDFMaqYqQtJcf3Vso2kyo2Q/l5mL3qIc85TvB5HSy6o1anfu5vG79xEl+FI61It4/wvpb9cWYFGqwgykiGsG4Lgx3Mn7RO8DZAKrVXqpXb5gy+838atLlYUWgZ62MeCCnS5BI6qmbKwFe88fs2DMFaV1d0C4/T/BeNG3SbXFzJwsxN1Plyr0ttW0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MzhWbFdqc05sMGFpK3ZYNlpDMDVWZlp4V2JlaU1oMnp3SERjNk94U1B6SUtq?=
 =?utf-8?B?NWdwL3YwTExRc3hXeFl6d0pkNnV3Sk9NdDRaUkVFdVMvTXhOSjZSWm43a0RD?=
 =?utf-8?B?eGhnNDFZY2RNdHQ1Qmt1OHJncU90WTlwVW93VWVJUXk2eERZWnJyMk5HYUNq?=
 =?utf-8?B?b2FaR0lZYXpESmhiUjlycFBaTUxJZ3UwTXkwNGcycFhNeUtQUmtwTFViRXZR?=
 =?utf-8?B?MHByQmh0Z0hoZWZLYmVQdjdZd2hEREJpQlNwM1N1ejhHTlV1YkJ3VWMxV3JO?=
 =?utf-8?B?YVEzMkNFNzVGOUhtRURxdlQvQko3M2d6aFRFMWFXcEVPM0twcFY2SzVYYnlp?=
 =?utf-8?B?Tzh1VnBTMVJJMCtRV0JNeVpucVFEalU0ZWxORVVzazk0eStwalg5Z0FRNGIr?=
 =?utf-8?B?SWZleExIK0pWRk96TE5oYllBRnNRZTJXdHhZSGtuRHQrS3NtZG1wSnd3NXY1?=
 =?utf-8?B?MUdpcjhZRFZrZVdMQk9kNTVYY1ViTlJiZmI3bGpqM0ZTS3hqaUxiWjJjNjBE?=
 =?utf-8?B?b0ZZL2RpVWwwWlk2V2IvSWlmbG5zTXpYamV5NFFidjlzaGQ2TkFPNGpWSHJQ?=
 =?utf-8?B?eXJaZnRsaE5UejNiQWFRZGl2MmlIcTdmMnhwdUYzenNoc1I3SDZrblJDWEdY?=
 =?utf-8?B?dnJxanhWTlVEais2c1RDVmxGSytNd2VGVnhoUFN6RjV2K1NUbnhuVVQ0eDZD?=
 =?utf-8?B?RkVVUUxMVUlXK3J3N004RGFSZGRqMkExME9CZDd3cWFLcHJJUWlaRzNIQkJL?=
 =?utf-8?B?dXNUV0tQZkVyQnFvWXpENmFjMlZqallxNXdrdnhWam5FcmcxTDVrbHdFTWVI?=
 =?utf-8?B?QjhxTEYzRlBxdFpOMHFzcnlXYkZzVzNGK3hPdjlTbVUxMzFWRkwxT1FYK3RB?=
 =?utf-8?B?TFlybUNvMlFXMTlBMDYvYWQ5em03NDUyRURSOHlsWkMrVm1CbU50VGpqMUha?=
 =?utf-8?B?cnc5TW5hTGJVRDNCSHM0and5QzZwd01zUnYyOGpuSElDVzV1R0VuWEhEUjdY?=
 =?utf-8?B?TkEzcC9ROWpZVVBxM3p0MUs3V2VRWjYzVGg0SXFCZThhcklYcUJkLzVua040?=
 =?utf-8?B?eXc2MUFBZ3hkNy84WXN4SFBrUG1lUy92QnFoRmV3OEFSUEJ0NVVNNS9Ud2Er?=
 =?utf-8?B?RGVGR1ZBSVk1aE83Yk5qZmdMYXN1ODJ6cHAweFB0QjlzZlR1UnkzQzhVMnF3?=
 =?utf-8?B?cGlPdDNGczQ5L1JSdWZ2V1dPWE9rTEJRd2pQcFVOQ3oxaURmT0ZIUU9WSE1Y?=
 =?utf-8?B?QUU0ck45YXJjMTY3dkZFK25aWlEwZ3ozMXRxWWFVT05XR0N4cUd6RXBKUEFP?=
 =?utf-8?B?Y21XYWhHaENLNUVIaDh5WFFzd0V2bkcyUFFUVzBId05BZjA0MGZ2QWlHZDN5?=
 =?utf-8?B?bFNXcXlhaUFURm1FRnJOeUpDS3pwRU1mNjloOVBuRENQOVZjTWpJa1NsclJS?=
 =?utf-8?B?ZHlMa1dzc0k5aVZNVExDOHV5eU4wOGdmZVdscVUzV3RDb1cySDhyYWZGT1BS?=
 =?utf-8?B?VGdBL3ZaenpYK2pjQlV4ODRnZmN4MW8xYzBPUFRRcm95K28vRDdkbjNxQitp?=
 =?utf-8?B?UzhaM2FOeTVTZEdRa2pQQy9XQU1LaC9RWTBPNExKUEpnTkFQdlJuUGtLVVlk?=
 =?utf-8?B?TzByM253UGF2QzZtQzVlN1hPYVhLUjF1WWNmSDRhMGMwNlgxaWdMWWZpNTNS?=
 =?utf-8?B?eEdqayt6eEd0U1kzckVFcEtxVzFpZEdNTk50OGVCMWNUc1VMWnpxN3cwUmla?=
 =?utf-8?B?MExFVFlyeURYelg5Mzh6OVBzWjRUTEc0MjFzYTRLYUs1QjBrTjZCN0ZrTFYw?=
 =?utf-8?B?MVhZUlBZOTBGWWJGNXAxMzQ5RGRHQWF0TEs0czdqUmJzdmQxdE91a2V3bnZn?=
 =?utf-8?B?emJRcUh2MnRGcXBkVXZUSjM0RmxQNjZ1NWtUMnQ2SFBnY3hzcUZJOUVka2pW?=
 =?utf-8?B?cFBOMjArZlZKSUYrbzN2cTYzVjBXMlZOWFFJeHFIQXFnSXJJcUkwUHNvWmVV?=
 =?utf-8?B?RWp0YjYva1BIZW04ZnFJRU10R04wMGJUb1M2b2RJbjJWMnQ2UmRydkVtdlI2?=
 =?utf-8?B?QVJzSG9PeCtKWHN3Q1N1TnNtSVZybFh5elRvMEwzalJRUzk3ZkpuN0NMcTk2?=
 =?utf-8?B?akRQbUVrNndFeUVtUzU2K0dseWhGZi9admZhUVNIVGN2RzhUVDA1VHpad2JX?=
 =?utf-8?B?Z3JJbzlQZWE0OVpFbzQ4eGhKNi9kQkhVT1J2SWMxOEU5VldpMjAvR1hDaGFm?=
 =?utf-8?B?OW5IdERSWGNnZXFZa0tHSy9zdGY3cG1jOWJsOUQ4ZmUra2c3a1hUUncwWFpi?=
 =?utf-8?B?T2dsRk5CbXg5UGhYSjFLVWRjNDdWNnMrK1Z6V1hQYjFOVitpakFUUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6eebfe-d735-4266-4518-08df1a09e75b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 07:03:15.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmdxoDnRNNE/fsLE2q+/m13f5r0DXpkNpVjPPsC2uczZqMYkI7rhnslYUpjHKuvbIWbZoPK56PvUC/RSlELIJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5446
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 07:03:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24285

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2026&month=9&day=24&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/09/cip.2026-09-17-12.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - SECURITY.md
  - LLM review tool: updates, feedback
  - /me absent next week

Jan

[*]
Date the data is created: Thu Sep 24 07:01:12 AM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip114
  latest version release date: Wed Aug 19 08:54:45 AM UTC 2026
  limit date: Fri Sep 18 08:54:45 AM UTC 2026
  Status: *Late*
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip113-rt62
  latest version release date: Thu Jul 30 09:07:13 AM UTC 2026
  limit date: Mon Sep 28 09:07:13 AM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip136
  latest version release date: Fri Sep 11 08:53:07 AM UTC 2026
  limit date: Sun Oct 11 08:53:07 AM UTC 2026
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip136-rt50
  latest version release date: Wed Sep 16 09:32:17 PM UTC 2026
  limit date: Sun Nov 15 09:32:17 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.268-cip77
  latest version release date: Fri Sep 11 06:54:50 AM UTC 2026
  limit date: Sun Oct 11 06:54:50 AM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.268-cip77-rt34
  latest version release date: Thu Sep 17 09:59:47 AM UTC 2026
  limit date: Mon Nov 16 09:59:47 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.187-cip60
  latest version release date: Fri Sep 11 10:35:49 PM UTC 2026
  limit date: Sun Oct 11 10:35:49 PM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.182-cip59-rt31
  latest version release date: Wed Aug 19 06:16:01 PM UTC 2026
  limit date: Sun Oct 18 06:16:01 PM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.108-cip31
  latest version release date: Fri Sep  4 12:46:01 PM UTC 2026
  limit date: Sat Sep 19 12:46:01 PM UTC 2026
  Status: *Late*

