Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF0F8FA80
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 14:10:15 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31314.1776780608371541040
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2026 07:10:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ua0csLFp;
 spf=pass (domain: siemens.com, ip: 52.101.65.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULT5gHf+rEqbc/bDCF29GdZzmsLmQMwOqSHzJqKcxLJoxedP1+dEyr8IwW6qPVreLdmTt6fdeNhJiBnKlbCYD0UZslO1TMkykCu3xWUbndVIRlxpDodPIVXngf08d8/M5nx6G+SdUYBccR+LD57EnKB5ZeXQLvEludPjeANByHhNoJCPzpaoc97RPHmAjroMdbPQsLljmqRVe6ubeIaxJX05VL5hNpGohg4LV6jihHYWOo9Sjg5dI2sLzCKPUTo6TGbB0g6huIzq9FTu6qIMcj4pC0SnWmnB6JsnAFxHT93O/Auy7R5Mmo+QIF9AbcDOO3LFwSYDtNeDQ/YYzUjY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VuKiHmEPWs+hmKrvzXmQOb6H8KJme3hp3/HbQ71cY0=;
 b=kH/+EiTHTquUiukkoNw9vcQH/yst+EPRn+PWXou4ySNnwTJFeO1E2D/9jwi0JDEzH4Hr7C4gVOMCXgByBGO0aSJnOIBUwLq6hbxbIXXoyDQhe5msbThATvlH59OYdr+QmYFj1iWVX/liSe4u/en3+AO1z+deGdPsSS9RE4NTjq8FOO1MtXLV84OtxgPHbya9v+XXpAdwgIOlCtA4ztKwAE9Y/A8UBrCTUK1FhcsJ2snxq+xCDyuZg2U+puYzc3msPoVDDFH/wMnQ0T34bd+swoOj2Ha2X8V3j18GD9LFx5jnoYeSZ7ihMbbDtrOehWTyjxlAMAEcvYKs0WYtMJQP3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VuKiHmEPWs+hmKrvzXmQOb6H8KJme3hp3/HbQ71cY0=;
 b=ua0csLFpuY2FftNGINYETJij9dLbsDJHowtoJ06uUrMy8IaffA745H7D8y3Hd+bDd6W/xcRSEuyZUyVfkWFqbu1Dqzf22S3YXzB/PfTyHZTbGXVY9B8kcFo1yzem1HeiRs6xCKe0OwKZUlbYo3rfwb0Q5KEOVcpU0It2xnVWVkfGkAFnvEs1D0kIar9caYoSVEcgVuarpGcAKrX8gO+ts1TDIp3fguAW2H4yhd7qhnabdMJES+Cnl4cOckWLevtYhLRTUzumSrhTlnu/+XVLF1s23RkQtlbKx1Wye8u60LND4JIk4eurq1qraKKUuOoN6N78YP9cvVYGQ2+shhAAug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6516.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Tue, 21 Apr
 2026 14:10:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.20.9818.032; Tue, 21 Apr 2026
 14:10:03 +0000
Message-ID: <9acbeb77-8539-43de-88e9-405185cbd7e0@siemens.com>
Date: Tue, 21 Apr 2026 16:10:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/2] initramfs-crypt-hook: add configurable
 mount options for encrypted partitions
To: Gourav Singh <gouravsingh@siemens.com>, cip-dev@lists.cip-project.org
References: <20260417113651.3923307-1-gouravsingh@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260417113651.3923307-1-gouravsingh@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: 6189345d-f789-4a6a-33e9-08de9fafaec1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|55112099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ozIg7jxMj9qeVWps0vU2iAPpsubrl63swpBytfdtv5I/z0wdZJMkJc4GjOnaEEFpU14Z81Sm5uECt2ZHOxc2vcYAVQZ9D6YXfH+VtB8FlDVFAopl7UW2EIngRwD0DYys8uYZUp9T9IWuQ5cDZ2ztwGhNIKzq7wLXEJOMXa6JPITMQsni2q3iuCeEuT6LfNw82r//rhhHaH/ZGjCabjBMRdu11vM+hBF+VA+PucXu4HAWoZoiF/o0i9hzFlHa0scLj0HX5OS9J4Vh+9ushGWbacc+6finnWUOjTb5UbhcCNaWm0AnNyHSQok/CKnYo2ah5J8oUtiAGSmoQu+WnNF/g2CW6YteO4mepykkE8F9fzhzPhcX4NHVMWpYSwhKATPCq9EuVrMHcdqmSUJKR0oAc/zSVrp+7M/tK0Li+2QomL7pTyCZ5USNzhsNZ0+PAUiBHJxR6tqYMKioUezDQzoEvp/BfQLZxxngKOL7J+4imUtGQBRUgyycWluviFFxGSs80iGJO9aMYVTWwIP7cc9eIfhog3pdL0hdEmnyVaBLd8tw2C6i4odFgTKxP4Av1iAb6VMjWd/UM8WV/UBnmCdKgch55PUxkSrnW/lUx3TKKPfgJMBJzs73MJglagzhNZlnAyssE/w5FfizvQfcM7yZrGbwpGyNHKdxAD8cegaprstwwp9eCa9b1WEY2Ph/An7LSiKrnRK6kzx6VVMajtO5DTSMSzkw3+cLbs72CW7PDZY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MkdtYy9SL3FZTnNpRGVvZFR3dWF3VHNtZjM2cFZoUUtXTmUwNFAyc1JCdWtP?=
 =?utf-8?B?Z1IyRFlweE5PY3RVR0YxWGE2TzB0eDNTYVhBS01kaVJvemRRS0wyZC9XRGJC?=
 =?utf-8?B?UEhhYXI0WVA0SHBiYkt6TEQzYTFYQ0RhOVdKYVJRSEtpdGlYQjF4bm14MVRn?=
 =?utf-8?B?SlQvazN0aFNzSmZsMFNYSHROMFAxczloNEZCTExMb0tyWWRuTkRWZEZ0NDlS?=
 =?utf-8?B?bTRHalJpQ2NqY3V2Z0tUUVB6L0paek90dklhRi83WU12aXdURmNJRFRldldO?=
 =?utf-8?B?bGkwYmJWKzBaRmtaWkMxQk91clE0QjFpRDVya2ZIdWhjbEdkcE80cTcyMkI1?=
 =?utf-8?B?LzU1UkhiODBwUG5reWtRajUrcDVvTjhCL1kwaWtBdnl6bVlTLzNSR1VkSWQr?=
 =?utf-8?B?eWZGOWxIOHZaYzdxeitYbFdKRFlhQWVkUjk3UHFseDdjZkRncy80QUwwck0w?=
 =?utf-8?B?aGhpRHMrc1VtZ0VvdmZnN0cyRjU3SUxLQ1pSaTE1MkN6bGVlZUpoYmlDUnla?=
 =?utf-8?B?NVVTN3BGK2NEdXExdzQwS1VpNXo5OUNZY1MrS1VjeGF6T2FWcGpwSXhjaU1u?=
 =?utf-8?B?cWNkTkN4TW1GU00vN2l0aW5WbktreE1xeUZoY2RmMFlNZXFwZlphdS9xcUNW?=
 =?utf-8?B?bDNFY0pTajdpNENTelpqSTQrdnVjT3FYd0JIWjFYZ2dqVm5rQjR6U3I2QlM5?=
 =?utf-8?B?Sy9ES1ZPV0ZvZjhIb0ZvYm1vQTlaVm51WGNnYnA1d1BPV1FOdER4bVFZMUhq?=
 =?utf-8?B?N05DcFhRMWk3S1lqOWJGSmpQdmZkVkVYeVFhQm9VVHdMNmcrRXBsRXBCSHNS?=
 =?utf-8?B?ckZuUEtORWFNRE1BeUh6cHh4a1hsUWtBeVUxRXczcENid2k0NzBhRlF4cWh3?=
 =?utf-8?B?UDZER3dLOW9jdXUxQldOY1RGb2FZUFA3bTV1Vnprd3dVZEZOMFNGbVpOV1c3?=
 =?utf-8?B?TGQ1bnNhL1J5YzJTV1pOdXZNa08zakxrM3dna1Fud3F1M0NaMFBnTVNsTSto?=
 =?utf-8?B?aldoTWVmcm10S3RJT09kRTBVWTZtR3pTbU9jVlFleVdrcS9OMnRWV3hxM2Zq?=
 =?utf-8?B?T3FsRXJEVzRDR01rMmJGKy9RTy9HZFZuL3gwOUIwUWhRYjFaa0hoQzE3RnVh?=
 =?utf-8?B?Ym9tT01BbnhTSVBndURWQzJBQzBFcjlzemhmczlpMG1tcUd1R3VSTjl5U2Na?=
 =?utf-8?B?QXlicEJUV09hYzY5bURSV3ZiTkJ3czJDZFpDYTlhTVpCSWp4OXpqVGZwamdp?=
 =?utf-8?B?OWlBWDlCRFp4SHh1TE1raUNJS0JMZzkzTWpNc2lpMC94N2VYL0Mwa1RyK2lD?=
 =?utf-8?B?NFd6cHhZNm1jQ3oyNUY1RG03clZ4WFJ6SUp6R3F3MnJOOXJaQ2RNZXRvcTJL?=
 =?utf-8?B?b3FkeWlPMEFSNmZUVWFqQ2FpSXlXamRpQVYwTGpWcDVDejQzTVRoakpoUERW?=
 =?utf-8?B?VllUVXFxNExNSEl2c213cFFZYlNMZE5FU0xmaWUvakZyOHlJeDNESXU0bkU1?=
 =?utf-8?B?YkdHb2Zya1VDL0l2aEtCWSt5RVdpKzBWd3ErSlFmdG9mRFE5YWZ2aWxMRE51?=
 =?utf-8?B?TCt5ZUpFbGVnamF2d2dEZDJVb01XdytqWE9jNk8rQ25XQmpZV0RKbDJpNnlq?=
 =?utf-8?B?STYyczJhcEJRcjRHZnpMSTg0Mkh2TWFuZWdBN3JTMnhBZFBPT0xNclBYUm9B?=
 =?utf-8?B?eEhFR1RBaFdncVdWajJOdTVsbVBoQ05RZnA0c2VUZmZaS3ExVSszalNxY3h3?=
 =?utf-8?B?U2xYNThXa2JJZUc3ZWtwcVZrU2c3T3h6TVV0eFVaUlVFbnA4b3BSZUVOSDlm?=
 =?utf-8?B?MXYwcVJVSERsOUlGV3QzaHl1YWNFL2t4dXEwTXZzQ3grQ1EyNjhqNDFJWjhl?=
 =?utf-8?B?VkFvZ1dUVE01UERiNkF1ZTd4L01ZV3BxTGpMcUphM0Z0T3lsVGUyTWRBK2Rh?=
 =?utf-8?B?NFYrU0lqV3ZDUDM3OVpMMy90UGJJQ0NIY3VCVU1ncUhxVHREMk9UN3JGMkdU?=
 =?utf-8?B?SDFUQllpeVlZc0JkRmJRVGdiRHErRVZjcmphVjdxY3psSk1xdGxybjBWSzdE?=
 =?utf-8?B?RVQ4cEZVcXp2QVYreEFpMEJxMWhuSmhpRVNnTDhXN3VObTJ1MUE4NkM2Vjl5?=
 =?utf-8?B?OHc4M0tXWmpkVDV4K1Z3ZVY3blpZVm1oWXFuWHpVVjVZd3RHcTM1RWhvQjh5?=
 =?utf-8?B?YmJNNEhCd0ovZHl0YWRDUEhOTUJpMDBnc0kvM1FEOG8zQ0FGUEo5N01DeVNi?=
 =?utf-8?B?MVQyZUtoWCtBb1VvNVBFQkY0OEd2UUY1eUpxQkptZTd3Rzh6WWFYOE1wL3FS?=
 =?utf-8?B?WTE3N3dJQ0xjM3oxVXIrQVdJb2NpUjJvOTNsdFAyYWl2M3BleHlhdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6189345d-f789-4a6a-33e9-08de9fafaec1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 14:10:03.4748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rs2RtOJf5DHxdS6dGpEeUdt4pjBe9c7r68LOg5hk3KzR4mCRA/qWEfi6PSeLop2tl4Bty3b49chLj2+RvZMHkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6516
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Apr 2026 14:10:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22777

On 17.04.26 13:36, Gourav Singh wrote:
> Introduce INITRAMFS_CRYPT_MOUNT_OPTIONS BitBake variable to allow
> configuring mount options for encrypted partitions at build time,
> following the same pattern as other INITRAMFS_* variables.
> 
> The overlay hook already sets nodev, nosuid and noexec mount options
> for the overlay storage device. However, the crypt hook was mounting
> encrypted partitions without explicit mount options, relying on
> kernel/mount defaults, leaving the same security properties unenforced
> for encrypted partitions.
> 
> Changes:
> - Add INITRAMFS_CRYPT_MOUNT_OPTIONS BitBake variable with a safe
>   default of "defaults,nodev,nosuid,noexec"
> - Expose it via encrypt_partition.env.tmpl as MOUNT_OPTIONS
> - Pass MOUNT_OPTIONS to mount_partition() via mount -o in
>   local-bottom-complete
> - Add INITRAMFS_CRYPT_MOUNT_OPTIONS to TEMPLATE_VARS so it is
>   expanded into the env template at build time
> 
> Signed-off-by: Gourav Singh <gouravsingh@siemens.com>
> ---
>  .../initramfs-crypt-hook/files/encrypt_partition.env.tmpl     | 1 +
>  .../initramfs-crypt-hook/files/local-bottom-complete          | 4 +++-
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb         | 4 +++-
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index 452714d..787172f 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -8,3 +8,4 @@ WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
>  HASH_TYPE="${CRYPT_HASH_TYPE}"
>  KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
>  ENCRYPTION_IS_OPTIONAL="${CRYPT_ENCRYPTION_OPTIONAL}"
> +MOUNT_OPTIONS="${INITRAMFS_CRYPT_MOUNT_OPTIONS}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> index 064e41c..d8516bc 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> @@ -36,13 +36,15 @@ esac
>  # get configuration variables
>  . /usr/share/encrypt_partition/encrypt_partition.env
> 
> +mount_options="$MOUNT_OPTIONS"
>  mount_partition() {
>  	partition_dev_path=$1
>  	partition_mountpoint=$2
>  	[ "$debug" = "y" ] && echo "mount device: '$partition_dev_path' to '$partition_mountpoint'"
>  	if ! mountpoint -q "${partition_mountpoint}"; then
>  		mkdir -p "${partition_mountpoint}"
> -		if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
> +		if ! mount -o "${mount_options}" \
> +             -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \

I re-indented this part during merge.

>  			 "${partition_mountpoint}"; then
>  			panic "Can't mount partition '${partition_dev_path}'!"
>  		fi
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> index 18a10a8..c0572f2 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.10.bb
> @@ -95,10 +95,12 @@ CRYPT_KEY_ALGORITHM ??= "ecc"
>  CRYPT_ENCRYPTION_OPTIONAL ??= "false"
>  # add support for btrfs encryption
>  CRYPT_BTRFS_SUPPORT ??= "0"
> +# mount options for encrypted partitions
> +INITRAMFS_CRYPT_MOUNT_OPTIONS ??= "defaults,nodev,nosuid,noexec"
> 
>  TEMPLATE_VARS += "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
>      CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
> -    CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
> +    CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL INITRAMFS_CRYPT_MOUNT_OPTIONS"
>  TEMPLATE_FILES += "encrypt_partition.env.tmpl"
> 
>  OVERRIDES .= "${@':expand-on-crypt' if ':expand' in d.getVar('CRYPT_PARTITIONS') else ''}"
> --
> 2.39.5
> 
> 

Thanks, both applied. Special thanks for proving a testcase along this!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

