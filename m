Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC24C369C2
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 14:24:36 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web11.41241.1745331870737660440
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 07:24:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dbkVAqyb;
 spf=pass (domain: siemens.com, ip: 40.107.21.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3X1+NIIF6Rq6qQ5o4XKSdLAC8/mlkH2zERB5HfWEtO/lSZH88TThP6Ap6/4ch995m8/YkR7W8foHcx/Q1o4d8jsXzaG8LtFMM4lsY3G2LHKU9+FoC4V1o0rQPEmTL3foDCmZlVJm9iwW5oMZTkfupUpatK02Bwwbn4cueEaN1qiIW4vfgDS9lH3zy1aGC5TOzIysdaBmHynzpSVjaFpR0j6lDHT1Qb/Uhvp33bs9mIhiZDCxypqCoHGIDmVaCjDk0T260TmkDobITQ8Whs7vy4TtZC/G6tH+si8OyWSGZkbYuTvq2GNAbbxZ0JdyoYPy7Vf7HCAE4+dzvGTI75b9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyyU5L2cHhhTT/9FF+n/w+CMLt+EKwP4W9ivasdr37s=;
 b=KK1BUNIPLAGbeEKvcVgN6FRjbkVvb0FzhWtAeFAqy+TklYbp9wqrUVGJuTYY4vmG4Q4WCnpCuh7Nr5jdsvUBGpZ7KZABo57mPG/bABecGSNkqdPHLI+c9BQ4Msx+2fAWlSXEWw0WODk0fcwvm5KF4rp+gfb6Mh1bXjpNARgBimiH199cgdrPPNLUbshcWdO4YOkNVp29RniZMOe1gn91ej2TXuzWvOAY+7m/zb40weJ/OmciMOKnqwvCIW3jLIH/NtvhxYdRKoyDMowQRdV6681Ar+vgOMEAOH2mEJvEM+83+JNHzOiNxreS6nsOhQ2rIVDg2zU1w5weonpbTYfQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyyU5L2cHhhTT/9FF+n/w+CMLt+EKwP4W9ivasdr37s=;
 b=dbkVAqybgRaPohTKGNzrefVZGGCCEUpOlHTiLm+Mobs6htJxd2Ck3+QRUchHlUdGEjGX62DkBcLIVGXh4jfY3zWCCR0pcvseAQWKudu3XyOiCDt+pR5dEe/W1gveYEQSsyzqL6+t7AF9F6ayl+AOHHh+LzphnnoPpSCzbSKoI/DqIfeu6oeEuOYiqg4fYNOWIe+Za5uM956hWq+zFs8mqkKQTpHqtT0//3gtZ6KObaVXavSYRd5SIOwhOy9IVIUSrmBBBrcxULMH/OYCQAJtP4FMqCRl3cSkOGIyvmbjOPSm3NN0Who3S/gUVX0yMNWQysB/ervRiQzPu4qKBwfujw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB6106.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.33; Tue, 22 Apr
 2025 14:24:25 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%7]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 14:24:25 +0000
Message-ID: <79d61200-975a-41a4-8f46-5fe5bf3ead1b@siemens.com>
Date: Tue, 22 Apr 2025 16:24:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v5 0/2] Update IEC job timeouts based on targets
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250422112751.3620163-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250422112751.3620163-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::19) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a25775-d483-421d-94d8-08dd81a961c9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aDY3QmFlQklHclNaNDV4Y1htZ3FLWG5HZ1poOEJpN0N2cHZXNHdKL0ZsYU9Q?=
 =?utf-8?B?RjNrNEd1ZWRPYTJlcWhsU3lHUWJwWTl4MHYrVUtYYnVLdFhEcHV6VmorVGh4?=
 =?utf-8?B?VUJ2NTVrKzI2R3BmUXNIRUtVYkRZYXdzeXdlWlVyK3c2NzVmOUJVUkZ4MWdR?=
 =?utf-8?B?bmtYQWtIUTZSSkpVVHJYeDF6dmduMmxjdkVCaHFVellzQW1nU2FacWloMm5u?=
 =?utf-8?B?aTZHM2tvUW90dFl2bEpnNi9kaGplWUdxTFpMaXkyY2phWDRFWjJKSitseWJv?=
 =?utf-8?B?Uzg1YWNWY1VtUzRLU3cwSmduSWoybjFFUGpHSUNFOWdQVGt1UnNMc0dXZTFp?=
 =?utf-8?B?TVhKRGhOcXVacHB6dGF4SjQ3WTBEQ096TmlxV05JdUphQUNQOGkzc2t1TFht?=
 =?utf-8?B?UEUvV3NIaVJlWEV4Z01RcUZFcmZPY0ZtUDd2NWRDMkxhbWpZNVNCSDVQUzQ5?=
 =?utf-8?B?SkpCdkgxdXZqNjRPMTUyTHFMVzBhQSt2WFdLSzBBMnFVMlR3bmtVa0YrYkxC?=
 =?utf-8?B?dUNiOGpJcVJoNFhZclpPR2FoWVRSdENNNjAwY0dLcGhoeDFqNXhxdUhTMGJ0?=
 =?utf-8?B?cFVWRlhHakNLbUhqcGdaV0JSbm1aeE5pMXZ1b0U1eGRDU0graFdQRzJwM25N?=
 =?utf-8?B?OUJibVJHRVJMK2RsRzVlZGYwNVcwSXNnV1JaeUFCZFA5TU5xOHNDMlVhbDBK?=
 =?utf-8?B?THgzb2U4bk5GRlpwOHE2VWJkcEtxNjMxUjNubjB4Nnkwb0Nvb0NQbXA2cTNG?=
 =?utf-8?B?VG5rNDUwZXpxYnhqUEl2RWI5UXdRTWUvSm9oSndQMkxxd0crVkcrMlJ0ckpi?=
 =?utf-8?B?emFWWVJLQkZMcnB6SFR6ZmZzaUNPeHpYV09EaGYxTC8zeTlWQjFtTEJtVGxQ?=
 =?utf-8?B?aCtodFM4OFdkNThEV0hGdnJlbHZZSDNHRmtyZlByYUVmZ3QvME9VQld4amxy?=
 =?utf-8?B?cERwNjd4MEYva0k2dERxT25ZUXBjSGZEZGNQekE1dHJwNkU3TGFoZTdkWng5?=
 =?utf-8?B?RGV1VzBiOUl4U1ZGYzZVdUFvNkFyT0g1aXZGNWk1dGQ1cFJOOTg4QXEwRjRm?=
 =?utf-8?B?dEdOQi9uV2xFQVNBVUlabjI4UmZEVTQvY2dpbjExSFJKa0hVdFNmcHZVWXlL?=
 =?utf-8?B?TVZ1T3VZT1lUa0FkRzRBb09FRnE4NFh0bS9oSmc1MzdDazJmTXEvTGZXVFZi?=
 =?utf-8?B?OStUUnVKc0FBdDFIR2s1SUpUcW5mSFY5L2szLzRFU3dZbDNEU2hkSEZiZFg2?=
 =?utf-8?B?eVFJN2FnMmtVZUo3cU1IeUJyaTdnaDNuaFpBQzZCL3ordUc2c2dLMC9rQWdq?=
 =?utf-8?B?K1BFREZFdTNnODIyR2tEdjVQRkFTa3BUbXlGem9nbnEvc1I5TEgwTjcvS1RU?=
 =?utf-8?B?a2ZIeWVPczVmNWdtUlduZEtQeHh1U0NGazFZNVRIcjVaYmp2TEgrV0VqanhT?=
 =?utf-8?B?c3FMWWNlZW1zZGJkdmRtM3FJVHdHWWlDcVdSWUZ5eTd4YlNucTZlOVRha0dZ?=
 =?utf-8?B?UnorUjV1ZXQvUUdXbEorUkJYeVdpZG1hQzJ3Zk5iZ0pnRU1INkNJL1o0dHRX?=
 =?utf-8?B?RFZjNkNlamRBQ2RFN21SVlhSS215V05ZdDlBMithSWdWaEQvMWxlWnQ5RnRS?=
 =?utf-8?B?Y0lHZkN3UGNBeUE1cElldGduMDFiNURWaDBabE9XTk5DbEU0Qi9wL2pSdFYw?=
 =?utf-8?B?RldLc0hHSGttV2ZsQXlpNTlMNVNibHpzOWtBUmpVN2ROd0tCNUhaemkvSFZt?=
 =?utf-8?B?TENFc0xZMXQ1QzZmalIvZ3QvZUxkdHdubDIzSisvVExnSDRrM1hrM0l0eDJk?=
 =?utf-8?B?TUJCRldheVpsRFpmOHNOeTdaMWx6WnZDOWM2Y3cvZlpZdDdwdWI1N2VCanJl?=
 =?utf-8?B?LytLZGZjaWZpaVRWQkFsUUs0cGVhREw3ZEl1SmdmTXFJVEx1bDJSUlZoZE9w?=
 =?utf-8?Q?ZLi1x8faBl4=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aytQRjRsNDJ2eFZybGV0Q3JVaEN1V1pmU25QS0dmWmxCcU95bG1BQ1I4R21x?=
 =?utf-8?B?MmQzS3NJMHFXZXdTVWtrb2ttS1l2dnpvbE1SbElyS1dLNUJhL1ROc21IM3cr?=
 =?utf-8?B?WGQ0NTk3S1VYemRIZnlaSjM3cEVvYXdxVmRIQnMwZEYwTXVHcU1VQTkyeGJy?=
 =?utf-8?B?TkI4eG1kNDJja0FMN0RQb3dOUm9ZRStjYmRacVZQV1pzOCtHOWZJMUxrTGR6?=
 =?utf-8?B?TjRYTUhKRkd0Vzl2U2Z6SjREdlZFV3ErcE1WRDl2QUZVdHExR0xiR0N2bSsx?=
 =?utf-8?B?ODJKQ0Y3TlFJQ013RElBQ2VnRXNzMjZ5b0FadVFGcmRsbnhuN2wrTmtreGZl?=
 =?utf-8?B?ZHdPTGR5ejd5OElJdEl2LzJjSjExN0JwSkJia05IOGNWMUxlbklqeXQyOFR1?=
 =?utf-8?B?VHRJbjVqREhVYzd4V0lmQnN5ZUpSSm9ycFhhYjBzWTl0TnhCWEdVU3piM1I3?=
 =?utf-8?B?ZWxGYVlZT1piVkZrUndxUjJ3QzY5SVc0bmwwcERlaXR4LzM0aE9rYklTY0Rr?=
 =?utf-8?B?T3Jjd3pMTUlWM1hNdnRUZ2oxeUNRSmRJYUdPdVgxNytzK2hmeDd1TUx3eUdp?=
 =?utf-8?B?NStSMGtaNlhaVk5xRG5aVWxIY2RvbmYwb3lBbUJyS1hhR1U3aG92SU5tT2ty?=
 =?utf-8?B?RGtyZC9JMnArRE5nRHFFcXFQZW1SMTZxSjdYR3g5U09ZcVRJTVQvd2pJOXRo?=
 =?utf-8?B?SCs2eklaVnVOeDZ2U1VBbTQrRU5KRWwwRkRJa1RFZmJ3Wit5NS9XYUFDVDA5?=
 =?utf-8?B?cU1Selh1Q0pOWkkyamI5Z0g3ZUwwV0lBa2lvVkphUDBvaFVCaVg3cDJLdzhH?=
 =?utf-8?B?QmRJejNOQ1V5VVBPaG5EYjdQMW5rVlNVWnNXNWRqa3dGTGZ6T0x2K1ZmREMr?=
 =?utf-8?B?TUhNcDhJclQ2Z2lKN0lJNEpjY0N5L3FDUG1UTjVGMU1XT3dGSVBPSW14bDlk?=
 =?utf-8?B?YjFvYVRTTDJYZ1J6VDNNRlFoYy9rUFd0M0tJcEVsU0V4WW0vQ1d4NjF0QjYy?=
 =?utf-8?B?OERqWFVBMmlHZG1tcEF2V3JpSVZNTFNQbnFyeU1YcFlhdUxBQTA2K0lGbXo0?=
 =?utf-8?B?bkVvQ1ZaWWJyZldQQmhpUTFTK2gvRWdmU3dJNTVjWE1SWUsxMDJoSHkyWUFI?=
 =?utf-8?B?QW1KYytFRzF2dFNMdndXTEYwbXU2Sk11bThhQ1VaT2tudlR3dm8zR3p3WkFQ?=
 =?utf-8?B?K0RYYVA0VGVIRWNNd1JSM0FYenZFVFU0Q0k4Z2xQTy9lMWMvbWVES0FIbmZB?=
 =?utf-8?B?aU94RVNhQTNGcVZtTjdFMXQ1REZ0ZmNjVm5HbUlwWVF2b1VyNnFIbWZ4TGdG?=
 =?utf-8?B?bkpRTzBPUTgrbWdyRzVkcjg4NHNSQlN6czJBTTB3TmlwcXhkR0I1cnBQYUFL?=
 =?utf-8?B?K2F5UnNldUFlYnVmY1BDblZyd3JZd3dJT24zL2xvL0xMcEp2bDdRc1JBT2lk?=
 =?utf-8?B?VGhrRWdOU3IwUGExUSs5MkpvV1M1Mko1blhQVTBDWi93blRBeUYxWHplUGtQ?=
 =?utf-8?B?THNKTFg3cEt6bXcxRWd6dXRmRDhuNXhUeEt1TTBPNWhGUTVYRm9GMVB5Ym1F?=
 =?utf-8?B?NFFKd1FXZ3VtakxTb0U0MHFwanFIakFPR3d0R1VMVEc4T3ZVdExDRDFSN04w?=
 =?utf-8?B?dTJ2bEQwc1RHUUI3WUIyZ09JTnZQZGFSak53VWZpQ0hMTENVb0RKalVKN0JH?=
 =?utf-8?B?YVRXRFdBK2VzRFhLUFJERzduOFVJK0xhZUhhcVpORjhaZFN6N0lrVUxOMVhz?=
 =?utf-8?B?QWRkeGU3WnlkR1lLNWloTUVncHpnYXdoY0g5NS80R2ZyL2tWYTFkWWlRS0Uv?=
 =?utf-8?B?ZTJMbXBsWnFEaUlHVTEra0U2ZHkwL2JLR1IrRTRlYW92MWVBUDZrNU5HZVNV?=
 =?utf-8?B?cXdsTjRnelVEN1dtZFp6TGRoMTVKVXIrc0c0QXdSVnhOWU4wd2hCWEw3MEQ1?=
 =?utf-8?B?VUhiMk43anF3Yms5VGFJaFdpTDVKL0Q3SVh5RC9vMzVORTZzZUYrVHNNWG00?=
 =?utf-8?B?WnIrWGR1RzJYWFNuYUUwUkhWWVNVMFQwWHprVzVVMVZRcUlIaDR0c3VwcDVL?=
 =?utf-8?B?eDI5MTFEZkw2Wjd6ajlSSVU3dHhqelk5YXlwOUNtU3VKQTJ3YVRTT2FoNXJ1?=
 =?utf-8?B?bVVMTXR3cUtUZXNpMXZIQ0o5bzIxOHdwWFozWU9hZ0NrRjJ2Vk54SjRPRkY5?=
 =?utf-8?B?Ync9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a25775-d483-421d-94d8-08dd81a961c9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 14:24:25.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9rHFAYUqjLoLtW1D+MrfWTlzsNylj+5eqnjUzbaDxB5+t6lHl7I3DorMN6JiagxguI4+RpcwXlaSTDLB2NB6+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6106
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 14:24:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18555

On 22.04.25 13:27, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> This series sets IEC test jobs timeouts based on the targets as well as updates
> IEC layer tests revision
> 
> Changes apart from v4
> 
> 1. Modified usage of envsusbst to substitute only "IEC_TEST_TIMEOUT_MINUTES".
> sai ashrith sathujoda (2):
>   .gitlab-ci.yml: Set timeout value to run IEC layer tests for different
>     targets.
>   IEC_template.yml: Update IEC layer tests revision
> 
>  .gitlab-ci.yml                   | 6 +++++-
>  scripts/submit_lava.sh           | 7 +++++++
>  tests/templates/IEC_template.yml | 4 ++--
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 

Thanks, replace v4 with this version in next.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

