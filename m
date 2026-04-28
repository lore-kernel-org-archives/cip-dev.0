Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40261FF886D
	for <webhook@archiver.kernel.org>; Tue, 28 Apr 2026 17:13:35 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2675.1777396407293656501
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Apr 2026 10:13:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xB/l5djo;
 spf=pass (domain: siemens.com, ip: 52.101.83.11, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldcCQ+l6ZhXpg7CaRaPeydYRZBf+WibumX3Br0HCZ0IH2QQadxrvqJxFA2y1pETD4pJQBIvbtNMjJJ20ae34rx3i4MSk0kp1/qRDwwPV/F5phsnVuRkD8rX8bQ3K7tMHA165BSniWWTwk+Z63bvBj1g6DBzYTCHe4wzpxQrTI/Fr6z5VjJnQwr0/L+7YsNAPuhL5+VzRrLfEaRCbt+O7bS+8wckfm3ddrJrrvaGzQthNQcHCy0HNie2BSYssunM+C+6ZPES8fPr80H2DTAYeTHLmZRFhgJWmc0kK+U/bpATYRQz7vWvvNWoLrMz6i0jyW4LFkS7DuhTSH1aEs6cAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cYC+de9LpZGb+BwkwCHdCtS1ZuZhTfwQm4CfVJ+y70=;
 b=uligutYvrIEFKStnmLSUSsUiZB+Oa8GOHGYHCWKD3y6NttAjIPKy41dJoPqBTrDhtpu3hUy+jw3tnXKPeLcbE6Xyr+QuQ38Te1VACrkX6cpep8mWlkqlxJYk2Ltvri6pPtwW3IS2iK/LqnGqCJf06C5157Il5HdUtnXdEOZNK+c3/qRfQBi65zCvla2jtz3HG8ltS7s+p8atGRXkCqEaX2I27xQeodQKRQpLFSuHbJhvh/Wy+eaqZz8pZ6a9aM/FuuWPnliBSsDAZhdkpUK332YkOYKLjc1FXVYfeD5MP4Fz0TfcZlRUputowOs3IDccGd2YLX137jjDCaIU6c5adg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cYC+de9LpZGb+BwkwCHdCtS1ZuZhTfwQm4CfVJ+y70=;
 b=xB/l5djol1UU+yHfDLderMjhvkgDk54qiNONkU16cc0Ph/pMVQeyMNQZx/MVxMQe6CjSyZCpb4g0Fe9FvPQ9nC6IKU2pM85hX5RRJP4Qx6lz/Hy0EK3wc++dFpB/Ojb56aaEZFugR3GL/ovgwbaQNZSU/NNAfy7EOfYiYAuoBfHBT7CRktIE0YIxAD0lhU+MxWyLGV069ANDQfOYx5OSiqPfOAVIxZd+Ov4h+9o7/qXQ6ObAZ5C2/05knODQqlgHV+ARl3mYu/d1dQZLbeZp4MDikGH5vMQR3XINsKmW06xHXEB7cFujVJLuCQgOlnDFiSHG4IjroOwVwTAjrK4ZBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8882.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:239::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 17:13:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 17:13:21 +0000
Message-ID: <dc510635-15ec-44d6-b64c-2af7a7e7cb14@siemens.com>
Date: Tue, 28 Apr 2026 19:13:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] crypt-hook: Check if
 WATCHDOG_DEV is set and available
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260428113247.27835-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260428113247.27835-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: d7fef592-06ea-4a0a-c9ab-08dea54972b3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	chjB0wTHRwFKCBjicA2PktIMEoYok6HeECnxOezAXEwMCpZ5LltDz7WyiIC575KFToeB5YB3ILDGdowAe3e+hcWjqizOsmol6pCMftcdZcs5W7pLREhAG/reL9e397hye4fJLuT9bpnoKFNnlvQNPqMjIwxIIfT8MIMy5wJyjfFclsoKcehA6jrRYwx0v8nQODw/MnFY1KLEqv4LvjetvjxLbrgeMhV7FED7KkCrOy3lqine7gOZOsm1KX4rGmqu8FcJb27WDdvBinWk7kz9R3Z8s4/PrLx6jM2ILgWa10NtZ9e1RkxH2gRWc9vxoRoi9mnUOQ19h8u7G2mIhT1UQCCTfJfkwIPMc0BExV0+eYHYdcDfUkg2/T/7cOvCGtm6v7KX9EJf/ZGL+bImFcRq5wOxW3XPuCUV8oFB6yDsd7FMVlmmhF225K1N7FONkZIe1cNIxLqLVS9DY8xTUxmuUfEx8zGcLZBWLwFhy4Ve0mvcSF4+Op9wNACSYS3BKQOxi2+0doUTGaJUsZlG5sZpcFBsDlC9LapDSht3T5aF941y31M0H7ZcTe065jkvND/rCRynRPpJki8XwehWxopSJZOWqtx+hOep9SRkdHxkxIgo2NliWLpzcuAd6rrz1yExvQcCEe3Qss6q+uSJvBGcSJfMGKd+V6BfJBXqvbv2A0J248Brqx0DDwX/Oqs9CPrFYXJMhhPmT8HxC3hekaMKnRejNpWk8Wb7JR5R/T6plVo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YTd1ZGhhRHFVK2hxb2t3Zkd6TjhiTitGWmp2aDV6K3VuYlZVeENMRWJ1VFlD?=
 =?utf-8?B?WlNONzZLdldsYVlhOHhWR1hQVXJOdFloajBlZ25EWGVoWE9Gd1plRFE5SHVX?=
 =?utf-8?B?TjdhV21FamRNWm1LRm1oMlVEQWsybGlqcGJITFpMcDZhaHJkcDNRa1lFcFpB?=
 =?utf-8?B?SjkxZWd6SDR4Q0FQcE1adjJQNEpIMG5OMkhDRC9JRXhQNUgzRWJsUk1MdlRr?=
 =?utf-8?B?YmV3ZFlQK2RZdHVDSzBNNnoxekF6N1VmV0pPUDZSelUzTVJjcS9MU2QvRW9x?=
 =?utf-8?B?THpvMVh6T3J5VnpxMlJqd3RVNlY1T01xdGVscUFjaExOV3ZGUS9Dc0FKL29z?=
 =?utf-8?B?cG84dDlQelN4YS93WlFJdDFoL3BtS1NuRVVSc3cvcVNCdXg1YVBxY2o3V29B?=
 =?utf-8?B?RWZORmRlbzR0dHlOL2NNWm10Y1laUDFzV04vZk1xZVd6eFJ6eGx0Q2xqVlFQ?=
 =?utf-8?B?V3BnMzljUjBuaktBSnZ1VHJvZW1NeXhOS2NBMmtUYVBOUy9RaTdxaWNpMFZr?=
 =?utf-8?B?THhObDhyL1djeitpdlJsR21keFZBNDRhUWN6M1dOUjNLcjdWdXI0YUdyOVBQ?=
 =?utf-8?B?enBRaU9neml1UVIxelpCcitsemR1QW55YzRJSzNzcC9ZUzN6ZDF2cHZ3U04y?=
 =?utf-8?B?WWd3a1VuaDNDR21nTlIvS0VZK1BVOXo4elJOWGRWZzE1RVkzQ3dXYU1OUVJ3?=
 =?utf-8?B?WTEwMVF5OHdCb2hoR3BOVlNiTjlJMjJwK1hYcThQV3RoNFU2bCtOdzQ5bWtn?=
 =?utf-8?B?RjByNmhLd3NjMWZLYk52TnZOY2FZcnlzdTJGYjVaS3lvbGFvbGNyN3BaY3hm?=
 =?utf-8?B?QWhGaDFuSzRUd3o1cTZJNnA2UU5TNm9wbmdRWmU5RDFCc2hYSFcyZlZvcHlq?=
 =?utf-8?B?cTNBSEU1cXp5am1jQlBVRUhIRWVGQ1RvYmxDYVpFUzBPQjFWNXRNNGtPWnov?=
 =?utf-8?B?dGdTZmlYWU1MTXN1VUV2dDhZK0toQWk1b09aSDk4UkhXUSthSTd4VTNVZWM1?=
 =?utf-8?B?YXQza3kzUExMWjFQc0lGQURpc2ZMU2t4Rlc0YVdRbGFhYWhIYXEzU2lJUnRC?=
 =?utf-8?B?bTFyaWJTQ1E5b0F1YnRyakxLQ0M0UVd2aytxUmhVQjZYR1hIbTZDYWxSMHhO?=
 =?utf-8?B?WVFlWlRySFo1dkk3cFI1YWdDV2xsMFVMQzBmRWhKTm1lSnF2NFpvVk5hbUU4?=
 =?utf-8?B?aFpyVzBINWdvTm1Ybjd2OThaczc3V3kvTmJyRGwrUzJXUzVta0ZSaUVWdk9Z?=
 =?utf-8?B?Q1JOeXgxTmtLeXk4SVhYQmVzNk9wUEs4SUgyQk4zaHM4N0ZZWFdjYUNZZWQy?=
 =?utf-8?B?ZkVkT2tlTlB6Y2hBQlgzRHd2UHlUMTdrR1RmdXhTZ0gzWmJIVEtMT0NKdVEw?=
 =?utf-8?B?LzNCR3JFTnhjY3Z5RkVUUjU3M2JYVmlIaXoxcmU3WUVzS0UvZ3VYYkovUE9p?=
 =?utf-8?B?ekhVQXNXMEJaMnNydkdxS25DVnFGU1UzeVZpU2xobktxZGJOVTRvWnBNUFY1?=
 =?utf-8?B?L3UxbW05U2dEOVA3N3NpS1ptalFONjJXVVRrQ3Y3SVhLTThMcWd1MjV5Mzg2?=
 =?utf-8?B?L3FXbmkrNzZOV0FOelUzUHJnRW1mcnNFOTBGMDRsWngxOVJscW8vTFZ2SDRR?=
 =?utf-8?B?c053M2pIYkY3NVBWNzd0NnYyMDJtazYwSkM3Y0MvMVQxMkNDQnNmNjMyNEpm?=
 =?utf-8?B?ODdZS3E0dGlLekVNTU1lRXJpdVd0UHlPNE55YnhQTWJrZXdQUE9VdnhOeGtt?=
 =?utf-8?B?T2pKZUlQVzMrVDJ6UHEzRDV2MEhnWWRYR1AwYlJqWkd2MnYzMG82cnJXU3F6?=
 =?utf-8?B?SHl6SkV4VUd0TEM4K2xWOGJoMTRJTlVOT01MYTQ2UXpPSE1US0w3N29EMm11?=
 =?utf-8?B?Y1RLeGhVR21vM2QzdXpqRjBUQWRRQUxxUjdraW83SGsrL0tFR3loZXlhTUJZ?=
 =?utf-8?B?YVVxc2V4MlJNL0EwV2QwSDlydUdZdDFNMnkwbEVFWnBSWjJrK3kvZy9IUzRh?=
 =?utf-8?B?WVlTNG4yM3ZnU2w2U25aRWt3NmNraEVUU2hCMlB1UGVjdW5LTmV6K1ZIdGVY?=
 =?utf-8?B?VVVoblUzdmYzY0k2bU1RTStXcWZGSUJEUXRkUCt4ZTdBb3VnR283UVc0QlhT?=
 =?utf-8?B?VnZtSlJZLyt2U2ZXa3d4bGk1WkFjeDNZeXBZVnVmTEFBVG1GUXNiZ1RBMkxx?=
 =?utf-8?B?bHdzU2NYNDdrNElJNjFQZFdXc1NZUWF5YVF4NXVLVXBLYWF4dFh1cmRFTEVG?=
 =?utf-8?B?cVFIcUl3SUp0c3h6WW8zUFR1dkdkTWFWQURhS0oxM1Bkb3ZGdFVPV3FMVWJW?=
 =?utf-8?B?WGhWUU84djV1cGxWeFJEUnNCclZRVkpsUGxPYnVuMXEzeHAyTVFsZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7fef592-06ea-4a0a-c9ab-08dea54972b3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 17:13:21.0281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MI0sDBP2vkwihhSnJh+xko6noT20R3C8hLyOBg1Rxn22a+lPLwonfHYIjGsEi3sqZ1mc3B4tOZl+PicwjIlJjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8882
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Apr 2026 17:13:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22820

On 28.04.26 13:32, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows the user to disable the watchdog by emptying the variable
> `INITRAMFS_WATCHDOG_DEVICE`.
> 
> Also add  a panic if the watchdog device is configured
> and not available.
> 
> Reported-by: Stefan Koch <stefan.koch@siemens.com>
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - if the watchdog is configured and not available panic the initrd
>  - add a message if the watchdog is disable
> 
>  .../files/local-top-complete                    | 17 ++++++++++++-----
>  ...ook_0.10.bb => initramfs-crypt-hook_0.11.bb} |  2 +-
>  2 files changed, 13 insertions(+), 6 deletions(-)
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.10.bb => initramfs-crypt-hook_0.11.bb} (99%)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 4f3eafc..e802f0b 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -2,7 +2,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2023-2025
> +# Copyright (c) Siemens AG, 2023-2026
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -64,10 +64,17 @@ if [ -z "${create_file_system_cmd}" ]; then
>  fi
>  
>  service_watchdog() {
> -	for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
> -		printf '\0'
> -		sleep 10
> -	done > "$WATCHDOG_DEV"
> +	if [ -n "$WATCHDOG_DEV" ]; then
> +		if [ ! -f "$WATCHDOG_DEV" ]; then

Given how red our pipeline now is, we likely want "-e" here. Fixing up
and retrying.

Jan

> +			panic "Could not find '$WATCHDOG_DEV' - Please check your kernel configuration."
> +		fi
> +		for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
> +			printf '\0'
> +			sleep 10
> +		done > "$WATCHDOG_DEV"
> +	else
> +		echo "Watchdog is disabled."
> +	fi
>  }
>  
>  check_partitions()
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> similarity index 99%
> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> index c0572f2..331a662 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020-2025
> +# Copyright (c) Siemens AG, 2020-2026
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

