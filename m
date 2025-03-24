Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5B8C36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 11:22:32 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.19])
 by mx.groups.io with SMTP id smtpd.web11.36726.1742815349983861376
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 04:22:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MvFwNvyD;
 spf=pass (domain: siemens.com, ip: 52.101.70.19, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ez9Z1jtcco4Rc8j4jhNT0MGt7kf3zA1oPBnziaHsZfpOpCpLt5OuV7Pg7gYIT9D6t0vSq5RJ5tNSNd/pqSopJImzq04n9fh//TbSr3U0ZORIVq9wVN3HHs0OeNeM8MvJd+hhb7JEGN/tLleewKBoPBNdyllLm7NklKaf5CJ9s83t6GYsk6gIFMMntbJyRfo6qMHLsGnz7WJbAK39tZqTZ0/jsP7lIWeKVywvlycu4xumLBkoghjz7SsTCGiwIBze2ZIE8CTRAbC/ZUaY1ayhFw+iAn/9ITqCJ3K+AaYV+7xXVXOHj5J2DbvQJ9dOF8HOFQXK9pUHvCXdqyDCpdTb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kdZY95ohqbF01m1SOaElkJtbT1gsESpg6L62mgt/14=;
 b=yso8FtkskMLgkV8FXLde08XUVvx+1hsWqDx9dEfeLdlVqX9WoAE6R8Hnbmx/56DwZTeRbq7sFFFJV+nKWT3CDtblf925h2c1kZ+zLft9+emr3N6GncFboPU5vMkWdyHRkEESZ/dlErgNRoXND8xS4T6QSyuHUA7lBCJCQxLnaPHrTvyigJHhnSt/bC+zUc8NUv9WgbWHKdCye4J6MfN5IyA1R7BHejP7KhkTQBDuqYAPls2KGr6Pt1FNV/dSDENuJuC/95uO/nWot9iLb+LVtmWYeRkOttXWY9HrwGvfLZvZ6pWxNO5SaU79W1ajfXP34gEWEoADbr2imKaEIxstfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kdZY95ohqbF01m1SOaElkJtbT1gsESpg6L62mgt/14=;
 b=MvFwNvyDNyHEk88YpFWrvoaLxQsOf+/dcWkK7YoHtXCrm5YX28LItFhFLR7t72j2Qjq0Ygmiy07xqcFG9IYkN+HNc3mYG6+vQvb/hJTg70m2f2WRqZUjmfKufZbNhEhjXJTI5O4C1I1s4afChHGvseYrp44gocH4jUkpo+Bzws3kaD4w+bLGtadj+EuNs3sc93plxGV0AdIA1RYBGumOW9pEEIPUoGnYC8Sh5a78rpDvsNZkVwBkMCIBGSrwF9L74NOyelHhMGjisI2w2dfNfsaywjN1MG6wLHm0x9xrw51OYfqNvEh5EqpCjXCUjrJqmWsOWjy87dB+oIr/GJec3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6891.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 11:22:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 11:22:24 +0000
Message-ID: <7f547056-01a6-471f-a37b-9f09fec41819@siemens.com>
Date: Mon, 24 Mar 2025 12:22:23 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip97,
 4.19.325-cip118-rt41
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 11034005-2da8-42e3-0238-08dd6ac626e0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L3Q4a2xrQW5GelJBWnNscmZ5MWtSQWlsZEdnY3ZOaVhwcVJRcTJqZHUzT2xF?=
 =?utf-8?B?RmxPc1hTTzNNSnQ2K3BSWjJLK1E3YTIzYzJhNkZiYWRGSSttYVVxT0ppK1RS?=
 =?utf-8?B?KzVoMWdhdDE0ai9mMGtWODRSSER5bUVXenJKMnlnYUh3SFhZRTVPRkdUS2FW?=
 =?utf-8?B?TGp4bDA0VDFYWVZKSFordVQwRmhiNm8wRmhFRzNaQ3RzbDlnVWZQV0M1R2da?=
 =?utf-8?B?dUh6YzZENmNTMEhlc2VCOHFObFc1SWJlREpISEQ0RzJsSjVrb1lJOWlHYlZw?=
 =?utf-8?B?RCszZGRWRmhoSXhxRTcrV3NrcytRU0loRTR1Q3VkUGNETXh6b3hlK0lTZy9J?=
 =?utf-8?B?bHovUWh3SnRhaDZ1TkNLS2ZHbk1vT1U2aDJ0d2VISGowN3o1Qk9oQlZhZVJy?=
 =?utf-8?B?aHl0MWgxVjhYYit5c0NlMHhIZkg4VUVQYlVBV1pXV0dPandHdTlpNVY3cFBI?=
 =?utf-8?B?NXR6QUQvNlRvVUNWdWYzVE8xbHVMbnZWTmswWkExZnRvNmVLYk9sWklWOCtS?=
 =?utf-8?B?NEQyTERQVVhiVno0OGZ3MU5zUUtLMWFNaU5VZlZpSmw3b1A4OG5ZRnMxQzlY?=
 =?utf-8?B?R0V6QU9NbTk3c0hjakJPdlVPWUJJUVk5aXpMZ1ZzajM4eVNTdVZ3Um9sVXEr?=
 =?utf-8?B?bUNtUHNkU2NGR1AyVmRyTVR0ek01bmZzak91TXlVbXVuZGxqNndsNVVBbzM5?=
 =?utf-8?B?UiszTWZHc1ZuVk84M3JYa2lGYzZ3cXlIdElERmZzY3RyRFByRTJLWlhoRWZl?=
 =?utf-8?B?aHlZTTEzWXYreThMOUpwdkNHOTR0cnZKU0ZWWjIvRkthdm9pM3ZyWm1qb2FV?=
 =?utf-8?B?ckJHUVNpd2N1UVBOZThRc09ncTdHTVZ0UG5NR3FzbWdHM2tmbzMrMjcwYlBP?=
 =?utf-8?B?ZEIyMkpCbW9EczV5TmtmMXpDSU80aU1hODZIRUtSTEZOTU82ai9NaXhyWkJu?=
 =?utf-8?B?N3pvSStnaHZDRklyV3BYazh3c2taTy96MVJCM2lPWitvZitjUUFleHJabDEv?=
 =?utf-8?B?ejVjbnFHOEdibXBJdWxOU1V3ZXFybE5KMjJlMzN4SGJuWUNEWkRiSTFmUk1C?=
 =?utf-8?B?ZkZPTkNHVXpjR1c2WjZmS2gzeUs3NVh5ajVkeG50NS9xMnBjUmpYTDhyWkFQ?=
 =?utf-8?B?SG83d0hEM3A1Qks3RExuaG9JeFBzeURzcnIwbDZha3I3eVhJVHZKQUkyY2Yw?=
 =?utf-8?B?QWMzc3BpZzhWMUptMmhKVFpycGNLT3ZLMTRHTGlBSk9rZWNYTTVZMTVpT2x4?=
 =?utf-8?B?WFlRaUlhK3hxMGltUG1JUFNpQjBlMGVOcEZMaU4yaHhKTDAraFIyUkZFcEJG?=
 =?utf-8?B?QlIzb3dLYnN0VHFaZkZpRStrWU9mejhDSjNWV1ZXSHViWnRFVEZCSmNNeWlu?=
 =?utf-8?B?VUpyM2NjS25DemNYeUNlUkdXNmU1OENxMG1tVGhxUitCVjhkNmRCUm9EcUN3?=
 =?utf-8?B?di9XbCtZdFVna1FLZk44RWpad0lRekRyUUU5QTVuM2FHMHZtdGJmTXNHZjJq?=
 =?utf-8?B?a003aEFqOUdqZGlUazZ5Zmp2YVpoL2dyZHRpNGhobmlRSjR4TTJlelgvRlFt?=
 =?utf-8?B?RVBYSU5SejcyaW5wTDMvMFJtbnEyQ1RERkR4R2oxUFNjc0JPcExFOEN6U1Jo?=
 =?utf-8?B?cDVjQlpteDI0T2JIbEI4YVBNSUJmcFhoaEJ6Q0hpalNEdXR0MmtXL29GU2gz?=
 =?utf-8?B?TmljaDdrSEVYOWo0OVNRTFZBNUdVWk1vZGNrN0haaEJ0dWE3TWp3NDRjOTMx?=
 =?utf-8?B?U0Rhdk9vNit0ZEJnM0RxZWlseVBXZTlzdDFIQ0F6WndZQ2xGREY4RTVuZ3ZY?=
 =?utf-8?B?R29nOXFkdUhqNzBCV3dyTDVUTEk4eE5NSFZYaGpRZjhSTGtldjFUdTBUMTZ4?=
 =?utf-8?Q?++jXUuCcYzXXI?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WFl0MzVBOW9EZW9vcU40RWtvTEg2MmZwcm1BdmlWVFI0Ykl5WXFzT1JVcTRj?=
 =?utf-8?B?am90bnlZQkZVY3ZhSldOSUtoQmZCd1M2aU5Ea2NYd2FFQW8yWm5oVm5xR1Bs?=
 =?utf-8?B?dm1VbnROeU84aUxuU0hDNEFibVIzS3VRcGEvUTZtNEFtNWVjN0ZISUtRUWhU?=
 =?utf-8?B?VVo0SS9wWFRISVFPVTR4RHpiZHlSUnNHbElZTFlFTXhwQWdqbzltbmVDNU5D?=
 =?utf-8?B?OHJtV0F6Z2t2dHVpOWlUT1BnT1ZSRTk0ZmVMSDlpYVg0RlV6R05hMmxzTTFa?=
 =?utf-8?B?ZzJGcFJtOWNjYW5CN1ZYdVlxZmpaSlRaZ1AraFpSTkc0aFRCMWhaZERzdDY3?=
 =?utf-8?B?Rm5KdFh2MjFVQ1ZsN0NXKzNBZmZrZVJEUUlhRUVtSXh0QXcvSGdVYkhQb0dK?=
 =?utf-8?B?ZHRDLzZKL3JWUWZyTk9kVzhzME1tMm5zZTk4aktNREUrY3Z6VXY0Tkcwa29Z?=
 =?utf-8?B?c0NOOGMzTEJISFVVMmlhVXlILzU4ZGxCdk1iazVuZ3hKYjRNY3lFMnJDZHNM?=
 =?utf-8?B?eGRyUXpLMk43TVk4WDhPRzRUanN5TE1FTDFrWXNqd3pkeFppT1JLMEZUUklY?=
 =?utf-8?B?eW41ci9OaG0rKzVwL3VFb21wMzZCdWttU0pBbFUxdXoxMEhac1A2dFZKTnpX?=
 =?utf-8?B?N1pPRWNHc2xhNWpIaUlPQVE0d3B1RTkwQjJMRHpOSkJHc1BnbHRpZFl0Z1dm?=
 =?utf-8?B?ektCY2RmQlFLaFpvTlZnczBaSnRDODMwYTVvY0xIMitzZE05ZnowdlRaYnIv?=
 =?utf-8?B?ZVcrQjlaNHMrSjBlK1Jyd28vcTFKYW5iYitvVXNCOGEwNGVJOUhjOWU3MkFs?=
 =?utf-8?B?ejB2L1VCeXltUmJKQWNIS1dPbHZvV3JrU3BveFVLMGFXMmVaby9NZnVIdGJS?=
 =?utf-8?B?T0o4RU1SWVRoamlCK0lJSWRma1Zzc1lHYStVc3Y3d2JqVkp2NzFETjF6dEtZ?=
 =?utf-8?B?R0IzT3U5NWFQeG9lakdBZnpYcTltNVZ5RmVkckxhaC9zUUNZRWRCQXV0dzBL?=
 =?utf-8?B?TlFWMTY3RklwME5hYkt0WGoyRTdFYThadGwrelkzdmZMVnljd04xYUlXbmZB?=
 =?utf-8?B?S1ZCRElzeW15bFluRU9lS1lpM1YwU3BGY2Z5d2k1Tis5alFOMmErRGdvOTc0?=
 =?utf-8?B?eFgxZHMwZVZYc2FHb1JwU05UaEtPalh1UUJzYTR1eUlIVk1BYkVhSkRpTFBE?=
 =?utf-8?B?TnRhbWF3L01qUVg1YXhFUkFqRUpLZWk0NnRhOUFKMEI4eFB6ZjVEODlJL1lj?=
 =?utf-8?B?MzFFb3pMT014M0pPTTR0YlNJaG0ySXB4VkhTTlEwbFFYN2NZMDFGTENHSEp5?=
 =?utf-8?B?S01UdkphQWEzb3d6b2t3ekloNHlCeWpvMTZYQ0EwbVM5SUJwMWFqRnNTb2x1?=
 =?utf-8?B?Mi81a2dveDBzelo1QmVieFo0VHlveVZtaURuaFpISnJTOStVbjFSZWtLenU4?=
 =?utf-8?B?cjRKYzllbytydjlnamVVVHBsNXhuV0syeE5sWkx5YW1ndXM1Wk1ZQU00MUY3?=
 =?utf-8?B?RXNncSsvQnEwODJKZ1FRV1ZEZFByV1dUdjVSN1l5RFI5MzBSRlR2bDFPWTZ1?=
 =?utf-8?B?Z1NIcUZUNyt0Und1bmNZd0VLdks2UVNMeEd1MkRWRXNYZUNYOTZKQzUyeUNQ?=
 =?utf-8?B?OC8welJCZ3R5cmdaMnAzUFRvQmw2R2ZLUmhsb3ZNbHpUUHl1NVpvdTB1bGc4?=
 =?utf-8?B?ZDhmK3Myb29qMnF1Q0U0djkvNCtJanRWaS8wcmViSjNwWjRuWjRqWVVJanRB?=
 =?utf-8?B?Tzh0dDRqM0MwazRzVmpCT0ZHSFRXT3BkY3paTVh5dHFKNExTb3ZKT3MzQTlo?=
 =?utf-8?B?OTkvaHd2bzZsZC8yOTR4dkdiQ0svUFJIQmlqQ0ZDK1dIN3NOQUR1MTIzTTBO?=
 =?utf-8?B?d2dMcFk2QnN6UU4zU0tCVTRySDhjeE5xTDVpMnJlVENxQkhpMmZxRW92dTN0?=
 =?utf-8?B?b1R0S0h0UGVHcjNNVjh5MnlwbHZHMkEyTmZ4cTh2UVgyMUtjdDgza1Y1Skdv?=
 =?utf-8?B?ckNsY2xWbzFnWUw2ZUdYYnRiWTA2eXRvSDdjQXVsMUdBVUxBaDRDRHY3eGlW?=
 =?utf-8?B?dllvYlBHM2w4Nlp1aTVSb0FDTU5ZeE00a0l0cEVZaHZRcjViL0xGYkxVSG5r?=
 =?utf-8?Q?JYL50o61cfUGGYExwBI9ggPO0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11034005-2da8-42e3-0238-08dd6ac626e0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 11:22:24.6137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCk6bDvbKRu0Uk3p2qA+Y5k5TkIY1kR85Q97iAL9mPAhajXTqdhLdBprU4v007GAtQilwIFsk55js009SAbQMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6891
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 11:22:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18339

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....325-cip116-rt40.bb => linux-cip-rt_4.19.325-cip118-rt41.bb} | 2 +-
 ...10.233-cip56-rt24.bb => linux-cip-rt_5.10.234-cip57-rt25.bb} | 2 +-
 .../{linux-cip_4.4.302-cip96.bb => linux-cip_4.4.302-cip97.bb}  | 2 +-
 .../{linux-cip_6.1.129-cip38.bb => linux-cip_6.1.131-cip39.bb}  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip116-rt40.bb => linux-cip-rt_4.19.325-cip118-rt41.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.233-cip56-rt24.bb => linux-cip-rt_5.10.234-cip57-rt25.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip96.bb => linux-cip_4.4.302-cip97.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.129-cip38.bb => linux-cip_6.1.131-cip39.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip116-rt40.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip116-rt40.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
index 2acaaf71..8d5c31e2 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip116-rt40.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "7b05ec6f1e6d97420247e26ee8d2a94924e7c17b9863909c3139cfb9efd7bcf0"
+SRC_URI[sha256sum] = "ac71b31b34e89e7d6daf98a202806037e44203d5d79bc74da5c57f5c24ccf946"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.233-cip56-rt24.bb b/recipes-kernel/linux/linux-cip-rt_5.10.234-cip57-rt25.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.233-cip56-rt24.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.234-cip57-rt25.bb
index 80f8a31b..e4ca8394 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.233-cip56-rt24.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.234-cip57-rt25.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "3878975f833e792a3a51dd08349c1317203c5e15658e33a28c8ec27f8c2a1633"
+SRC_URI[sha256sum] = "96dbd4ee8e782387faf8bdb4065c7c95733fd320d79d0fb387b9c5824e8a0e92"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip96.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip97.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip96.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip97.bb
index c12075c1..a33c565d 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip96.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip97.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "d3e5cbbcb4c462fa8218efda7ba8f70bc7e3002ba5fe913d4a1418eff33ba14d"
+SRC_URI[sha256sum] = "96adad4dfd19ed4e277da07f64db5a0a7a8cd9ba0b854247a647d2d707c89ee9"
diff --git a/recipes-kernel/linux/linux-cip_6.1.129-cip38.bb b/recipes-kernel/linux/linux-cip_6.1.131-cip39.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.129-cip38.bb
rename to recipes-kernel/linux/linux-cip_6.1.131-cip39.bb
index 906cfef7..5bb45114 100644
--- a/recipes-kernel/linux/linux-cip_6.1.129-cip38.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.131-cip39.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "8c576cc97e600d1d7d215d2bdf52b8903a68a015f47e899aaf9850dae2c6e67c"
+SRC_URI[sha256sum] = "a83a4381dc9d0934bca7a31c6f30fb587e5d89c03ca5d361cd7425a3b92e850e"
-- 
2.43.0

