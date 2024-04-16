Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CE3C4345F
	for <webhook@archiver.kernel.org>; Tue, 16 Apr 2024 16:32:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.79])
 by mx.groups.io with SMTP id smtpd.web10.25840.1713285156962264436
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Apr 2024 09:32:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NSvZn0Dm;
 spf=pass (domain: siemens.com, ip: 40.107.20.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnJQU9YsYcuR7Iw1qsXMyD/7ggXotBEGZXesBoFBbhTPlHCFS3EyGCiFBD+McoYMwhVHUmszvdAnHlkB1EwhzUHCUCqvEvLrhxWSuzCi8YJnLhJerKNvuedARneZnwBE9XyG1VNDXaroTXpIMVTR0mIlaBBk8e3re6qm6NZXUcLwOES8oMS+UE1W2U1CdwQzFrgS/gkFuU+ki3P+HewVrn5BkC7RRYkZTMx224HzZqRpCJSRrjrDK9pUOEXjBvUUtnbcsopzfmV283BMsP6tox33Jq58aSScvUNIXl8nq77E+sNHJ5AfpUpt+U3fsZJNEfThBWEyv+/BSW+iPnqV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAq+lWbQAam5/vfDXQjQ0RNq59rCIlDIL/mzSY0gT7A=;
 b=N8PAlpNz6FVXXzj8oEvDu71qOmA79sFMJPeu5ZUCZlU8ICyhaS01dIZgzViARSdTByrsanK1B5lO1I6a+sQXoL7JBxTd+Z5/nqwvveXehWpAWLUXesE0OyYM3fPqHDnaKkSZFh17g6KBCgSdDSqCESRkEQOXtGDdtb+jiF2GHDV03lksxlsqzCF8e5p+wrg6qK3+WgE/MwvMa4y59TfjAuxw6um2aQMfb+fimDe5wF8UzsghOBkssT9987zVmSafw2c1f/QVES+l6ZGyJIYUTUJKKU1jywwYeqrbfsrfLpi/VlV8+HtaJjhB+Jm8IaSc2QtccFzJwn1TgcFyp8CpPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAq+lWbQAam5/vfDXQjQ0RNq59rCIlDIL/mzSY0gT7A=;
 b=NSvZn0DmuYHb6Jo0WckVacI1AHb02q2kPpabQC8n1nIJrorZZMoCI8NBDV6OkuRkzHr+LFaRapWSzw+3u+ObEd2KBJS7w9B1O8jXzXnzgw8ehV5f9jUUtlETvzNlr+UkxsILNSbTmc9R6BO6x+048Q3+7i6inhY0/I8dJm92N9CqpgpnXAf+bxY6mvpH5OPxVKjMkWovQXKPNERGU4io1cFHhdL0xY1fLEdslM3abrqn5IWKx2XNQG7vrEx8joPqdNporo3UY4BQy8xZAvOYKx13YE8vKZR72+zu68ysCd8vJB/wktOXIZl7HLEfu0mMfjgevNqbDRuEqfatH6HbZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA4PR10MB5756.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 16:32:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 16:32:33 +0000
Message-ID: <25a849a7-f0b8-4773-b58c-422666ee97d4@siemens.com>
Date: Tue, 16 Apr 2024 09:32:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] recipes-devtools: use DPKG_ARCH=all for
 arch-independent packages
To: Cedric Hombourger <cedric.hombourger@siemens.com>,
 cip-dev@lists.cip-project.org
References: <17C5CC2DB0C515DA.10043@lists.cip-project.org>
 <20240413100140.2432650-1-cedric.hombourger@siemens.com>
 <20240413100140.2432650-2-cedric.hombourger@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <20240413100140.2432650-2-cedric.hombourger@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0149.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:346::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA4PR10MB5756:EE_
X-MS-Office365-Filtering-Correlation-Id: 81bbd90c-5bbb-4edf-064f-08dc5e32d0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uezQ8H4oaGRkHDiPbUBRs1ukbM/QMRneM+qXfJ0zxpWM8XlofcDIXNkupG/NUBVhMukfg0+ZFjh69d/lGhDFeRdoyQoru559hVMqbCA0JAx8AgqmAhM0yPq7Ql6BjZ1WNsCpDLxNix91Czv5Md2Jq9TlpNVT9uJquoDcRVQKwy2iUhOs4LwawguiHTXbF6cY8xFFMoxLl8+/Uc+a4hJpR/XXqnfcXZZ13+G+JbyHNIwTyBPaG/SJIfr1Gh2rJpmVhrjvUqFUEmDqIr23piYrnmj7BRGZotL+aiDjIX2YQXw4FcILSasFJPYvW3YnxzKNZTua5JmeaL1CpNoiKCuyUn3r5t336durnbCNa84wwxPsLJsGomtP94NACIwGkgzx9MedCbC72ksPe0na+4WS/XienJ4dVJ6j5WJNWOWZ0V5kcNfd0bWcp0mSQCE4nrMqZSsXMBrXFF/RGpP23JMEkwbDbCS65RoV1Ew5Z/BhlGDi9RrtOxtZb82wo86rnpjdkyW7748hYe6tTK5XNiiX74EEnTVZCVwqWRs/e9e++NMBQvn0R07L834524RVj9IlVGCAda1MRXgB0SvzFL+UFTeVJXIjk64nZ4L/CdH29yDrYXZdbiiTzfY7QUTvctmGOL1bU5VtKI4PO8OFxesNJt6A+izXkSqfw7xs71tQzNo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aUNMZjI3UFhBcHJwbFJQZHNvLy9PMDd1NkRuY1hhRWR6L01oRmVZS3pnQ2xM?=
 =?utf-8?B?YmlKT1dyeWkrdGQ2enViaFE2LzFIZ2dFYUhjM0pzTGhnZkpYSlZVM2I4ekl1?=
 =?utf-8?B?YW5iL1R0QzV3aEdsS3hyQmlnalF6bmUwM2s5SXdPdXhSaE9KeEFmWDBmMnYv?=
 =?utf-8?B?cW8wMXJiclVxSUZRcnNnVHg2bGd0NUVTcS94VmxNeFd3RXZNOEFjMnJkUGlI?=
 =?utf-8?B?YjJVc0s5ZTQ4L0c0SEo1cDloeDVOSU1SSzRPTG1vMHJmSmVxVHUyTTFGNE0x?=
 =?utf-8?B?WFlCMFN4ckROd25ibittYnZ0aWgwd3hQTkNrYy9mUHFYVU96cGJraDhNb2k2?=
 =?utf-8?B?SWZOVFhRNzBITU1vNGVieFRwMExFN2VqeEN3K29lYmQrckxSVHJoN2YrNGJR?=
 =?utf-8?B?SjN6cCtmdlRSektzTUhnN2hFcjU3ZjhuR0RWd1VOUlJiQTZCSnJqSHNEQ1VL?=
 =?utf-8?B?aHg0cFJKTzZyR2MxWUd0ZTBUMkQ0QTVaalVtc08xNWNrZDgreTNYUTNpVVpF?=
 =?utf-8?B?ODhKaUNNUTg2WUJnbDJjbjQ5K3BNK1VqK3RvbDh4Y1VrNllRRlk3ZnhmQjg5?=
 =?utf-8?B?VGV0YXUwMEZrcUtVdWtDbFpJUkZ3RURlOTgrQzZOWnloVk5QSDFzeUY0aUZE?=
 =?utf-8?B?N0Y1bDBiaDdZUGFMUTVWOFBJVzV0L2Vlc04rckFLRUxzR2lCWUxaMVdkNTFB?=
 =?utf-8?B?TWJ2VC80Z1psN3RzMlE3ci96Z21nMFA4VU9udG81OGVSeWF2VGthSGRRcWtt?=
 =?utf-8?B?Y2lzVXp6R2UwbzBPVGlBK1VVRVNoTGZKdTRpUFdHSEJ5OVdkNjZxZThQWXZV?=
 =?utf-8?B?d042bTZmczJzcHVFK25wUStBLzFqRjl6S0Z4VWNjY0xLeGl4VStvaTBYbjRz?=
 =?utf-8?B?bnF4L3Bsek5DeUZLc0RPZ1hkQTdMa2F2Nnpya2FObXpEUng2eUpGUXIyN0hi?=
 =?utf-8?B?TDV3UHFqaFJNTzdaUVFqOGNIWmhkdjVxZCsvRmVwWnAvUlhFOUF6M3NmaXli?=
 =?utf-8?B?VWZuamhsZUdjOGdrMlBGcmlDR0t6OUEzYnJCQkREbitRRkNkaFh3azdBWHhD?=
 =?utf-8?B?UmozVklORGI3M09BTFhqeDgyaWRHVGw2bmhZRnZxQ29oY3RLbmsrSDJISmRt?=
 =?utf-8?B?WjlUbmZET0R5djBaWUlrODBSOG05bHE3eUlhRCtFV0lPbUFoaW02TmVML2lG?=
 =?utf-8?B?MWR0aEFSazdzVW42UjhvblVDMllXdmllOU1WelBDMDhyRitqSDI1ZHUveE5R?=
 =?utf-8?B?UkhUaUhILzdnd0JYcXVtZGZWdFZSa0ZRUW9TNDkraTVzMHIwUmpaZlZORzhn?=
 =?utf-8?B?c1krL3l5aUpscHpnZkMvR0RlSTBhWXYyQUo1ak9NSGc4VEM4akFaNWJlY2pX?=
 =?utf-8?B?Vk15WTRTVGw2RWVPYld5S1cwdlJqUFo1TjluTVE0eU00QjFsZmhIY3AxZzcr?=
 =?utf-8?B?U0l6M2lDMUI4YWhiV1NabS85eXZiQ3Y4SFBoNm05Vy9GN2l5eTBPajJNaWVv?=
 =?utf-8?B?SFBmTUZ3U3pPeFdBOUcxVlpvaWFiLysvTDFQSGcyL0hPdFRodmZoSFF5TjZQ?=
 =?utf-8?B?QmNqcVRESGlYYld2aFphRzZyUlMrbS80b1lnOC8xOGRtQ0dDeHNLWm02cndW?=
 =?utf-8?B?VTlkNFFKcmpzc0NJMzNsZ3J6SDh5RTdEaGFGVEo5Vm1aMm1BTEY3bnVWd2Rp?=
 =?utf-8?B?ZmRTQ2RjQkhzRXJ0ZUpqaGJmbzc1R2FCQTR5RXh5V1I5WVphblc5OWd0blNF?=
 =?utf-8?B?aDQzWTlzdFBWVmZEMWRYOVJ3U0JJYVVySHJGcFNkNDl1Zk9sQUw0SnpaVE9x?=
 =?utf-8?B?V1RrWk5DMEQ1RzJuc2pobmtidzFoNUZNMW83VGdONnZReEdzUEJtRWdWdmpw?=
 =?utf-8?B?ak13aU42eVJQQTdBN2xVYW1rR1JNVVkrakprYVplVEFxMjF0Vm14OGk4dVVJ?=
 =?utf-8?B?bHFWQ0ZTMkVuNW1jRXgydXZ0cTg1c082b1lBcGhMa1pFQXNHYUpWZ1Q4bS9q?=
 =?utf-8?B?WG80cUlCU1lHdks4VTJUWmlUYXJXSlRXaWdWdnBnZFI2RitCbm84YlhQU2VD?=
 =?utf-8?B?S1JlMzl0ak1nNjNoRlVPWDZQaFpKa3JocFM4YXIrcnpxRVltdStDWHhWdEl2?=
 =?utf-8?Q?iZ19eotweNdRf+8XW4E3RTuWM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bbd90c-5bbb-4edf-064f-08dc5e32d0f2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 16:32:33.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41rENZPMpACxLkckTK8Uf8IKMxY+y67dHb4+EKDkqQiUcBJKDUF9sGN8yvhOMi3u/HEcVIyEMiNOYvK17jo89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5756
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Apr 2024 16:32:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15568

On 13.04.24 12:01, Cedric Hombourger wrote:
> Most devtools packages are architecture-independent and should really
> be built with "Package: all" instead of "Package: any". Bump PV for
> all affected packages (to be "apt full-upgrade" friendly).
> 
> Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
> ---
>  ...g-secure-boot-signer_0.1.bb => ebg-secure-boot-signer_0.2.bb} | 1 +
>  .../{secure-boot-key_0.1.bb => secure-boot-key_0.2.bb}           | 0
>  recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc     | 1 +
>  .../{secure-boot-snakeoil_0.1.bb => secure-boot-snakeoil_0.2.bb} | 0
>  ...snakeoil_0.1.bb => swupdate-certificates-key-snakeoil_0.2.bb} | 0
>  .../swupdate-certificates/swupdate-certificates-key.inc          | 1 +
>  ...-certificates-key_0.1.bb => swupdate-certificates-key_0.2.bb} | 0
>  ...tes-snakeoil_0.1.bb => swupdate-certificates-snakeoil_0.2.bb} | 0
>  recipes-devtools/swupdate-certificates/swupdate-certificates.inc | 1 +
>  ...swupdate-certificates_0.1.bb => swupdate-certificates_0.2.bb} | 0
>  10 files changed, 4 insertions(+)
>  rename recipes-devtools/ebg-secure-boot-signer/{ebg-secure-boot-signer_0.1.bb => ebg-secure-boot-signer_0.2.bb} (96%)
>  rename recipes-devtools/secure-boot-secrets/{secure-boot-key_0.1.bb => secure-boot-key_0.2.bb} (100%)
>  rename recipes-devtools/secure-boot-secrets/{secure-boot-snakeoil_0.1.bb => secure-boot-snakeoil_0.2.bb} (100%)
>  rename recipes-devtools/swupdate-certificates/{swupdate-certificates-key-snakeoil_0.1.bb => swupdate-certificates-key-snakeoil_0.2.bb} (100%)
>  rename recipes-devtools/swupdate-certificates/{swupdate-certificates-key_0.1.bb => swupdate-certificates-key_0.2.bb} (100%)
>  rename recipes-devtools/swupdate-certificates/{swupdate-certificates-snakeoil_0.1.bb => swupdate-certificates-snakeoil_0.2.bb} (100%)
>  rename recipes-devtools/swupdate-certificates/{swupdate-certificates_0.1.bb => swupdate-certificates_0.2.bb} (100%)
> 
> diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> similarity index 96%
> rename from recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
> rename to recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> index 57ad1be..83289d4 100644
> --- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
> +++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.2.bb
> @@ -16,6 +16,7 @@ DESCRIPTION = "Signing script for EFI Boot Guard setups"
>  
>  DEPENDS = "secure-boot-secrets"
>  DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
> +DPKG_ARCH = "all"
>  
>  SRC_URI = "file://sign_secure_image.sh"
>  
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-key_0.1.bb b/recipes-devtools/secure-boot-secrets/secure-boot-key_0.2.bb
> similarity index 100%
> rename from recipes-devtools/secure-boot-secrets/secure-boot-key_0.1.bb
> rename to recipes-devtools/secure-boot-secrets/secure-boot-key_0.2.bb
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> index 76233b3..859637f 100644
> --- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> +++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
> @@ -11,6 +11,7 @@
>  
>  inherit dpkg-raw
>  
> +DPKG_ARCH = "all"
>  PROVIDES += "secure-boot-secrets"
>  
>  SB_KEY ??= ""
> diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb b/recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb
> similarity index 100%
> rename from recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.1.bb
> rename to recipes-devtools/secure-boot-secrets/secure-boot-snakeoil_0.2.bb
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.2.bb
> similarity index 100%
> rename from recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
> rename to recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.2.bb
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> index 2c67e89..944c2dc 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -13,6 +13,7 @@ inherit dpkg-raw
>  
>  FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>  
> +DPKG_ARCH = "all"
>  PROVIDES += "swupdate-certificates-key"
>  
>  SWU_SIGN_KEY ??= ""
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.2.bb
> similarity index 100%
> rename from recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
> rename to recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.2.bb
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.2.bb
> similarity index 100%
> rename from recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
> rename to recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.2.bb
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> index 564dda4..d319d8e 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> @@ -13,6 +13,7 @@ inherit dpkg-raw
>  
>  FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
>  
> +DPKG_ARCH = "all"
>  PROVIDES += "swupdate-certificates"
>  
>  SWU_SIGN_CERT ??= ""
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb
> similarity index 100%
> rename from recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
> rename to recipes-devtools/swupdate-certificates/swupdate-certificates_0.2.bb

Thanks, applied.

Please tag future cip-core patches with "[isar-cip-core]".

Jan

-- 
Siemens AG, Technology
Linux Expert Center


