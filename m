Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2245BC636CC
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 13:32:24 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.47])
 by mx.groups.io with SMTP id smtpd.web10.11676.1675171937893117589
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Jan 2023 05:32:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rsi1zjky;
 spf=pass (domain: siemens.com, ip: 40.107.13.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vcr4Dn6pZ7LNDB51+2T8/zojLhzeBnQ+3x+7ZfW2hbTijNbGNXmGSAxteUdm7e7HPhfZEMOx5GH73qLCHui39VC+mSmE50rbxpj3zbhPh1/3C+CuLQhWpF9cVCLwVlPedg6TfuHU/vv1nc410bqaR+p5UbLr+R5cCSIa29s5C9noHYZWyzDLYK79KAO6gg7+HXWPJEPhIl4T6KJSwN8fqIJXawLlyDXLer+0H/zV6svWb2dhXGi+11YzxTQ3+ipyOLGzob7YyZmf7nvNqAT5xMVpQFCM6Lo5xHBorkBIgkbBBP+uqybBW+irUYLNP/n2fBubDqj6UMiMTff9EKF5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnRDT4cXhP2UyRUKCWQNAwXBC67LTavj7EHq1BrSkig=;
 b=XOe1iZmPhxEC2qFQJcn/i2l8zasxKqeTf1tbYPmu8XLJoAZEhxdA412iD3ogpHkmmppmCadq6vi40laziRvxrTSxd+hX2mILMKd3SY3Kh7RDQLvS6AaxcwMakYUFu5NLzVq0BFnEwS195S5IpNI2ueWp3RgtytdHSMYCqXZ/YAjsCLyPJuz6EWatg0VTsiazkdlNMMrIKzHyIKsmeSD/gjHMbxxT4NX/S9vFiOszL7aHZDt7rVfLdmqGKYFsqtPS5kT48d/yc5T5mFg5iHjssew7N40rGi59qDM4UjobdWh6elA47TKTWWhOg8kIv2OGc0YZX+lMWiO6Wmn92rXa9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnRDT4cXhP2UyRUKCWQNAwXBC67LTavj7EHq1BrSkig=;
 b=rsi1zjkydgrV0fkQjOEDt/Y5RmRuikciQxEt9PqntLOGnwxTu6dJXBSFCeps9Rr3X5EN8l5sb0DNdqO4YRc3T9W/73cOSUmpBnECfDauXInPDmepMBCT0FXn0/PUyo+f/wHrfPiXUO7yDEXe+yvwHDFFYmjWOhqXhocgWGGypH7TyDlkOSJDzs+MTMOqbEqJsjbTQvfJJ3eSbPRjRfZoWFXtJRIokeDEL8/pFnQeQYQkBMYou0/TwEtJY+OWeA8QdYRiyztP5Amq4vo8BNFn0p/58Y+ctlutC9np+NoaFYZO7Qd7TCkmDk3waEl2OPjN3/HcV1qFX6Z2A2AQu86gcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 13:32:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Tue, 31 Jan 2023
 13:32:14 +0000
Message-ID: <fc719c2e-4bad-bbe1-b99f-75de2d3e633c@siemens.com>
Date: Tue, 31 Jan 2023 14:32:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][RFC 5/5] Add initramfs hook to encrypt a
 partition
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230130150204.697758-1-Quirin.Gylstorff@siemens.com>
 <20230130150204.697758-6-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230130150204.697758-6-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: a28ca469-f2b6-498e-7dec-08db038f902a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NEHCtw03eaXZKHQ293E81TdZRYQM4apLNXeUbkxp7+6UPy4r2gUvHTBtd+dIpCIj1cjj4P4MjixX+ueC5W1vUccoDIMUuwT49kStZ6IDdgHU6cghFkqdIc5sxQ1cllOsRhH7y8wKEKlWcHBRspXDqTG0u1nnxANV/mXklYhvHqnFUF3lBTW97TOadEUZ1ejhp0tTqLkyA+Ku0OzEw9m5hOFThn5LqScS/U2mLr3jU5u7/h4XsFHpt67ciJ3rmgQ4ZJptFp/5p63xltOaPA82RE5ySoxQu2WNTPshDNE2pbId67TK8erF6F2T6FPD2GvF++4TsKKhxhAh0XByY+XPNPrDFnQ22HScmdmt9ugoaG+jDFc6mXxOdzPl3JKdIBj4qxXYzSryb9ewBEgs6IUzeI/Px4n7SNAK6xAld+66KbGbr6UuaWW5miQfTxeK6syY8Z1M2XAXbi5VinCP5UgPR1e6s0m73Aul8blTH8QMIVHuK6WDWGukMY7ZLM9oytwCqx6B586xcDOWnTtN2T2IAEKReTofC3X8HPuLWk0uz5MtMy7Fp1wSeYnU6wxNvvLDKEowR0PgcXveyJXpvsXQtuT6yTg/IJPvz7FmxjEFz7xHIHLOZntKiSVAGow6vP+5/qr7rb7SYyMJdhsxjVp8SK532NjWSQwey+oY1n2C6/fNJ2Cd//6oVcegfEkiGt3dFmsvnmgLGq8IXqUcLZ/wQTIugH36TSPh7tfJxEX8bTI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199018)(31686004)(36756003)(41300700001)(66556008)(66946007)(66476007)(6636002)(316002)(8676002)(5660300002)(8936002)(38100700002)(82960400001)(86362001)(31696002)(6506007)(6666004)(53546011)(186003)(6512007)(26005)(83380400001)(2906002)(44832011)(478600001)(6486002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bDl0K2YzRDlHWHNBd3d4ODlPYTNvYjlsVkdhNHN5T3FvMnlLZCtmd3QrekJm?=
 =?utf-8?B?Y1RvRVB0MmNYUWovUjNBOTVKd1A3Y2EwTDEySTVZcTQ0aGNEb1hOeU52TllW?=
 =?utf-8?B?bzVBZlJlSWNtWHNMUEJsSlI3eis5aUg1bm9wdXFHOEs0c2VqZEYxVmJEdUJr?=
 =?utf-8?B?Q3lUVmFSTjNmZEZHZnF6eURZM3VtVXhXZEF5NDNaL2d4V0NjYW1HT0xGRlFo?=
 =?utf-8?B?ZWc2U3p0Smc1YlJMZTYwNmt5alUzYkg5a0RrN1Y3eXdrY0VzalhXNnBDbjU2?=
 =?utf-8?B?YXdBUU1ObmdobGRXbk5uaVFxdjN0ZldJajZzbWF4R0QrMTJhSHF4WTQwQ1Z0?=
 =?utf-8?B?eGx5K0lkZDBRTjF3NmRYOHRNNDNHMTdHNWlwUUE2eGkvczVuWFpFeFR1TGxw?=
 =?utf-8?B?aldTbVVac0w4RmwxbkVreVpwSUVPVW9jNnhDSnVqWEpUN3MwVVNLeWhsaGlV?=
 =?utf-8?B?OGVJQ3lsMGF6L3RjRkg3emdjd2dzS2VXNmk0RXhXRllSd3M3M0NsZ0FKSmNy?=
 =?utf-8?B?WGxlVkFXQityMndoTUdYaG1HZTgrbFAySWxvQkl0L2lRbGF5WHovbTVPNHZL?=
 =?utf-8?B?OGw3YUgrTC9MQnA3OENyNTRvWXYyS01TVDZybVNYSGlJUGNCVXloZ0RuUXNJ?=
 =?utf-8?B?QUNsRlVZQUhJVU5JMHFzR0Y1Qis1aG1LVi9zajl5WmVENzBldzh5TGRtNWds?=
 =?utf-8?B?ZUxHZG0vK0FIdG9MVWJWbno2Vk1IR3hBWU9Na01DUXpzbHdGUHZyeFp4NVhL?=
 =?utf-8?B?RTJWcEhmSkNldm9lK1liWkV4YmVzRk5vVXZNVkdUVjVRdTNDVjN1N3lVZWVm?=
 =?utf-8?B?RlFJZ2xvQUV6dlRRZWVDSVBCSnpZYlFCUHZDdXcxUlJTSUVkSjdCSEFqTFF6?=
 =?utf-8?B?M3UvZmtXUWxMRk1lOFBEclBQMDBRMzRtRy8vVWpoZG5ydm52dVN4azkwZld3?=
 =?utf-8?B?TlM5dnBObEh5VFV2bG1TYWlXRnVKOHZUYW8xVVQ0ZGdGNXhqTEhocWFzZEVV?=
 =?utf-8?B?aGE1eExuVmM2UXJwY3FNT1d2TXZVVHJEOFdSaEZxb2s0akliTXVoY1dNckph?=
 =?utf-8?B?R0prS3REOVUwbmVVakgycFFtdUs3NnNmZmdIdytVbHZxa3NTYVNPOE43Lzkv?=
 =?utf-8?B?WnpyUmMrZW5GbUJEcW5jZEx0empVSXdNK2g2R3pmRDVVMDhqSjk1c25rb1VG?=
 =?utf-8?B?NEVkNTdEWHd4QXRsRS94WFdPUlFFbFdjRzJYNm8yck5NTDAzTFg2cE9TL3lP?=
 =?utf-8?B?ZnJnczdxb2dQSGJvTVhucjBWSHlKWjgxVVFURDh1OUV0SGZvVEZmNWpvbHBS?=
 =?utf-8?B?alZHdGVIV3pOU1BhNG9zUXhucmlpNEZDVzNGMXFiK2J0RVdxbHVwUW1LK0ds?=
 =?utf-8?B?aGM3MExLVFBqOVdxU2VvaE1PQlRhUDZIaGJtV3IxWHlzOWZTY0ZSU2dQdDZV?=
 =?utf-8?B?K1hEdlh4Snd1d2gwWUxKQk9rckRnQWQ0ZGkvYzBCRFVzQ2dObnowcCtqY3c3?=
 =?utf-8?B?SUtnTHRiQUlxajVUc3grUjlOZ3M5L09IeTY0Qk9lNlMraTB0QWVnMjdNTkZS?=
 =?utf-8?B?Z3B2M1BySDc5dXh5Q1ZWcy9lbkRMTFF1VmMxTzdQVmFoTys0Um1qVDZUVmpX?=
 =?utf-8?B?Nlluak4xUXNaK0NmRDczS05BVUY0ZjVERWZEclFHRnhOMklmOGlGRWhObTVz?=
 =?utf-8?B?aGhCbWFMN01pLzNRbzJTMUh6UDU0MEI5VkZXWHR4Vzg2b1d5NUVhQzVEZnNU?=
 =?utf-8?B?UUVYUVhKTDJ6VmRndE9WQjF2ZnltNkVDd3kwYWxTMHV2NUpidmhsSG9wTjZH?=
 =?utf-8?B?bHFPYkhPcGtLTTVJdjBTSHVsSkIwN29XRUsvSU93cldKTUVLTVUwNWVTS2x3?=
 =?utf-8?B?NDBoSWNxKy9RaEtnczZZam42OThhTm9MRlVXNWxuMmE1THFqL21jU01QN3ha?=
 =?utf-8?B?dVU0WFE5cEh5a1BxZHEvMUtmQ2JkMDVCNGlkUVlkRUl5UzBZZ2hwMGJZTC83?=
 =?utf-8?B?TlhtckxVQ2tZeGg2ZDg2MzhadDBnaXpIZWs5c2lxQml3azlOWUdwN2pJckJt?=
 =?utf-8?B?azIyTWlGOWQzOEc0RFNSc3c3YnVXS1NIckQ5cUF3Zmt4ZXJyNGJuOTdNREpT?=
 =?utf-8?B?MkNNNjlRVjlTUnRrMlptVUxrU20vbmlsRitCSWdFQmJiZnJxelRiUUV0SzNI?=
 =?utf-8?B?ZlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28ca469-f2b6-498e-7dec-08db038f902a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:32:13.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSP5l2FscdnrRfUrNIHnnXCWXYmd/Ll6jOhzqGYuSq7V45QMYFu03jp0GDcapaAhiGlwvd+xjd+8TIUssBKacw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6093
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 13:32:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10533

On 30.01.23 16:02, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This creates a new luks encrypted ext4 partition with a the
> key stored in the tpm2.

Again my question: Why a new partition, and what do we do with the
critical data on /home and the overlay(s)? Why not demonstrating their
protection?

> 
> The initial key is randomly generated and removed from the
> LUKS partition. Therefore a new key cannot be added by the user
> and if the LUKS header is corrupted the data is no longer readable.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/tpm.yml                               |  2 +
>  .../files/create_crypt_partition.script       | 96 +++++++++++++++++++
>  .../files/crypt-partition.env.tmpl            |  1 +
>  .../initramfs-crypt-hook/files/crypt.hook     | 42 ++++++++
>  .../initramfs-crypt-hook_0.1.bb               | 37 +++++++
>  5 files changed, 178 insertions(+)
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/create_crypt_partition.script
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/crypt-partition.env.tmpl
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/crypt.hook
>  create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> 
> diff --git a/kas/opt/tpm.yml b/kas/opt/tpm.yml
> index 03e8e47..a77a2be 100644
> --- a/kas/opt/tpm.yml
> +++ b/kas/opt/tpm.yml
> @@ -16,3 +16,5 @@ local_conf_header:
>    systemd-cryptenroll: |
>      DISTRO_APT_SOURCES_append_bullseye = " conf/distro/debian-bullseye-backports.list"
>      DISTRO_APT_PREFERENCES_append_bullseye = " conf/distro/preferences.bullseye-backports.tpm.conf"
> +  image-option-tpm: |
> +    INITRAMFS_INSTALL += " initramfs-crypt-hook"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/create_crypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/create_crypt_partition.script
> new file mode 100644
> index 0000000..a30dc59
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/create_crypt_partition.script
> @@ -0,0 +1,96 @@
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
> +    # Make sure that this script is run last in local-top
> +    local req
> +    for req in "${0%/*}"/*; do
> +        script="${req##*/}"
> +        if [ "$script" != "${0##*/}" ]; then
> +            printf '%s\n' "$script"
> +        fi
> +    done
> +}
> +case $1 in
> +prereqs)
> +    prereqs
> +    exit 0
> +    ;;
> +esac
> +
> +. /scripts/functions
> +
> +. /usr/share/crypt/crypt-partition.env
> +
> +# fixed tpm device or do we need to find it
> +tpm_device=/dev/tpmrm0
> +partition="$PARTITION"
> +partition_label=$(echo "$partition" | awk -F "/" '{print $NF}')
> +crypt_mount_name="encrypted_$partition_label"
> +decrypted_part=/dev/mapper/"$crypt_mount_name"
> +
> +if [ ! -e "$partition" ]; then
> +    panic "$partition does not exist!"
> +fi
> +
> +modprobe tpm_tis
> +modprobe tpm_crb
> +
> +if [ ! -e "$tpm_device" ]; then
> +    panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
> +fi
> +
> +# check if partition is already encrypted with systemd-tpm2
> +if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
> +        | grep -q "systemd-tpm2"; then
> +    if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
> +         "$partition" - tpm2-device="$tpm_device"; then
> +        panic "Can't decrypt '$partition' !"
> +    fi
> +    return
> +fi
> +
> +# create random password for initial encryption
> +# this will be dropped after reboot
> +
> +tmp_key=/tmp/"$partition_label-lukskey"
> +openssl rand -base64 32 > "$tmp_key"
> +
> +/usr/sbin/cryptsetup luksFormat --batch-mode \
> +                     --type luks2 "$partition" < "$tmp_key"
> +
> +#check systemd version and export password if necessary
> +if [ -x /usr/bin/systemd-cryptenroll ]; then
> +    systemd_version=$(systemd-cryptenroll --version | \
> +                          awk -F " " 'NR==1{print $2 }')
> +    #check systemd version and export password if necessary
> +    if [ "$systemd_version" -ge "251" ]; then
> +        PASSWORD=$(cat "$tmp_key" )
> +        export PASSWORD
> +        /usr/bin/systemd-cryptenroll --tpm2-device="$tpm_device" \
> +                                     --tpm2-pcrs=7 "$partition"
> +        PASSWORD=
> +    else
> +       panic "Unknown systemd version: '$systemd_version'!"
> +   fi
> +fi
> +
> +wait_for_udev 10
> +
> +if ! /usr/lib/systemd/systemd-cryptsetup attach "$crypt_mount_name" \
> +     "$partition" - tpm2-device="$tpm_device"; then
> +    panic "Can't decrypt '$partition' !"
> +fi
> +
> +mke2fs -t ext4 "${decrypted_part}"
> +
> +# delete initial key
> +/usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/crypt-partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/crypt-partition.env.tmpl
> new file mode 100644
> index 0000000..04c4123
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/crypt-partition.env.tmpl
> @@ -0,0 +1 @@
> +PARTITION=${CRYPT_PARTITION}
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/crypt.hook b/recipes-initramfs/initramfs-crypt-hook/files/crypt.hook
> new file mode 100644
> index 0000000..38fff49
> --- /dev/null
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/crypt.hook
> @@ -0,0 +1,42 @@
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
> +copy_exec /usr/sbin/cryptsetup
> +copy_exec /usr/bin/systemd-cryptenroll
> +copy_exec /usr/lib/systemd/systemd-cryptsetup
> +
> +for _LIBRARY in /usr/lib/*/libtss2*; do
> +    copy_exec "$_LIBRARY"
> +done
> +
> +copy_file library /usr/share/crypt/crypt-partition.env /usr/share/crypt/crypt-partition.env
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> new file mode 100644
> index 0000000..024ff68
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
> +    awk, openssl,  libtss2-esys-3.0.2-0,  libtss2-rc0, libtss2-mu0, e2fsprogs"
> +
> +SRC_URI += "file://crypt.hook \
> +            file://create_crypt_partition.script \
> +    file://crypt-partition.env.tmpl"
> +
> +CRYPT_PARTITION ??= "/dev/disk/by-partlabel/crypt-data"
> +CRYPT_MOUNT_POINT ??= "/data"

This only supports a single encrypted partition, right? Why not
following the same pattern as for overlays?

> +
> +TEMPLATE_VARS = "CRYPT_PARTITION CRYPT_MOUNT_POINT"
> +TEMPLATE_FILES = "crypt-partition.env.tmpl"
> +
> +do_install[cleandirs] += " \
> +    ${D}/usr/share/initramfs-tools/hooks \
> +    ${D}/usr/share/crypt \
> +    ${D}/usr/share/initramfs-tools/scripts/local-top"
> +do_install() {
> +    install -m 0600 "${WORKDIR}/crypt-partition.env" "${D}/usr/share/crypt/crypt-partition.env"
> +    install -m 0755 "${WORKDIR}/create_crypt_partition.script" \
> +        "${D}/usr/share/initramfs-tools/scripts/local-top/crypt"
> +    install -m 0755 "${WORKDIR}/crypt.hook" \
> +        "${D}/usr/share/initramfs-tools/hooks/crypt"
> +}

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


