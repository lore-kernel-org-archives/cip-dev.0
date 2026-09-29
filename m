Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8FECA5FA1
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 11:53:15 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6046.1790682788156414677
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Sep 2026 04:53:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Wk2ZHMaN;
 spf=pass (domain: siemens.com, ip: 52.101.84.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edGY5TAT4uypstdu+pJ/EauEK9/U7qRPpgnnxUcLj3nwn3WqtApo3cgUAfOb9STw9PsbwM2zHfmjVGFGOX/sIGzNn9BnRS1tQbRjy5Ii90X0DKJ+s3aWSYzoHoN2ghISCveDS1S6Tfbl/QiJB6pkXwGRmLRqvw3rqVfi5S2kKvi+a5SeqIZ56e7U6LvEdJnqFV+gAGYxAm92I1abL7cnkNNtZrEziqqdb1BXuVRQ30LmImOmrIcH5Rh/ZLgkldbMKNiv7J92rMCTGMiPFd0zDB4Qt4vNK0aaRhXr/nFU2u0atvKnOgdWl3r8TBvMhXGlpT2u1V5ebJmY8HoU2yajoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4wDpBS2DQXhb3uf4RM/rGj7L7C966xDrbDdUEX+DB4=;
 b=Lk0ilfZNnmFAOTlsLOqJuHWzczHGOcIfZLXucSytNxpBO/gjD6D1bzD8qPO1dx1HdMDcBTICwcm3rW2RtrwlOnAgNh1SWHED5GKc0xr/B5JwmffvGinjVB1l9E/aybga0KaBUXGqGK93rUAVn4yAP4RZ+q0CyZNtCuridtINQw4c/UrKgyPeN88oVxZ5WUn7JDGIM9zA6EWTtnS+1bHG6kh86miLbCjh0uEI+x9wom7kpPEj1eo7ujAc0ivoWa2hxGXJ2sh2mm01YWXOJLoFu7sIdB4aw65dA8FDoWKAKBVmrZmgNOsxSR2lNxjj9NiJapljPur3BoR1COgwjz42+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4wDpBS2DQXhb3uf4RM/rGj7L7C966xDrbDdUEX+DB4=;
 b=Wk2ZHMaNT8csHE65vxNXW5f++S3j3Hk2hor7XQHLUUxgAOR25RGepA8SFiR+TY2oVXGPWW4VW/rt9QuNZBx7TbecSN8msGk5XTbyz6KLBw7qVpi7192/Lv3WYf4c0lzFi1krt6sNFWYZvel2EsNR4Ovl96fTEBp0wo/GIIJfxRnr+3kVTVnYmzHW8x6XknXviu4pTkqnVMBOitSUNVPg42Jkgldlx7i67E56DO8qh03F2nNe/jgYgvn77u27TD+41KAwjnDo8GG8n3bcrr8KFxClHpKlVmlXKgMCFghOygtndjYIkKN3pGxY1u9MefZOIsrhIbIw1EDr1YlD5M963Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA3PR10MB9331.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:4b8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 11:53:04 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 11:53:04 +0000
Message-ID: <06640825-6f58-484e-b9e5-5e5349938fd0@siemens.com>
Date: Tue, 29 Sep 2026 13:53:03 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 Pavel Machek <pavel@nabladev.com>, Ulrich Hecht <uli@fpond.eu>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>,
 Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: CIP kernel lunch
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0429.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::10) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA3PR10MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f47431-3652-4653-2db3-08df1e20385a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Ob551iDYfRTsPxlL6glK5qHPqxpr0oTcSkHLXjwBSnrocDJBjv5NWSjD9nNPnOUer3FV3mSupnKI2lBD2HfAcC6FMJNsYB0J/F361pYU0Bje587Oa96TU1BtCQjwP5J6EIzC4QvFL8mxY09q6QGO1t32Vv4ecbOyFXeh//CpmUp823/w1W8ybrGBy+NxKVnkD2rMLhwOsOyjUo4Er89UAMGtdAOKZk5idHTdxNJgaga/lTGuiViI6gDQAowu+LfwELu7lmOx4gJRXBFWkg9L1Ep6mDazvZhwfRct7e60lHDpOddYIe4dKh3HWIpYpujVUXlBHg0uRYmSI3OcHORvrb2TQpwk5OR3pWh0QwjoK5VmMeZl8qpyQWST80SL76YT4viswpxqleQ3i5T0iun56xbklKVVu/xIJrKkPOhtM0WS8w6SsIejcz5DqqHP7rNhCC2N7ZgK5gzPd+7v9satzLi36eNWwZzv1wVy2JSwv27BnZQD8Lw3h8knRqxAyWzu3ayU/DQEFBNT9NrHAiauSzvtivAZzJ+NQ3uiKEXkh9hwD+OkuthtlwFQhSUrKI/unVZ1YnQWJhEom6AS8VUwkaJF5saxUUWNHeUdzL3TAY5hl5/PCXnPtPGhVh3fJfhPFqdXwD9ztWP8gLjC1zLkeA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eHBZak8yR3diYUxoU29tdGMzYW1KTFlKWDRISmQzek41UlJlaWMreDVKQTlz?=
 =?utf-8?B?UWJqUjkzOGFiRkovR0pFaTJYaFEyWTlhTmt4SURQRkJWcFlIMW9rZnZHVTVK?=
 =?utf-8?B?WXVTL1Q3aS9KWVgwNkhrVGJDR1BpM3RQQm55bkVzK3gvTlphWHJDRmZQNlhy?=
 =?utf-8?B?ZHh6d1JiQ0tHcXBGemM0TnQ2T2pMcThOc3V2Ukk5aEVMRnhCRkR3ajRwNzhV?=
 =?utf-8?B?Tkd3ak1xNVFNWmdFekZhNmIzQ0JTRjdwMFA3aUVhVGxXdjJvbVYwMnF4b0Vv?=
 =?utf-8?B?cDU2OGx6Z25IVFRVLzh2dFZ6cGg0YTg1WHVucUMydm9UeVJWS1kvMjlKdkpY?=
 =?utf-8?B?UzF4UWdMd2ZBWjhDS2J5am5OTGd1MldPMmFXYUdxQkEyVDZVbnZsTUM5Wml3?=
 =?utf-8?B?bkxnbWdLUUpMaGRJMG9DbGdMYndrVDdGRnorN1NrQ2VVdTBhejlzTi9Ddkhh?=
 =?utf-8?B?c1RoYVhDUncvVlBvYVlMeTJqSHlndEhRdmI3Rzl0T3Mza2tOMzEvSzBDdStt?=
 =?utf-8?B?U0UxOHdBZnhMZUpGM1hxQVU5SU0zdzhpTjVPVFN4UkFCajcwRVNxQTJkbS9y?=
 =?utf-8?B?RTk1UE83S2RtRGpoWTBTZlo1KzRWWXJTdmFjOWVIcXpiVEZrMGVuZVdHc0c3?=
 =?utf-8?B?MmozeGQ1MU42d3pvMzB1TkdndU5nbEN1UUxJaWJJejB5d2VUcVQ3bHIwUHhV?=
 =?utf-8?B?bTBjYmhxcS93K3A5NzlYTjNrVE1QYm1nbzJjRzlvc2hIL1lKc2NLL1hwQUl1?=
 =?utf-8?B?R2MrK0xwYnV0VHZDb1dXL093ckJOaHplbnRySFN1clQzMUVRZzc2RDF0RjVy?=
 =?utf-8?B?dytDaU44S29uTlVTT0ZIRW1kNks5QVljOFdvRXJnMld1aW1KNGJjZDhnTmZO?=
 =?utf-8?B?YXQ4SG5hQmlVV1h5RzNqRVhGK3dDakRHdmQ0VUc0L09zeDJiY1AvaTk3cldE?=
 =?utf-8?B?QUpjZzlLRitwK1BKSFc0Q0NlZEhDYlhzT3JrUlZpY2UxRzR2RCtrUlVnK001?=
 =?utf-8?B?WlVRYWFtb1B3ZU9UaHAwcmJXUUFvM3VFSTlxbjNtdU9KMFVERUF1L1o2Q1FO?=
 =?utf-8?B?azgwenZUSW41UjhjSXlYd0s0blRFOHBuQ3lwNWtMSzVSa0lUaDJ3UTBrbW4w?=
 =?utf-8?B?bGNPVDNPcW5iMC90VmVZNUNMdzRJRmpnRTJFdGFEaHVKUnpXRXNtSmVGN3V6?=
 =?utf-8?B?RVBERmRBRTVvakg0dENKT09iWUkrTGkzWnRxbXdBR1NPdWJtV3o4ZVdJUGdS?=
 =?utf-8?B?K0pBRnVUbHNxSWdoL0V6NVNTcGlnbXluUnVkSnZYcTd6UEJIVXlqcHRna2Ur?=
 =?utf-8?B?RHV6ZTFvYVdHV3pJcC9CQmtTUFVlR25SN0pxY3dmRUdDT3pJWlhYS0kvamEy?=
 =?utf-8?B?T1Rxdk1iY0NtT1hoSnBsTzArdzFGV3NHYVlHd3pKNmhHYWE4NHZSdFlaMjZX?=
 =?utf-8?B?T2I4bXFYQXc0WTQ3OW9UdWMyd3I0N0lOVkw5L1A5VlBTVkxXMzdyNXhlMWlq?=
 =?utf-8?B?R1g2SU8rVmJoakZGM216a09uVDBRVFAzaW1LWWk2ZDBPSW5pNkxqODNmNzdr?=
 =?utf-8?B?K05EdDk2NW1xbTAveWFyV2l1d2JDTThuOWFuRlcwUHJ0Y3dxb1RhSWlzeTg1?=
 =?utf-8?B?elpSZ1Z2L3A0emRacGZyT0RxSi83eXp5ZUdXb3pqbk1tRXNGN2JKNFB0TVB0?=
 =?utf-8?B?c1p1MUNKNFNQY1ZpRWNiSTJYSVArdEl6SloybUFZL1Z1S1JXZ1MxTEFCNGhO?=
 =?utf-8?B?M3BFeDU3MWNDczkwRDZYN09tU1BTRFB2ZlUwR0RsWE1MbzA2WFlqYVRzd0Jh?=
 =?utf-8?B?MzMxZjIxcVpoSG0wTjRLTEJORWUxcW45S0wyYmFhTWlWS1dYWEVrNUl1Sm51?=
 =?utf-8?B?Z2Q1NkxuZ2UvY2JYM0lnL1E4U3RTWEZ3Si93REg0aGV6SXkzcWRBcFlKeDRs?=
 =?utf-8?B?NmUvNlBhZmUyL3VLTDdFc2xRUkVGQUp3VDlXMkluYWoyQ3J2Y0RQR1lvazZP?=
 =?utf-8?B?OWY3cWgzWENOL3RMQnVrUllGVkVIaVlqZVNQQXZ1a0FZdkhsV0NNN3JhTlUr?=
 =?utf-8?B?NUY1VWhJOEp6TWVzRWh3OGRQajBvQWpxNmdCTXpBNE1RdVAyelo0L0Fja3Jo?=
 =?utf-8?B?YkNkM2hQNGU2eVRIWkxvb0JtVUNPekkraEVMSCtNVDFXazhRSFYxd013VjV6?=
 =?utf-8?B?N0FRWWVyc3VldTlTYUVQY212T1pkUXRxSGdSNFMwc1EyWmdGT3BFcmFQUkNU?=
 =?utf-8?B?VzdjbVMyVzZuR1hvZTQwUjBlcXk5SGtRZnVqSXo3WEtKaE5RcGRaSUtZMjNx?=
 =?utf-8?B?Nk5lM2dKeXBiZTR1N1IyQ2lzSmVPT01JWXVkMCthRG9RWkZRcXZFQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f47431-3652-4653-2db3-08df1e20385a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 11:53:04.4074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yfUldsX4AjKKSJUBMNmohG0yTDCWS1RwTn4oOPzD6zkD3IqorU+L3YdxY32XGfOjd2n6kM+rs95uYf/dkCzzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9331
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Sep 2026 11:53:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24374

Hi all, CIP kernel WG members and beyond,

if your are attending OSS Prague: How about having lunch together on
Thursday (Oct 8, 12:20) and chatting about CIP kernel topics a this chance?

Jan

