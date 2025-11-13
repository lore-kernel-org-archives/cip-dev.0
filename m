Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6ECCD5BB9
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 10:20:27 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20525.1763029223714443241
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 02:20:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dTLzWwyS;
 spf=pass (domain: siemens.com, ip: 52.101.66.5, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRMdnle1tvFF/65lhkXq+ZR+x2i/RSgOUqamqYzGx8QUfRZOi2fiyud7G2jQcJB/kAZ8iYIo8ko/vmRkB+UtSbpxVAnH0tkcf+ryTUDzp0gAZbw4sxy258mmyHycP94qWOvB5WST2o7cK7snjxJfRUUSC7lGWTCiPBR3DpSV8wDsWrOiCz/qrH2Yq7FaEqRSwnR21FWlslVQBDCK9sfEUUnYG1V5oVmsovDEYWIdoLOWZJLVkg+JFm0vXrGMyHUHbopnFqoqqb7BRX6jYbCios+HMPGV1/lcgXvi4lg8MD9CVU2iLFJWEjFc5T4zYBhtN375RnN4HaqPYzvL9WHY+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWan4E+1LHraomakbpHIVPVrbPvo1abcv0Z4kW3dUGY=;
 b=XzLGo4dvP3but6+ulIwfQ5otCi8IujkPHHYIhSHYofD/3B9fbAOaQ5EWLmbK1HrP9th+4gABp0NOqwY204n/10wSvKDfSTGDhlfGaBZgd1F9g3+gT05FvufwWITxQUHEzCOjqBHtUZLUpeysM3ywDv33pbcHJYG7SG07bKUHUsM/KGJc21y8K/zqNmID8Iq4vD3r3XpKncrxFZvUUkLTE8XVzqkVZSTbTFWpefPUriP6Rhreacx4J3tkgjMRxeeicss7M2uSMuQGo11PgTrxL7If+dLYwYKxPLID3l47/UynWRsLKn+ZuTi2ad69okD+nkYiGBcAQrmxhsybI7nJKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWan4E+1LHraomakbpHIVPVrbPvo1abcv0Z4kW3dUGY=;
 b=dTLzWwySfpQeBp9tLR6nhQRjHeraa87joZf74lY7wnkrvbUX/W2bEI+XRF2AuQV8XQ6WxxNmrEXYPXfoEU5mlO4VYa+Qd9868tsF9R6/hLpwnDc2qEeWM1/BwLTiBc6Vj5wt6wVAt+gYZCewEZOXuT9SbfI6FVV38djInxMT6/CjTkDPM1kR3dyzGbNfWXRooxWrrEmQLDQw8B/NiGg4OiAUxrCzOpUkOuN5eQsCHI0ulqinpyxQPcw3b2DHigyijzTng5l3lmUMqQMSIuKwW83viICQ4d6jWSSlr973QeLI2vKoTCvFOmZ6ALmAuOqZbivVUnt4cR5bEQjsJNQ+hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5614.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:244::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 10:20:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 10:20:19 +0000
Message-ID: <b28e5c10-31e9-4f18-959f-89438fa28a4f@siemens.com>
Date: Thu, 13 Nov 2025 11:20:15 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.4.302-cip104[-rt58],
 5.10.246-cip66-[rt29], 6.1.157-cip48[-rt26] and 6.12.57-cip12
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 64060d18-63ed-4b07-b775-08de229e3f4b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SDFpRmxETHJqaldxMnJSN0pWRTQ5OFFlVlhuV2ZpUC9qYzFwYmY5WU1zYnBM?=
 =?utf-8?B?ZytjRm5yUmFFV0FSRzc0VmFqT0k0NlIrRDRDZDZZbDBhMkF6bk1mWmhzeExF?=
 =?utf-8?B?cEZwTFhoSjRUUE03RnF1eFhDaFBwNGFSNTVSUW9uNjJKaDFLZ20yRDZ3dGtE?=
 =?utf-8?B?a09Ra0lJNWlYL3J3emN4dE1mTDJ1dWVkNmhyM3p1MmFOZzRKY0lLY3BsQ0l4?=
 =?utf-8?B?Vmo3UnM2TDFBelVGaXkxU0FvOVBMZktDSG8yWGl6VzhEb1R5YXZVVVZHNWw4?=
 =?utf-8?B?bmdGazlyZzRtSnozTENRZWtjVUhrM1VwYjhjNjdBMnpCMWNxb0JmQlhIWDBI?=
 =?utf-8?B?bTBjSkZvbE1PSmZIMEJpRmNrYkU0dnZ3TEQrQnYrN1BWTXNiS0FWR01lVzNz?=
 =?utf-8?B?VThVRHUwR21YTUQ1Mi9WVEZHUTJhNk1TRnRDSXZmRVYwbVBRMDh2U1FJVFJH?=
 =?utf-8?B?bEpPOGFCeEsrUHVjbjdKWHdWbnVoQ3duaWtMMytMaGlhMytPaGJTWkxaY0RI?=
 =?utf-8?B?cnRjeVI0YzJYRTFmOTRkRTJjb25CbHg4WW13R3dnQlovRmZZTmhVUndzM2NC?=
 =?utf-8?B?bFQ0M3FGUy9Tc1ZyVDFHWUFsaEFKMXB0N2ZpKzJPTmhSSU1tVWVzY1pyVjBj?=
 =?utf-8?B?MVMrWGI5b2ROQmxlalNZY2JKR0p6OUd4Z2hLK0ZXTTVFQmk1RFBHUlRtN2JI?=
 =?utf-8?B?cWJvTWxrVStPVGQ3cXVORGhoV1ErZUJLbGJ4RnlFOHAxS2VBN1dlbDMxTU1j?=
 =?utf-8?B?UDQ3ZU1yZDRmRmZHVGhoUVcyTlFveVhjYnNjOVV6NzE4S3ZEWEFaMklJN3hX?=
 =?utf-8?B?eVdVdHYydERqWWFrRzIvaERSSkMycjEyRkozdVNOcVdNTTZUa3BEdHdnd1d6?=
 =?utf-8?B?aitXVENBZUFxL3IvSVZPczVQc3NxMFVPL0JmczZCUjZCaGRZMzNoWHFxcytU?=
 =?utf-8?B?bThqUVljVU9jTWtuNmNDdFNCbm5hS3Y3Yk5SMUFsQkVDNkEvMTU0aHR2VnJk?=
 =?utf-8?B?K2VXZFJQaDhOZkc5NEFlbjFFMXYwQ21SeUMrMDR4QXE3YVZ3cGh2ckJNSnZz?=
 =?utf-8?B?enh5cVpWaldSS2pEVnIwblo0bnNDOStQUG5mMm9YbFFpNkc2NzhoWS81SzM2?=
 =?utf-8?B?U2Z4cDlGdVNyR2djK3g1UHo2UVhBdkhvMEl2ZGJqalNna2p2UDRFMGd0S0do?=
 =?utf-8?B?T3JtQmhGNWFhVHNXWjlTZTlRbU8vQWZQcmI1a1ZORjZDV1B4aWhjT1FrenZ3?=
 =?utf-8?B?cU1kOFZLeU91eVRZV1JyeXdWUmhEYUY2QjJwS2RuTFV2RlptWjNCbE81elp0?=
 =?utf-8?B?Vk5zMnRDaUVLQTd3eGRPYUdyRDNOZnlJRWJoNi96ejBRRDZkSzFsMjRNVFk3?=
 =?utf-8?B?WktJYUdUdnBuUGhmc05wcDRHcThKb2R6eWV6VUxSWldsZW5iRWtqVjM3UFJp?=
 =?utf-8?B?eUVPazBNaGp5RlpES0pPU3ZuVlRkOGJuQkt6QThNUkNTY3dMU29XR0c1T0VB?=
 =?utf-8?B?Z2I2anEyenNCM2hXVHNhRzBJbkM1eUxUNFFmWk9tS2pkeEo5cGIrT2xpa0Zk?=
 =?utf-8?B?RldTbUhWbHhqNjJ5dGMrWGNZam5NZzF3cTZ5VGJlUjN0QjRCWVhpY0ZlQVVQ?=
 =?utf-8?B?aHFlUDhESDNBOC93Umt3WGZPS28vL1JTOUFrUElpQmtJRmxmOXhsbmdza3VH?=
 =?utf-8?B?bDlLUkVqT3RJazFnZlVVTFVBWllMYm4ybHZnS0JQSFpjakJhTWk2dE1Ybmpu?=
 =?utf-8?B?UWVxVndMbDhKSThDeFQ2Q1NPMFVvWGhCK1RqaE1NS1lZRGJNMGVRcHFRY0tP?=
 =?utf-8?B?Yk8zOGpXWlI3YklrQjlPdFRpcFJqcFdQcnFiaUVRYXdjeW9Dc2w0YU1PTDJE?=
 =?utf-8?B?YjY1K3RKTmN0Q1ZxQkhsRStZUFRSYy8zcENCakt1YUJKZzM3aitLN2c4YjVx?=
 =?utf-8?Q?wI+EtfiM+zGcNDxQWeYCxX8TYH73XRFA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WlBjNzhOUDBLc3BSTzgwSmZ1c01EUy9DWkgreit5SmU2MHNHRU1tbTlSb3pk?=
 =?utf-8?B?Yll4QjZleG12YjkrOTdtcFVQZjByK01MR1RIdjZoMFRKNU44S3c5dlZjY0Ni?=
 =?utf-8?B?SzVRcHR6cVRiR21Ya3V1anRNb1RCaVAySVR3WEtlTkVUTUdTL2xzUEFSTis0?=
 =?utf-8?B?S3BydWhWRE9FUXgxYmgyVElkNDRPbHlROGRQOTNEZ1ZzVTIwSE5HdHlhVjkz?=
 =?utf-8?B?WVJRRmlUbDBCQ2s2dkZzc25rQjNuUnlWRXltbXMyUFpxeVRUeXh1TDlrQ3V3?=
 =?utf-8?B?R3hVZk9NU2hQQmpOREx2MG5KQnBxZ1FuMzlTSVN2cGFydDd2NUpsc3VhZ25z?=
 =?utf-8?B?TmNBdjJLalpIVVdPaENjaGFjdGN5SUltKzJsdkFZNks5TE9tdWxGYTBQcGwv?=
 =?utf-8?B?MHFKdXNpMERGbVZMK3lYS3dCTE1oc1pXbkNBMEVJYmVkenR2UXRBOUNTa1lm?=
 =?utf-8?B?WUloVmh0VjdxUDNaWE5hVEt1ZHRMbU5ocHpyY3kyRlZ6eWxhU0dXUzBGUHZj?=
 =?utf-8?B?cFFLUHkraTgyZDIwbmZIT0tUQjVkLzd6Q1RXenVyVkxEZHFRb0hBRUNrckhK?=
 =?utf-8?B?ckg3SCtWM29rQmU1Wm5PajVxUzJCeXNQWW16dHQ5QkpoVm4vRTZSaVBzSm8v?=
 =?utf-8?B?aVQ0U25TY0RpTC9yUDRQdW82WHpaMzByL2Q3bnhwampwRWVxS3F1VDVCdjNM?=
 =?utf-8?B?RjBSa1M2Tms5QVF6Q2NpN05CWTNVVVRwN01SUmxjVFJnVkhJQTlHVjJkWXZL?=
 =?utf-8?B?eVFYbkg5REpCbWdXZS90ZlNaYXhlYzd3MnBiMldtL2hKVGhrQjFvbnNlS0Uy?=
 =?utf-8?B?UDhOT3lmaUltNWhNMjhqek9qV0djbG9DVWxEK28yU1JneklNQklFanM0TTVl?=
 =?utf-8?B?bjdnUkRlcGhLTGZZLzYvUEZ0anZ2a0R3TjhlWndyR1RTa2kvaFpmSUpkUW5U?=
 =?utf-8?B?Nkc1b29EdzEyb3pPOEpEdWY1WWV4WWdSSjFmK3paYndEVUlvTmVRLzc1cVAx?=
 =?utf-8?B?V1dSM1JnYjkzYWQ2bWhuUmdjYi91elhJMTlFL20wUjlrUmZIWEFVdWI4VnFz?=
 =?utf-8?B?QWVqQjltakJLeWFYS1Z5VlFWWGhRckp2c0xuNjRNNWRuNXZWQ0Yyb0UxWm96?=
 =?utf-8?B?bXo1b0oyV05yL3ZsQ3VUSW1tVXlGaUdRbFFsL25iQzB1K2xHdFZFNkxFWmZF?=
 =?utf-8?B?VjQ3TC9pWUM3ODZJKzUvVi9lNUxPc0tVa0hna1ZqejN1V3pKVmd3M0k0MS8z?=
 =?utf-8?B?dWg4bG1jQkxNK2lFVmRzWjFDaW85WnRVeUwrcUJyZnpzaEFDODRGOGFZdTFT?=
 =?utf-8?B?RkJCSWV2Z3QwUnJMY3dLLzV6YUVKb3c1bXVNRTVydFRxTDJhdUp3US9tQmYz?=
 =?utf-8?B?UURFR3ZMSEppNFZBcVllMDcrQnRreHUycWl5bXpBTk1MVDBXSTF2SGlLMVdt?=
 =?utf-8?B?aEpUbkFzSmdGRGgxZEV0SW4rdVUycnFMWlRpcis1MDFSVDljRzdQbWhoSnNN?=
 =?utf-8?B?R0ZRVFQvSWtmWkRMaGRHWDRRdjUybUZHc0MvOXIyQlFzSVBVUGlnYmNPblpU?=
 =?utf-8?B?eVRJQmUxRFBVRjhYRGp3bjY1cmFXZ3g2dGdibklJU2JYb21Ob0k4Sm8yM21F?=
 =?utf-8?B?WEMzT1FwT2taanQ2bk90YXRJWHE3T2dvTDFGZGIyVldtcTU0ckhtVFdzaDc4?=
 =?utf-8?B?N1pZOTlLdG5iUVFjUU1hZHhwY0RHZ09JVjVlQmgvRHFoSWZSUFQxVXNyMndZ?=
 =?utf-8?B?a00yS3FPQm5mM3BzWkxuL3JkdExRWllLQ1l4RmF5WnVucG9HQ2IvY3gxWktU?=
 =?utf-8?B?SVB2U2t1bGYrNTY5RjdwSzh1MlJBUWRTWStsa0pjMzdZOENPTWhRb0ZXUlM3?=
 =?utf-8?B?VFpCMnU0OUdqbDRuc0RXVEhrZktQTHcvRnVSd0tTNjMvWi9ibWlrT1JSbTEx?=
 =?utf-8?B?Kys1U3pDR0VncjhRaEcreERWdExyNlNtQ1dBdEdvZmF2MzVHVjdlbjRDUmpj?=
 =?utf-8?B?MWphY0FObkcrYUI5QnhvTFA1Smc0ZGI5OVFjZ2VtY2RWVUVTMDFXaWpZcWxP?=
 =?utf-8?B?bDhSRVdZMlkwUW1KU3J6d2NoOHdZTmxkQTNjNkJ1amhSQlV3UE13T0R1M1Ew?=
 =?utf-8?B?Y1k5QWI3dDdqNVY0MlhTSlJKRDgzVW01VWZGOFIvRTQ1YWNIbWxrRWZOUVIy?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64060d18-63ed-4b07-b775-08de229e3f4b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:20:19.8110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Et1PGg8wVeqTUrT/5RJQluuyfTA0kxa8A0Np5SD9HRYtzrB6D5v8nhL7WyxgA4WACSrVT9AZBKHPVvnkhPzAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5614
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 10:20:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20528

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...4.302-cip102-rt57.bb => linux-cip-rt_4.4.302-cip104-rt58.bb} | 2 +-
 ...10.241-cip64-rt28.bb => linux-cip-rt_5.10.246-cip66-rt29.bb} | 2 +-
 ...-cip_6.1.155-cip47.bb => linux-cip-rt_6.1.157-cip48-rt26.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.51-cip10.bb              | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.57-cip12.bb              | 1 +
 ...{linux-cip_4.4.302-cip103.bb => linux-cip_4.4.302-cip104.bb} | 2 +-
 ...{linux-cip_5.10.245-cip65.bb => linux-cip_5.10.246-cip66.bb} | 2 +-
 ...-cip-rt_6.1.155-cip47-rt25.bb => linux-cip_6.1.157-cip48.bb} | 2 +-
 .../{linux-cip_6.12.51-cip10.bb => linux-cip_6.12.57-cip12.bb}  | 2 +-
 9 files changed, 8 insertions(+), 8 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip102-rt57.bb => linux-cip-rt_4.4.302-cip104-rt58.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.241-cip64-rt28.bb => linux-cip-rt_5.10.246-cip66-rt29.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.155-cip47.bb => linux-cip-rt_6.1.157-cip48-rt26.bb} (59%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.51-cip10.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.57-cip12.bb
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip103.bb => linux-cip_4.4.302-cip104.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.245-cip65.bb => linux-cip_5.10.246-cip66.bb} (68%)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.155-cip47-rt25.bb => linux-cip_6.1.157-cip48.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.12.51-cip10.bb => linux-cip_6.12.57-cip12.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip102-rt57.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip104-rt58.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip102-rt57.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip104-rt58.bb
index 9800cf9c..df900fd9 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip102-rt57.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip104-rt58.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "1d6cc128cdc0e763dc645364b1f49ecc4d6d31f9be15bb31774a9c4e2dbaed49"
+SRC_URI[sha256sum] = "705c91e197198c7771af123164e51ad520daa9cee30e0b8ed914841be97ad7f0"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.241-cip64-rt28.bb b/recipes-kernel/linux/linux-cip-rt_5.10.246-cip66-rt29.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_5.10.241-cip64-rt28.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.246-cip66-rt29.bb
index 09bc40cc..8386b246 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.241-cip64-rt28.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.246-cip66-rt29.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "681e2ed1c9407c6050c0b60432050c09cb3257f654368fe3d48880945fddd1c3"
+SRC_URI[sha256sum] = "ae5233fd7d570b1fbd537bb0a84c0de8a865a4317f4bd4bd6e963bf9ab24e64c"
diff --git a/recipes-kernel/linux/linux-cip_6.1.155-cip47.bb b/recipes-kernel/linux/linux-cip-rt_6.1.157-cip48-rt26.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.155-cip47.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.157-cip48-rt26.bb
index 8d1bd1b7..fb4810bd 100644
--- a/recipes-kernel/linux/linux-cip_6.1.155-cip47.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.157-cip48-rt26.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "a04254f036c472bd0656d6013ee9be27d4aea31d43ba558af08dd1d4081c4ebc"
+SRC_URI[sha256sum] = "38f7198a3b3e1b0f4c92452754582866c9d12b14272fa57f502c75ab64c8e576"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.51-cip10.bb b/recipes-kernel/linux/linux-cip-rt_6.12.51-cip10.bb
deleted file mode 120000
index 6df87a9a..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.51-cip10.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.51-cip10.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.57-cip12.bb b/recipes-kernel/linux/linux-cip-rt_6.12.57-cip12.bb
new file mode 120000
index 00000000..e78f72ab
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.57-cip12.bb
@@ -0,0 +1 @@
+linux-cip_6.12.57-cip12.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip103.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip104.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip103.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip104.bb
index 5f4d1e34..994d934a 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip103.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip104.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "a7ec74eb70cd953f1c10e031ffd34cc1e0e30942b684a331225fb7991d95b829"
+SRC_URI[sha256sum] = "73489ea64b015a3539b4399dd233f0ca7e69cb179c0676095c1d587c77c93a78"
diff --git a/recipes-kernel/linux/linux-cip_5.10.245-cip65.bb b/recipes-kernel/linux/linux-cip_5.10.246-cip66.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.245-cip65.bb
rename to recipes-kernel/linux/linux-cip_5.10.246-cip66.bb
index d2fe0e66..7e02ce32 100644
--- a/recipes-kernel/linux/linux-cip_5.10.245-cip65.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.246-cip66.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "23996d35b4264c02839705539390cde672da51150fca655ad30cee01b8f7e4a8"
+SRC_URI[sha256sum] = "776dc35c07830ef54756328b47c72b81f4af58117a9321683eb788be6dc82258"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.155-cip47-rt25.bb b/recipes-kernel/linux/linux-cip_6.1.157-cip48.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.155-cip47-rt25.bb
rename to recipes-kernel/linux/linux-cip_6.1.157-cip48.bb
index 0edb2a38..185d56ed 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.155-cip47-rt25.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.157-cip48.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "f9bc9fdacf78719926d7e6d92575f2dc1b975b359b73e375c92541aabc3b623a"
+SRC_URI[sha256sum] = "7d4cf60253c1a57745d1dfd56c92a4a7e2d71ba71f1d3f488d5c37c435fea141"
diff --git a/recipes-kernel/linux/linux-cip_6.12.51-cip10.bb b/recipes-kernel/linux/linux-cip_6.12.57-cip12.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.51-cip10.bb
rename to recipes-kernel/linux/linux-cip_6.12.57-cip12.bb
index 4c000d7b..320888f0 100644
--- a/recipes-kernel/linux/linux-cip_6.12.51-cip10.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.57-cip12.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "729b2987b444e3dbbe85551d37a416fd9d06c9e53926da0680342df89b9f525a"
+SRC_URI[sha256sum] = "bd5279dce14c0dba16dda09f35b6d2d8224d8251a6575544beca2165c591e1c6"
-- 
2.51.0

