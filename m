Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E743CD3439
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 14:57:55 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14003.1778165867663933860
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 07:57:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Em2aGyOP;
 spf=pass (domain: siemens.com, ip: 52.101.66.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWo+iwxY4kSF1zOHcqeYHMD/xnkm8w2YEh+vpsaprKER4lxntsei5J2Bjb7pwie4PfDrqs7jn+8ACynNDEmpq9tcVbPMHkC8TRYMZ+13+3W68HxPOQ0c/gcMFUcPF6R9t+Rrkg+JzFxRmGghoNOiFlXfeh0t8DI5bwqj6yvc8Dqh4AxegbTGifZ94R2rqACkESpJq+U+yTuj7ac8/t5XnxMtjkCjmnC2KL5JbZ27f8PULh370Nh56Rn6NiJt3wwXe4u2sJGhb4VDjcmXugQnknqjTso+by/46qycebzwV7P1U44AZGybH4P6NuHI2UV2JWY10q5b0Ys8HT1XOhSNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9c2m37+xb1SUlGjJKPp9NBO8N06B/md5z7iFT7sN/c=;
 b=a/c19E7N2geV/I5VDo07UUBiK456U5nQeQczcPUQnonteR0MrfjdVJHFvkZLd4sXdlVQUDzV0RvkJUhz8pc0QrVfNLeY1iSdPfDqwgIPTd/TM0txuxIko6kAnGG5HhhbTlZ3ItUILFBeLcWHPvsWihlMrQW/RQtyJJjEYtMluee7i8UmByGhwj1G8t4yIomhzW6RAZX8XNHoLnOqmLA0O6SB10Ey9pgKVNUKcwQD51bkN4x/CrDq0UYLud1AUMob3cJtQzONFD0P9I44eYV2NoL3v8I/GlEOs9Hfh1P04kzk3SuqJlY6ZLzrFGAQoy0HAmccQS/jCpjZqRfcL8+I2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9c2m37+xb1SUlGjJKPp9NBO8N06B/md5z7iFT7sN/c=;
 b=Em2aGyOP3GLH9aMxE0Ic/OvRnopRsQutKQDpgMi2M20Y+RV8RQV0XAZwrdnmxuScNaoRCvOHZnaakWBZWXLavB+OQPDJOnDIIVQA10RE+9aSmYSgZ6jaiNf9s1+UDfD8KW/PIym33wPFpLX8Ph41nb/Co8My1mfxvp/nY2aqlJwYX3gR5GIyTVNex3op4sdfcT4XbguqaC4s9SKUQ2yIxGbnZZzMvG3pWf3MRWPrJke325W9997JVldPmn+DiNt7cFZ8h8eD9gMnmR8f1144yblpxlvmKZs48Cy/hCLgOIEBniyGyZ6FoqgciGly9c/U6x/rw8AQcJ4QSz1s5YQyUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5574.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 14:57:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9870.023; Thu, 7 May 2026
 14:57:40 +0000
Message-ID: <e4be98a1-10f6-4b0f-9e5f-b990be2204e2@siemens.com>
Date: Thu, 7 May 2026 16:57:39 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: lava: qemu-renesas-01: "client version 1.41 is too old"
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: 026c4909-7865-4116-6141-08deac48fc3c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	uJwHWSOm8eHsiVd6NiEJmqL9UC341x1TKT7etH4SZxzZAfzzxezgHrAFWa1DTuW7o/LW71SkKSbX8XNY2ixADS/PN+uUE60vrrqqqv/tEWDb15mNEv8uhZJjjwkX9qSextdIcL6+JtZW2wmGFmWeQnM/dzbKGObk4Rljr50MuJHD2lja4KtTYNc9n4JeNaZyvBSyNSz9GcjKprjaSM0EME629yWHK09EM0pNIl5CNnzqlPsqbSlgCmsBuA0lALavkLLEaqn7OORDSnXDIMGQmd1Tr7BPv4eoVA4jP93SaE+igNpXX3zWd6jcMX+Zj1D24IpyvWdCpPXkASyM0+veovlQvXnrWPMQ2azC1y/Myp9NfGcD2k7Uq329ZOJklGUUSyO/UoJO2TnCg4kR8AGvjCiF7VMWhpzkCsMXdyj/4Oqx/rnJz6/UUp4A0MGOJB3nlSmMUfZaCoOrJDxExyWbyiadBqHJ8jqonOsYzIN5ZC6VM6GsNLqjJXYrDiMANocnwKXwy7RaQExveZ6aBtMPsnwqDAYMf/lLL5G5l9R3RLO+XeQliGV7TudeMp/fhJ5846D7DzI2+1Yn/U9kbGmh5WBNtIpdBGH/DHgpIPhv6JKpj3PUZiy+uOy9QbYxLmzTuQXea9OQIAOmmbn/0TSXSQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UzVmRjBKQ0F4UjhYQUpVclJxdnFUK1REV3FSdnI4cWNmemxMTzZ6U3M5MUZP?=
 =?utf-8?B?cjZWOUgvOG9yNVMycUx3NlhyczVtaTNPVlFpT1pWTUM1b2doY1NwTXN2cjZw?=
 =?utf-8?B?aE0zM01zTGZOcDBVaWtPd21UdTNKSU5uTFVJNW1ReWtQVm5FbitCSktYbG9N?=
 =?utf-8?B?VUFZOTBIYkhpai8rejBacWJtVVBKVUxGdThwZmtCVWFjcFlqc3pHN3duTVll?=
 =?utf-8?B?YXl3N2wyZFJsOGlHUDJVSkNRZHZUak5YVzlxU2hOMFpGclMwUGdFQ2xKZFU1?=
 =?utf-8?B?bTlHTlMrZlRSaklHaG5ncmk1eW5VSkhKOE5jMy9pOWx0RjE1Yld4SEhnakV1?=
 =?utf-8?B?a3d1RUhyWUdrTEVMNFhGRlA3d2dZbUtENFQydHhuVXJDTHU3ZHZCSlBmeHlZ?=
 =?utf-8?B?bElGMm40K24rSFNBQ3ZSaGJpOVMvWWNlSUZNQ2cza2pMTmdFL1JTWU05U09x?=
 =?utf-8?B?QVBFQ3J2U3pWTk12YnB2djBZdUpwSVU1UkNXTmpYSFNlbW81ZkRwendMZjVE?=
 =?utf-8?B?YWF1Si9VWG1WeUFySStGb3hsa0tWUktGSXFvUDNvUGFhM1VqTFYydjBtRWpw?=
 =?utf-8?B?ZUxUWENqQitOYjZ6eFBpVk9FNTZBWTVNN09tbHltS2VHdFdUVmVXcnVrVHRU?=
 =?utf-8?B?OTI2RzhqR2hMLzVNOFZzUk9sQytNL3dXT1NieXV6YnhMT1VpVUpRTjAyVXBU?=
 =?utf-8?B?Ly9IbWdBOU4xRlBwOW1yMHEzd1p5bFY4NE1tMnVSa1g3NUhKUlgvWWhneEpx?=
 =?utf-8?B?Z040S1MyMmxMS2FaU3J6VVJVM1dhVTZNUDlsUFdPcDAzMmtTc3Q1VzdodGlG?=
 =?utf-8?B?S1JOTmtKTGJZK1ZxOFM0c0lrTmdHUS9nZWtvSzNwTi93QmFEajZWV3p5dDh4?=
 =?utf-8?B?S3RGZG5HUjk2amxJbXFQdFVCdlVSbEs2QkNuSG0wTUdPZXhrb1ROU0JkaEx6?=
 =?utf-8?B?RkRjeVQzZzNUTmxMV0NWWlFENGZlNDlZdXhyQ1F6bjk1dmM2dk9xa0lxTTd1?=
 =?utf-8?B?R3ZPc3IyQXp0aERCOGdJbHcvMGd1bHJ5dW5lZURaZDBBTmR5TnI0RVRsTTU5?=
 =?utf-8?B?dThMOWt5U1Z1NHNTN1U1V2VoNEtyM2JnYS8wWXczbXF0dERCcmxDR0NQTjE0?=
 =?utf-8?B?bHRhcmUwRys5TVZucDZ0S3VoRG1SK1RqQ0d1aTVWWUV2Zm96b0xNcS9rSXF3?=
 =?utf-8?B?TGludHFpN0tuWXB2ZUEwSmhrNTU1em5ocjloK0VlY3kxcjBZNUkyMGlXSnFH?=
 =?utf-8?B?UENyNGtSaFJqSDB0WTRCOTBjR2RvOVZ3dHc1bStidmN5SmIxQS85Ykh6TVd3?=
 =?utf-8?B?U3Z1UC9jbEdvRHlZOHRXWVFwT3RJQVhmSExZZkV4R1A3YkxrU2ovM25yeGF2?=
 =?utf-8?B?VmtQOEZ4N2VoNDhKSFgvMjQ1YVIxcHNmZVUvMzZycVUwQkI4MmZrekVnME8w?=
 =?utf-8?B?TEN4UC95SnAwZ09yb2dKc2cxWGhVVGhDcVRzaXJVTGl6QmRZdnBVMWlSL1Ev?=
 =?utf-8?B?TUp1OGZBc002KzVFTDY4N3lzc0JLK2dhdndNRHpYZjF5L1lFRmNLbmdDNk9a?=
 =?utf-8?B?Zkg2UWFFOGFaSTJDWThWeFV3MC9HV0NxRy9tcGhNS0VteWZtRW9EemFqWHc2?=
 =?utf-8?B?WGZRbXNMVHZTdDJ5UEFwa2E0a1dIY1BicWVDc1ZINjAyTFkzN3lDaitkdXYw?=
 =?utf-8?B?WTY5cVZiQjB4a3NXaXc4VHlEU2ZwRS9WQ3V1Y1hkOFduZy94OXRhNGowRmcw?=
 =?utf-8?B?anhudjI2T09OSk5ZSE5kUmYyU3R4Y25ZU2ZhbnEyZDZOQVdDNDNoNWxET2s3?=
 =?utf-8?B?U0hGbFAvazNYOUg0Rml5SWNOTTdoa1VLUkt5R3l3OFpKZVg0MXZYaWo4V0pm?=
 =?utf-8?B?WWNMMC9hSWN2VDBLZEVyU0s3NVg1SWxycnhFa3RBN2oxcFd4aFhobnR0d1Jn?=
 =?utf-8?B?L1FtNkNrLzVDMnVQMUpic1dwNmQvTEdNTGdrc3Bva01MaDh1a1NaSnZ5S0tM?=
 =?utf-8?B?UmllY0o3VUNnUlBoZ0NXeTBUdDhPMTZGSFlqb1llQ1ZtcW1MN1dhUGVpdnMy?=
 =?utf-8?B?cEtOalVqOVFSVVJ4clNhRXNWbnU0bFNleTh1V2pKVGpwcnBNNHhwK29yTy9q?=
 =?utf-8?B?TXhTYVhBRitYeTBVWTlQZ083N256aFJlTU9ldGxrNmpwY0VmcksydEc3RE1p?=
 =?utf-8?B?bGZaZE5kekR1Y0EvOGlaNS9KVmU1UkhxRldxTGkrUDNkK3V1K2xpa3dVWXJk?=
 =?utf-8?B?Z2FVOUhUd1kwa2hVSHVrWkVmWmRJQ0xsbU1rcGtzeGw0RXNpaGpZM1RxVEdV?=
 =?utf-8?B?OHVNYXFMVEVNd0NIcFI5MUpUNHNDVHJnZnBHaWlvU3VYc3NScTJQdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026c4909-7865-4116-6141-08deac48fc3c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:57:40.4098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQcVFU3JG8z4Nou72INO6q2Ov6poRHdteXjJiHPMIwwD7B10L6O5xh9m1I0kx/ZQXiNe7HyPTf5+ijTudcDY0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5574
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 14:57:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22906

Hi Chris,

is there something out of sync with this particular runner?

https://lava.ciplatform.org/scheduler/job/1439187#L54
https://lava.ciplatform.org/scheduler/job/1439208

Or maybe something similar to
https://github.com/nextcloud/docker-socket-proxy/issues/51? Quirin found
that.

Jan


