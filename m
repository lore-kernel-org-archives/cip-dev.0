Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96149C531FC
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 14:43:03 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32582.1785163380581451570
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 07:43:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=L1R9nUuY;
 spf=pass (domain: siemens.com, ip: 52.101.83.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuGnhh7wia+A6QuLveIi8GieBF/EIyKt2RMDzIkHceGrwf6I8AIa3NI9/YuFvDAazUBNccVe6jaPBnqY6kYp7sFLP5pGaKMyy9CEHH5ywvIvYxgilQ2uzOetEMfq7U/crBEI7jsuLN3+W28QiAVNuBzXU2odrMxMLLhvst7aKmf1vkJCVOqwM+Q0Sfd8+kLl7w6pDZ4w8I8vyVmhwNE+3odQt/lfv3UaoHPmZouaV4IKFoDck/ixJHTKhhbFrnHriQ8USsmsBqtxZHgCZCnBOE/l0tXOTJMRnjjvMYXkRM+HHA/Yznh0FIh0zSPZrnSFMKc0o5mIuP9tMSnZFNBWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlmKuOBPERerTLJo1hJ6PdFEEbAWqLCn/wJYxR6UbKs=;
 b=Hh3DWhfD7jd9B8ESf+frp2sRlVDOT7/d6YRZQq512Hqdjwk0ISt4fBVPgavYkwr0CMqceyh/IwBiCogFgHu1g8J3bfYVxIiyXbh6QKRsLCd0iCkVw+Jku9Q2ff8H3aOWQPFv5geUFxfIiOxXZeOFRwGr1FGd3k98IQ/Z4UiyX4PW6GmffKT6rTIRn2jI7GdslLE913OmLW4Vd2k74KKRRa2GpJYWPp39nap1huC+VXUF6TC+e6+cAPkYWn0O2iSWTLO+r7rELbAFjDSQeSfCQQoisX6yv2Q48zhpJAFHCftcD29s3s1MueBbJoUsSYEBX6FTJD4t1btpgoj7P2xxiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dlmKuOBPERerTLJo1hJ6PdFEEbAWqLCn/wJYxR6UbKs=;
 b=L1R9nUuYpMX1U87iOlpk/nUCp70rtOu1mq+mMcggExBDYUrfJaJoLFZFwYrp8nhhhyBHBeJUj0kb6mP6g2uTqwr376fm/ABIXBEp9PAbVtkAnL3C0JdHFjuzRZmFwYX9na5CYwwJOT0uw/kX6v0sTMYdCjJc8phB7EZuTlElMglS5m2mYyU7rnHEwRSPJOn4kXV9xklCjE5ndnluSMNLepBfef4NjC0GiAVTQZrZCpj/+AloqWg2r2a8mFoxa2v1SsmT9CCI4UMjua8u2BPUyTMNRjWzXfOheYHZ85PK/rkxHaEd9A9o/ZU6u+bh5DTfjPjLCQbTakjP8933Zkw8QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB9144.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 14:42:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:42:56 +0000
Message-ID: <464f9842-7ca0-444a-8c6b-da1040bcc087@siemens.com>
Date: Mon, 27 Jul 2026 16:42:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 10/14] Integrate cis-hardening
 into cip-core-image
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 christoph.steiger@siemens.com, clara.kowalsky@siemens.com
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260724124945.3636668-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260724124945.3636668-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR02CA0030.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::35) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 283266cf-1c2f-438e-9ca3-08deebed5871
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|4143699003|10067099003|11063799006|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	B9Op17LR0Jr8W1fJk99ElPAr60kiFfXBAu+qUkzfFAMZC/f+bvxf/zhebh4Ime202sFQBGI7K9r3KISEwz66CT4DrvXsl8m365bSuWM2rVG6dkdcZDaSbsVGadfNjNAbo7i8BnnrdLjog0+acDJ4Bhs4wJv0GHazvZwEjooYEHE9JBO5BoTeNplVAKH9BV3yjhIIPuLU9tvbymTBcI0CT1Vkt7GZ6NFTuIj7vEGNKWgcO7mYm45J2S2FndUwZM7UClRhMMQ3lguj54s9gFwOeECqQtfLmAM6aMOpJ8usdy+Z1uvzhcIA/FwQ6PB3DPbVAnTUDJ43IBmtMDmEkoBI3HwgYTQ2vNrU16jFuJZyPhKUmAMfbjOgxhSCLkct2qP6d2wn4t9nz+XOs21W+nIOU3pTzuGR71Ck2GaTTKVt5OM1vb/71dOumpamFRYY+/5D2T2CvCF8Phz4JyPJURc6jH1R9M2QxCDwG2yOQqkFXxEErW1DQ37OaNjBIp8a/6Hs15/LNbB+dsHekzD4SybI6ziiS6jO2fU8eXou5vq97InLeBWOB3y+JZ1geF0ID4CmTcDZxk85pKsM6dW6INqck14jkdru1somYVQvOn1g3ro+D4lUHF7f2gq7NGi3icQwWDGysCfLBLBBLhoJmmGJOrkXvyIBf+ckeGcgG2/Cg/M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(4143699003)(10067099003)(11063799006)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MTNNaFpkR3B6ZmtpSzFVYzZ5aXF1dlliZ3hRMUFUbVZGRGZRS0ZWMHk3NUpm?=
 =?utf-8?B?c24wZlZqZHRPRHFyRWpXUzlOWld4d3MyMEVuZWd5VUp4RlBWY0hGVU5IdzlE?=
 =?utf-8?B?ZThKZGdlOHBqVlJKUTUrVnZJVmxaTlRUdjczOGdGRHcvYkNLdGNzRmc4Vi9V?=
 =?utf-8?B?TGluaU9iUnNmNFF2bFRzOSszODYvbDhaZlNzR0NiODR1cFd0bmlZS25hWHl2?=
 =?utf-8?B?bXIrZGU2dGlCbWRjZlluMlRud1NHd1F5SzhianlEVStuMnR5SW5wdU90dUwz?=
 =?utf-8?B?RHFXOWhSaU1FYlRuOEV1b1NQNG1vVmlhOGprVjkzdVh6Rk5ROEs4RTFJZEZW?=
 =?utf-8?B?ZGNaQS9tdmJRQmo1b0Q2Nk9ZeDhsMzdkTVJteHlIek5uclE0SHFGL1pxWU56?=
 =?utf-8?B?YmRIVTU5V3R2dHc0R2Q1MzJLVHYxTzlTbkI2c3JXdmthaytPQ0xwYmZ6VzNp?=
 =?utf-8?B?NFFnNWpXQ2dlMk9XdHMwU3EwVnRFdXVRMUNSS09JOXZzVTRRVE9rMUliM2U5?=
 =?utf-8?B?N2l6R1ZkaUM2aG45WktKRGNvZWdFSlJLYzgvd1g3RjVtSU9yR3Fvb1czaCs4?=
 =?utf-8?B?UXA1aUdkRittWEFRaEJuRWs0M3VRUytSU1VhTzZBaEZBQUdIbHNvVVVRSCtn?=
 =?utf-8?B?Q3gvaUFmYkRsVU14MGZMZ1FtcFhoa2VSQzYyRFl0MWhFMy9UMkJIZmN3WkxH?=
 =?utf-8?B?K1MzNVZiZXowWVdRem1uVXpJRmtEMUh2elozbFkwQ3JsWEo2QnpKS3J6QkVz?=
 =?utf-8?B?Y1EzVERRZHUvYlR0bGZNWjhVTjBtdVZobkhab21nM3NLY3BVWklnOEFBSTFV?=
 =?utf-8?B?Slg0ZUtZM2xxSlF6QWJEZzRBMnlTZERwT0xteW1TUVJiS0Zic1R1cXphaDAw?=
 =?utf-8?B?MkNnb0c2bnRXdnpFZjZXUFc5dS9Lb2VXTTY1d0JqWCswOHdYeEVZRzA5b2cz?=
 =?utf-8?B?c1BYTkU5YTEvc3lQMXUzVW82aXZWRmpzSUNvMWFzUkZDWGIrR2tSMjRVZURj?=
 =?utf-8?B?WjF1MmRua2NTb0ZzS2MzTmFQc3kxVk5KMHQ4VTZJZlFBeFc5ZWhtdmUwUm1M?=
 =?utf-8?B?SXNMc3RteDRmNm1MeUkxWnhYSWNad29kUWZBZG5kUEVxS0VjQzViYkdIbVov?=
 =?utf-8?B?T0JoQ0kwNVh5MTh2OUdUVkpaTDVVSkFrR0U0dXhkbUpoOWk0NEFacDdCdTQ5?=
 =?utf-8?B?Q016Ujg3K0E1Z0FpcVF2eVZLbVdZZ3FGREFDUVQ0UUZyaUttQWozR3ovRlh6?=
 =?utf-8?B?QXRtTmthWkFVb0dxa3EyYm55V1g2dVUxeFRQbWU2ODcxaWRjRDJIcElnRGdw?=
 =?utf-8?B?V1NYekJFWWhHdUdDdmVkd2wvdS84bjhUTWZZaG9PSW5UUjFydFVtK3gvemhs?=
 =?utf-8?B?R1dYZW02c1hleldpWDJJNnl3S0NWMXJuU2o2eUhza0RwOWo3STMzbVhiN2g0?=
 =?utf-8?B?cFJOMk5RVEpKVWlyVGp2bmxtUmptazkrcy9oRWF6WGt5S3hUSDRLam5GM3FX?=
 =?utf-8?B?L3E5MFAwSDhPKzRac1h4UWFVd1R6TytZTFZQWVNFWGpWT2YwNHZ0VzJxeHZG?=
 =?utf-8?B?bUpUTkxSUkJIOXh4bDA2TjA2cUtnZWF0RHhsbzB0MjJKNUZGZ3ZSeGxqS0ow?=
 =?utf-8?B?RlI2ZmpJYUNaaDBablZ6cWRVeEFOQjhFcTVJbURZeWhJYWJRNDd1R0hWOU9T?=
 =?utf-8?B?Z0tJaWtaMzY4aTJoSzRXa0pnRW5xQ0FzS1hiNTVQNUorb3IwdlZ5MUROWmU2?=
 =?utf-8?B?d2dCOXpHajl5ZE51VTJUVHdRTFhYcytVV0xOTFF5YXpsb3F5M1RzZXRSeEp4?=
 =?utf-8?B?RkdFaHVEc2RQa2NyOTNKSTRuRXBSUStyOGY5TGt6STN2cWxmN2p5WkRQOGFY?=
 =?utf-8?B?bDR1WWtjeGE0M2NHbENqRDd5RmNkTlVCeDRkajZPM21WZWRMdDNVREZVanhx?=
 =?utf-8?B?NXptRVlLbW1jZWZFQi9KQk1ZSGZMRW8zK2dCYkpQQWNQUGcyUmhJUks2Z3V6?=
 =?utf-8?B?RytWR2NyVWt5SGo2ZEppc05MM2hLcEttYkxLYW1uQ01WQnltK3F6a3o0Qkdp?=
 =?utf-8?B?VUtXVHVySUZsdklqWGlZbExLYXVBaHhZM3ZxMUJtZXN6WkxlN3NlVjlad2dI?=
 =?utf-8?B?bEJLazhXV2RvVjdkQnN2NnNoREpFQW0reG5IY3NlM1E2RGtkdDF1MFlGVVJq?=
 =?utf-8?B?VU9xYitzZ3NuSTZKb0diQ1VsVGwzSmUwWG1DTkZQY2x6MzVhc3VsOXJZQUhX?=
 =?utf-8?B?U1dCT3pOdGFta1lQQnZaT0xheUR0V0JyWW05dEc4Q3RsRG9FT0c0dXAzd3U3?=
 =?utf-8?B?SGNxSmRsYk9CMXhaajR3c2p1SHBqb3VTeVpxdFM0QytsNGNmbVlMQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 283266cf-1c2f-438e-9ca3-08deebed5871
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:42:55.9548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+lebm9b5hp+xxBCJrpQHosO2ketgU+rQNA/6fr2XvBjSPE9RyO1fUP6/Yx/bHXepZAI3pITmZm1OpdUNzahUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9144
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 14:43:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23778

On 24.07.26 14:47, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
> Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/images/cip-core-image.inc | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/recipes-core/images/cip-core-image.inc b/recipes-core/images/cip-core-image.inc
> index f6162cd..859aee6 100644
> --- a/recipes-core/images/cip-core-image.inc
> +++ b/recipes-core/images/cip-core-image.inc
> @@ -10,7 +10,11 @@
>  #
>  
>  inherit image
> +inherit_defer ${@'cis-hardening' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}
> +inherit_defer ${@'cis-kernel-hardening-validation' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING_VALIDATION')) else ''}
>  
>  IMAGE_INSTALL:append:factory-reset = "factory-reset-helper"
> +IMAGE_INSTALL:append = "${@' cip-cis-rules' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
> +IMAGE_INSTALL:append = "${@' cip-cis-validation' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING_VALIDATION')) else ''}"
>  
>  ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always --match 'v[0-9].[0-9]*'"

Hmm, patch 7 could also be moved here, instead of being folded into
patch 6 - if this commit should really be the final arming.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

