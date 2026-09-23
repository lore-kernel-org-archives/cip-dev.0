Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A53C98302
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 06:48:39 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1445.1790146110913001444
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Sep 2026 23:48:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HAYp/nGc;
 spf=pass (domain: siemens.com, ip: 40.107.130.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTwyDORRH+6D19fTM/64bcX4iag5G1W/iDNFxIu0bdNI6u0sBMDtPhc56pQ3WJkOdrCgdYpmsThzM3TAEgTqsz0zm+NA4fJNhJs1hAlbyO2QPajT61f00jvlXP1T9HEjnbadqXiWSvPmblFo+6zPfVMm8gp2Xg/Z4jtShBalpBaDmqH2NxJW+ORmBF7T67BMK/milu22d+YxbCDP9EgJ2rYkh3JXOW5DKkVFo/KJSNZ8mtLzYnW1WKYnHAQDD3GwXA6zfO5ktPHjRk777sArnrZAD5yRiHBaK2w1hvdzMuBVkrd8vUIO8WSb8SDrsq/Ol+bedFy6avYaTaoPYVr5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8ymR98f7HotiSAUkEInWYgR1B8qBBpnDXP9m2FS52Q=;
 b=VV0gJBoR5RKmqt/UFcL2WvoXZhzojLLFesSzdSv96kZSelJhf4hABqSuUq09HaKqCgm/pRj04AoEkLiW0bDz2LP+BU3pNH6FZRr0hbEj+sK23lLg6wrGNOEPC6uDRhQ5D5fAV1sqkWlQ38vvHSs+Mda45bI9j6YsLVFgIqsdMbb/80cMOgVf0BNr4FypsUCZ5dGxp45Y72NHoWMTHfxNCnAQCilC/Z9wfYsLb5m5em9lbrKRhNw8eWaBJqXH/0CX4yiUF1WtZlAWJdKHbyGmK8FVV5CspEnjllGLmXdLfHISn5GfgmlhIIetxmAIc+/A045OhhGuHruUbiQj6IXSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8ymR98f7HotiSAUkEInWYgR1B8qBBpnDXP9m2FS52Q=;
 b=HAYp/nGcca2JwyVI2eYJo8qb9IPw7kvARo5Vdnp+lMbz+S5Y9LGKA3HY9yb8i45mUWW+afX60TpDa433RMuNpFVVqI5lDgCa/YfF5mAIowqJW3tCAFes6YNlDF/BfltMXT3eA++E4AzYgd6YMvzs+jWOl2h5ey05bqNHq4AYOTbZKYIsVuwl03uJ2aGX9aYbrfZNlDaAlaDybmNHOsbfEW0fF5iuQTD2m8H/3nUJG2T9XPijbRabvlRtEx81rIWrGLvFhI1zZICQc55oUhVH2X3d+4CuOLj6OpJ3/8UzSK1dm7EXnw0LsHU0FGVXijMLbfk5g9T9ZTWQC620nhRxIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5905.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 06:48:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 06:48:22 +0000
Message-ID: <5dd02353-cd3f-4a5f-a412-7249637cff20@siemens.com>
Date: Wed, 23 Sep 2026 08:48:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/3] initramfs-crypt-hook: Move
 service watchdog to cip functions
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, alexander.heinisch@siemens.com
References: <20260917161425.666709-1-quirin.gylstorff@siemens.com>
 <20260917161425.666709-2-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260917161425.666709-2-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: a097a5c0-e6c6-4565-3b3b-08df193ea8ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|4143699003|10067099003|56012099006|11063799006|55112099003|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: 
	IxsytPDTt6H69k9F1W1qf/xkSOA3uEfG44TRLUNTBmUVS7jEmLYYesBDT3UsBzkw95S5NJyOnnQ31x2FKP3Yt79afTWzvgq3pr12ubJ+EJPT+WjkbFV78KhHG/8I8e92V4aCwQC14bSS2ACeA2YOTGcosZ2tM7YpC2qavpXHG9YqXsIRJCh2CSeu+g0ZSPYVJnMcJJitGPZ8i4hdpX0T1ChbWXYRNKcSfQhXNAd+GyTB8IXGycxNWMpt9KUQb9ijzVl49L2hT745DGK9EkGqOoUwZfZY7/tCoHJL6A5ZJHX28Lzrv28JQ/ZWySzsUbc8/8f9/uLd/DSAtVDoG0AqIb8tP3/slbxU0DN4BnyikJrdBk/jGVWUjVFH69xbvoF8x1uxhCjnblTEYeBcl1yO0osAbbRegQFXYJbCGGu72Le51Caxit8RptdOesSll/lDzCQxlmifTVIU8mXWv7mUayDpvHRAexLpdzAen/nzPqaaLPh0L3r5tvLbVwLid1OR0ApG9GslqNovC4jc0z28ykehprO6KGU8fnkbfsYwtF/ZpVL5dxkFav4+HP8SACCnhGh2vbJI3Uywb992p4xauLaZIIz8yOnK0yTqDlkfBlK3cf/Q0yXe7fmDCxcqEJrRZeZ599iLUrVQjtCzIYglcMOZcNnrA/6Cmwxt0sjuDS4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(55112099003)(18002099003)(22082099003)(3023799007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFFQbUVYUDVBN1pXbzJPSldQZHY2YlV0a3Q3a0ZjU2xtSU5lTUZlUThncVEz?=
 =?utf-8?B?MFdDZnduTEFlVU9aL1J4ZW5YSVhJNUNublVuaTRoWkF6UHBiY0xZTmw4NGhN?=
 =?utf-8?B?eFJycFM2WGNuSFFiaFNLZ2lCd3MzM1VtaXhnK2dEY3hCd1RhNTY5bzBJS2tU?=
 =?utf-8?B?LzdadGJ6TEZ3dnhVUHhvVmZHOWl3Nm1UVHE0c3NmTG1ZdFc0dXd3Rjh6dHdL?=
 =?utf-8?B?MlFRZlJ6N1NBZ1BnQkh5SE9oTDhJL2ZvRmtZMHZTcjhxZ0IwZ1d6bmhLR0FY?=
 =?utf-8?B?cnhWWjkxZkE4WjNhdG1lUXlHUzhCY3BEQ0hHWjFuT0dIMVRYL0F0b1BSOFlW?=
 =?utf-8?B?VEZwdytFSFN3ZisrWlhSVlhSUzBUbTk3b1lhc2xXa1RnZEUwTHh4N0hJUFp5?=
 =?utf-8?B?dUdNTTAzZGRjOXIvTi82aFJwVEFtZ1drM3E1eEFxaGVya2huanJBYkZJMmQy?=
 =?utf-8?B?eFM2Sm0yUGMyUDUxTWdsV2FuUEMyQUdsYTNYSEZpMDBKeDQ2TWFSYkJGdlRv?=
 =?utf-8?B?R1BCbWhka1F5WjdCKzJOb3VnNUVMSWx5Q1UycGxuYjREWnluVVhJMkc5UXcr?=
 =?utf-8?B?bVZFWWlxUHF1VlFETU50aDM3ZWxzbVpkU2xTUGs3M0JjZHluUzZPK3J5dGdX?=
 =?utf-8?B?clZBSjNWcDlOL1ppV1hpY0J1ODFhOXFaa3lFcngzNmp0b1hlcU9heWMwYlRy?=
 =?utf-8?B?dENzMXJ1UlcyZ2NIV2NUR3EzUTB3Tk11a1NVQWx2TWh6dURGcHNHdTlhVE45?=
 =?utf-8?B?QXd2QUZhTmtCUDVjWURFaUdLWG85bi8yRWxVODN0YWsrSkc1QTJUaW42cmRS?=
 =?utf-8?B?RVFZVGtVVzdXNEI0dVpSU3k0OXBHN3IzOXEyNjlKRmgyZGVvWWhxVktFa0R5?=
 =?utf-8?B?dkk5b3pMUEtOS3J0N3NNNWcwTVA1czczbEFacXdFK1hER3lFNnlOWFlQNFBh?=
 =?utf-8?B?aGh3clQ4bEFYZTRGTDVmZ0hjRUxDSGxKdG5TL2E1K2h0Yi9OUUtqNy9MUGh3?=
 =?utf-8?B?MzRmaUhqdFFnSVpHRzgrQ3hYTWFXUXkyVXkvc3RNQjRWOTZmeHBvY3pyZThE?=
 =?utf-8?B?S1dnMWFydnl5b3ovN2FJeGN2Q2E5MHlnODBJbGJqRlkwTzVXcHV6REx2Y1RJ?=
 =?utf-8?B?UGh1V0IxMlo4enlSZllsK3JvOW9Bb1MvVVpZSDA1bW81c3ZodlpvK3hYdUlT?=
 =?utf-8?B?L2h6UnJiSGlGa1dZSG1ZZ1J0WU5CVVY0OVBzYVFLaFEzdkJyaVJZeTh5WHpB?=
 =?utf-8?B?UVpTTCtFNFkyb1d0NzlWTnQ5REFSY0RtNjdKb2lmQ0loNWJtalh1WktWdi9r?=
 =?utf-8?B?cDNOTi9CVHlpNjNFd1hkWHlXNFA2dVdQdUlZazczQmRRcXVXQkZSY0NQUjJG?=
 =?utf-8?B?eU1MRm5teVNWbEN1LzJGYmFyTk56MGxGcnBTL1V1QlNWRFQvZFYzS2FQaXZj?=
 =?utf-8?B?SmFrYk1hY2h2aS90ckdNb1R6enQ5a2pxUXlKc0N5Z3lteXYxRi9jV3I2TXg3?=
 =?utf-8?B?blpwWFZNV1RnOEppdG1heVcwNFB0WmFjSllCOUFyNHhhQ3l5TXJhbUI5U1Qz?=
 =?utf-8?B?M3BSbVgrNWZLRnRuc05MMUZyUWxWNnRzVUlTOUVwYU1WTWY0TEZQbTZWNzhM?=
 =?utf-8?B?dFkraWhWVVpQZ0tsYkxyWXB2Q0dFa25lekl3aVZ6MEFuTXdIeVRma2pTRjFH?=
 =?utf-8?B?TG54UlZoTzk2dnZOR2FFemVtNEYwUG1aeVlCbFBSb1ZmZ2ZKOWo4akNIQ0tD?=
 =?utf-8?B?WktQY2Fxd0p6NUVLYkZ2WHRCaDJLaW5RVkxDL0poQUNZdFBUb2RmWmczM3pv?=
 =?utf-8?B?dllrWkJTZ21Xck5tTDJsdkUrblY3R3N0TGZVdS83Z1ZaMFczcWxtMlBWMGZr?=
 =?utf-8?B?Vk5ROUhmNGZLcEpwMjJHVE5naVR3aTRGd0ZxUUUreWV6U1VnL3M0eDQrak9S?=
 =?utf-8?B?ZS9UU2RrK1M2Y3FaUG9GRDZ5UkVUOUFjTUJXNVIrNktOWm0yZFpGVm42dTZ1?=
 =?utf-8?B?cEdHVmh3RXFxcUlOQ21JblFPbS9ZY1A2L1pOaXNmMm4wTWxHUUtDdFhEUlds?=
 =?utf-8?B?eC9BRFRrZjIwZm5lcHhUUGFaY1RNYm5PYVVxdWdOazZUYmVRcTR4Sk5oZjU3?=
 =?utf-8?B?MUR4b2d3SWdGRVBkTmoyblBBR01nT0s1U1NIblFGTDhIbmRpQk1hUktBblNT?=
 =?utf-8?B?eW5MK2ZKRDYrYVVIVG1GSllRWTl2WGxJWmQ0OExOV0tnYkt1Z0xzMSt0Mmcy?=
 =?utf-8?B?WTAxQksxMHZZMEtRTGMwWGlUQkxWWWZSNHJETXZxNXNuc0tNdW1aNEI3cGdt?=
 =?utf-8?B?Nk9uMSt4RGg2R2dnSE4vVjNRWDYrdE5DbHpzSGRrQXRNQ3FpL3ppQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a097a5c0-e6c6-4565-3b3b-08df193ea8ca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 06:48:22.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+GWvnDA318NfuBP6k5Et3Bo4KpnOfgYS3PebhkExQ1I9Efj6WB419a2l47sfawoB1vTKXqhoS7fcW4tlQc5Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5905
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 06:48:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24269

On 17.09.26 18:14, Quirin Gylstorff wrote:
> This is in preparation for deleting all data during factory reset.
> 
> Also rename CRYPT_SETUP_TIMEOUT to INITRAMFS_SETUP_TIMEOUT
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/cip-initramfs-functions             | 36 ++++++++++++++++++-
>  ..._0.1.bb => initramfs-cip-functions_0.2.bb} |  0
>  .../files/encrypt_partition.env.tmpl          |  2 +-
>  .../files/local-top-complete                  | 23 ++----------
>  ...k_0.11.bb => initramfs-crypt-hook_0.12.bb} |  4 +--
>  5 files changed, 40 insertions(+), 25 deletions(-)
>  rename recipes-initramfs/initramfs-cip-functions/{initramfs-cip-functions_0.1.bb => initramfs-cip-functions_0.2.bb} (100%)
>  rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.11.bb => initramfs-crypt-hook_0.12.bb} (97%)
> 
> diff --git a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
> index f14956d5..aeeca06c 100644
> --- a/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
> +++ b/recipes-initramfs/initramfs-cip-functions/files/cip-initramfs-functions
> @@ -2,7 +2,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2025
> +# Copyright (c) Siemens AG, 2025 - 2026
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -84,3 +84,37 @@ secure_boot_enabled() {
>      fi
>      return 1
>  }
> +
> +service_watchdog() {
> +    watchdog_dev="$1"
> +    setup_timeout="$2"
> +    if [ ! -e "$watchdog_dev" ]; then
> +        panic "Could not find '$watchdog_dev' - Please check your kernel configuration."
> +    fi
> +    for _ in $(seq $((setup_timeout / 10)) ); do
> +        printf '\0'
> +        sleep 10
> +    done > "$watchdog_dev"
> +}
> +
> +# start_watchdog and stop_watchdog share $watchdog_pid via the shell
> +# environment, so both have to be called from the same script.
> +start_watchdog() {
> +    if [ -z "$1" ] || [ -z "$2" ]; then
> +        log_warning_msg "Watchdog is disabled."
> +        return 0
> +    fi
> +    if [ -z "$watchdog_pid" ]; then
> +        service_watchdog "$1" "$2" &
> +        watchdog_pid=$!
> +    fi
> +}
> +
> +stop_watchdog() {
> +    if [ -n "$watchdog_pid" ]; then
> +        while kill -9 "$watchdog_pid" 2>/dev/null; do
> +            sleep 1
> +        done
> +        watchdog_pid=""
> +    fi
> +}
> diff --git a/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb b/recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.2.bb
> similarity index 100%
> rename from recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.1.bb
> rename to recipes-initramfs/initramfs-cip-functions/initramfs-cip-functions_0.2.bb
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index 787172f6..c9ae70a6 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -3,7 +3,7 @@
>  #
>  PARTITIONS="${CRYPT_PARTITIONS}"
>  CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
> -SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
> +SETUP_TIMEOUT="${INITRAMFS_SETUP_TIMEOUT}"
>  WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>  HASH_TYPE="${CRYPT_HASH_TYPE}"
>  KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 3312e632..f5b1c8f1 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -63,20 +63,6 @@ if [ -z "${create_file_system_cmd}" ]; then
>  	create_file_system_cmd="mke2fs -t ext4"
>  fi
>  
> -service_watchdog() {
> -	if [ -n "$WATCHDOG_DEV" ]; then
> -		if [ ! -e "$WATCHDOG_DEV" ]; then
> -			panic "Could not find '$WATCHDOG_DEV' - Please check your kernel configuration."
> -		fi
> -		for n in $(seq $(($SETUP_TIMEOUT / 10)) ); do
> -			printf '\0'
> -			sleep 10
> -		done > "$WATCHDOG_DEV"
> -	else
> -		echo "Watchdog is disabled."
> -	fi
> -}
> -
>  check_partitions()
>  {
>  	found=0
> @@ -307,10 +293,7 @@ for partition_set in $partition_sets; do
>  	fi
>  
>  	# service watchdog in the background during lengthy re-encryption
> -	if [ -z "$watchdog_pid" ]; then
> -		service_watchdog &
> -		watchdog_pid=$!
> -	fi
> +	start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}"
>  
>  	# Create random password, store it in the tpm2, sealed via PCR:7,
>  	# to allow continuing reencryption in case of power-failure.
> @@ -374,6 +357,4 @@ if [ -x /usr/bin/tpm2_shutdown ]; then
>  	tpm2_shutdown -c
>  fi
>  
> -if [ -n "$watchdog_pid" ]; then
> -	kill "$watchdog_pid"  > /dev/null 2>&1
> -fi
> +stop_watchdog
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.bb
> similarity index 97%
> rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.bb
> index 7d198582..514bda80 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.12.bb
> @@ -89,7 +89,7 @@ CRYPT_PARTITIONS ??= "var:/var:reencrypt"
>  # in a newly formatted LUKS Partition
>  CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
>  # Timeout for creating / re-encrypting partitions on first boot
> -CRYPT_SETUP_TIMEOUT ??= "600"
> +INITRAMFS_SETUP_TIMEOUT ?= "${@ d.getVar('CRYPT_SETUP_TIMEOUT') or 600}"

This is at least lacking a comment that explains CRYPT_SETUP_TIMEOUT is
there for backward compatibility. Even better would be proper
deprecation what is additionally issuing a warning when
CRYPT_SETUP_TIMEOUT is set.

>  # Watchdog to service during the initial setup of the crypto partitions
>  INITRAMFS_WATCHDOG_DEVICE ??= "${@'/dev/watchdog' \
>      if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 \
> @@ -104,7 +104,7 @@ CRYPT_BTRFS_SUPPORT ??= "0"
>  INITRAMFS_CRYPT_MOUNT_OPTIONS ??= "defaults,nodev,nosuid,noexec"
>  
>  TEMPLATE_VARS += "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
> -    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
> +    INITRAMFS_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
>      CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL INITRAMFS_CRYPT_MOUNT_OPTIONS"
>  TEMPLATE_FILES += "encrypt_partition.env.tmpl"
>  

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

