Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0011C98302
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 06:58:59 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.63])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1531.1790146738564171062
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Sep 2026 23:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DLFLaKd0;
 spf=pass (domain: siemens.com, ip: 40.107.162.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=darA3pKU8dBZRGeUGnP7++8N1jFzSrRCF7dZPvklvpjFSA0FiokPQ+KyUyw8xUMgWnFNZwy8qckIfd6tPrfKjyibEhUDh8EH33w083LOE1GQBm7N3++WuZv3hKNrChdP79EPVDyfyEd/XiwOAJ/g90nEO63Stvo52QYMQd+lWa4pAICcU3Ir7uFLq65WlUwF7jTxQ4OrY3rfikfQTSvpPUdPWjp0PY7CmsmUfxX2LWt2fELD2QrJKzBlZyD1gM6DWqvFrYxV+oGb48Gll7XBBgEEHhLnIr3WVSmuppVScjcTB32IXpYj/ngfC4Sw4qAgyNWT205P1ALN6SVtwA4cqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAIP/ggVnFdmF+C2DnCIPdm92Mn9Y1yLK0R8OVmCMOA=;
 b=zG3rlyiF6Pqd/IhgWwbz7Ej7nupSs37CXjtCAwDROX24YokEqTCqieKxgFjrA9D9sOqwOVRdLK57QplOs1mwWwrFxdcWW8QhBUXt6MxnLG6pCDxaeKkl5fgqUTUZMNUn9Tk7xzFKVowV6YvX34tck/qxr1Qk0fTQ+TE4GstTPBnBseYjmhrER65j0O9X722UdZd9+X2bIj2KPNTsTgvchfxvYoAAjTHGPN0gkXx0bEdo1f0Zci6O2A6CWNB5qfWJzemX6bStKkw11sGvFKdspNfyTUFl7kGI+DyXbWbymGvq2mQE3q6zWkHQ1lyBTH4lijNYyZ+Uz9Mgi03H9ahRVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAIP/ggVnFdmF+C2DnCIPdm92Mn9Y1yLK0R8OVmCMOA=;
 b=DLFLaKd0lqgnMY0802Ulk4eqpwK/pzSETFs4m4uyN+KG7TcULhPST9qnRiD5gtFSGwh/ejJOX3h08MDxODJQVbh9WYRSdNO/OAQ2N4wTm4c+Uono48FgpC8MHEZ40oONDvVwZMiN2YzmChxgt7cdnzEvkYLGBf9uTXApvvlIgrBBhe79t3G0517ZwUrNSbsbrg5bkyifnkRc+0sY0mviN/P3439TZYMTB4urlEWiP9UfRA3kuEmHWSXbqd9vk1jI1w4o+OL+KLOXHronuRhR9lK3qoYZVE+A4Dn13vKNzRN2pNRkHN3qkGcivyt5jWKdSffL/1HXsZK8rstCskKaRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7403.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 06:58:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.012; Wed, 23 Sep 2026
 06:58:54 +0000
Message-ID: <4d306c86-0b50-49b4-a7d7-3494d82fb37f@siemens.com>
Date: Wed, 23 Sep 2026 08:58:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 2/3] initramfs-factory-reset:
 Add option to clear partition before new fs
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, alexander.heinisch@siemens.com
References: <20260917161425.666709-1-quirin.gylstorff@siemens.com>
 <20260917161425.666709-3-quirin.gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260917161425.666709-3-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a95f91-5abc-4437-0398-08df1940215b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|3023799007|6133799003|10067099003|56012099006|11063799006|4143699003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	BssOH8u1FlX9AaF+0BZnxzsyYFBmz7cos8aFbLWJ32dntuTmC2JwfOJ26uhC0r1VJala3OKuxemDAgVp/vx36xBy4+kYKNtWPSCi73D40Lvm1+d499uP1DeLVepOF8uR6t+5HLihOQNehjll7jCJ4UTvW8f1cUZhRT1zBL35Z9JZnxe+1O4UL49OWBZXNLlBaJVcW2uO07e5Wufq6Na+p+lWvZonULQrIKIF4t5ZrWtURIwaaBVO3imUOFvelosdQ7+5w6BEpDjoBhI5Xy7+3q2vUlJUzB43k0ccDrXg8n0mQswKClsxPJpo/TJPHnh1Uh8rJV3R49hXKWuSb+wljAnnKlgprDLtwDyUUVwNYZ0FmZH3LAm03Wl6SX8dOd2ZGK5clAjdfC5CIwBlKuicByjNYx1396xXhWbZM68rvlx7yTjc0Gd+7zNJNdBDh1kCnY++e/lw3lIxkJEntfsh2QeoOfP8K7n/M9+CTOdCT9Ua5hplHnQZHFveYaMIxdQXdUp+/6Za1G98W2ZukPsXjEwdInahjZJ1/Yjk5Oz72i38akkTRcBi4BQz/PfoyIr4FF84uI5vKUvxDFn7kxdj20IUghNL/Nk7es+DUiCnHEmZLgbOPSKbjmD5XO1ckMA2c4o72XLyKmhp9qL7PtwIpdPXLUZSgx5/ExFW75MDzxg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SnhNbHFsNUczQmQxNnd1QTdxYy9zZHNEMHpwT292RGFTeWxqdCt5SzlqUEdy?=
 =?utf-8?B?TWlWblFaZC9iSVZmZGEzYXhJRExIN0VRQmN1WGVUWjN5cU9mcVhuY0VtRGJ0?=
 =?utf-8?B?Z3FKSnFocEhLY3dvYXg1TmVWb0pTL1NoQ3NKS2lYZzF1WUNBTXRkUDluaUdO?=
 =?utf-8?B?SUZwekpCQVFCbHJFOHYzMWhGVFNuUHhROFN2YWVNZDNIVVpMUkZ0SmErcHBO?=
 =?utf-8?B?RktRczFHQXVWcUJvU1NPVTVtWkk4M0RDMjM4NW9leXZzUjRPbjFhT1R1cUhC?=
 =?utf-8?B?UnhLSjhjaHZlNjJFQ3JmRXlHbGpxMUVhaVMzeVA1MHRUbUlBNVBMaTc4TDY2?=
 =?utf-8?B?dmd3MkpFbU9SbXo2TWtxMW1FblR3dFdabE54RWp0cDRXeTlpUHFTRnAzRVJv?=
 =?utf-8?B?bGI0S1hkYzRRQWJEVlBZdnhCcitYYmJjSTFtS2Z2S1pERzJNTkE5QVkxUnF4?=
 =?utf-8?B?aXdIZXhDQldZdWQ4cUNqSTR0MkFDVi85eFU1ZG9BMXR0SUxuRE1WT1l5T1pX?=
 =?utf-8?B?OUN4RHBRV2d4SnZEYUtqOXgzZnhVNjVNb0VRb1NqdDZQa1c2ZHNLV1RCZHJk?=
 =?utf-8?B?Q0tRRTZ5VnRIMEhwd3FzK1JuSk5vS2o1VVZMSGZ2QmNPeDd2Q1I1WEhkckJT?=
 =?utf-8?B?SCtpT2NKcU8vNUMreDA3UGxETmV0dGpMa0hyTFdPZkgrcVRSM0o3N2ZOMk5x?=
 =?utf-8?B?QlI5aE9kZ3pONEFMUlNmaWd0RVVrbnhocGpxaVE3RCtlbWVHbXdUaEVabG5x?=
 =?utf-8?B?U3VpTE93SjJkWi9HRDZaUFJ1QXpJaHZieVc0a0JPSDNGWjZ3enA4QnNZNEVv?=
 =?utf-8?B?Y2Fwc29KeTJ3K2VObENWR2Y4Ry9HdVlvNEJhMkl6RnZONlE0bkJzZk9KUHE4?=
 =?utf-8?B?N3FCQ1huQzl2MEVRSkNJMlhPTzZHTGhyRlM3eUtLNVZrdHNrNWJ3WTZsQ3Jz?=
 =?utf-8?B?ZWhuVnAwcUo2SW54TldJcFY0SDdub3NkSzRjcmRzN21tbjlXQnkzcnN3ZjFX?=
 =?utf-8?B?SnA5SCtVK2tTSVQwWkpoY2lON2xBbkd1UmQwSnU5cG1OR1hMSllOR0d6QTVO?=
 =?utf-8?B?YWZ5Skw4dW43WkFLWU5pdVZOa3lSelZ6Rmo0MFljWVE0eHRMYXpiRGJBOExp?=
 =?utf-8?B?UDl2cDdjR3M3Mnd0RUw0SjZhZXBBdzdXS3BCQXYvQlAxelBoeEpnVzlPMHpa?=
 =?utf-8?B?TkdOMU1JbzRxcXdvTXhBdkFwRDN2cW4wVFB1UUxCakkxZU1qQlc5V2FmZk1w?=
 =?utf-8?B?VndmOWM4WGlTVVQ3a2NYL3dlZ1VvUXlUQVlzdG1RQnZLMjNsT0wrS1RqU1Uy?=
 =?utf-8?B?a3pvWkRXMDErSWhraUZ4N01OZVloeFNlU09Ub2ZPSzMzaDBCeHBuSHVPclZY?=
 =?utf-8?B?Nk5JbkF4ZVgvVFgydEhUSWJvVWFWQkk4V285SVQvdmVVT3hUUDBsRWtGS3FC?=
 =?utf-8?B?Q1hPTEkxUkdhNkRIa1RhMWt1TnRFT3RMQXRNLzBxelpvS1FqUVJqaWlOWnJ6?=
 =?utf-8?B?TVRvUVRpMi9pQ3BKVnlod0VFVWo4T1BrWjI2Mmp3bys5Q0lLNW12WmN6ZG9s?=
 =?utf-8?B?L3RuLzdrOXBUaVVLN25YUmdNK3BaWnNyMjJnK3hTaW9LZVFodTJMRHVzTWd5?=
 =?utf-8?B?T3IxRUtvOGcrdElwNlRRWE5pZ05RdlFTMi9vRXlJb01lMFVCeDV6aXVHaGpB?=
 =?utf-8?B?eGFGNVRIbDFySzFoZHp5czhlWHJiQUx6M3MveUlIazNRbWJNWHExQ3hRMENz?=
 =?utf-8?B?SFhtTUNnb3dDSEExeFNvMy9md0IyMk5SMTg2WGF3QjlsOTltNURHNmtwNklH?=
 =?utf-8?B?WVYxcWNIVlViL2xjMFpnVGR0cFJDcStNMFlHSlR4ZldlQTltbnlhcy9EdTYz?=
 =?utf-8?B?Mk9kaWVVekcwR3phbHRHLzJUS3FwTi8yL2lSaDNtYk1KMVE0R1lnN3lzYWQw?=
 =?utf-8?B?Qk9BN0kzcE8rektwRTRkalZ3MHRMRyswcVJGQkJqL01NWW9qZDliaEVwRnUr?=
 =?utf-8?B?dFdKUHdpRmFBK3ZPRk1pQUVvMnQzdmpyeUhJTUpjSElWcmZzby84ZjQvSjBt?=
 =?utf-8?B?dnpIK1ZnWmVoaHBueDJvZWVyc0ZNYXpsOFBlUUpaOGpITEF6NE9ZSWNkODBB?=
 =?utf-8?B?dmFKa2krcnp4by9jRnBmYjlpNThFbE83b3Z1OC9CZHUvQzBmVldoSTJ3VWpP?=
 =?utf-8?B?SmZzdkdMRjFVdXQwZGZHcFVxajNqWGVyb3NDd0lPTkZnYWRFaENjNThCaStz?=
 =?utf-8?B?RkhGdXNHWVRLVzZBdDlvQjRkWjRUOWZyaHExWWRUNEh6clpDSHp1VXFGd1Zw?=
 =?utf-8?B?dUppa2MxUXZQeDc1dlVmMVJVaEZMYTZEYUhGSEQ3MW9oWENjMjk1Zz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a95f91-5abc-4437-0398-08df1940215b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 06:58:53.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR5z7l+Mt/x4osVDDlD1OcKTkXWBJxvjmzH+SQ5kYTN2giqx5R3+yWXYAjSue4USc76WkYSmYGbcGLMOZ+p4Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7403
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 06:58:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24270

On 17.09.26 18:14, Quirin Gylstorff wrote:
> This ensures that the data cannot be accessed after a factory reset.
> To clear a device, attach `:clear` to the device string in the variable
> `INITRAMFS_FACTORY_RESET_DEVICES`, for example:
> 
> ```
> INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var:clear"
> ```
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/factory-reset-script.tmpl           | 48 +++++++++++++------
>  .../files/reset-env.tmpl                      |  2 +
>  ...bb => initramfs-factory-reset-hook_0.4.bb} | 16 ++++---
>  3 files changed, 46 insertions(+), 20 deletions(-)
>  rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.3.bb => initramfs-factory-reset-hook_0.4.bb} (78%)
> 
> diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
> index 94b5f8b0..e58b5460 100644
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
> @@ -17,7 +17,7 @@ check_partitions()
>  {
>      found=0
>      for partition in ${INITRAMFS_FACTORY_RESET_DEVICES}; do
> -        if blkid | grep -q "$(basename $partition)"; then
> +        if blkid | grep -q "$(basename "$partition")"; then
>              found=$((found + 1))
>          fi
>      done
> @@ -33,20 +33,25 @@ wait_30sec_for_condition check_partitions
>  
>  if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
>      log_begin_msg "Factory Reset"
> +    # service watchdog in the background during lengthy disk wiping
> +    start_watchdog "${WATCHDOG_DEV}" "${SETUP_TIMEOUT}"
>      for target in ${target_devices}; do
> -        log_begin_msg "Reset device: $target"
> -        fs_type=$(get_fstype "${target}")
> -        case "$target" in
> +        wipedisk="false"
> +        target_device="$target"

Could we split off the introduction of target_device from the feature
extension into a separate patch? Most changes seem related to the renaming.

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
> @@ -56,23 +61,38 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
>                  # use a variable from the reset-env to set it
>                  fs_type="$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
>              else
> -                target=$(find /dev/mapper -iname "*$label")
> -                fs_type=$(get_fstype "${target}")
> -                echo "luks device detected use $target"
> +                target_device=$(find /dev/mapper -iname "*$label")
> +                fs_type=$(get_fstype "${target_device}")
> +                log_success_msg "luks device detected use $target_device"
> +                wipedisk="true"
>              fi
> +        else
> +            wipedisk="true"
>          fi
> +
> +        if [ "${wipedisk}" = "true" ]; then
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
> similarity index 78%
> rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.3.bb
> rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.4.bb
> index 670725b7..ccb8a72b 100644
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
> @@ -17,11 +17,13 @@ DESCRIPTION = "Delete the content of the given Devices"
>  # list of partitions by label
>  INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var"
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

Please align with b31ad236d5d9. Actually, this variable should not be
set at recipe level anymore, now that we have two users. Maybe the
complex logic should go to distro config, and here we only define an
empty fallback.

>  
>  SRC_URI += " \
>      file://factory-reset-script.tmpl \
> @@ -33,7 +35,9 @@ FACTORY_RESET_HOOK_TARGET = "${@ 'local-top' if bb.utils.to_boolean(d.getVar('IN
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
> @@ -41,9 +45,9 @@ RDEPENDS = "factory-reset-helper \
>  DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, awk, \
>                      factory-reset-helper, findutils, initramfs-cip-functions"
>  DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
> -HOOK_COPY_EXECS = "mountpoint findmnt mktemp basename \
> +HOOK_COPY_EXECS = "mountpoint findmnt mktemp basename dd \
>                     mke2fs awk blkid rm get-factory-reset.sh \
> -                   chattr grep find"
> +                   chattr grep find blockdev seq"
>  HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
>  
>  OVERRIDES .= "${@':btrfs-support' if 'btrfs' in d.getVar('INITRAMFS_FACTORY_RESET_FSTYPES') else ''}"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

