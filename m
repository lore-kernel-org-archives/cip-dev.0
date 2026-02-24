Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB6BF3C9A3
	for <webhook@archiver.kernel.org>; Tue, 24 Feb 2026 15:55:44 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.35])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23585.1771948540513866465
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 Feb 2026 07:55:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eDIPhc0q;
 spf=pass (domain: siemens.com, ip: 52.101.83.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJkDVtcFZTjVe+zKTYMwJF9wC+kDwEcc7AMyFmE+DOHnPHmSsNthgR89nojSdbEOUjIcH4NMnHAmhcB8j2VEAhrmvh8zTDSRLloW4d8uZUYlSkiBIwi5Iu4EIaC/xGR8dUXdROw/bjBRL+o2eIG15PxkOXRdhhc7kf4MLPPeQlketG6OfcXcwsLcLfaDMpX8hgXL1iPKG7j0KAKvAFUh/F9Z1nZskA/YPKleIZLPAsFKsvfdQZKAWzBAWkKrnYpyiaAJdaPYdQxdTz/5F60m5lP9DD9gXrjV8bH1S30/vDq2TjHHP56kxFPHrDo0oOlt+bHUvL+zG/GThPUv5R7H/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgu5NefAJIVrUWdi08Se3HovEsnQ4xpABFYQ5LNewgA=;
 b=UYVAzIxeiGcpMqOlXlYYwDJDtXyxVMZcoKSFtlF4XVGtPx1S06f6Bd5x9hCffkE4uyjd3ervHlc6A5zurWQnkdh0fPp7NWzmZLAB977qhEONK5dwfkBUcdzcDzkpLvqB0ouwjrcUKQxn6wi2lgP2AFR/qrhxlqJJGmTupuquvV4oScTflsZVofxDOQ9XDo0bMaVRUfkT4l1O4wgIJl6bGomw5m2orbPWJP73VGxwUAgD1bF23ZnQeDxEY2Q3GtvHOVC9dUvPncNO8dQqkBn8ReNdpzhb7vq6gdgC+iSU7UPLyLJmcoz5UsXYhB39iL/l3Qd6rgtcwxREx6a4yNC56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgu5NefAJIVrUWdi08Se3HovEsnQ4xpABFYQ5LNewgA=;
 b=eDIPhc0q8TK8NXv+hYdWiu14eGajloxokbViEABlYpEppjjwCgjISGBlVfy8WN813cGDnt62hJWfF2WsI0mAOugNlZmna1fTADplRiEV4o6Kg3wLJ7ItQ0tOajwAy8vzKlJQMEH3LMYO2qcin4ruLK1g50CBHHKNyV4uLHLKS1p1PLEmE4j1v+KZTKmgyBhcaWKI7kXXcYDlHl2R/4UYs14xY4agjQ1H5gnzojN8dTM5VMt31/LCgDbrcr/Bjjzm66u4e6TfWHlt62pGPJNmeEVup4gjEGcjzu5BaFQAVmt5DRbDHrr5WfzvBCSPNFCnwcalri/i19NHtpofEagikQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 15:55:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 15:55:36 +0000
Message-ID: <c7323201-2e56-4b96-9561-6180b526cb38@siemens.com>
Date: Tue, 24 Feb 2026 16:55:32 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.325-cip129,
 6.1.164-cip52[-rt28]
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:610:e4::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: 2954b29d-bdbe-4dd3-ea0d-08de73bd2648
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eEhVWjNBRGFUUXBpVmlpRGVrTjZJcjdNMVdsZVhaRFVxLytxYWRnb0NtYWd1?=
 =?utf-8?B?aHVhK2hDb1JNdldLekcxSmhwNGdKUThQbVVsNlc3aFJ3akpQam0vZlhmTDdO?=
 =?utf-8?B?d0hSQVlMSUxqa2JTYTlLQUtVQnpiZitXQ25lSS9qRHpaVHBLaFpwL09zTzNG?=
 =?utf-8?B?MkNaYmtaWVhRSzdxOHd4clExRFdQNU1MZFBPUFlZam9ZZVZramhKcXpIL0lZ?=
 =?utf-8?B?VHBqVUk2aTJMNWlmRHp5WUU4M3pucnc0emJMS3MrdmRsRmRCYkMxdHFSWW1h?=
 =?utf-8?B?UTFNR2FRN3RNY2ZtSjdONjIzaGhKL3dVZkhFaWt3S0xqZXN2TUdSNkhhVGtm?=
 =?utf-8?B?UjZmc3d0U3VVZFhBZDZnYzNjY2Nxc1BNUWZaSnV1Zktrd0MxTUhYWHBCSTVw?=
 =?utf-8?B?Wjh1cENnVm1USVJCN3BPclY3R1krWWl5M3FkL0kxTzV1Vkk2R0NHeFo4d21K?=
 =?utf-8?B?VlhMTHo2SlBkb2Z2eDh5TW13aXprSzBFT3VDZmZ4bG50b2pnbTdtM0REQVNZ?=
 =?utf-8?B?MkY3WXYyTmJFVk96SkMxQk1obnlWSTdtTjU5bnc0ejVOcHJTUTVHd0hhS1hT?=
 =?utf-8?B?aFYyaTQzL3ltUEN1Z3BCekoyeTNEYkhiNmtQblpmZUpHbkxQR2x6Z1E0UzYv?=
 =?utf-8?B?TjY1dzY0aWNNYU12elVpVmdHVkRoTEJ2SjZNL1ZUdVdlRlA0cmxvc0U5emVR?=
 =?utf-8?B?LzE0OXNrNEtHTnNwMHk0SzBoMmQza3FkRXJCRE5LcTlGMGlUQWcySGh0Y2th?=
 =?utf-8?B?OHNHVFB5R2FGcTkvcHprMEE5RzRVT2ZWcHJaVWdINUplemV5aytpbHk4Y2I4?=
 =?utf-8?B?SFAyL3RKS1dKZXk2VnI3QUVtZjJMN2xrYy85Ly9GTGlEZGtCREZUeFBWSldP?=
 =?utf-8?B?VVJ2MlBoUnZuelArT0xjcFdxZk9xY0JNSVVORnBuS2lIMGFrMzMrU01PMmg3?=
 =?utf-8?B?TzRaRm5oZDJTd1hUYlFxS3BUYVhtM3hxNXRiTVU3bDAwdjBBUnU4RW1CRFZ3?=
 =?utf-8?B?em05TkVtYXIyMmM2Q2NheWVPMGJLQUl4STJPZXE0K2FVaEI1YjhJNVRsK1lW?=
 =?utf-8?B?UVUvWHhjdTB0OXEwUE0xRHF0bEYzcXEvckROTnhrMDFqYjNZSkRHVXVOL1Bh?=
 =?utf-8?B?VDBhU2ZqRTN0Nkprb3MwUlVzWG9pemtoUHpzSXJMUmVZL2ZOdTl2VUNpbjBx?=
 =?utf-8?B?N2RFdW82cDkwMHJBZDhLUG05bzhpZXhJTEtBV2dhZzViSzlhVkEvaHg1cm5M?=
 =?utf-8?B?UjB6VVpBNVgwWFUwVk5hbkt3bWNYU01pdyt2dkdvUjlGeG9IZk43RjlzbVEy?=
 =?utf-8?B?UDZqM3pOOTJJMjdRc3lMaVk0c1ZrUytabEk2VWU1S0VrZk9ENGNuVEo5S2Vk?=
 =?utf-8?B?Vld6VFZIN1UxUXJvSXdsQkdicGVHYkd1VmJueC9lRXQrbld4QW93c0wrSXlh?=
 =?utf-8?B?Nm9HNmhlZytYT0M0S3V2Z3ZVU1I1SC9jZGlEaktVVjdQYVRBbUZHSkdienZB?=
 =?utf-8?B?VzRCZHpJQmxreWFvdXNFWEtsM1FGcjg2T1dQbGZqWmI1My9FcnZKT3RHNlRl?=
 =?utf-8?B?S0Q1SnZacFg5UnRNMXM0Z0s3LzhEMVAxaEc2SW9lNkFkRHAvdE5PcUhvckJQ?=
 =?utf-8?B?ak9pdFVzM2RXeUI4TGc4Y2RrSGdWM3k2bHJzQkFsaXNuQlJkQ2Z3K2tBTTBI?=
 =?utf-8?B?UWkrSVN6N3lXRzlMQVB5TWpYWVJOTmNHUkRWc0h2a2krT3N5QkhRSGZXenh3?=
 =?utf-8?B?elBNWkpQY3dvdllteWs1bFU0MXJzTzFmQ1ZCd0pQWXBKalJwaTl1b2dpSG9q?=
 =?utf-8?B?aWJtbGYzSHVaVFVHQkl3UXRES2tXQkZ4VWgwRkF0WGRlaXlJeWRCc0pzQkdy?=
 =?utf-8?B?aHBHSWhyUk9TNElhby9yeXlib0QrN3k2bkRIaTRSZEhNN1h0bWFzaEFsWEhH?=
 =?utf-8?B?ZXp3SXJiRjF4cmVQRkRLSVovZm1hZXpCSlpERlhlb0U5RmNXenRybkpyeDNv?=
 =?utf-8?B?cUNpUnBIbDRkb2NHMTg2dUVrSzRtNWF1UTJzQ2djT3U4RWZabVBqSit0bXNI?=
 =?utf-8?B?MzE0UllDMStrMVp3WWJEb2hSQ0haUlpYdThZWloycUNES0pLMm9hS0xGTVlD?=
 =?utf-8?Q?iLJg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VGZOTmoramRnODRRZkdNWjdIL01vK29QdS9IdVU2VE9EMnEvaUM3QzZMR0hU?=
 =?utf-8?B?OURvRHNpTU1QQi9LYm9UeHBLYmVCRlRRc2NqOXBDMXNCU1o4KzFhVGFoRDJD?=
 =?utf-8?B?RWU0WUZuU3J0cW4zNkFtOUE0TU9LUmprUzAwaUlRbkZ5TEFnWmVHRFBBZ2g2?=
 =?utf-8?B?U0hZN3kyaEVTYkgvQmtmd2t1TjRFRFpBNTZsbE1XZjk5c3BRQ0F4Vnd2Vmhi?=
 =?utf-8?B?aWhVb1dPb2h1S0RPWWprd0tVS21UNDdWRDRaNVhTNHNqaE1ldk1PSEVOSitr?=
 =?utf-8?B?Qmc3Y2ZMN0ZyZ1NyV05IUitRVEYwTnArSnNEbjRjM1VUWkNvaUFUdlRtUmhq?=
 =?utf-8?B?NWdINXBnTVZ3VDFLdTdCMUZXZ09lbkV0REszYmZsVm1vL2o4QzUwQXBjNVFo?=
 =?utf-8?B?LzliR3BQU1c3VFZKblFiQzZOMjlaVXFKNzJWNWVmdmxuRW5ObFI3a1BSS1Z2?=
 =?utf-8?B?ZFFOTzdFK0g2ZjV0TndLVDJMOTR1RE00cDRheVRnYU96ZXB5ZFlzQXI1SUZQ?=
 =?utf-8?B?ZmR6Wkl3RXNGVHl0cngzSWhvY1BxbFdCKzNHem1wS1J6STNwMll1dGg1Vmhh?=
 =?utf-8?B?aERxR1pXY3RBdnJDbnhCUTRxblNDbGpXRkJCZ0FmTFJpeGI1bU55bVM4RUJC?=
 =?utf-8?B?WGZCd2RsYitwak16bVVpbW0wMnNreVhKdnRBWTllQVR5Tmg5czlrMjA3TWtI?=
 =?utf-8?B?TE9IZ0I0ajBuczIyYVI4RnRINk5VMGg2SWxla0I3OEJtdGpoSTc0OVpGR3dR?=
 =?utf-8?B?RWVMdDdBYjJaZUNoeU5BaWFsMXpuMDBWakVFa1J3bEp2WFlsWWU5ZVhJcTI4?=
 =?utf-8?B?dzhhaEJ0VnRZNjNpOTl4cU9tVktjeUdrN2xRbnJBNW5MczlZOXdGT3hDbk5z?=
 =?utf-8?B?R0szaXFwa0oyek5MZGNwempKQlVVUStSVU1EWjBCNUpLQmRveUgzU1ArTkNC?=
 =?utf-8?B?QXd4TzFwcm95ZnV2emF3VmU2UGtENVg4WXhzazRsbmNxbFc5TDVhM1R2RVZI?=
 =?utf-8?B?L2x1MVJXZVc1S29LLzZ5Ui9YSTRPbkE0SjJhUE43TGRlNnJtTXVGblBDR1Jk?=
 =?utf-8?B?YWE5aGc5bldWV0JUVFRmS3BVRVgyRmprY3FudXAxWGQ1UlhxRFhKZFh0N3pk?=
 =?utf-8?B?WXl5eW5pbDdDbVpCMkdVZExQRiswWVc3akVCZjdNbkt0MFB0ZXdNajM4dFQw?=
 =?utf-8?B?dDdMeHJhYS94NVg4UUxMUmhNdzZsUmFBSHE1a3JYV2RZWnB1Z1JrVVNuS2F3?=
 =?utf-8?B?SWptdDNtdXdLOGVNVGpTc3l2T3FoWXErR0tBWndlOXJaSHJDOUhIRVplVGUw?=
 =?utf-8?B?bnczOEVDc1dDWEdOUktWMTBJdURaRUQ1Y3c1eHREdlFjU1krWmo4cWczTXly?=
 =?utf-8?B?dDJOQTJmb3RHVjNGNWN2OUJackhWU2ZOMlhOaEZCeWlqaXpscEtrZlQvdGdM?=
 =?utf-8?B?NXJsWTRkUFpIOHYvZVBLNi9wbXltd29pWVZocGo2UDcrL3BVcEo4YUZBdDYy?=
 =?utf-8?B?clUvMkRHK0FBQnZmdjhJT243YXhqdlFqOElWRlJXWHhnWkt3dUJHaGFhMVl2?=
 =?utf-8?B?YXhjOVJhejBQdkZoaktFaFZzMWZVZ3BGZHZ1S0FhMTh5MUtoZ2VpUnI0UUdr?=
 =?utf-8?B?MEFXL2ZWWUFrN0tVV2FtbjFHalJSVjZpV1FCOHJPbGtlMmxqUzEvK0p6LzdI?=
 =?utf-8?B?ZXhpMExaMlVWeVlFR2NjWmErZTE4cHI4Rk1udkhRM1BnWFR5Q1h6TWM4NDl4?=
 =?utf-8?B?WFg2YVBwZ2ptc3ZUbmxSOWxpaHMvRUdFbzVKR2tCdUgxTnRUOFA2VzRPMnQz?=
 =?utf-8?B?cWZGM01nSjV5Z1JHVHYzUjQvSzVWd3dma0srb3VYVHpPL0VDRkl6MUlQOXRp?=
 =?utf-8?B?UW5QZlF0cDM2UHJobWJkS0cvVzJYYU42MVZaRUZqdDcxZ2xuSVlQMGNzOU1a?=
 =?utf-8?B?cjN2WHRUdHZRdk9ZNXlPVW1oL3VORTBnNTZqMFlRVWFDYnlQQUhyKy81Z3Yy?=
 =?utf-8?B?b1ZTK3BWRTg1VnFuMFFURE1YUk5sSXcxMmVOZXVaZDhDOHRrdloraU1XOWlB?=
 =?utf-8?B?dmdZNnRpRkR3TTZ0T294bXJUWHBBbHdic0ROZVdPcGNQZXJqWUl0MUtRWDFM?=
 =?utf-8?B?d1Q1eHc2U2o3c25EemhDYjlUS2d4NEZ1WkRuTWZSNWM2b2kxYnV2aFdTWjBx?=
 =?utf-8?B?dWZoVDdzejcwL2tuazRrSmVKaktMU1JkaEIwT1Y4YXdDaGphbTNLVURVcEVQ?=
 =?utf-8?B?Q2UxQndIU1UzVTNLMlNqUTdORHcxRC93MWk0eEE3aXVpZE8xRUpuV3RsYVVQ?=
 =?utf-8?B?ZU5Qa1F1bFArMFlXQ0Uydis5RUR1Qk9tUU9hRWxseDR4UjJwc0R2dz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2954b29d-bdbe-4dd3-ea0d-08de73bd2648
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 15:55:36.4553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQh7v9SVHR/+DeJIJOAEWfwbvPJMLVcUEatN1QbNUVPAUvyq1USrmWtpoWX8nMfbH7BEVlI6O0uhZe/A8bM9JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5313
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Feb 2026 15:55:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21923

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...6.1.159-cip50-rt27.bb => linux-cip-rt_6.1.164-cip52-rt28.bb} | 2 +-
 ...inux-cip_4.19.325-cip128.bb => linux-cip_4.19.325-cip129.bb} | 2 +-
 .../{linux-cip_6.1.162-cip51.bb => linux-cip_6.1.164-cip52.bb}  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.159-cip50-rt27.bb => linux-cip-rt_6.1.164-cip52-rt28.bb} (59%)
 rename recipes-kernel/linux/{linux-cip_4.19.325-cip128.bb => linux-cip_4.19.325-cip129.bb} (68%)
 rename recipes-kernel/linux/{linux-cip_6.1.162-cip51.bb => linux-cip_6.1.164-cip52.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.159-cip50-rt27.bb b/recipes-kernel/linux/linux-cip-rt_6.1.164-cip52-rt28.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.159-cip50-rt27.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.164-cip52-rt28.bb
index 5ddc44fb..d73e90da 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.159-cip50-rt27.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.164-cip52-rt28.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "1ed937388ae8cee994aa8b28e56fe38851f967b013acc6256d0dd564783dadd1"
+SRC_URI[sha256sum] = "db608e0a9cdba7acd288f8fb3cd4dbbac76feaa6a3d7adfb466b7b3033181a66"
diff --git a/recipes-kernel/linux/linux-cip_4.19.325-cip128.bb b/recipes-kernel/linux/linux-cip_4.19.325-cip129.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip_4.19.325-cip128.bb
rename to recipes-kernel/linux/linux-cip_4.19.325-cip129.bb
index f16d35e6..b5a261b4 100644
--- a/recipes-kernel/linux/linux-cip_4.19.325-cip128.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.325-cip129.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "5b2a2f4b702a458732d91cc549995cf6ebb374fae20f5192915be635eeaf3080"
+SRC_URI[sha256sum] = "92a2610abe7bff4988b8d603d9e4d118b26234635048a1172ab74fbae5b36b0a"
diff --git a/recipes-kernel/linux/linux-cip_6.1.162-cip51.bb b/recipes-kernel/linux/linux-cip_6.1.164-cip52.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.1.162-cip51.bb
rename to recipes-kernel/linux/linux-cip_6.1.164-cip52.bb
index f3310dcb..8a044e8a 100644
--- a/recipes-kernel/linux/linux-cip_6.1.162-cip51.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.164-cip52.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "b4ab5ade94bcfb0b0f1051b8266772a4c72020253646ec0b389f99c1d9d7d086"
+SRC_URI[sha256sum] = "d2ab87160abf545624e34acf5fa908325b99f324f9a4b1d4fe23f2f33389768d"
-- 
2.47.3

