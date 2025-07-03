Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707D5C83030
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 13:20:06 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.46])
 by mx.groups.io with SMTP id smtpd.web10.22463.1751548800325199262
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Jul 2025 06:20:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zeC8Bu/3;
 spf=pass (domain: siemens.com, ip: 52.101.70.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2AhiQIOsITVFntY4+t+zUBYF046Pf7mVX1Z86QRkvECV5wSCraNbtNEam2HlBE0NgMmfh3iBoE+80a0qPgo1OLwr5+96osaiDrdKhTMkqEMWq2n8610p8AJSRb8Tiw1cM1fQUR3ZxgAK84KLy6XJI7ElJpGyfeRe5U+vBSUhAoFm8baRigAyqBiWCQvS3Eqm9Qy2rkd1dBfqt0TrgzmbMjoU44TM59k3Ul6ikGPs9gy9Akpt4sZH412/q0DemSIrbGPrnPih2CAzH1LfJn0p1HBSAuK86WELvTKUn8VrjqGIOFXiFfX4oK2rdBVC49y3Pykl08yUcwEsb5X5TIeRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zd/adkgFSxHyB+RfXhsyHdz24of8zUmuhBFbTsNEGx8=;
 b=PKFhakpVRW3uwQ9QfOdTj5JTr1dWbdTwvDHMf8l7m7mMGvUN372nsMWXsIDhsY39P9Otlq+3pnTOD6Fa2Ynd6/d+37i8u82wS5imP70ZDv061V2iAA9LcMsdSbTXLITtd5tGggfpW6UNbHfAWON+Tlj9/LUUm6yIPORqADQsEyr5nNwgyhvffjD2raymYtZdfuR9699HGurrVcD+Hrya7RnfZioO1MQub1RMLve2+uYVG71V6QFivJuj+SbCkTOivUawf5aVYVhhN7qDNJ3MOuFxyE7nULYJ2XO1ohT4eQHFgFtmW/bNwATfMCnAy22qzS96SNu4EupeN0O0y0CxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zd/adkgFSxHyB+RfXhsyHdz24of8zUmuhBFbTsNEGx8=;
 b=zeC8Bu/3sjXrItU6r1X3ibM6wDAFe2NssTyU8Z9jtR3VvU0DVNtlAEQB5bEtVeGcoRwM5TOARK4TZahSMdz2SuCFaQOymRsivB804WdbIjAJf2lxPmaAkCsnbwDvuT+yGltzLJLY0Jeu6Hxhuf+wa+VIsNAhXvaqJ3EfbeKubPwsRApeZUZUXKGFFNHzpTjM2v6ymllRhabikDGX93NoGlhbdQyIJsfhgH9BKsAnzEX9Hi3axMr1RT/7mnxTx+c0oVfWulqlNIZwOtteT32KsH/lC6qqIoN1CRBBZzsXVGDzg5oVzfzFVd+laxZJdDOvj38+/+Q8fx14ZB6SPe8EgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8448.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Thu, 3 Jul
 2025 13:19:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 13:19:57 +0000
Message-ID: <34be46bd-6d58-423c-a29d-f238872f34c3@siemens.com>
Date: Thu, 3 Jul 2025 15:19:56 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.302-cip100[-rt56],
 5.10.238-cip61, 6.1.141-cip43, 6.12.34-cip3
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0278.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5f1163-d0ee-475c-56b6-08ddba344e4d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZVZrVkNxaUNWTjU3U1p2Qzg3RFp0dFVqaHB6OWxRSG9NNHpoYjRCS1RiY3lB?=
 =?utf-8?B?UmFJN3Qyc3hiT1RLQWd1SDNNOUJ1QXN6Y2FpMERJcVFjRXYrdVA3OEVnUGpm?=
 =?utf-8?B?VFVGRjBKNUUxS2F5U1FFaXNpa0xCTDlJNnh2NThpUy9rZWdveUUyeUNYellC?=
 =?utf-8?B?bHlUNEpnajVNQXM1NjZzRkQ5bENFdFFINzhrWjI5WHEwKzgrNHpxQTlYQUhM?=
 =?utf-8?B?Z09OVVNDTmpqZEJjZXJWWXVBZml6Qnk5Y1pibFoxUStXTlo2UjRWUWx2czU5?=
 =?utf-8?B?Z2crelI4WlB3QmZpNkZhVUFPc2V3Y1Yxck8yTEFOYUFXcWVWQ0RSNTdrUWtP?=
 =?utf-8?B?aG9rR3d2cW5LV2I0YXU5OEw2NHpXZzhuNHdoQkV6MjJ4SS9zc0NwemwrZ1hT?=
 =?utf-8?B?TnVqaEdlVWJrb1JzVkZqQkV1Z2VvMUs2MzU4T2toRS9tbUZRQUoyZ0NjNDRK?=
 =?utf-8?B?V2pLcVZ6Sk1wU2ozTTZDRTJVYjBCYUdKN2FjQmF3LzRsYVVmMEx1VTZSSkE3?=
 =?utf-8?B?VlN1cDhWdkFKUzErM05HYUV5SkR5SlJzWXVKR04yYlBkTkFzSFpHZEowaXhV?=
 =?utf-8?B?dlNRRXl2blhLa29HWTVndDZSS1g2WXlzcFVsMDFOYURZNWtBS08yMzVjRjRF?=
 =?utf-8?B?N05TQVo5cUhnN2tzL0I2bUcxL3N1OW5ON0RUWGVYRzRMM2FlQitsV1Faa0xF?=
 =?utf-8?B?SHc3UXR1WnhXbmNLZXRWdS9NL0lVUHQzbFk3c3hDVFRIaUpwYmkxUE8reTA4?=
 =?utf-8?B?d3YyKzRBUk5ZOVlTTEdOMXFDZkRkanEzbFhqR2pIRzF3U3ZhcFBDOGJtOE90?=
 =?utf-8?B?cEhSS2NXOFhmbGVpaEo4QzNCM2ZuczFsQkRYK0xFMGIwTlRYV0xuSW1Jbm9a?=
 =?utf-8?B?WFFQejN5SkRWWWE4dEVnL2tDenM0QnZ5WmZ1d2txVWVXdU1naVlCZ3hUeW9B?=
 =?utf-8?B?cnVGWXZ3YnpvcER5K1kwSEMwclBtck5ZZUw5c2NTVFZ5TWQ2OEhuQWNNSlhS?=
 =?utf-8?B?Sk5mQ1hVTHBIUEZJVHp4blZNbDYvWjFDVUdvWUJndW9JZG5CdnpMUmVpZzZG?=
 =?utf-8?B?b3JqTmFxVFNDak5XbExmVks3MFJTQXNvVC84Wk1GaHhyZXlsMlpQQTRwR2tQ?=
 =?utf-8?B?S3lMazN2cnB3YS9TcW1xMWRIdFhlRkQrdHdaTlQvNEVCUTF2N09qKzlIRW9U?=
 =?utf-8?B?NHA2VmhKVExSVEZEbnBFZ3U3Vkt0UVFEWHZzRHVjS2R5Q3FCQnM2NmZ0eXEz?=
 =?utf-8?B?MXI2azZyMjVKNnYxcS9jeXd0WmJVcjV6NVQ2emtHdlpRY3VZS0l5Zk5HRHE2?=
 =?utf-8?B?bUVLR3pBQkwyYTk1T3NxU000clRhelBZUnVFTm5HSEJQaEhXUURwY0crMXdN?=
 =?utf-8?B?S2kxa2NQdnBnaUNOWC93VktsNmU2RDhNQnBWdUlzNnF4bm5BcXNSZVZjSjBu?=
 =?utf-8?B?REMrODMyTjhKMkNRNE1nUUdkNFdWZ1hRM05HelpjMFpCSi9BN0NBMkRYVXB5?=
 =?utf-8?B?VVVtNnRsVUF6a3dYbEhBMFFwbDRnQ09kQTYvV1kzTkpDVllSb2VDRVIvQ1Zo?=
 =?utf-8?B?Zk9LcjFGRXFHM3EwTTR0bTNCamIyRnAwNmhPYS9aOU5JQ0VFWVRyTXhibTNM?=
 =?utf-8?B?THhoN2RyVWRsSXc0Tk9rdnFzb05HSDFCdTRyVnJpOXpwQWpaV1IxV2RBcUpG?=
 =?utf-8?B?WkZHamdOc3NtaWlyLzhrZkhWcHNzMExWNnVPaitFa25UeWtsODZVQnZkV1Vy?=
 =?utf-8?B?Y1dHeVRHUGl2NkxSWXBTaEhQaXlCVzEvR2JkQmVZODN0V0FwTWkxb3hUT3dG?=
 =?utf-8?B?WnlOZGtadXJ6Z1lNMFF0b2oyaGFTZDJ3MWtxT1RKanV0R05tTHNlQmxXVWdl?=
 =?utf-8?B?cTN6K2FxS0w1VjNsRGF4eXorNjJkamFhZnloOUxwbHNrdzUxNXJ1QWlzZEMz?=
 =?utf-8?Q?sFhwLWk4GoQ=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SjFZNFgvemxrOUV1MGxud2FRZ29VdCtoZTZNakNYTTRYamdycUc2Q2gwT0w4?=
 =?utf-8?B?UUdZb0FUbTNQWnhWMG95WW1RL1pRZm4rRnBLbFBTZWttdzhXZzNjd3hUcjF4?=
 =?utf-8?B?cDdFczdXZ25mRUFCMTlPcGhjOTNYaEpBV3dYL1BkYjAwOU9QRGdwR2JzNmJv?=
 =?utf-8?B?NTJ1REo5VjZxMWwwRU1pakkxNjJBcEc3dmVxQWRKWDFmTi9FdEh1Y2lhLzB3?=
 =?utf-8?B?UFBRaVFFTkZnOFRUWC9ocm9jdG1Mb0xKU3RPUGFaVzlNZHFnT2ttZDkvVkZP?=
 =?utf-8?B?dXE0U2Q2ZHA4RER5OGN6VEVYdlVaakVKNEk2K1lmZGRhMzh5OHdSNnh5eG1u?=
 =?utf-8?B?Ull5SGFteEwvRXZJcXFNSk9TWGZ2bTZTazBUaktsMjFNWURvaU5oS00vd3Vr?=
 =?utf-8?B?NEcva1cxTDlVWGNhU0t0SjM3dHVVREF5UUFBcFNOYzkwZW9Sd0crdGdTclJz?=
 =?utf-8?B?Nm83VWxMb3lJcFNiUjVEazFXMmdqdVRHV1RRay9xcTdDRjErZXlmL0dQWDZN?=
 =?utf-8?B?SEREb2QwQk5mSVNDM3M2U0Q2T29OT3lvRG02REtVWXRpS2dFbnlINkdCNTZH?=
 =?utf-8?B?NzNMOCtGMU5Tbkdoc1ZHUXRSaWZEZElRZHhXMy9oV2x3OHVqYWs2MEVLMFZR?=
 =?utf-8?B?cWczVGhvOEd5KzV0aWI5S1RVM1BIc3d4N054SEtuNGVWWUpiU3ZKbUU2WnFW?=
 =?utf-8?B?NDE2L3l5TzdZc0xlaEZSNTJEVjBHT1NPdFJBN2lNUUhsT2UvTkd5SWZCYWdG?=
 =?utf-8?B?ck44elBLREZmb0V4VkpoUTY2R2Z6N3VaNjRDVnAzVjB3S1B2T0IxMGdkdmNB?=
 =?utf-8?B?Tndzbnp2U3RhaktubEQwZ3FYMnF2OXdPbS9oN1FpWUNtN01YdnNGcVBvZlBr?=
 =?utf-8?B?VEVOVmljSVMxSGFURjFlSEVzNWV3YWJ0MStBSkN2VWRzY2g5eTc1dCtMdVJl?=
 =?utf-8?B?QkxXSityekZUTTlDdnpSYXhUeGF6LzZ6L2cxTnhWMXlkWFVQejd1SktHdzlj?=
 =?utf-8?B?T2owVFFXNmk0VjNUK3NSaG0zYkgzS2ZFVUczRVNJWGIwV0lKN21sS0htb2Fp?=
 =?utf-8?B?dEdWMWdEZGZFUGpmYWd4SnAyVllBY3ZoYjgrbHkzQ0JXQS9zb3VKelI1WUNU?=
 =?utf-8?B?a2JqTDdDRTFxclh4UThrb3FDMk9JcUJ5eDBPeGFxSlJScjJJdkF0dTJncjdE?=
 =?utf-8?B?WVNQaWRMMDlGYXh2dzMxZkFrUHJNczYxa1A3WmdjTTlaZGxWdGNpcDBENlEr?=
 =?utf-8?B?YmZtc1pYdEZwVXNiVGwxMTBFckZ4bktERFpBcFl4MWJqYkZ0eTV2bXNHUERy?=
 =?utf-8?B?TFZiVTRYeEc5bkw0YmV0WlBieE8vRGdLWGVtaCtwNEx5akhOMG5YS1lROCtH?=
 =?utf-8?B?UzMwUGI4TVpYWG9BSFBvWURlTVFYV09QYkh3MldWWUQ0U2NwVmRCTmtBV1Nw?=
 =?utf-8?B?SndkaFlaWmt5ZW5Cby80RTZmY2dpeTYrSHU2TVNuVEpQUG5TbTJCK1VCeUJN?=
 =?utf-8?B?dHVsdzZmbk9ycDY0MmJra1hvcXR3L293YkF1SXNHSG1xdERmQTlzSHQzRmc4?=
 =?utf-8?B?SHBkSWdPWEhITVZKWGZ5Vk9ocVF6NHRRRkVuMk5Ba2htN1F3aFFGczd6aTFT?=
 =?utf-8?B?cDRhMStyNDQvbnFtRTVndmx0d3hablUzQmJ4TEN2SngySVEvbnRibVhxTlpr?=
 =?utf-8?B?YWZvQmc2c3lUTEFNbTFIc05jdCtnN0o5QlRTaFB0bDdIYnhtdlV3eGkxTU5o?=
 =?utf-8?B?bU56SjIzbVdURWFnTHFlMDJyeEk5SitHNnQ0TFVRZDk3QWIxOGEwbjdSR0l2?=
 =?utf-8?B?K3NGcXZSRXBzRW9YR0JuYkFPY3VTUmdoR0VZM3hqT0JQYkZjelJrUmswWkF6?=
 =?utf-8?B?Qy9CTWhBQnlRQU9ZbXFza2NQVEkzZDlCY29wTmZ0dFpPRE9uZ20zanNuN2ph?=
 =?utf-8?B?bUhZSzVkZnpWL0VEL1hIcUtVdnBxRWlkaDZmRjNNenFGVXZDYmg0RElEWXNT?=
 =?utf-8?B?UGwxaGIvR0ZhODlia0o0Tm1jejBxQmhxdy95c0NqRE5ja1RWNmpQNXZWL2RK?=
 =?utf-8?B?UTZ6a2Y3WEpVT1pDaVcwcmVsZ2V2UTBjS0VWZVZLOEZ3MmdXODZHV1g0d2Jq?=
 =?utf-8?B?WXlOR093bWNNUGlxSmRDVXFiaXdtbjNuS2dURHlzYTBYUFJTTEtETHJMQldO?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5f1163-d0ee-475c-56b6-08ddba344e4d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 13:19:57.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nVJU+3gp9YqJ8W00a99vp2NLMRdYK+i1BBBMogRWskAGaMnb2rFliLBzM5OqaZY030KqhGL7KFNOWItuVBicw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8448
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Jul 2025 13:20:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19328

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....4.302-cip98-rt55.bb => linux-cip-rt_4.4.302-cip100-rt56.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.32-cip2.bb               | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.34-cip3.bb               | 1 +
 .../{linux-cip_4.4.302-cip99.bb => linux-cip_4.4.302-cip100.bb} | 2 +-
 ...{linux-cip_5.10.237-cip60.bb => linux-cip_5.10.238-cip61.bb} | 2 +-
 .../{linux-cip_6.1.137-cip42.bb => linux-cip_6.1.141-cip43.bb}  | 2 +-
 .../{linux-cip_6.12.32-cip2.bb => linux-cip_6.12.34-cip3.bb}    | 2 +-
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip98-rt55.bb => linux-cip-rt_4.4.302-cip100-rt56.bb} (68%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.32-cip2.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.34-cip3.bb
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip99.bb => linux-cip_4.4.302-cip100.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_5.10.237-cip60.bb => linux-cip_5.10.238-cip61.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.137-cip42.bb => linux-cip_6.1.141-cip43.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_6.12.32-cip2.bb => linux-cip_6.12.34-cip3.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip100-rt56.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip100-rt56.bb
index 8c88eb5e..5d94f7ee 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip98-rt55.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip100-rt56.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "70e223852d3a7f711dd511524243df512dcc7799010004b4d99e0acf1f95866a"
+SRC_URI[sha256sum] = "313cf525f5ce70b5ef99ab329360f5beba3d82a594a896d041d9c17c4b1434d5"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.32-cip2.bb b/recipes-kernel/linux/linux-cip-rt_6.12.32-cip2.bb
deleted file mode 120000
index 24622cf6..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.32-cip2.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.32-cip2.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.34-cip3.bb b/recipes-kernel/linux/linux-cip-rt_6.12.34-cip3.bb
new file mode 120000
index 00000000..86637754
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.34-cip3.bb
@@ -0,0 +1 @@
+linux-cip_6.12.34-cip3.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip100.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip99.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip100.bb
index bb307304..f2d2e99d 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip99.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip100.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "ecc90814484dff84dae3f25ac2da7eb9156dc43c18acf2e806dc71ed4800b558"
+SRC_URI[sha256sum] = "7d130141f58db7124ab30527137986a4d789f7b952f43043ac26c085d3b07a78"
diff --git a/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb b/recipes-kernel/linux/linux-cip_5.10.238-cip61.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_5.10.237-cip60.bb
rename to recipes-kernel/linux/linux-cip_5.10.238-cip61.bb
index 81e21268..c46d3343 100644
--- a/recipes-kernel/linux/linux-cip_5.10.237-cip60.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.238-cip61.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "be99dae17d2989965dc6dae2092067332f9965df0dcee8b7d517b823aac67990"
+SRC_URI[sha256sum] = "baffc5d9a487b168fe12ff539f48f53618a64c296a1d409789f556537f04e8f6"
diff --git a/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb b/recipes-kernel/linux/linux-cip_6.1.141-cip43.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.137-cip42.bb
rename to recipes-kernel/linux/linux-cip_6.1.141-cip43.bb
index 125fbe49..25773c39 100644
--- a/recipes-kernel/linux/linux-cip_6.1.137-cip42.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.141-cip43.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "05e279c5e955e96c85be7f8b19b3cd7aba109343d7837bbfa9b9a1b6362ecf2b"
+SRC_URI[sha256sum] = "e7de47f1bb910da28a5d4fd4887757909f00850dd0cdc40f1731b5fa85a329b0"
diff --git a/recipes-kernel/linux/linux-cip_6.12.32-cip2.bb b/recipes-kernel/linux/linux-cip_6.12.34-cip3.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.32-cip2.bb
rename to recipes-kernel/linux/linux-cip_6.12.34-cip3.bb
index 45705a4c..81a0d4cd 100644
--- a/recipes-kernel/linux/linux-cip_6.12.32-cip2.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.34-cip3.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "948b118eb9f36a881cf77e6a20e508362131bcebff6fa46353062ceb939a4d5e"
+SRC_URI[sha256sum] = "7d4aa1af336bf2044514ca90177c690afd3117bb567ac9f048c6ba18341220f9"
-- 
2.43.0

