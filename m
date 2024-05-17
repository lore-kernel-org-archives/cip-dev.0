Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293D6C04FFE
	for <webhook@archiver.kernel.org>; Fri, 17 May 2024 16:07:36 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.81])
 by mx.groups.io with SMTP id smtpd.web11.44554.1715962053293380890
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 May 2024 09:07:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=t7gW6Wvp;
 spf=pass (domain: siemens.com, ip: 40.107.15.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhLXP0zn18M8OjbsUdY/CJPfiEdQyj7H/WNH2MYq2e8ABy8DIhzW0XPfAm4k0eDxVMAWJ0MAB+BA67Bx8R9CpXS+sHaRBMtPqxI82pFbyqqJzZChDN2Efkf1hq8xagJD+R71r1Mn039Xo3FT4o6rdByHyUtnrqRs/P8pfozsd8pbW8CQNNUEp0uuDpVRqFAlzoqCU716OLP1UShhNiy+xF1vgx/orjMXCUehWcLR0eDNw9/2LNLrLUbTmmw7OsTb443E+M9lT1tbEwe0Gj7E1lSznQZ8LBOR30pnGrCJtnL7ledX2N1FIxcaWcxetH9mzxaQUNoxumtrxWWtZq8EEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBmRXYZdA33IdyPU66XP5YJpH36mrLIbvDM0fS5hj78=;
 b=H0aoI41aUzbFfsM4kJyjOLAFCuZGEC+8DlrMyxw6jC/dp9EUUsE32irN98khujNBb8ttxyPIuw5i9BGYTMOZrN/dZ517FsYF1+RgFhEbYkelZp20jlynh8YIqwC3h16CMRIMXgU7nrAP/JqNwi6DhLnEGTsV/8L7/eDmOSj+oeJQDHdFqH6JXkzUWOrEUdhlW2VB1FCkeWhpUtd6gPAwVkMValGSGDJ/B5JmgfYniEiLSGGm+eontoD94jBNEfFiD/47nHgJ+QuptNPnvVf4Dix3VW2Ngr3iYyEgcyE7P/OmbzHr9+xjcxC6DxIEGj1GzX2cWrBoMmhti846hlhuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBmRXYZdA33IdyPU66XP5YJpH36mrLIbvDM0fS5hj78=;
 b=t7gW6WvpAgpmPwFmzosfp30AGyF3vbhmzokQz9w4bCySKDugqqkqVbSimhjwSRtw2ac6WLx+ikYoF28DfLcDNMRf6GI9KwkBuVmdrDNgz/cgIUlUntP6ntVQnvBOtE65jhaaTyC3qfMR/2TO7j6ymeaXtPjt2gWN4Nuz1Y8EvCR7aPrSL+ShXtkD8bz3YYbKtBg5jA8u1GU4IL4FkCohgSIOFinGjOJIUXCCukz6tG1rrGRj7MwinFP49tK2NjSFzCJFTch9foGZPnpFYquTFpsW9BnbrgPxY70SJ+jqQ3zhDXt3hg2CuB+TUO2LOl5ZHbwcYOC2DiWQxghTi6tNUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:301::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Fri, 17 May
 2024 16:07:30 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 16:07:29 +0000
Message-ID: <075ca777-ce0f-44aa-bbb5-4c5645fdb02d@siemens.com>
Date: Fri, 17 May 2024 18:07:23 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core v2][PATCH] Refactor tar.gz image option
Content-Language: en-US
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0053.namprd18.prod.outlook.com
 (2603:10b6:610:55::33) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7617a9-9778-4dff-e422-08dc768b738d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SUw2OVhKRzh1elZ5ZmdUdTRKaitFY2pMWXZvN2JmTXd6ODM4Yk5UMlhVSDhW?=
 =?utf-8?B?aUNPQXJRMVgxbDlKVzdXRXd0NTVWbnVubWJqUHpkbzZqVlB4SUoyQldGM1Zs?=
 =?utf-8?B?NkVWV2VPcnpwYmpqYUpFOVFWSFFaRTZXVllJSG9pdUR3c3lWaFZvZHVIT1Jt?=
 =?utf-8?B?QkgwTHhXYks4L2RiL3pjRmhmL2ttdEFsM1lwTzcramp1bVhlSmhQTzB2SmF6?=
 =?utf-8?B?U2ZHMXM5VDM5TE43dGdyUFFwU0JJRFV3MER0c1h3ZE43aUw4eWxDTXNjTUpS?=
 =?utf-8?B?YU1GU1VTZnhYL0ZBMVcrSUZ5eHk0RjZ5aVZIcG9qbkIzMjRzSTlKVElVclhE?=
 =?utf-8?B?bXFvY3dteGF0VytmLzBlc0xXcEExdCtEY3lDQkE2czhjVmN1ZXpubUUwNUZr?=
 =?utf-8?B?ZkpHSnBnZktzUG5WMnA1ZmZNNkw2eWRZOTl2VzdSa3dHTU02bjVHaEEzUE5w?=
 =?utf-8?B?Vkt3U3h0M0hGSWsrSmY0MzRqeGJNREVwNTZqQkUwVzdVNDQxTG40N3lvVmFH?=
 =?utf-8?B?cW5Mcy9LY3BudW5uYTBWNldnRVM2aVdxK083TkpxWTlGYW81c2dxbjl5am1o?=
 =?utf-8?B?RVY5MXU0ODM2aG5jWnlZcGl2SVZxK2dOemQ3TUsvaG01SUZYY3NNV1htZEx5?=
 =?utf-8?B?RTN4d0VIbWtTVjdFYXRwZHQ4WjJGNHFxRStXSUFoZDR5MXc5NktRMk9zeGl0?=
 =?utf-8?B?dDFxZ3grWDMwTFJWY1VuSE5NU2dNSUt0cXhrejVxYUFHbW1kcXlTNEtLR1lF?=
 =?utf-8?B?TFErMjhtUk5nd1lhR2krYTlZRisrT1kzMlEva2NFbjc2eGpBejJXalI5cG5R?=
 =?utf-8?B?YmJUd3dxQTd4TmY2RWViUFJDd1QvYXdCOGZwdFQyRGkrdWpWbnY1UEIxK0xr?=
 =?utf-8?B?VWRQbndycW1oMHlubkJYOE1TWWVDRVJ0SS9KNk53clQwMys3OUVKcVc2T3py?=
 =?utf-8?B?S0V3TXlyc2ZlbmpnR2I2dENpR2hmK0tvODN1L1dIVERlZGNVYjlsQldQYzZa?=
 =?utf-8?B?bGtpak5ERXVuS1FoOFdEUmxnc1VIMUpzeUFMekdMaGw3bW9YaU5IQWcwWTln?=
 =?utf-8?B?emV1UisyT3pTYklUM3Y2cXBVV1RrN0x6VEYxeFppSzBLem1IR2JPQnk4Q3o4?=
 =?utf-8?B?L3h0ODhsdytlMU9MZ2RBRzhWbE5vMCs5MVh2ZXU3aHM2WHN2YlorQ0ptSnZE?=
 =?utf-8?B?MWVqQ1JVQ0ZBdkltSGgvNm02UTFQa2xmby9iaDZ1VEg1VzZVYzlCUENYS2dq?=
 =?utf-8?B?TloramV4VXVhdW5QSTFYK2lqQ09XeWp2VWh0OXEwODJocXd4K1dyWmUwYzlm?=
 =?utf-8?B?NllYNDhxdkhlWFlFU3dZeVJ6c1lMTVFJeDJ4Y0tuWjZ0dDhZMzBEZzJTdzF3?=
 =?utf-8?B?R01LN0ZFUlR1N3MxU1RXQ05RSkZvSFdMTHR3eEZGQXN3Z1VYQnlWd0tYQnBy?=
 =?utf-8?B?Z2pQb0VXbkQ3aWJpcXhZcWVkVUJ5V3liZFVTSFBLODFiL05pR0JGWWlJeGl3?=
 =?utf-8?B?YnYzZXVpNlNuTkt6NllhRm9MUW9ieTVPRFFSKzA4K1Q2Myt3MytwSVMrYWNZ?=
 =?utf-8?B?UE9JTHV5Qzc1bitUN1E0M2E2ZTZlQXdvQU1ibEpCbUFBMUlYZkRIeG1Da25s?=
 =?utf-8?B?NkgyVkNpWkR6RjYvYUM3NFpkb0RVQ3ZPOTd5c2JVOEV1VDR6aWE3NENkc1VU?=
 =?utf-8?B?S0NsM29WMjFpaDFsTXJHUmJoSk90ZzZZM1F4UEVVNEFnenc3WlgzR25BPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TW5qTkV3SjdyRTEwVHBjeG8rNERSdU8wWThHOXVya2F5U3ZvV3l4Q216RVdE?=
 =?utf-8?B?V010T0Y1UjlZVWgrcW5PczZSUW5uY1ljRFdaV2tzeWowMWJ6Ylp3WmlKdWNY?=
 =?utf-8?B?aTE5RzlKT1dnYmhacjVERDhNTThSTG8vb2dFc3VqeGRVQmlFWngrT1Y3YXd0?=
 =?utf-8?B?Mk1aSzZGTkpPQ1JWb2xIU25lRlczc2NNQ2VGRHpGbmt4blZCZlhjbFlUNGVV?=
 =?utf-8?B?Z2YvVFB2cXg3VWoyd1ZPU1hCV3lYYnlZUnNreGg0SW5jOFI5aUt3ejFUVkRw?=
 =?utf-8?B?Z3hVSSs4Y3Z0R1hnQmJFNmNqVDY1RzF2enBNVWgrODVzVmJoMlROMk9oVFdn?=
 =?utf-8?B?Q1dxdVdiRzFtK2xDeDJydHlwZFVjNkZWcHFGdENsc1FCZG9Pa1JyMkZ0bXlm?=
 =?utf-8?B?RDRDa3NpNm9yUzR0bDdwak9TV1p6WkdaNHFXTlBQWnpEemthZGNPOFBzdVlr?=
 =?utf-8?B?dDdwZnA5Z2VLMmhiamVmY01hK1hsN01GU0J1VW14K1RNR3ZXZmh0bStQczFJ?=
 =?utf-8?B?NGdScHUyRjNGWjgzMjI1NjYyYUNkMThRTHNzVFk0dEJiZHR6ODk1ZGZhWUsy?=
 =?utf-8?B?TnhDSjU4WFJOWFIvLzhIOGx6eVRyNzRJS2Znbk9yQ0VKU3VLNXEwcnRjWWZz?=
 =?utf-8?B?QXNraXd3WXBrQlBVR1BVb3NRQ01WbHpRMHhjT3djTGdzVG5jM1Q3VnRYZU1G?=
 =?utf-8?B?QVBLTGQ0NEZxaHMxT0VMOCthKysyeG1WSVBkTjY2WTR1MmpjMm40V2ZTaTAw?=
 =?utf-8?B?OUs2STUzVGhNTkpQK2lHV1RWQmdBZnovb0NWOTlHelJxRkJxUzVDVVhFTkxL?=
 =?utf-8?B?VFcrSG1kTzNFU1ZHME1HeEQ5dnZOdkZ4a1NMazlyY0xBakFOUXRqUnV3NWpG?=
 =?utf-8?B?Wi91aC95TjdsVUJFNTVDZXY3L0U3Z1pJYTdRd0dONmFpSDUzV1BZRkMwTGl5?=
 =?utf-8?B?S1hTNXBOZnUzVzQrM1hwck82TnFsZ2RNeG1ya3FpekZBVkY2WlR1VGhLc0tO?=
 =?utf-8?B?aHJJY2VuWjM1U292ZEt5b3cwRHVpRGhsY3FMOUhKY2I4SXRPeGJzVlV4dGpy?=
 =?utf-8?B?TGpqUlRFcE5MWEU4U1pyNGR5eXlmcENocnlXemJFazNGOW5CbkVXeUxWRlBt?=
 =?utf-8?B?OGVMbTBUa2EyWlVpazh2VTVYMW9VOTdxSjlLdzVkdFhMK2ttVDVCZjlNaXFj?=
 =?utf-8?B?aktaN2R5K2llNm56c2p4N2VNOWgyQnNibncvbGNTYVM2M0YwVG9jSVEvV1Fs?=
 =?utf-8?B?WG03Zm1oR1loaVFCTWxNSDVvNm5xbVJBUFhPb2U1K00zbGZHUU9uUXBUcWlB?=
 =?utf-8?B?NDZzWlRXTG5KVXVsWW1HU0tJVk45YklWVXRmc3FseXpNbktaVm9nYzlyUmhN?=
 =?utf-8?B?cWpISG50WWpKeEIvZ2M4a0RrRE5Od0w1ajlSZlcweS92cFpDSnJoT2FJaUlW?=
 =?utf-8?B?YmhGZ08xWkloZkZucnJKV21PYzhNc2hqbFppMFJHRkhhd3RWVjFiK05CQkRR?=
 =?utf-8?B?ZmJoWE90dDNYbVgySGRPUU5TdXNDT0dqbkQ3ZGhDTE9LUTdtb1RBekg3clFE?=
 =?utf-8?B?Vml0MzZ6V3U4UDNqSUZRaGwvaEtlTmtaeWxQUEVXSU5VQjhSZHk0OHhkcW9n?=
 =?utf-8?B?cmlHcFpQMXlvbVh1MXVzdVFvRnZsdGVCY28yMFNjTHdGSWpFdGVRdWFwVXUw?=
 =?utf-8?B?TnJsMlA5aGRLVE41c2dkNTV2RjdVaHpyei9FU0RJNTJSQ0FhV3Z3Vy9XSEtr?=
 =?utf-8?B?b1FJRFIrWEZVQ1cwYnlPU0NwTGl5OUs4Y0U1aFA1aEpROHdud1U2SGVpVWVx?=
 =?utf-8?B?STZvSWszNitlMTV6ekxaei9VdXVqT2cvSzlqc0FDN2JIa29uMlZBQ0V5Ky9x?=
 =?utf-8?B?a3NNeWQ5TFk5SE5acG1KV0NPSHBSTnUreWMrbmZkZVhtZWFjTFlQTWZiK1VI?=
 =?utf-8?B?dnhqVWRFKzB3eVM3UDFXWTRPN1ZlWXBvN3czMllpSWI1UVpOM2VZdjNZUjdl?=
 =?utf-8?B?ZlFlT3ArbEtsMTVaZC9WVVV0VUtkSW1EYUFuRXc1cHgzUTRRSHhVNmgxRHV2?=
 =?utf-8?B?eVdUUlRLT3ZqQzVLM05WZld4d0YwNFZVQjN1L1p5UzBpTGljbTlWSnVvakxv?=
 =?utf-8?B?ZG5yY3M1YnM4dkd1ZklBekx0aUNYemNyNTlXZWFNamR2alFDK0RtN0FUdW50?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7617a9-9778-4dff-e422-08dc768b738d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 16:07:29.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xz+NEEqOYOcW0BM5b514VeKYVln9VoMNo88U5t98cGRhiblrTllQ0L6kXEGtRumK7Ww2tga5zn8iJNb3CbfdFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7930
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 May 2024 16:07:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15912

From: Jan Kiszka <jan.kiszka@siemens.com>

We have wic-targz.img, we have targz-img - that'c confusion. What we
need is a way to say "generate (also) tarball of the image" so that we
can feed LAVA specifically. If the normal target image is wic or already
a raw partition (simple QEMU targets) should not matter.

So, consolidate the kas options and the kconfig menu. Furthermore,
simplify the CI options so that tarballs are by default on and turn it
off actively in case that format has no user or cannot work in the first
place.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - fix kconfig menu, making targz now depend on the absence of swupdate

 .gitlab-ci.yml                       | 40 +++++++---------------------
 Kconfig                              | 27 +++++++------------
 kas/opt/{targz-img.yml => targz.yml} |  4 +--
 kas/opt/wic-targz-img.yml            | 20 --------------
 4 files changed, 21 insertions(+), 70 deletions(-)
 rename kas/opt/{targz-img.yml => targz.yml} (71%)
 delete mode 100644 kas/opt/wic-targz-img.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 72084f33..b4291d0d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -20,8 +20,7 @@ variables:
   extension: none
   use_rt: enable
   encrypt: disable
-  wic_targz: enable
-  targz: disable
+  targz: enable
   dtb: none
   deploy: enable
   deploy_kernelci: disable
@@ -58,8 +57,7 @@ default:
   script:
     - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi
     - if [ "${extension}" != "none" ]; then base_yaml="${base_yaml}:kas/opt/${extension}.yml"; fi
-    - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi
-    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
+    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz.yml"; fi
     - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - if [ "${release}" = "bookworm" ]; then base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
@@ -111,8 +109,6 @@ build:qemu-amd64-base:
     target: qemu-amd64
     extension: security
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     build_swu_v2: enable
 
 build:qemu-amd64-base-kernelci:
@@ -122,8 +118,6 @@ build:qemu-amd64-base-kernelci:
     target: qemu-amd64
     extension: kernelci
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     deploy: disable
     deploy_kernelci: enable
 
@@ -134,8 +128,6 @@ build:qemu-arm64-base:
     target: qemu-arm64
     extension: security
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     build_swu_v2: enable
 
 build:qemu-arm64-base-kernelci:
@@ -145,8 +137,6 @@ build:qemu-arm64-base-kernelci:
     target: qemu-arm64
     extension: kernelci
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     deploy: disable
     deploy_kernelci: enable
 
@@ -157,8 +147,6 @@ build:qemu-arm-base:
     target: qemu-arm
     extension: security
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     build_swu_v2: enable
 
 build:qemu-arm-base-kernelci:
@@ -168,8 +156,6 @@ build:qemu-arm-base-kernelci:
     target: qemu-arm
     extension: kernelci
     use_rt: disable
-    wic_targz: disable
-    targz: enable
     deploy: disable
     deploy_kernelci: enable
 
@@ -211,8 +197,6 @@ build:qemu-amd64-test:
   variables:
     target:  qemu-amd64
     extension: test
-    wic_targz: disable
-    targz: enable
 
 build:qemu-arm64-test:
   extends:
@@ -220,8 +204,6 @@ build:qemu-arm64-test:
   variables:
     target:  qemu-arm64
     extension: test
-    wic_targz: disable
-    targz: enable
 
 build:qemu-arm-test:
   extends:
@@ -229,8 +211,6 @@ build:qemu-arm-test:
   variables:
     target:  qemu-arm
     extension: test
-    wic_targz: disable
-    targz: enable
 
 # secure boot images
 build:qemu-amd64-secure-boot:
@@ -240,7 +220,7 @@ build:qemu-amd64-secure-boot:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
 
 build:qemu-amd64-secure-boot-encrypt:
@@ -250,7 +230,7 @@ build:qemu-amd64-secure-boot-encrypt:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
     encrypt: enable
 
@@ -261,7 +241,7 @@ build:qemu-amd64-swupdate:
     target: qemu-amd64
     extension: ebg-swu
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
 
 # secure boot images arm64
@@ -272,7 +252,7 @@ build:qemu-arm64-secure-boot:
     target: qemu-arm64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
 
 # secure boot images arm
@@ -283,7 +263,7 @@ build:qemu-arm-secure-boot:
     target: qemu-arm
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
 
 # bullseye images
@@ -312,7 +292,7 @@ build:qemu-amd64-secure-boot-bullseye:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
     swupdate_version: "2022.12"
 
@@ -342,7 +322,7 @@ build:qemu-amd64-secure-boot-buster:
     target: qemu-amd64
     extension: ebg-secure-boot-snakeoil
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
     encrypt: enable
 
@@ -354,7 +334,7 @@ build:qemu-riscv64:
     target: qemu-riscv64
     release: sid
     use_rt: disable
-    wic_targz: disable
+    targz: disable
     deploy: disable
 
 cve-checks:
diff --git a/Kconfig b/Kconfig
index 600e568a..62be071f 100644
--- a/Kconfig
+++ b/Kconfig
@@ -151,23 +151,6 @@ config KAS_INCLUDE_DEBIAN
 
 comment "Image features"
 
-choice
-	prompt "Image formats"
-	default IMAGE_FLASH
-
-config IMAGE_FLASH
-	bool "Flashable image"
-
-config IMAGE_ARTIFACTS
-	bool "Separate artifacts for NFS boot"
-
-endchoice
-
-config KAS_INCLUDE_IMAGE_FORMAT
-	string
-	default "kas/opt/targz-img.yml" if IMAGE_ARTIFACTS && (TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
-	default "kas/opt/wic-targz-img.yml" if IMAGE_ARTIFACTS && !(TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM)
-
 config IMAGE_SECURITY
 	bool "Security extensions"
 	select IMAGE_DATA_ENCRYPTION
@@ -186,7 +169,7 @@ config KAS_INCLUDE_TESTING
 	string
 	default "kas/opt/test.yml" if IMAGE_TESTING
 
-if IMAGE_FLASH && !KERNEL_4_4 && !KERNEL_4_19
+if !KERNEL_4_4 && !KERNEL_4_19
 
 config IMAGE_SWUPDATE
 	bool "SWUpdate support for root partition"
@@ -242,3 +225,11 @@ config KAS_INCLUDE_FULL_ENCRYPTION
 	default "kas/opt/encrypt-all.yml" if IMAGE_FULL_ENCRYPTION
 
 endif
+
+config IMAGE_TAR_FORMAT
+	bool "Separate artifacts for NFS boot"
+	depends on !IMAGE_SWUPDATE
+
+config KAS_INCLUDE_TAR_FORMAT
+	string
+	default "kas/opt/targz.yml" if IMAGE_TAR_FORMAT
diff --git a/kas/opt/targz-img.yml b/kas/opt/targz.yml
similarity index 71%
rename from kas/opt/targz-img.yml
rename to kas/opt/targz.yml
index fd8303e4..5c0b87bf 100644
--- a/kas/opt/targz-img.yml
+++ b/kas/opt/targz.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -14,4 +14,4 @@ header:
 
 local_conf_header:
   image-type: |
-    IMAGE_FSTYPES = "tar.gz"
+    IMAGE_FSTYPES:append = " tar.gz"
diff --git a/kas/opt/wic-targz-img.yml b/kas/opt/wic-targz-img.yml
deleted file mode 100644
index 74053f52..00000000
--- a/kas/opt/wic-targz-img.yml
+++ /dev/null
@@ -1,20 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-header:
-  version: 14
-
-# lava uses nfs to deploy the image. For this we need a tarball instead of
-# full image
-
-local_conf_header:
-  image-type: |
-    IMAGE_FSTYPES = "wic tar.gz"
-- 
2.35.3

