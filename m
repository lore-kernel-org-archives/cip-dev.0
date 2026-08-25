Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422A1C61DBE
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 14:57:58 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.71])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23972.1787669876245839275
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 07:57:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I91BREWz;
 spf=pass (domain: siemens.com, ip: 52.101.72.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoQ3bps4ZMTqMUtIX7GeU1jnNbh5t2V44RU/YxDfcosxD+EPvg5aaSY/pP4U2sG3OKr4z6cG7kRtQXGfHSdST3PjrofDcEw5R29jmZEu/4wJTssSRmiBH7AWZEbP11/d8r8NVHesiH1A/061zAeJDszhDDMQprTt61SWYUEKGGp5rpmCY5cU+3/xUCJQpBH79MAqWXOOGf2QXWrHPJq80Pa/2sB3tbkuzkLcXHZv1/kwjHmC6fIBm1mb83/MWC2M5nqfn9Thw30j70qeQ0ZCjTFKaYSwOPyGTQwcrdQMtJ4tRN8uALJqb5qY+B1iNl4mGZciEz++iBjfzi16+iEzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fznk+lqY/X7kaQEuk3sJ91Fp/fdWy77qUmKlaOy9gdE=;
 b=DRkVMwTf3vzj1BMXkuo0rdvd7JXRCg+pwMJ46WXNajuEDMUNlu2UxUOnTuoX8UCaeAiaZxUN3c5leUJoDIoaTXgHDzS0v+ADASo+uNBtWHvCTFhJ9u/EeUmb2JU4liqRG6cfQ1w+i0fkqDhT5kUwds7bgjb/rijF8+tRaQSbbdGPyXJnQ9WSwrRpdxwC3APwJB+a/tI/5Y30yx6I7WOb2IaEaf8+XRxrs++xDDSwvKnEDYpb9KC9kMnNYbVxYDs0I9lhuvCH/X/kzOJME1JvfE4wlkr2MLSPPeRHeBqD/40smP+iPSvx1Vh3GgzDmnKMOEVQuTE+fuDNEC72fbyQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fznk+lqY/X7kaQEuk3sJ91Fp/fdWy77qUmKlaOy9gdE=;
 b=I91BREWz1+0j04xaH+IZwFRHfpjDQCsXpz9MBB/pXdJQnAsBKEGFO8v9NKfegTj5/cXZuH/SqYgnCq7HYxfSUzyecMlSXLNGYkKSXNDX+rcBOrD+X+qgJ6ymoRMX4P/RffSnQepETIeUkkHRIxwoxrJ7y8K2pGOm1OAfaX2tmmhPgBctTvhwWurjlXlWWJ23hZyHydg/HCcqSCJXFkofNFW4N3xTquN/ZmUHJKswkM0O4Z0jHfevad6DdH8LPOUtdD9scolP2DOOby93w9esOBfhGn1fpoWtCfKZVedYQLdyj+pptupcuKBGTTbx9DtZyV/P+Zn25OQ47p6mortpcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5510.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 14:57:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 14:57:52 +0000
Message-ID: <65a1f330-1941-4d09-97ed-fc29421b35c2@siemens.com>
Date: Tue, 25 Aug 2026 16:57:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 2/2] initramfs-factory-reset: Add
 option to clear partition before new fs
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, alexander.heinisch@siemens.com
References: <20260825143802.3764929-1-quirin.gylstorff@siemens.com>
 <20260825143802.3764929-3-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260825143802.3764929-3-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:610:59::39) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5510:EE_
X-MS-Office365-Filtering-Correlation-Id: 090485c6-e8ea-4cab-7796-08df02b93cb7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|6133799003|11063799006|10067099003|4143699003|56012099006|18002099003|55112099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	t8YxD0vHyy+FieCUdYYqHLTr07rkR4t18q21AfL1R1fj6bMLGWUA4CyrIuF5gIO0P2i/0yrlY8moguueGKPGQm7gQjozKtX8KGaYyty9PEq3i1WWwOEMV6Lw9cohvsEdKylMx94THyoK4oT8IDRvH5oMao1jG9PtKozE72+o/jkxpp9tRqzfSPIToP76PbT8tkLDGs+t0s97bZE+DxOObhqND6Rhj3MRFm0xyVKd/2ZnXdY993Ke0h3R2relkay2Tn9PeMmnD6Qm8LWjlFwnajIsISQKf5XMhFEqrgcsFMhvc5r/eIk/E/ICurSwZG38cVyJi6b99NkEfHe/XBffZrT6pxy22HwX9zsMZ9XRUxgtQxNJhg1DUcU6SmCfM+BMzXPe4FDiWZGYkxKRg5aJsFi1kYQ41MikTXwqttuIoAmNp3qwyxJBYGaBB2lDOFmUB0d56zyazqrBHlvarMvcIbTZUiSCwUbtOX3/MDxjXEYS5KuieLPqKf31ZZFXA8nHbYpbB3/4Zve97f6wHcsrxkPoVOvgDp2b730c9HIxR9h/DmYj9GE4qaAXuPJJbt4O4ohv5v6goHiQKCqlaIGzi2wxAL4VjSoZlkXp1S0m+H1OnTc5YDZGuh6iMzshB7dUNUZzZrslB4dRWWS3YbnmJU1CSEjSf5ULuabrEE00L0s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(55112099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L21YaXhGSWJtdEVWbFNybTQ5bFRBcTcxK3RqdlQ3RXJqNmNwdTk5N2l6YmRG?=
 =?utf-8?B?K2NvUDB0OFA2Y0VSOGFCSktjTlZycm43M2FpT3FQV1M4QzJna1JBZTZUcGF3?=
 =?utf-8?B?S0RZdHVqaXFjMDNObmJlYjh6aVVzalhCbXZYdnlyOXU4Q1RpeGlpY1ZxSk1j?=
 =?utf-8?B?WHZXZm5rOXlpYloyUEdNVFREelZpMGFyVFRaSU5EeVVnc00wbG5QUjZrTm9a?=
 =?utf-8?B?Um02UWNwWkozTGJNd281Um9sbGhHVUhXVkRtUGkrWjUxSmhPcDFiZVloRS85?=
 =?utf-8?B?a05EUWJFTnhrSTgwUXVVN3lVQis3eE53ZUd0WG5pUkd2ZDFkaTVGdC81a0l5?=
 =?utf-8?B?dHJPTnBFNEFTeHlrQUhyYjBGa2cwU0FTbjlFTFE3c1duSUYxaC8vMnJxRlJW?=
 =?utf-8?B?SzNzMUVBczBnaHJsSHJFdXNEdkUwREpsdTNuRm1YZUFZdzJPeU9aT3krSi9N?=
 =?utf-8?B?MGoyczJCN2M4V3lQeEREUzNyS0MxcEI4R01SR09RN2Yrb2cyQXM5STltMEtE?=
 =?utf-8?B?US9tNXdmRktneWJRQU1zdDBYb3M2RVYzeGJHTFQzdCtweE5XMGNQQWI0aXMr?=
 =?utf-8?B?UG9CeDhsN1ZFYldhdjBJUnlQU25yakIzNlVPalVNamJiNDRmbkloeHh3M2Ez?=
 =?utf-8?B?Z1JSeTJNMWFEYitsb2tPM21mL1R6aEdQa1hMTzcycUxxSUJyZjJTNW9aUVly?=
 =?utf-8?B?ZFZyN2Z1ODZYU2xoTExlRVZQcWhQanNJREZkdnZaME4yclZTR1hZV0ZtSzNk?=
 =?utf-8?B?L3Q3QWVvS0NSSCtFOUhjNGlxeDhZOTdoMis1SnQ1eVRTaTRxVWxzcVNJUGIr?=
 =?utf-8?B?eVNLdzFXRG5GSUd4L3N1TW9mcGVZSHZ5MjZ2T0docEJZenRKcnpMc0w1V3Vw?=
 =?utf-8?B?ZHdjWVFvU0J0S0Jzaytic3lLcXAwZEJLOUZia21BMENvcEhQbkwzbWIvTnEr?=
 =?utf-8?B?KzM4U1NWRHo5SGJnajcvVk1ndFE5bHY0b0hPdG96ZzQ5dGtNMGN1RmthMVhT?=
 =?utf-8?B?NUZMYnM1QndDU2JwTytkdWdZeUEzcUhPbnIxZnQ5TUVPbGhyQ21iVGREbmlJ?=
 =?utf-8?B?MDBrZm1lT0VoeEFCcFEzK1ZrcXhzc3o5V01IVGJWUi81MlFxVkxOaUxML1ZE?=
 =?utf-8?B?WXJFL3ZScEhGRXNRbmt0NU8yelVjTDZnSWV5NkdQT0Jab2pMY2tQNkRuY2RR?=
 =?utf-8?B?OVRzLzdnUHl3eXRFbFBiN1lOQUNqYmVmWWRjdjFkYU91LzdhMHJEVjkrOHpz?=
 =?utf-8?B?aXdqWExxb0JhR2E3WDc4eW56Sk9GUEZ3WWZVQWM5Q3l3SmJva2dPU2RhTDR4?=
 =?utf-8?B?QUV3UWFNWEZhYWRHcHQybVVMZGRBQzFoNGY3L3JXbzE4ZTZCSEx5R0grRkpz?=
 =?utf-8?B?ZU92T0tpNjI1WTFLbmdoUlFEUDJUZk1GQ2xDQnl1Ymk5R1VIVzR5N2p2WjFq?=
 =?utf-8?B?ejBlSkF5YVpReEVJOFNhcUpucFVRZzcrVjk3eGt6TFZyWUZaSFZUQWtSd3Nt?=
 =?utf-8?B?UVYyS1VQbXNFazNvWGRoNFYvL3JEWWpRN0g5OGVRV0NSQW5FNlFaOGhNdDNr?=
 =?utf-8?B?OUpGT0I0b1kyemVOa2NNVU41bDRhT2VNd09mcDM2V3Y5ci83Q2JvMHVzZW1h?=
 =?utf-8?B?RXhxZFpvQjhyNjZlUUE1UGF1eVl6UFNaL0p4Y0ZMQ2l4bjhjSjU3Z09NNnBo?=
 =?utf-8?B?d3VjZlBhUnZQanZzcnBlTHlmdTNwcHJlaEVFRkl4SmJ5ZmFlcUV0VHRQMVRi?=
 =?utf-8?B?NGZ3ZUhyRm5ITWdDdWl1VnNQZmVVRmkyNTJyellWTnBoT1hZRDQzSTBIdUJI?=
 =?utf-8?B?WTVTYTlVUTF4SEFtMGgvNzJ2czk5bkZ4Q3k4OC9OR0ozalQ5UzR5b2Nla3oz?=
 =?utf-8?B?N1lqRUMrbVhJSkNBc2h5K240ZnJVQm42Q29BRGN4MisxMTlwWkp6Y1ovc1Aw?=
 =?utf-8?B?b1c2TW9Tb0pLLzU2K3QzeWJUbytOVXVrM0hXWGx3UlpjVmRudHpXVllRYUNE?=
 =?utf-8?B?eklsaGZ0TC9Yd0YyTERicXhBdmd6cjhoWXJNWTdXNllROXkxa0dLVzZidXEx?=
 =?utf-8?B?NldBSldDajNjZVdiVm5GNlVFTk5XTWdlaUkvNkVWYkYwNVM0SGY3UVcyR29m?=
 =?utf-8?B?cEg1WFJVc00yM3pBMTZaTjlXQk9vYzh3bDJlamd4S3RGSzFWR3hDQ1YrS0Fj?=
 =?utf-8?B?TDVHc1ZwM0JmSFBEZWtobHJSVzRKWVBIc0FWLzlYT0NsSnExbitqbzRwQXBV?=
 =?utf-8?B?NSsxdFV3ajFwbk5aUFcrczNlVlQrM2FvWWdEZUE5SDVFQTZlb3BJQytDelFx?=
 =?utf-8?B?ZUw4VWMxTzJtcFZVZDlEVTFubkNUL2lRbnRGV1J5ZG1sS2Z1UEJqZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090485c6-e8ea-4cab-7796-08df02b93cb7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 14:57:52.2137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiwaK88Gs/GADW+QSYjnBvJCd1k56SqVKhgljke2wJ2xZUNaLG60v5G57crF+723B96VVK5KGZ/uH7xyjMj8Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5510
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Aug 2026 14:57:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24002

On 25.08.26 16:37, Quirin Gylstorff wrote:
> This ensures that the data cannot be accessed after a factory reset.
> To clear a device, attach `:clear` to the device string in the variable
> `INITRAMFS_FACTORY_RESET_DEVICES`, for example:
> 
> ```
> INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var:clear"
> ```

Why this extra control? Why not clear automatically when there is no
encryption or there is no TPM clearing?

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/factory-reset-script.tmpl           | 69 +++++++++++++++----
>  .../files/reset-env.tmpl                      |  2 +
>  ...bb => initramfs-factory-reset-hook_0.4.bb} | 21 +++---
>  3 files changed, 69 insertions(+), 23 deletions(-)
>  rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.3.bb => initramfs-factory-reset-hook_0.4.bb} (73%)
> 
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> index 94b5f8b0..8f95d780 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> @@ -2,7 +2,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2025
> +# Copyright (c) Siemens AG, 2025 - 2026
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -13,11 +13,27 @@
>  
>  . /scripts/cip-initramfs-functions
>  
> +# entries of INITRAMFS_FACTORY_RESET_DEVICES have the form
> +# <device>[:clear] - return the device part
> +target_device_of()
> +{
> +    echo "${1%%:*}"
> +}
> +
> +# return the option part of an INITRAMFS_FACTORY_RESET_DEVICES entry
> +target_option_of()
> +{
> +    case "$1" in
> +        *:*) echo "${1#*:}" ;;
> +        *) echo "" ;;
> +    esac
> +}
> +
>  check_partitions()
>  {
>      found=0
>      for partition in ${INITRAMFS_FACTORY_RESET_DEVICES}; do
> -        if blkid | grep -q "$(basename $partition)"; then
> +        if blkid | grep -q "$(basename "$(target_device_of "$partition")")"; then
>              found=$((found + 1))
>          fi
>      done
> @@ -30,23 +46,34 @@ check_partitions()
>  target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
>  
>  wait_30sec_for_condition check_partitions
> -

Keep this.

>  if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
>      log_begin_msg "Factory Reset"
> +    # service watchdog in the background during lengthy re-encryption
> +    start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}"
>      for target in ${target_devices}; do
> -        log_begin_msg "Reset device: $target"
> -        fs_type=$(get_fstype "${target}")
> -        case "$target" in
> +        target_device=$(target_device_of "$target")
> +        target_option=$(target_option_of "$target")
> +        case "${target_option}" in
> +            ""|clear) ;;
> +            *)
> +                log_warning_msg "Unknown option '${target_option}' for target '$target_device' - ignored"
> +                target_option=""
> +                ;;
> +        esac
> +        log_begin_msg "Reset device: $target_device"
> +        fs_type=$(get_fstype "${target_device}")
> +        case "$target_device" in
>              *by-partlabel*)
> -                label="$(basename "${target}" )"
> +                label="$(basename "${target_device}" )"
>                  ;;
>              *)
> -                label=$(blkid --match-tag LABEL "$target" | awk -F= '{gsub(/"/,"");print $2}' )
> +                label=$(blkid --match-tag LABEL "$target_device" | awk -F= '{gsub(/"/,"");print $2}' )
>                  if [ -z "${label}" ]; then
> -                    log_warning_msg "Could not find any label  for target '$target'"
> +                    log_warning_msg "Could not find any label for target '$target_device'"
>                  fi
>                  ;;
>          esac
> +
>          if [ "$fs_type" = "luks" ]; then
>              if [ -n "${INITRAMFS_FACTORY_RESET_CLEAR_TPM}" ]; then
>                  # after this the data on the encrypted partition
> @@ -56,23 +83,35 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
>                  # use a variable from the reset-env to set it
>                  fs_type="$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
>              else
> -                target=$(find /dev/mapper -iname "*$label")
> -                fs_type=$(get_fstype "${target}")
> -                echo "luks device detected use $target"
> +                target_device=$(find /dev/mapper -iname "*$label")
> +                fs_type=$(get_fstype "${target_device}")
> +                echo "luks device detected use $target_device"
>              fi
>          fi
> +
> +        if [ "${target_option}" = "clear" ]; then
> +            log_begin_msg "Clear device $target_device"
> +            device_size=$(blockdev --getsz "${target_device}")
> +            if ! dd if=/dev/zero of="${target_device}" bs=512 \
> +                    count="${device_size}" conv=fsync; then
> +                log_warning_msg "Could not clear partition $target_device"
> +            fi
> +            log_end_msg "Finished clearing device $target_device"
> +        fi
> +
>          case ${fs_type} in
>              ext*)
> -                /sbin/mke2fs -L "${label}" -F -t ext4 "${target}"
> +                /sbin/mke2fs -L "${label}" -F -t ext4 "${target_device}"
>                  ;;
>              btrfs)
> -                /sbin/mkfs.btrfs -L "${label}" --force "${target}"
> +                /sbin/mkfs.btrfs -L "${label}" --force "${target_device}"
>                  ;;
>              *)
>                  log_warning_msg "Unrecognized filesystem type ${fs_type} - could not format"
>                  ;;
>          esac
> -        log_end_msg "Reset device: $target"
> +        log_end_msg "Reset device: $target_device"
>      done
>      log_end_msg "Factory Reset"
>  fi
> +stop_watchdog
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
> index 07e2376a..663b0af0 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
> @@ -2,5 +2,7 @@
>  #
>  # SPDX-License-Identifier: MIT
>  #
> +WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
> +SETUP_TIMEOUT="${INITRAMFS_SETUP_TIMEOUT}"
>  INITRAMFS_FACTORY_RESET_DEVICES="${INITRAMFS_FACTORY_RESET_DEVICES}"
>  INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE="${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
> similarity index 73%
> rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
> index 670725b7..c192c38c 100644
> --- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2025
> +# Copyright (c) Siemens AG, 2025 - 2026
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -15,13 +15,15 @@ MAINTAINER = "cip-dev <cip-dev@lists.cip-project.org>"
>  DESCRIPTION = "Delete the content of the given Devices"
>  
>  # list of partitions by label
> -INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var"
> +INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var:clear"
>  INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??= "ext4"
> -INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= '0'
> -INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?= '1'
> +INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= "0"
> +INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?= "1"
> +INITRAMFS_SETUP_TIMEOUT ?= "600"
>  
>  # to support factory reset on btrfs, add 'btrfs'
>  INITRAMFS_FACTORY_RESET_FSTYPES = "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
> +INITRAMFS_WATCHDOG_DEVICE ??= "${@'/dev/watchdog' if int(d.getVar('WDOG_TIMEOUT') or 0) > 0 else ''}"
>  
>  SRC_URI += " \
>      file://factory-reset-script.tmpl \
> @@ -33,17 +35,20 @@ FACTORY_RESET_HOOK_TARGET = "${@ 'local-top' if bb.utils.to_boolean(d.getVar('IN
>  TEMPLATE_FILES += "reset-env.tmpl factory-reset-script.tmpl"
>  TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
>                     INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
> -                   INITRAMFS_FACTORY_RESET_CLEAR_TPM"
> +                   INITRAMFS_FACTORY_RESET_CLEAR_TPM \
> +                   INITRAMFS_WATCHDOG_DEVICE \
> +                   INITRAMFS_SETUP_TIMEOUT "
>  
>  RDEPENDS = "factory-reset-helper \
>              initramfs-cip-functions"
>  
>  DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, awk, \
> -                    factory-reset-helper, findutils, initramfs-cip-functions"
> +                    factory-reset-helper, findutils, initramfs-cip-functions, \
> +                    psmisc"
>  DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
> -HOOK_COPY_EXECS = "mountpoint findmnt mktemp basename \
> +HOOK_COPY_EXECS = "mountpoint findmnt mktemp basename dd \
>                     mke2fs awk blkid rm get-factory-reset.sh \
> -                   chattr grep find"
> +                   chattr grep find blockdev seq fuser"

fuser: see patch 1.

>  HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
>  
>  OVERRIDES .= "${@':btrfs-support' if 'btrfs' in d.getVar('INITRAMFS_FACTORY_RESET_FSTYPES') else ''}"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

