Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46C2C982EA
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 07:02:29 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1598.1790146947240338063
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 00:02:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QyhhhYSb;
 spf=pass (domain: siemens.com, ip: 40.107.162.0, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vv5lPTdIIZDANIvPWbOeJa9fU16MDO8iFEbEEi4aoxFUnqtqsuKcJdQdF1666E5y20pWuyUFHMbqDu2vp9A7FHtCpH2R4CPz6h2Ob+nRerzWQO++cdyQdw+bKT2bIthSpnaIK5yR8F8lUCL+CY3VLVJPzIG4552DXfy6gQaRBr2Y9rJXx/jLn4uNzJQgy4MkEYB2xOF95tqGnJXeLI1/+4OeQkpMqJrm+TLW0RgtmgH0M3TdOCNJn57RP7k4HD6Lk7HgSHzKZuzYQ7RSQZRE5pIzmMM+HP4CP3RpF0ur9zRuhpY8UyufHZiIITq+IBl9wazDGKQ9dc1/KtAcnuB1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LD431CXViw1CenM1OwujnVDqLA7QPm7+TPViWreacw=;
 b=l6ycDHVp/xI3pwt7aS5qdC+CpMSi2Orx7lJ2nKM/VUxhgTKDkHj8rmIen/yiVetfpD5ODBudPLgeh4sFc3cbT1Mqrq9DrcJn++1Rp58A5Bo1R1EIW3TtPTJCR6b/qzM+GV/rcu0Vz5l6KbtBU9wFO2CLCuHHyVbtpVU/Haw1/29UfMQeCUhgUH0hrJJ9Yy877VjEJIs6XLrQIme7K1ukSvTYUa3XQDXwHxq0SVNTVfg3ZWAmNb023RHzgcZq5gQ1uZbcxqMfZoPDUcmoXf3VM38Ixq2QWv8RWKawJpHNerpqFRf2u5hgeJ/ee/FhStzWi+O6NP4kBppNyEla0s6C0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LD431CXViw1CenM1OwujnVDqLA7QPm7+TPViWreacw=;
 b=QyhhhYSbo5gZGJrlpGBJZxEEU6XnvCJp51QU9xA42jpYZtP/rOiFqsDS2bHpC3Mr/rb/MdfgVSkSBv381uXV6PSlV1myBXKmn7xiHT1746WhyOO9WZFNw3/P4RZVTY6C9n3L6Xks8nFcG7KCZd1qci4S3Teivzcn2tUMJ0cySVYUdGXRSns9yQJ6fPkup9Ozq8846ZU5FkKGgT+9GtSRvYlVkpm+daJfMK1YGCV1GtNA1VkRWDkFFJOfn1rI2La//coI8IC/ef+BWno1gZUbvIdgW+VqkReMWTpLhuW81dKMdKLTEM+Y4xPjk1IeeYycONNcI850lX32uWE8KY03Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 07:02:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 07:02:18 +0000
Message-ID: <1ea74cd1-7343-48c4-9359-af364dd205e3@siemens.com>
Date: Wed, 23 Sep 2026 09:02:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 3/3] initramfs-factory-reset:
 Ensure that '0' disables the TPM clear instead of enabling it
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, alexander.heinisch@siemens.com
References: <20260917161425.666709-1-quirin.gylstorff@siemens.com>
 <20260917161425.666709-4-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260917161425.666709-4-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: e3752905-a20e-46a4-5bea-08df19409afd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Nj4jmpjASagylq0loulUbRgMbrczAgoxek0cte4RN4HNQXZ9bnrmRlqZV589v1QcF2UaloD7BvWn8BgNXocx5aQ6CCH0a30x2f9KLD46KK6n/cbB7UxtVQ8HuY5XgTutqyV6TWPBDtejINz3KZPHLNq0lQWzp35L89KsiDfZXFyVnygWYCn32TUFsaBEeU3HZ2zZ+hqRwCwVE9Oh0YuiOm/k2baG9tLOC+ezNkvF/+zD7vR+JPn4ZvOy3ibk7nna4Gizb7cUVFQ4qhcprKl8Khh5qVuT70TkLO6AD6StMfnQyBQVapHOL/wk4VMqE7YWG3lbhSRV18lsBbO9Ae30ONsJ1Q8OUFkiV4xrFlFsslWTSQkqoDwhb+Sg2ZWGMmNMvcrdAzOQAcndGAVh5ucy9+hKn7r2RWG++JBismUdy2kUkSDYyD5Bb0EPTrt/10uaByWWNflo2gahuohgnvxYOtin5b5tZK3TOIDhOLkBQjEOryag+dTLh7S9TkxuxdlGwud/vMBEqQtch7WLvOW110hVSRuXc1LkFYGGzC07nROEyj+9mNJAl+8UmvDLb8f6PPj4N1uW7N6F8d7mkFS6hZJiBEenjiBV31bWliFf1p2qZWunM57QN32Tz4CZKNpQENEawvyi3UjDnGqxZxI5yd1q+LS2YAdAsaOfesY7N4M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXNXVlN0OHhyM3ZKbVJEMStEN21RcEM3MXk0Y255L2xSaXVsZ2loQVRLVVc1?=
 =?utf-8?B?R1NJdUxGa3BGTG1laTM0WHNPZmw5ay9CSHBNR0dBbGx6WHVWblpEVEErelB5?=
 =?utf-8?B?N283cWZ1OTV2QldmSTV3dlVvUXRLcHNuMnBDdGg3RDk2NjdkNkhwam41OEw2?=
 =?utf-8?B?bU1CSXlmempMVjFLajdaeSsrcXpHVUdSWEk3V0pKVEJ2endMbk92c2dUOWdX?=
 =?utf-8?B?TFZpTXkvUFlBenlRR1g3Z0ZCQ1c1SUtOZ0ZFeVJBRmg3M3laQ25CZHpvcVNx?=
 =?utf-8?B?RjI5bDFIT2pZVUlhWHIyUlltcjlzZ3JrYlNyd2l3RkdYelJKVlJGWkM1aFRY?=
 =?utf-8?B?TmRtTkF4ZytxR1RPS0t1SmxoVnhteXRvb29VL3JsZVdSZmZKNUV5ekJtYnRz?=
 =?utf-8?B?TElsandncVRHVk9PUXBUaUtISTEzUVE2UzJONWo2aFJFZzk0SHlhaElxa0RW?=
 =?utf-8?B?VGREeTl5dU5CU1p3TkhacklvM2dlZjdBWjUvcExqV1RYTGFwZTVJM2c0b3JX?=
 =?utf-8?B?MExId1YyUklWL2tUWGsyT3dvWHF4b1kyT0hlNkg2RFkwN3BnK2IyS3hzTFBt?=
 =?utf-8?B?TVA5MmtKbm5kY1RaeG9VNzVuV2V2Q1hGN3BsK3pKUVR0Rk1xeXFYOXFSeHBJ?=
 =?utf-8?B?Z1pHU0lSMFlqMncxc3BBU3VqVXFnazF1eVl3MlA4S1RXcmlBMUJVR0RIZG9w?=
 =?utf-8?B?dERTNnJJVXFyNU1tYWNCd0dhSUgvODhMT0hpWFcwY1J5TnRtT01jb253b1dK?=
 =?utf-8?B?NVVTc3F2VWhCT2pwb29abnhXL0dWNmI2RGNBN1hUcVFyakpLTWtvTk9QTy80?=
 =?utf-8?B?VlA0ZEdnbXRoWTRkOHMrbGhmWXNxZGtGRmI0djlqVFFPZzlPa1M2RDlrd2s1?=
 =?utf-8?B?N1U4djVEVHRqc09jMjU5RkJONEYyd0REU2JXZHZCNStXSEgwR05OSmhIQWFC?=
 =?utf-8?B?WGdLeFQ2QlNoaldBTUozcWw5TUN6QnNFM0JzZVNzYVpGUStuK3RRVzRvbFdi?=
 =?utf-8?B?WFlLVkYrTk1WNG1yV3FrbVM2ejh3d29QVnBMQjF4OWpRci9DV1FLU3BUZWlN?=
 =?utf-8?B?aGhMTzg4eVAvZTd5d290K3hWdHoxbTBOem1oVW4zZTYrU1BWRWV0aGdDME5U?=
 =?utf-8?B?a2FybXM1UmxlKzFrOExSQWV5Z0xuR3Z5UmVNbmZuWm1ReEhiNWhPQ2Q0ekgr?=
 =?utf-8?B?VlUxdituV1NaWVBKQWFTbVczZGt6Z1hiZmpUakc2ZnlRQndnb2Rqa1NXZDI2?=
 =?utf-8?B?bTl3WjlPZnRGMUFtdGYwcUJUaVJScWRwYk1yc2p6ZDBrZTNrTzNsdkcyVmhU?=
 =?utf-8?B?ZG11enc0ck9Dd0YzbkFMa3p0NVdrWnp3RDBNTTdMWWNnOTY4RzZMMHVhVXgx?=
 =?utf-8?B?UU5uejh5UGxkaUI5QThNRWV6WUZjYktUc0UyZXpOZzV3RkRGVUxXOGkzS0lU?=
 =?utf-8?B?N25CSEI5WFZLN2RmVlZwbjU1TjZtRW93MW50cUdqVHpMNlRUYXptNkhNeXh2?=
 =?utf-8?B?Zjg5eUVUNmJveXRXb3lUeU9DQmNhT3EranUyRDh4djRCS0JYRFIwMGpTS3hY?=
 =?utf-8?B?THplR0tERDk4bHY1aUZycWF6NWd3ZXBTeDNId2JndDJBZXFOUThiOTVoU3JZ?=
 =?utf-8?B?TmNEU3JiUUpDanI5WHRUUVFUSjBIbTh3eGcyK1JxYjVicWlPRERudzA0S3NJ?=
 =?utf-8?B?V0NiM1UzR2FRUmdYMVhWWkFieDZEVnROcEdFTWJYUjNMRDRtL0FXZnpxOWRM?=
 =?utf-8?B?ZFNNeEFFVkpxM3ZOZFRueVp1djhOYnBlS1RSUGNnVlZWOXBadHlHeVRYRzQ0?=
 =?utf-8?B?Y1FvOThGMHZ5eitUSE9kbHIwOHNMRlNlZnRwaGEzMVM3VFZUT2NkMDZ5R0F6?=
 =?utf-8?B?NE1JMmRQUUxqcURVbTZQeGEwczQwTE83bWt5Sk54WFRMTmcvZFNIU0s2dEZR?=
 =?utf-8?B?V283U01xK1IwWFJ1K09jTVhXVjZuVmY1QzQvcGlCZ29UTUMyNWlCWUs0TktU?=
 =?utf-8?B?OWQzK0twZjBpSG1TQ1BOYXRYeElKSGd2WVhmK1o0bGlMVHQ4Y3E5SFp3TVVU?=
 =?utf-8?B?dnV1T1RiVXAyN2hWQmlJNGZwYjhva0prSFI2TFVpMmRBOEFEbE1LUWFoVGdl?=
 =?utf-8?B?WlZyL0o1bFk1bXFYQUJoSytJcmhSZE5XSG1jWmtDWFpmZ01vZlRWME1GN0Fj?=
 =?utf-8?B?V295UktnTXdCNzJOSFRDc21xU3o0UWp3aHhWSkRBVTRSejM4QVhpQy9pNzNk?=
 =?utf-8?B?NmpwcVZYVGl4TytDWnluL1JwS3h4eFFxRjRBZ3Q2QWVaK1JIOFlwUUN3d3I3?=
 =?utf-8?B?UElCcUZ3Y2RiMm4vWlBsOVZVTk1ZdTRwbUlROGRPTFByVnMzY1d3Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3752905-a20e-46a4-5bea-08df19409afd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 07:02:18.0321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zqShBDXAsBAR0ufmGKedhVT28QL8PcyEpkbMBI54Zxh6JEM99ouVhkXI1EpWV0/k4jgpmmgKKf7lTra5U+w9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7403
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 07:02:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24271

On 17.09.26 18:14, Quirin Gylstorff wrote:
> Setting INITRAMFS_FACTORY_RESET_CLEAR_TPM to '0' did not disable
> clearing the TPM: the generated script tested the variable with '-n',
> which is true for both '0' and '1'.
> 
> Normalise the value in a separate variable and compare it against '1'
> instead.
> 

The fix should probably go to the front of the series.

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/factory-reset-script.tmpl                            | 2 +-
>  .../initramfs-factory-reset-hook_0.4.bb                        | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> index e58b5460..e8d85e64 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> @@ -53,7 +53,7 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
>          esac
>  
>          if [ "$fs_type" = "luks" ]; then
> -            if [ -n "${INITRAMFS_FACTORY_RESET_CLEAR_TPM}" ]; then
> +            if [ "${INITRAMFS_FACTORY_RESET_CLEAR_TPM_VAR}" = "1" ]; then
>                  # after this the data on the encrypted partition
>                  # is inaccessible
>                  tpm2_clear
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.4.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
> index ccb8a72b..e3951cea 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
> @@ -21,6 +21,7 @@ INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= "0"
>  INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?= "1"
>  INITRAMFS_SETUP_TIMEOUT ?= "600"
>  
> +INITRAMFS_FACTORY_RESET_CLEAR_TPM_VAR = "${@ '1' if bb.utils.to_boolean(d.getVar('INITRAMFS_FACTORY_RESET_CLEAR_TPM')) else '0'}"

INITRAMFS_FACTORY_RESET_CLEAR_TPM_BOOL maybe?

>  # to support factory reset on btrfs, add 'btrfs'
>  INITRAMFS_FACTORY_RESET_FSTYPES = "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
>  INITRAMFS_WATCHDOG_DEVICE ??= "${@'/dev/watchdog' if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 else ''}"
> @@ -35,7 +36,7 @@ FACTORY_RESET_HOOK_TARGET = "${@ 'local-top' if bb.utils.to_boolean(d.getVar('IN
>  TEMPLATE_FILES += "reset-env.tmpl factory-reset-script.tmpl"
>  TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
>                     INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
> -                   INITRAMFS_FACTORY_RESET_CLEAR_TPM \
> +                   INITRAMFS_FACTORY_RESET_CLEAR_TPM_VAR \
>                     INITRAMFS_WATCHDOG_DEVICE \
>                     INITRAMFS_SETUP_TIMEOUT "
>  

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

