Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBFBC05027
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 14:54:04 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.54])
 by mx.groups.io with SMTP id smtpd.web11.8172.1676645640572595787
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 06:54:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=owNFC+OI;
 spf=pass (domain: siemens.com, ip: 40.107.6.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwdLrPamaeCwdKR0Vnf5mH0Yub79nXkmXSqkY+ukbltED+MBbFJbgfquH9yR7/G/pJ0TRW3I9ejwOvr7uA69FPLCHwMAvYxyaKutebHpbxC0WgMLZBIOKqrWVxkN2ZD/a9u3YRZzgSB+5iTwXaZbzO/5jOr6hQjxusyYwsOXa6wkURGn6fwcX4Sbgn/iYBux5Od94uoI+w2kpNPy3+VoXB0ptVXlDHFy+equXaxXAgAzRmjh7YR+8U8xbxXlcORCw8IGA9buZ2LvJwD2xle+eoa4nK7vgLSc3ZzEJtbP8tDoRu/W9zjAczmCAH6ROdcBY3uhoUqyNUd9vrr7QwLtvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AVKss4UU7EVjOyZzCTyEnaXodOoVGZc5OMs1sc8p6E=;
 b=E/EvCJd+jJqaxlU/TEb6s1b0bvbU+GiEN6t8SCvZutFVuRpg13RgILeCHB3Ulb/g2TWi4vVSALxSDjShVjri0L+7kk68QFLpQEVMIVBEfMZ6HNFIonw10eIJgzlBRt5fg/Ykn2oW65beel3om/uljABmoQoc8gDOXWnVt83+P3kvcExX9fbqj+2lIIx+CX2xAQCAVQvMlWfe2MfIvvX9SSy8xhSR3Jsk7s9/j8AcsuIkAWUiPfly0eAJNjyA7KU3079uON04TYCDffKZDeL/6J0j7CtN+qxFXnWGGxvoij/oQy4BiPLhmPEObEWU0g9DQV2qaQc5LV2xfipZ386ovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AVKss4UU7EVjOyZzCTyEnaXodOoVGZc5OMs1sc8p6E=;
 b=owNFC+OIfjaIg9YGCNVy3MKVl5AgS5u+I9RtGhNX7zDWoyWR/lidlsSoI6jd8OoRjLWzs33BbDvTIDU7KKNyCoWYyk5wqZvYi8Qcnx1MGEf0KgrNyttGW3FAjcHC5MUSntwONc2jaM8ZQTidD0Q9JewXnvP9GW46qqmDh83+XudqqagbHuDGMJHcAFBm/IPq1MkIqtHJXNqrCxj/lj7DIeVaxdy7vZkX6TvtgC9CZNSLhrAk8/OAnJovWElCg+O5qu9AHP9X5515Y7eaG2admnGxw3gTaa57RvQGcMMIFnrE3flvWQ+/ulAhZOkQbrQaoxXjzbacPWuY8+/iL33ETQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB7571.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Fri, 17 Feb
 2023 14:53:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 14:53:57 +0000
Message-ID: <2012e77d-1892-1797-3161-b834ccebda86@siemens.com>
Date: Fri, 17 Feb 2023 15:53:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 4/7] Add initramfs hook to
 encrypt a partition
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
 <20230217130540.509910-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230217130540.509910-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0628.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: ed40a627-295d-4fd7-e0f1-08db10f6cbc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9GyLlubU4B4m8FzYwIJ5oaMVDqkNS6JFV7IjTIiAvheEHW3W5foxRJP+WNHZK9JpJwGqCM5dDHXLErwOg64SCP8sgb8k2XSa8orVsabkMb+g81by7aEDQc2RNraqhDhpNkX+2PRsBIhSWtqRv/yFen1UlEpxQE3UpWKXYwrl3WEZiL08Pdm8fs5/sAxf3wQWid6Z/j9WOopm3UzjElKBj65B/9v7DxuD1E1nXqVgP1UHJC8DOU5ViGxv6fuezWCsbzIVe7ozbvfzawcjFVfBoprLb3Q+GeIxI43EvOcK2RIGiFsOcoA/KdmWWZ9WDyU0OY3k1vnHpoSBCEhKEGXg3IsLi/ibjPGOgFRn6lNV3mlU2ufEZXS1fFjJ7lWcT/i+uUqfQGD5l4hduE+9qaip7IC56sNXTgB7jQUT1oKbQ8zP2u260SiZ4jp6ouldK+nWbkna0qgTTda3tlNwjzQrz6BgCGmGamguWU0gDWN9L0z68Aw1ZI3Lx6ZG8B+cU27DTDIYqpin8TzIcSNyCJbm8xcfeMrLutVIKqRTfh9ZUeOeUu9ONIkrIkFQYV3kiqHVIPlpvpPA+2edZR8Op5DdTMYkGtKyqz6WcKhMS5UHfu1lD+AYVE3gtFuynAW6mt/7b0Td+zl+EYL8LJXW4scu77fIYHF9S9W6GHB+7eXBYZjCcyENdoURqftyBSUQCmc5eTag6b9zeZ/K5WHD+MaITRzJ+DrgJtrRbzeVRZ5ZprTu6b5s0iAAJqK+6LIYvYCQdjH0dLsYKu0jnbnYEtupRg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199018)(8676002)(83380400001)(82960400001)(41300700001)(53546011)(36756003)(44832011)(26005)(186003)(8936002)(2906002)(30864003)(6506007)(478600001)(6512007)(6666004)(6486002)(86362001)(31696002)(5660300002)(66476007)(66946007)(66556008)(6636002)(38100700002)(2616005)(316002)(31686004)(403724002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RXgzZXp5RnFZQWU1cVNKbTJqSm12cTlFSjFQd3Y0OERGZWI1WWIrL25rWENF?=
 =?utf-8?B?Q1ZDUDcwSjJPTFp3bG1wRmNKZ1loMWgyVThkNGI0VzZEazZkQno0bXkrUFFy?=
 =?utf-8?B?eXRwblhqKzNyOUtFTk42c2ZkK1AxaHRNbG5JQjJFU1RQZ0FsSXo4OFJXSWM1?=
 =?utf-8?B?ejREMVg4dHh4c3BJT1BhcVZsR0NHTkwwQXBDbm5DNW0wSW5zMytlcy9LOStW?=
 =?utf-8?B?TURUcElaejY5bmtCTWNFRzgrMkhxYjdNSS9uU24wVVhUcWtrZmQ4YTVyUGh4?=
 =?utf-8?B?SFplSkxscEJZL21VTlkzaXZlZkY1OVlHOEJFelFJZktrVDIvc1p3d3p5WEdG?=
 =?utf-8?B?K05ndFdIUHAwcmVqbkdPZDBRSk5uUktodVF6eTRERjB4UXJWKzlFdVo1NlNp?=
 =?utf-8?B?a3h0NWV0Wlh0MUNBaEdLbzU1WXlBeEhrOExsRUlOREJicWdvbEJjQ1lhN1Q3?=
 =?utf-8?B?UDFHWkFaMXh4VURYZy8rbEthaVRPRXM5cEJ2TSs5N2VDOVh4NEZuSjZoend2?=
 =?utf-8?B?K1o5OUEwMVEvd1EzMVNERW56VndrRDVDWk1uOWJkNGRxMldQZWgzRFowdll6?=
 =?utf-8?B?YzBtWnZrazdHamRUSEh6VlhWQnh3emUwWVJES01RRUlGM1ZaNmEzdVlLVXRq?=
 =?utf-8?B?RFdrWjl2WnAxUzhMSUNsRDZocUNlZWI4ZThzT2xKeEVnSExwR2dGVVVyN096?=
 =?utf-8?B?bzhFTmFPWklvcFZXaVYxYlJMRjhKYVVESUVqOFlpeDgxRzJRd0h6RDVzUUZa?=
 =?utf-8?B?ZVpPUENrMHpBa3cvVmhCcHZwMDlFQVlETWd2TDVCMnpRTXpXR3Z1Rjh2NW1L?=
 =?utf-8?B?VXA2K0RXSGs3SzRraG9KVDFLZDNZOXlLOHJwckdqQzZ2aE9BNDdybmcxV01z?=
 =?utf-8?B?S1VtdTZQT1RVcVJONm45U0FTdjZqejhDQUtQeDlCUnlHb3AyOHZmSVZOdnEz?=
 =?utf-8?B?RGdWLzF2Qk40NE9GOXdSakVyWkZncGZ2YkVycE5Ma0ZZM0F5L2tGSVcrNWM3?=
 =?utf-8?B?YUF4SS96YWNxamErd3c0eTMyckt3SHZnb1ZUVDJVZ2ZtWHF0ZkZJS3ZXbnZR?=
 =?utf-8?B?UTNsdXY4V0NYOWpFOU93anpHRnVhQ1lxbm9YaWZ3VEVZazJ4aEtQd1Z2MlQx?=
 =?utf-8?B?VDFSWmRsbjBLMW5tWWk5YTMrT0xLUjVaVndDVDM3WXVGWWw2MlJsQnRGd1lC?=
 =?utf-8?B?Ty9DUkNoZlRwKzM0ZWtYMkg4VVpKVkJkRTQ5b0N3Y1V2MW1MQ0VlNHZweWtG?=
 =?utf-8?B?OVhHWmZzSFFnNE1kajltQ29RSFBvYlFMRERZTk9jc2c3TU9FelZOcmJyQTVB?=
 =?utf-8?B?clg0VjNRakg2MzU1RVg4Tk55cXBHeDgyNmEyOVp5d0JOZUNBTmF1OExDdG1Z?=
 =?utf-8?B?RGtObk5NOUozZzczMFo5Vm5nczFialowZEI3RnZ5V296RiszQ09YZjNZOWFp?=
 =?utf-8?B?NEZpSGhPNjdNTmRQN0lCY2xBN2xGbndsM29DMkEvYUFsREFZMTBlWVErV3hj?=
 =?utf-8?B?d2hmdzhET1owN2ZLVXhWdGVtbXRFZm5YMVZlT0RyQS82N1lHRmIrSlNMTHEw?=
 =?utf-8?B?ZVlzQ1Y1TzNOdC81M00xL0hPekIrRmpHc2tQRndueHdnb1liOW1ZNHhkMDJK?=
 =?utf-8?B?UTJFdmRZMGpQTkNqbEFxd2ZUcE9rVTFUdGI0TDU2a2FrTWlnRVUxczdySGJD?=
 =?utf-8?B?L3RXV3E0VndkSDJxKzBLMkhjNWhaZUlxV0FqV1V5eG9IdlhmYzBjM3hIVFlw?=
 =?utf-8?B?RTRKY0VkMm1MRmE0WlV0OG1IM0VRSGhtVUdmbXNNMC9MTXkrbmxiUC8zU1k4?=
 =?utf-8?B?UFljMDN1d09rc3hEN0h2enhQWkc2TlRHaThucDBLb2VZTEl3Q2hyREpsSVZW?=
 =?utf-8?B?L3NJME82Q2p4bnlFSmJLMTJqa1o4MTdmemtJbTA3MzM5WmZpRTNrbGJLT3BU?=
 =?utf-8?B?bFRWWkhrOTNEbWlsOCtlV0dDalpFVHZMR1FWT0F2TlFBYWpwZ0krdkZhbjRw?=
 =?utf-8?B?S0loMlZhcnJlbkszUXNBbERuSW5LWUVNeGpNUzZKVHBydDQrNkNJM1hydkpI?=
 =?utf-8?B?clBLWFpaTElTaGtEeS9RRFF2bGY1RGYvRElpZUtoazFkTUlrU3BuakdIMWdl?=
 =?utf-8?B?VUhpaXMxcDVSeUxWRVZPOGpuZXQxZ2ZKZnJRMEZnZ3lFd3RLVEMxNHM2dUti?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed40a627-295d-4fd7-e0f1-08db10f6cbc4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 14:53:57.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxTK/dp6sXZ1zvAapiydJ6aLh4aY47m+TNIe8HTQxL7LQCm/aT2W3C3jeNdbhZMmrySbHXgkzqigfWvZuTNhiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7571
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 14:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10723

On 17.02.23 14:05, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This creates a new luks encrypted ext4 partition with a the
> key stored in the tpm2.
> 
> The initial key is randomly generated and removed from the
> LUKS partition. Therefore a new key cannot be added by the user
> and if the LUKS header is corrupted the data is no longer readable.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/encrypt_partition.env.tmpl          |   2 +
>  .../files/encrypt_partition.hook              |  49 +++++++
>  .../files/encrypt_partition.script            | 135 ++++++++++++++++++
>  .../initramfs-crypt-hook_0.1.bb               |  37 +++++
>  wic/x86-efibootguard.wks.in                   |   4 +-
>  5 files changed, 225 insertions(+), 2 deletions(-)
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> new file mode 100644
> index 0000000..943fe4b
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -0,0 +1,2 @@
> +PARTITIONS="${CRYPT_PARTITIONS}"
> +REDUDUCE_DEVICE_SIZE="${CRYPT_REDUDUCE_DEVICE_SIZE}"

Did you mean "REDUCE"?

And what is this variable for?

> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
> new file mode 100644
> index 0000000..96e084a
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
> @@ -0,0 +1,49 @@
> +#!/bin/sh
> +# Copyright (C) Siemens AG, 2020-2022
> +#
> +# SPDX-License-Identifier: MIT
> +
> +PREREQ=""
> +
> +prereqs()
> +{
> +     echo "$PREREQ"
> +}
> +
> +case $1 in
> +prereqs)
> +     prereqs
> +     exit 0
> +     ;;
> +esac
> +
> +. /usr/share/initramfs-tools/scripts/functions
> +. /usr/share/initramfs-tools/hook-functions
> +
> +manual_add_modules tpm
> +manual_add_modules tpm_tis_core
> +manual_add_modules tpm_tis
> +manual_add_modules tpm_crb
> +manual_add_modules dm_mod
> +manual_add_modules dm_crypt
> +
> +copy_exec /usr/bin/openssl
> +copy_exec /usr/sbin/mke2fs
> +copy_exec /usr/bin/grep
> +copy_exec /usr/bin/awk
> +copy_exec /usr/bin/expr
> +copy_exec /usr/sbin/e2fsck
> +copy_exec /usr/sbin/resize2fs
> +copy_exec /usr/sbin/cryptsetup
> +copy_exec /usr/bin/systemd-cryptenroll
> +copy_exec /usr/lib/systemd/systemd-cryptsetup
> +
> +if [ -x cryptsetup-reencrypt ]; then
> +    copy_exec /usr/sbin/cryptsetup-reencrypt
> +fi
> +
> +for _LIBRARY in /usr/lib/*/libtss2*; do
> +    copy_exec "$_LIBRARY"
> +done
> +
> +copy_file library /usr/share/encrypt_partition/encrypt_partition.env /usr/share/encrypt_partition/encrypt_partition.env
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> new file mode 100644
> index 0000000..e58794e
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
> @@ -0,0 +1,135 @@
> +#!/bin/sh
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +prereqs()
> +{
> +	# Make sure that this script is run last in local-top
> +	local req
> +	for req in "${0%/*}"/*; do
> +		script="${req##*/}"
> +		if [ "$script" != "${0##*/}" ]; then
> +			printf '%s\n' "$script"
> +		fi
> +	done
> +}
> +case $1 in
> +prereqs)
> +	prereqs
> +	exit 0
> +	;;
> +esac
> +
> +. /scripts/functions
> +
> +# get configuration variables
> +. /usr/share/encrypt_partition/encrypt_partition.env
> +
> +# load necessary kernel modules:
> +modprobe tpm_tis
> +modprobe tpm_crb
> +
> +# fixed tpm device or do we need to find it
> +tpm_device=/dev/tpmrm0
> +partition_sets="$PARTITIONS"
> +
> +open_tpm2_partition() {
> +	if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
> +		 "$1" - tpm2-device="$tpm_device"; then
> +		panic "Can't decrypt '$1' !"
> +	fi
> +}
> +
> +enroll_tpm2_token() {
> +	#check systemd version and export password if necessary
> +	if [ -x /usr/bin/systemd-cryptenroll ]; then

And if that file does not exist? No error? No bail-out?

> +		systemd_version=$(systemd-cryptenroll --version | \
> +							  awk -F " " 'NR==1{print $2 }')
> +		#check systemd version and export password if necessary
> +		if [ "$systemd_version" -ge "251" ]; then
> +			PASSWORD=$(cat "$2" )
> +			export PASSWORD
> +			/usr/bin/systemd-cryptenroll --tpm2-device="$tpm_device" \
> +										 --tpm2-pcrs=7 "$1"
> +			PASSWORD=
> +		else
> +			panic "Unknown systemd version: '$systemd_version'!"
> +		fi
> +	fi
> +}
> +
> +reencrypt_existing_partition() {
> +	part_device=$(readlink -f "$partition")
> +	part_size_blocks=$(cat /sys/class/block/"$(awk -v dev=$part_device 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)
> +	reduced_size=$(expr $part_size_blocks - 65536 )
> +	reduced_size_in_byte=$(expr $reduced_size \* 512)
> +	reduced_size_in_kb=$(expr $reduced_size_in_byte / 1024)K
> +	resize2fs "$1" "$reduced_size_in_kb"
> +	if [ -x cryptsetup-reencrypt ]; then
> +		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "${REDUDUCE_DEVICE_SIZE}" $1 < $2
> +	else
> +		/usr/sbin/cryptsetup reencrypt --encrypt --reduce-device-size "${REDUDUCE_DEVICE_SIZE}" $1 < $2
> +	fi
> +
> +}
> +
> +

One newline should be enough here.

> +if [ ! -e "$tpm_device" ]; then
> +	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
> +fi
> +
> +for partition_set in $partition_sets; do
> +	partition_label=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[1]}')
> +	partition_mountpoint=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[2]}')
> +	partition_format=$(awk -v var=$partition_set 'BEGIN{split(var,a,":"); print a[3]}')
> +	partition=/dev/disk/by-partlabel/$partition_label
> +	crypt_mount_name="encrypted_$partition_label"
> +	decrypted_part=/dev/mapper/"$crypt_mount_name"
> +
> +	# check if partition is already encrypted with systemd-tpm2
> +	if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
> +			| grep -q "systemd-tpm2"; then
> +		open_tpm2_partition "$partition"
> +		if ! mount -t $(get_fstype "${decrypted_part}") "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
> +		    panic "Can't mount encrypted partition '${decrypted_part}'!"
> +		fi
> +		continue
> +	fi
> +
> +	# create random password for initial encryption
> +	# this will be dropped after reboot
> +	tmp_key=/tmp/"$partition_label-lukskey"
> +	openssl rand -base64 32 > "$tmp_key"
> +
> +	case "${partition_format}" in
> +        "reencrypt")
> +		    reencrypt_existing_partition "$partition" "$tmp_key"
> +		    enroll_tpm2_token "$partition" "$tmp_key"
> +		    open_tpm2_partition "$partition"
> +        ;;
> +        "format")
> +		    /usr/sbin/cryptsetup luksFormat --batch-mode \
> +							     --type luks2 "$partition" < "$tmp_key"
> +		    enroll_tpm2_token "$partition" "$tmp_key"
> +		    open_tpm2_partition_tpm2_partition "$partition"
> +		    mke2fs -t ext4 "${decrypted_part}"

We likely want to make this line configurable at recipe-level, both
regarding fs options as well as the fs type itself.

> +        ;;
> +        *)
> +		    panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
> +         ;;
> +	esac
> +
> +	if ! mount -t $(get_fstype "${decrypted_part}") "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
> +		panic "Can't mount encrypted partition '${decrypted_part}'!"
> +	fi
> +
> +	# delete initial key
> +	# afterwards no new keys can be enrolled
> +	/usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
> +done
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> new file mode 100644
> index 0000000..ba2b884
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -0,0 +1,37 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2020-2022
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +
> +inherit dpkg-raw
> +
> +DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, systemd(>= 251), \
> +    awk, openssl, libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0, e2fsprogs"
> +
> +SRC_URI += "file://encrypt_partition.hook \
> +            file://encrypt_partition.script \
> +    file://encrypt_partition.env.tmpl"
> +
> +CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
> +CRYPT_REDUDUCE_DEVICE_SIZE="32M"
> +
> +TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_REDUDUCE_DEVICE_SIZE"
> +TEMPLATE_FILES = "encrypt_partition.env.tmpl"
> +
> +do_install[cleandirs] += " \
> +    ${D}/usr/share/initramfs-tools/hooks \
> +    ${D}/usr/share/encrypt_partition \
> +    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
> +do_install() {
> +    install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
> +    install -m 0755 "${WORKDIR}/encrypt_partition.script" \
> +        "${D}/usr/share/initramfs-tools/scripts/local-bottom/encrypt_partition"
> +    install -m 0755 "${WORKDIR}/encrypt_partition.hook" \
> +        "${D}/usr/share/initramfs-tools/hooks/encrypt_partition"
> +}
> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
> index b635a8b..1d29583 100644
> --- a/wic/x86-efibootguard.wks.in
> +++ b/wic/x86-efibootguard.wks.in
> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1
>  part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}"
>  
>  # home and var are extra partitions
> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G
> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M 
> +part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M
>  
>  bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


