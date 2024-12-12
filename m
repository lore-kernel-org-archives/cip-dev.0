Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0708FE7717F
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 13:19:11 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.86])
 by mx.groups.io with SMTP id smtpd.web11.19404.1734009544942739471
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Dec 2024 05:19:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I9eDqUS2;
 spf=pass (domain: siemens.com, ip: 40.107.247.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRGyfKjurb/NVx+CJvPGhpiPAm2FozzEQaguGupvRbTev8cl35bGsMkj9xSEjSZ2bm9rU5RWOmiVOwjSJIedN7RNb1GaL0r0Kezaz/cffjuv5xORMAn1sbwb3/afqbisjP+EawEvDdUd3Em3Ah+BJwe5tVnIFmsabo2D2i6tMkC8s1JyZDuZPKPn6b//uq57rPCeZK8/XxdYxlMNJ+f5tZUbbHo52tGdYE8Fwobr7LyJYw3vmRYJY27nkj9V5TCLXB+JVZD7oleb3mgSVvQd8gpcocL8wSH/IDYfTA+PEH+VoxW63qmZYnpaWtOdNjJNFo8J1DlNQDs1LBGFZQd8ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0+H4aMg4y70OU3wYmGHVUcWymBw3a04JpuHKj6Lo/M=;
 b=wagNZPxAIDPR/i0Ibf1qFnPJH5rrPXQg9sZU2VSPtG+A3L7qcP1MKpL0E3iuIw6HB1kjVntxMr4aQjGtVXVhjdbQ0KgeFubHJSg4tKxnzPY8WO5YgLkf0jr4e4SL/THypE91RcAu9F5pQ30y/QjzIFtx3I+dFk2BGxQU4KfwK3la5ztxE16/b0ofxyoHDbg2vJmwZN3IKpp/YD+s5Y3s+irtJdcczrfyaVuu2h8xekJ5i9vaam0aooxCHkWdoyZcv+Ab3fuCwnIXbrXp4Pi0DlHgrKm5kl59BzfnGz/NYS8pSffAHog7NDoB96Qaq4PrMWjPiyIVpftHUiFInjcxKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0+H4aMg4y70OU3wYmGHVUcWymBw3a04JpuHKj6Lo/M=;
 b=I9eDqUS2JXJQMbykhbGQo6j+doowbqJhiQRkoz5+FjOUrTr5p2Yohp+MeEXKjlAaOQxdf/6vnB5w2ACUhN1zg9uLIlnvPH0Y8IUr8yBLD6iXe2Lt46gf2nfaCIYNYdAWAvgZx5IrSDPvpJtT5D/Y7yK+3lNSykbBrEHgjo94RU9zkup0m6QAwKSpnc4VeOSGMpnNvY7EIbDHQl+/HnRVbxUDRwT+bSGvPQ3HmmfaP4cKvcxm5cxzb/+w5N0r+lHe/DhXwTwt1EHlQO58eAoh8UpuRIJO8w+ym5W9sp+fhpDJB6XF7Q8EZNrwOWGhggsD/EhHI33/ml/1HXaFti+DbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.5; Thu, 12 Dec
 2024 13:19:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8272.000; Thu, 12 Dec 2024
 13:19:00 +0000
Message-ID: <f9e5f35c-ada3-45c3-972b-ebd510e82214@siemens.com>
Date: Thu, 12 Dec 2024 14:18:59 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip94-rt52,
 4.19.324-cip115[-rt39]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 30543a66-5e61-4316-7cd0-08dd1aaf8a75
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WDcwSUl4NTU4UlErN0MzRVRUNlFJM2dnVG42R2pTZXp6Y2xjNWhVT1M0OXhV?=
 =?utf-8?B?cGxveStyMlpZK0ovT1pxY0lNTGptYnc4ZU1kQlQ1Y3BIbzEyVGhTT0JPMmx6?=
 =?utf-8?B?T3l0S0VidTlxQ3N6czAvY2UrQmw2VWJGYjNKWmRrQ3VIYjUwL0lNK0pkYllk?=
 =?utf-8?B?eG1HcDlxRGVwVmFxaHFXOFV2bnoyRTVRVC9NMVNORGFBSHVJdGtWWW02MlZH?=
 =?utf-8?B?a0pGRFlsQlJQa0NYT0VrbTE2bTlGOE9temRtVkhpRUxpTXVRVThkVDdQMW5Q?=
 =?utf-8?B?TEFyVTdBNlJNbEZmSEtEUnFNaGtCTEoyOWQzZ2ZlbzQ0RlVBL2xzbElUT2V3?=
 =?utf-8?B?MnZLZkx1TGl1Uk9ocjQxSDVyUndvYnlBdm5aWnhTUFVnSnQyR0FkRWdodVZM?=
 =?utf-8?B?UnJNYUZkdlMwZ0QyNFRYdFE5V29LWEg3L2Y5Y0RiVExORFVzdTZYa0dvSEc4?=
 =?utf-8?B?ck1teU5zTXQ4RTZZZ3NtaFdVZEIxa0cyUXV1VHFZYnB2RjN5NWFKTFlOSmJ1?=
 =?utf-8?B?UGhyS1QrZ2FmUzdWWHpBZGJoMkZqUWl2aXgxZmFUZm9ZbkxmWmd0SkorVWtE?=
 =?utf-8?B?R1FOUGJ2QmMvcnFPVDhtbFlmV1hBWERNNmc2R1MzdERsZzNiU2tsdHl4MHlY?=
 =?utf-8?B?TWJ1bEJZbS82ajFnR0F0S3k3RE9wb09NSGZVZS9haGttTUsya2g2RmJIRHNR?=
 =?utf-8?B?R3U0dE9KZ0I4VHBFTzkyZ1hWSjVTRDRxNTIzY2x1bE5aREZyd2VmamY4M0Zl?=
 =?utf-8?B?cE96NmRuTE1BYWtzeFM2Q1NoSjdkTVVUUlpWaEtXd09sVi9Vd09jZ3FVYVJW?=
 =?utf-8?B?dXBTNlpabWs0WnRiL3FMdkRNREZNaGNqbXgzRVNTRTcra3NQZnBJYXpXcGFC?=
 =?utf-8?B?VHJrcWNzeTlFRXF6RUViSU9iSHF2VFBiYWhvczc5N0tTMU9FV1dTeDROdEVr?=
 =?utf-8?B?eHRrQWhJQ3YvRHc0cXhHVVArUTBYcXl3ZzdnQzduc3cyVWhLS25WTE1qT1Bz?=
 =?utf-8?B?aTdyZ2tNSTc0VjhRTmNkemplSG5kd05JVWN3eFRPbzBENVNoNHAyM3J4Risw?=
 =?utf-8?B?U0RGRE9qajBHcmcwTkFOUDhEa0UvTERxd3BCeEpha0hOcTJtSzBjb3pOc2VF?=
 =?utf-8?B?RkY4blhwN0k2WnMyQjVLUDhIbEh2dFVCbDd2ZE1YZ1VuUmJ3c09EMkxLYmFL?=
 =?utf-8?B?VjFvOGJ1bnVVaVVaellmNzB2d0FqRFBrS1YwZkRWSkxRQ2dmaEN1U3pwSU1F?=
 =?utf-8?B?YjF2b3JHQkdhNzM0WklVeXV5SUJReFBZRVJ6M0FUMEVwOG5LbTJjbVUzejFN?=
 =?utf-8?B?WXVsWnhxOWJvNENxZnpaWEIvdlBxTlJOZmNVdXFZRTRYZDRwWWlEUE5rWFJl?=
 =?utf-8?B?ZW5QazVKQ01wVWxnWXppd2ZkTFZHUjBJcjhqRDdhMDU1Qkc3amM0YXRkYStn?=
 =?utf-8?B?T0w3STRyVy9NNW5TK3lMRzBMOXRYb3VQbjhzYzFGdnFkbmhxMTJkSEthU0g3?=
 =?utf-8?B?Zjl4SFdtTjF2RC9jNDlOeW12cmJ1MmxycS84TXI0U1JOQ0JMNUc2V0YvS2Jm?=
 =?utf-8?B?RkRCTVh0N0RlNkE3TGJsUnkwdkdiNnhBRTlLWlN3eEpxMVBkNU1vaTFWWi9a?=
 =?utf-8?B?UC9VZDlqZGhSTUVnVlZ1Z245OWFkeGdxNU4zbDkvREY5QkRmWU1nY1gwZ0ZL?=
 =?utf-8?B?bFhWRTVCdzZOeGdUTUd0TjR4M2pBZWhkVXVSQzJNNU1VVEJQdkVlS3JYV1g2?=
 =?utf-8?B?QkFmcFM3OWRoYmYvWVdkZDVJM0NiWm9SM0JCRVJ5Q2w2U2c3M2xiNHdtL0I5?=
 =?utf-8?B?QTUreWpxWE5NN3RhdWNydz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:hu;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1owWTM3KzlRNDZNb0ZuaklPdWFxQXdMOG9TbE81dzI1VGNrZ3NEeStlV1V3?=
 =?utf-8?B?MG9HUXlHbWlsNHU4aDBBMGVkT2FPYkFHZCtHODYwR2dvY1lSSGxnOG9SSXFW?=
 =?utf-8?B?U3k3RmIzNVZwdVV4MkdLOXZ5TUwrWnBxckJERU9uZGlDQUh1S0ZVMExFVjFp?=
 =?utf-8?B?VXRGTFluL29ZNExBNzJNbHFyQVpvK1gxcnhyUjBRZThGUlkrT3YrVzR0TDE1?=
 =?utf-8?B?RnhETW15UXBKcHVMc2NpSXJ2RkFyeUJSbjVGUlBRRUFjSEk4Q3BCaHFZUnFO?=
 =?utf-8?B?NHZtRXVMUWdMNjlKdTEzeHdwOTk4OVEyUithNlBrdWcrdlIrWlBJZjBGOFFS?=
 =?utf-8?B?WnlQUVpZenE5ZDJ0ci85dWJtb2s2MVhGai9EVm1VSkNKSFI3cWhOdmhsNWRq?=
 =?utf-8?B?TDgzYmdJbDlKc29DVlp1MFJ3WS9RUXVaY2t1Yks2UVBjc1FJdmY2MnVlaWpy?=
 =?utf-8?B?NUdRc1lMZisxS0xBOUlIc202YThISE9tRElZVG8xYTdmQVNXSVJ6cFNWTUgw?=
 =?utf-8?B?eUp4Szk1eWRhMG5BYjFBMHdSZUZwVll6S0Nud29DeUJSUWFnYVJNUEROOVpF?=
 =?utf-8?B?dE1iaTJxSTFRajMwSDd4Z1pMaTUzL1hCOEZIbW1Za3kwZ2FLbGhxSktqMmc2?=
 =?utf-8?B?UjRFYnloaElDZHhFcmxpQjRSVFozWGJQd3U4UTVsODlldjRFSEdnMTMvaTJp?=
 =?utf-8?B?b01RMkxFYXppWER3NEs1eEdqcjFzbVdaODhCeWJheDMvMHptOU1pRnJKa0VI?=
 =?utf-8?B?M01RVW44d2E4S3ozN1NsK2NqN21wRFl1TlBZSCtQekZERGMxZUR4VGFiWjdK?=
 =?utf-8?B?ZVpUTTBoMVFmbTltU0p5OU53SlJnaDRQZGUwSFFSaFVlKytFRDBIdlVralVI?=
 =?utf-8?B?TVovS3FNTnlZUWRnUklNMTZ1SVA2d21IeEJZNEVRRS9WTmxJSWd6L0VGdkJo?=
 =?utf-8?B?MC9OUGN4VElkR3U3ZDEvY2NFb3FtZW9iMFhkbFlVc2k5QnF3d0xEVWYxOHF0?=
 =?utf-8?B?dkQzaDB4RnU5R2RtMitpRGt1VGVTQkJJVXlvcVFpR1BraHhvOHd4YU4weENN?=
 =?utf-8?B?dVJIcEFlNi8yRnhPdE1FR0JFNm9Nc25hdDVHdWJkQ1dKSzJBakQ4THBwcWxH?=
 =?utf-8?B?dFN5MzM4NHZ0TXdQRVR3MGkyeEZwRFNFazBEVkhKejFXV3VoaDFPOEthTHYx?=
 =?utf-8?B?MTRObUpUamUwYWVKOE1LckhyNGJtZFFab0Fsd0dXL1NhbGdkQWkwMURjbkJs?=
 =?utf-8?B?cEJzaDBwaE0vQSt5czNSME1YTlVORThJSnRFM2xSZjNUZkFGV2RybkJnNlYv?=
 =?utf-8?B?aTZvK2Fkd1pzVjAyZ2pVczRNdXpVWmRrSXBMeDNkZ1IwU2NTL25weGRjc3Zm?=
 =?utf-8?B?UXpDbWRmbGNoNXVkZzAwQ3VVREo5RkpvN0lpWVpUVE0xUUROSnpOaDdKOFZS?=
 =?utf-8?B?TUpnY0RwaEh4eDNKelZlajUxclIxOW1pTjVDL0oyWTFqbVlSMmpPZVhJc0lz?=
 =?utf-8?B?Nll2MC9TL0JGaTY1YmdMU3B4Y2ZvQUxxQkVIalBLREdGVTgxMXVkVVZ3bmxu?=
 =?utf-8?B?T283S3BrOTFYNEpJNWU3YjAyYjU4dWRaa2J0YS9LejFHN2hPWlZjeXZ0M3VZ?=
 =?utf-8?B?L2dOeC80Q1lBTGZMaUFNWnhkeExoYXRYK2xwOGlqMVh5Q3Zlb2pYYnpoZ3JF?=
 =?utf-8?B?a0UzZ2FRRWRrQ0FRNnIyS2tsSytEMkdBWCtQcTd4blM2MGFiUlFOSFBJQVBO?=
 =?utf-8?B?MGRVandmcytuelFGcDRtRUh2N3B0OXJTMkxZb3JoS1hjYUw1TXJDZmMvVGNs?=
 =?utf-8?B?L3R3dDY5cCtaZkJsK2NaOVZwdWd0UmwvZGw1MzF6RFZza21rY1FxWm56NVVB?=
 =?utf-8?B?d1llRTBBbmV6VjJRUzRQN0hKUHh2TG83aHdFTk5jcjREbnR4aDlSMW0zWFF3?=
 =?utf-8?B?REh2d2l6TExMaGMveWk2ckgzbG9mb0lxM3hMdUdQdVhIRjdSS3BybGxiQUh0?=
 =?utf-8?B?UXNQVmFFa050QnpLRHUreWRNMkJKYTl4RllrY2JRb293TEtwdGNaaHNCUHhS?=
 =?utf-8?B?LzFsZ09QZGJzMmkwN1hyYVh1RXowaldKVWc2TGRUR3U5eHRLOTF3NTZGTTNV?=
 =?utf-8?Q?k/rDis/JBNINw07P6eA61/3K0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30543a66-5e61-4316-7cd0-08dd1aaf8a75
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:19:00.2412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m91KoFCH1zUI6frnhO4dETunsKdReH6O+n6Fx+xPllxVLvaxzWhVKNjfOJeR72HcsAWWgvZ0u3cbx+4590rb5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5627
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Dec 2024 13:19:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17417

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....322-cip113-rt38.bb => linux-cip-rt_4.19.324-cip115-rt39.bb} | 2 +-
 ...4.4.302-cip91-rt51.bb => linux-cip-rt_4.4.302-cip94-rt52.bb} | 2 +-
 ...-cip_6.1.118-cip32.bb => linux-cip-rt_6.1.119-cip33-rt18.bb} | 2 +-
 ...inux-cip_4.19.323-cip114.bb => linux-cip_4.19.324-cip115.bb} | 2 +-
 ...{linux-cip_5.10.229-cip54.bb => linux-cip_5.10.230-cip55.bb} | 2 +-
 ...-cip-rt_6.1.112-cip30-rt17.bb => linux-cip_6.1.119-cip33.bb} | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.322-cip113-rt38.bb => linux-cip-rt_4.19.324-cip115-rt39.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip91-rt51.bb => linux-cip-rt_4.4.302-cip94-rt52.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.118-cip32.bb => linux-cip-rt_6.1.119-cip33-rt18.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.323-cip114.bb => linux-cip_4.19.324-cip115.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.229-cip54.bb => linux-cip_5.10.230-cip55.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.112-cip30-rt17.bb => linux-cip_6.1.119-cip33.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.322-cip113-rt38.bb b/recipes-kernel/linux/linux-cip-rt_4.19.324-cip115-rt39.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.322-cip113-rt38.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.324-cip115-rt39.bb
index 1b25f72f..73195c01 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.322-cip113-rt38.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.324-cip115-rt39.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "eac40d6041d66b3a1e9c1aa2268a431c03c096f04008e94a079a3bad796470d7"
+SRC_URI[sha256sum] = "54c5b8c4ee31c73794e31f3f44b85c85a1ea760e0783121da715dd14076e1c04"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip91-rt51.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip94-rt52.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip91-rt51.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip94-rt52.bb
index 5265ee16..c9acba69 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip91-rt51.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip94-rt52.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-SRC_URI[sha256sum] = "648850184297c57ff4951d04ecfdef870848faa5d83ac70372818355da357685"
+SRC_URI[sha256sum] = "f197cb9f47625e46c2cf50d3624c096a9de18f1507b462ce76501f7a872f3e8a"
diff --git a/recipes-kernel/linux/linux-cip_6.1.118-cip32.bb b/recipes-kernel/linux/linux-cip-rt_6.1.119-cip33-rt18.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.118-cip32.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.119-cip33-rt18.bb
index c6af0e65..cb476223 100644
--- a/recipes-kernel/linux/linux-cip_6.1.118-cip32.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.119-cip33-rt18.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "2823163be5f468631fe9ba0f889e2dd69fe27408cf9b39d19a6ed951a8508a84"
+SRC_URI[sha256sum] = "5f6aceb0a5828a2828f63cbe9763857ca3cd136100f11e392c847659c353773d"
diff --git a/recipes-kernel/linux/linux-cip_4.19.323-cip114.bb b/recipes-kernel/linux/linux-cip_4.19.324-cip115.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.323-cip114.bb
rename to recipes-kernel/linux/linux-cip_4.19.324-cip115.bb
index 37101884..b0346b7c 100644
--- a/recipes-kernel/linux/linux-cip_4.19.323-cip114.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.324-cip115.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "c93bb88417e0a4e13db22476f0d77cd3bb512a78ec413b8bd1986fae75ca6e48"
+SRC_URI[sha256sum] = "eee447439d3967bff4ba25130bf22a98deacbe90bc0dde7f75422578e6c167f6"
diff --git a/recipes-kernel/linux/linux-cip_5.10.229-cip54.bb b/recipes-kernel/linux/linux-cip_5.10.230-cip55.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.229-cip54.bb
rename to recipes-kernel/linux/linux-cip_5.10.230-cip55.bb
index b66b6a46..8839d70a 100644
--- a/recipes-kernel/linux/linux-cip_5.10.229-cip54.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.230-cip55.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "04c87684c909a11ce385364611d6dc22705edb66e21fa02836f930af1458914a"
+SRC_URI[sha256sum] = "729d210ba8190859af616897bca6a845a070a483788bf1cf02b8dc0ec9b94ba1"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.112-cip30-rt17.bb b/recipes-kernel/linux/linux-cip_6.1.119-cip33.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.112-cip30-rt17.bb
rename to recipes-kernel/linux/linux-cip_6.1.119-cip33.bb
index 483a8411..069b01bf 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.112-cip30-rt17.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.119-cip33.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-common.inc
 
-SRC_URI[sha256sum] = "93f8d61b68d4e4b2d2a7f756e5e19839f320b539173f30874f2939ca8f37d39d"
+SRC_URI[sha256sum] = "95f5529a116d6b8172ff53e387509363f06aa19c60ee7e07ea2366ff31f7cb70"
-- 
2.43.0

