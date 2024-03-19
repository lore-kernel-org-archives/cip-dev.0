Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EB3C6FD1F
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 18:35:51 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.41])
 by mx.groups.io with SMTP id smtpd.web11.23919.1710873344353572022
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 11:35:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Qh/wc/Op;
 spf=pass (domain: siemens.com, ip: 40.107.249.41, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcYANJlbO49Nb60im+1g1GYSLGbtK19KyS4wdL7EZGCzG22Tt0M21WZ4X5Kxq1cuML7llG89VPG33D9ymiHFnLw9e7Sk6pf+lSvSbyIwFvbYkRyoY3rylV6COlZ8uhCawlm6oZGP413edNN/STPntnu0ntU+0uZUhr8LT+at/JY0Q5rNxc0uAgswvSM/3qsUIkmb/Z6QwDTgKLNaZPqnVEasUzWsKxgcQ+iBh1V6NvIiIMTLcpqVXhuLJfENvgYPMyaw7jnrkfIy+3m10spVt7xvkZ5ijxMB2SeI4AnHK+IGffu4UaCZ7zKPsPXHPyLRkv/nXSv8rlRacT2PciTQxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYqKpaYhysefqvqUM/UAWFOHJE1uT5b17H9+slWvNWQ=;
 b=BYDIt8wTN1pbEF/npGoU3sq4Ak9v9KC7o5nAHi5IC+vq/wOY6DLi2rBxrIbVxNxh/gAyi4Z15RPCBzzRNdoF+vIadjn66uqlOeKBT48Va3BibhJS/5Ypq+KASlpb+LJUSh+QxMk2V11toJFucac1e/qD9JuuyBGk3GB7xCjX3a6ktZxRVIC5vZDweQNlVHxsqlHgxNKx8q6rKt6fQtRRjlFxz5sQlE6egRTEYkuKl16zFm3SiinYyVw/RXDKNUH6/yoBpDee2oSUTNr+M3frJk/B7Q+s2oJg8EGlJZBvTP0zCHtPw7642+7C0SRq3MKMYN2tW9NoxzjIWI2CsCBRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYqKpaYhysefqvqUM/UAWFOHJE1uT5b17H9+slWvNWQ=;
 b=Qh/wc/Op2Pupmd0gHTUk8y1YZ4w8xFUFXpEauNNmMNf8xp+F4OEcNapI9DdAztmjxcP78P9u3ij72UWsjLuTEnebDo6Fl5F41M3VL4WPyQWEJNTUi/p1Loe+22Nj0riJhxzIZi9gKPaslKteME7kRXzhzEoJIFPJRl5p1ycxY8dUZEHWKWJ8cQpaX8BOzi62gTWYXyy9PJe6MQ4y506LzdxVmscZib1A9Z4Kivzxn+2BsATuHJsbqp8GgXvh5+faazH7NpLeFZZRE2ks//qBuswzAOMd2axQQOBMQ5IItuqucBJpaZ/N0WAjKZuTROHTHUk9bfqGwsC0/E+JIe0F7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3829.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 18:35:41 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:35:41 +0000
Message-ID: <1b8b19ba-c2dd-4139-bbc2-954040928b56@siemens.com>
Date: Tue, 19 Mar 2024 19:35:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 4/8] initramfs-crypt-hook: Check if
 the TPM device fulfills the given requirements
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, johnxw@amazon.com
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
 <20240319182026.1571362-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240319182026.1571362-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3829:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1e3d1b-ebf2-4010-c5e8-08dc48436149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tc07h/i2AqQ9k2mBiHZy2wW/kRGcuhFmMU7e8O2Vp/E08PfmrFj9jFfPMijiilc6fCmbD1ar3eWYXcv0zJ/RBZjnC7lpH0sC0vYycYyK1sX0Ez2H7Mjj8xbWBLJODrO0kI4/SDDRHBdTA3FVD47rANrFc1b0VY1v9yRHWkgv+W4O4M1d2/8GijIKnCai5WjIIdnijgmiAUfo/WU4gq3BtRAmWfT0s0LYNZbV32X2XmsryIPwcUSBgNfeFFRjQosWmzIRrbU4koF28NPrPOOT9weh3W59TKfTixOMQocoSKjXfgGhi1DOVVxnX5zYE4SX+xum29FzbAqjqgymtAjjB0xBrGZ/bBD30tW4Pt4ca1iMncyXci6IuOh8fWElxQfUBNl6NOb9UhAJCZrJI12Yd9YS+deL4cht1OoIkhI7r5cRNI2XLoAETiskm4dm7kWnbX1lD0AQZe67YmnlnkrhQKcQH00aaYxPnhSdEY++uVWzXAmoBL3uk74cuoQbuBko5Cyj/ueNnZw4yBWh9WVvDHUt2IChv2183lt+S2xIqVBQQ6Riii8LELkeQ2KVgmB/tg56tjQUsUlpwApwpE0qZgQaok5UOTAA0gphzMDYuFeRrj1zffNYhAoA/NR/y3qz5tx6FI0XXgQcDbVLoZr3jJR9UV4U9zTbLidgv3VEFFg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1pFSXRRekVPYWtHYW5DTDlZVFkwM0ZKQmQvMzFyRXZtQU1ialhJdE5WRERH?=
 =?utf-8?B?WEpIQjZMQkFsc1N4OEhSWU9uVUZZY0dHcWRQK2lLVjVhZnBhMEdJV3R3MGN1?=
 =?utf-8?B?OFJNTG1OU3pWMXV0WkVHenRKN3ZNeStqbHVERzVob3FmdjJoOUFMaEI4Wmp3?=
 =?utf-8?B?OG03WXpzNVJrQzNxMFQ1d3FkN3VVOFJybVAzUjJEOWZDcXNZbWxFcE1Nc3h6?=
 =?utf-8?B?QmdIVTROeW9HekJFdW43aWNQNjUzYzRFVW54MkIrdDJDNU1MdzNKZGlCY3ZW?=
 =?utf-8?B?Q2dWTWpYcFBTVkRhSlhwRytSVmpNRlJ1YVM5TkpxVkNxUkJTOFU0RjhLdlEw?=
 =?utf-8?B?ZStoVlBYb1p3dUtMOE1vYzBDekpKMnh4U0dLeHZYNGxpMVU4cTJFUG5NOEhN?=
 =?utf-8?B?QlB6bXJicndIZDZIZHFDRmVRbTlEVXNXRU5JZ0JEbGZDbmkzbENFanA0ZjY4?=
 =?utf-8?B?TFVxdmtPb0ZpditQakhYc042ZE1vTldWbmF1YXBlbXBXemQ3Z1BYZEthMHpN?=
 =?utf-8?B?TXd5ZXNLL1lZZUtNdjdFdTQ5eXdVMk5XOFY2Q1lnb21DcU9qcHJnT3IrQnVr?=
 =?utf-8?B?NFVWS0x6SDBDN3lXaGtwME4vSHJnMnBnRkFZTEgrV0lHUjFHSHNiS1o5WDRG?=
 =?utf-8?B?SjNpS1RFbkJhVVhmRlc4WjlmZGtVMklCOUh3UE9kUkdJRUFsVy9iMDRaZWc5?=
 =?utf-8?B?NzlVL2RiNWlBVGpDdjJLdW9TQlNPOHZUcDRENG1oNzNoQzlKWFErSnNaL0hY?=
 =?utf-8?B?VmlQNW9Bbi9DN09kZWxteXhWODV5RkR3dUtEZFZMSTA3THhRODFyTmdsMlkv?=
 =?utf-8?B?ejVPSU1mWkU3YjA3MmFnT1JYZjhWK0dkVFlHN2pWRjNEeTRqMjM5ckloTjdl?=
 =?utf-8?B?VWhxMzhpUUQrQVVaelltanBPUkhIYW5ReEEwTStoZXU1Z1ZGRHVIQkxQL3Nj?=
 =?utf-8?B?dkxiNlNZNmM4bWVuS3A3MkcyNHJwa1FFbURTOGhXc3VtRGJFbHZvbWhWaUZr?=
 =?utf-8?B?ME5GVXRDdDd1cTUxeGV6TWlLWEc5NndZNGtvZzYwZ0ZjSko4d0dad2FVWEpT?=
 =?utf-8?B?RjBaZmM5cFJnaTBIcHFHSEhmcTliWGhCUWhka3VvUDNVcUZJZk1QejlMbHB3?=
 =?utf-8?B?ZHRyb0MzdXV5Z1ZNdGcvV2pUSzRadC92OUNEeTJYbkFEam95b3ZoMERENGE2?=
 =?utf-8?B?UkowdGlVeWJZR2dwdXdTTXRtYldDT0dkMEh1RGZGMjY4MnI4T2hnMVpkMUth?=
 =?utf-8?B?T0FKd3NWOEpOcFVBQVZYMGowdlRpUUdxVm5Xcmk3ZUd1MTlmNXd0NHc2dStN?=
 =?utf-8?B?NS9XWERUS291Yk8xSTJxQzQzaDVJVmN4YVMyWitOaDZ4bXBZUlFQWEpLMEZF?=
 =?utf-8?B?YTczOHJRemxOVDBmMlBjclhSdG5sUUg5R0puditBOTlsNzMyWXplVWYxNmlI?=
 =?utf-8?B?TlJvd1ZMeGFxTGlpMmtybnRtenFtZTRWMFR0WVlKek1va0dvdDlkM0tyQ3dw?=
 =?utf-8?B?cndxT29MQ1BvcnJqQk0vT1Z3RThiS2VRWTZZTlB0S09ZRjQzZEtuVjJqZDRG?=
 =?utf-8?B?SEdFYk4zdzZrY0hSTGJMUW5UcS9aNW03T3YvMlo5bFprTWZPaVEzWThGU3hW?=
 =?utf-8?B?SE8rQ2JpZW9YODY3ZnB4Z3JURTZESUU0eVo0NmZZd011ZjgrTEhBV05KR2Y2?=
 =?utf-8?B?OVp5NG9CbUtDU1cyTE4vUUR1aFdKTXhWRW5INUNyUkNmVjlKd1VyU1MwVFZS?=
 =?utf-8?B?ZGc4Z3RGSWduY0I4dTNxRXFva1NmVTNDUGJxY3NKckVFK1hQQUdQKzVOUStD?=
 =?utf-8?B?OHpRcER5TzdUOWtQcEpKNDJaVlRyWW1uSkZQSldjYlZlMXcxK1VnVWJLb3d3?=
 =?utf-8?B?bzV0blRlVHY1eE0rdGhOcHNOcWNJWjhFbU1FUmdsVmYrQTRkdDArcS83VXFC?=
 =?utf-8?B?QytCb0V2WGF1T2NGWG5QSlFVNk9DN0ROSDRZalRCNjNQbk91U3ladFBnb2Yw?=
 =?utf-8?B?bWcrZkROZ0tNQXRpeXp2MVppTEtlVWJrNTJ3cnpyT2FYY2owQXhYditvdDlB?=
 =?utf-8?B?UkJlelkrbG11UUJVQUVSUkZHUFg5NlNWUzFTWXZxZ2pXbldsdG0yenV0Mmg1?=
 =?utf-8?B?Z1RrTTF0bzlvbGsvS25qa2xhUzJhdlhkZi9hWW9xNkI2ZU44UVJ0MURSNnNB?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1e3d1b-ebf2-4010-c5e8-08dc48436149
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:35:41.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qx05rw2zODpmgm0gbwUMDaVLZ9eVJmDHaKIlqgUzMYu/wAGqDowtuapzxSgEqunFFlfH+4XhRilGvlNySfgwUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3829
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Mar 2024 18:35:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15375

On 19.03.24 19:18, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This also adds the Crypt hash and Crypt algorithm parameter.

not yet the end of the sentence.

> and avoids errors to missmatchs between Hardware and software.

errors on mismatches

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/encrypt_partition.clevis.script      | 18 +++++++++++++-----
>  .../files/encrypt_partition.env.tmpl           |  3 ++-
>  .../files/encrypt_partition.systemd.hook       |  4 +++-
>  .../files/encrypt_partition.systemd.script     | 15 +++++++++++++--
>  .../initramfs-crypt-hook_0.1.bb                |  7 ++++---
>  5 files changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> index 0f82c1a..f271e85 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
> @@ -43,12 +43,10 @@ modprobe xts
>  # this needs to be probed particularly for re-encryption
>  modprobe loop
>  
> -# fixed tpm device or do we need to find it
> -tpm_device=/dev/tpmrm0
>  partition_sets="$PARTITIONS"
>  create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
> -hash_type="$HASH_TYPE"
> -
> +pcr_bank_hash_type="$HASH_TYPE"
> +tpm_key_algorithm="$KEY_ALGORITHM"
>  if [ -z "${create_file_system_cmd}" ]; then
>  	create_file_system_cmd="mke2fs -t ext4"
>  fi
> @@ -69,7 +67,7 @@ open_tpm2_partition() {
>  
>  enroll_tpm2_token() {
>  	if [ -x /usr/bin/clevis ]; then
> -		clevis luks bind -d "$1" tpm2 '{"pcr_bank":"'"$hash_type"'","pcr_ids":"7"}' < "$2"
> +		clevis luks bind -d "$1" tpm2 '{"key":"'"$tpm_key_algorithm"'", "pcr_bank":"'"$pcr_bank_hash_type"'","pcr_ids":"7"}' < "$2"
>  	else
>  		panic "clevis not available cannot enroll tpm2 key!"
>  	fi
> @@ -102,6 +100,16 @@ mount_partition() {
>  	fi
>  }
>  
> +for candidate in /dev/tpm*; do
> +	if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet 2>/dev/null; then
> +		continue
> +	fi
> +	if ! tpm2_testparms -T device:"$candidate" "$tpm_key_algorithm" --quiet 2>/dev/null; then
> +		continue
> +	fi
> +	tpm_device=$candidate
> +done
> +
>  if [ ! -e "$tpm_device" ]; then
>  	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
>  fi
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> index bcc57be..5d28dc5 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
> @@ -2,4 +2,5 @@ PARTITIONS="${CRYPT_PARTITIONS}"
>  CREATE_FILE_SYSTEM_CMD="${CRYPT_CREATE_FILE_SYSTEM_CMD}"
>  SETUP_TIMEOUT="${CRYPT_SETUP_TIMEOUT}"
>  WATCHDOG_DEV="${INITRAMFS_WATCHDOG_DEVICE}"
> -HASH_TYPE="${CRYPT_HASH_TYPE}"
> \ No newline at end of file
> +HASH_TYPE="${CRYPT_HASH_TYPE}"
> +KEY_ALGORITHM="${CRYPT_KEY_ALGORITHM}"
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> index c3b31d6..6e2a211 100755
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
> @@ -1,5 +1,5 @@
>  #!/bin/sh
> -# Copyright (C) Siemens AG, 2020-2023
> +# Copyright (C) Siemens AG, 2020-2024
>  #
>  # SPDX-License-Identifier: MIT
>  
> @@ -49,6 +49,8 @@ copy_exec /usr/sbin/resize2fs || hook_error "/usr/sbin/resize2fs not found"
>  copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
>  copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenroll not found"
>  copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
> +copy_exec /usr/bin/tpm2_pcrread || hook_error "Unable to copy /usr/bin/tpm2_pcrread"
> +copy_exec /usr/bin/tpm2_testparms || hook_error "Unable to copy /usr/bin/tpm2_testparms"
>  
>  copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hook_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not found"
>  if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> index 6c6d22e..ea267ac 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
> @@ -43,10 +43,10 @@ modprobe xts
>  # this needs to be probed particularly for re-encryption
>  modprobe loop
>  
> -# fixed tpm device or do we need to find it
> -tpm_device=/dev/tpmrm0
>  partition_sets="$PARTITIONS"
>  create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
> +pcr_bank_hash_type="$HASH_TYPE"
> +tpm_key_algorithm="$KEY_ALGORITHM"
>  if [ -z "${create_file_system_cmd}" ]; then
>  	create_file_system_cmd="mke2fs -t ext4"
>  fi
> @@ -71,6 +71,7 @@ enroll_tpm2_token() {
>  		systemd_version=$(systemd-cryptenroll --version | \
>  			  awk -F " " 'NR==1{print $2 }')
>  		# check systemd version and export password if necessary
> +		# systemd version 251 does not suport hash_types
>  		if [ "$systemd_version" -ge "251" ]; then
>  			PASSWORD=$(cat "$2" )
>  			export PASSWORD
> @@ -112,6 +113,16 @@ mount_partition() {
>  	fi
>  }
>  
> +for candidate in /dev/tpm*; do
> +	if ! tpm2_pcrread -T device:"$candidate" "$pcr_bank_hash_type":7 --quiet 2>/dev/null; then
> +		continue
> +	fi
> +	if ! tpm2_testparms -T device:"$candidate" "$tpm_key_algorithm" --quiet 2>/dev/null; then
> +		continue
> +	fi
> +	tpm_device=$candidate
> +done
> +
>  if [ ! -e "$tpm_device" ]; then
>  	panic "tpm device '$tpm_device' does not exists - cannot create a encrypted device!"
>  fi
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index 317ea12..7f732cf 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -11,7 +11,7 @@
>  inherit dpkg-raw
>  DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, \
>      awk, openssl, libtss2-esys-3.0.2-0 | libtss2-esys0, \
> -    libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, e2fsprogs"
> +    libtss2-rc0 | libtss2-esys0, libtss2-mu0 | libtss2-esys0, e2fsprogs, tpm2-tools"
>  
>  CLEVIS_DEPEND = ", clevis-luks, jose, bash, luksmeta, file, libpwquality-tools"
>  
> @@ -49,10 +49,11 @@ CRYPT_SETUP_TIMEOUT ??= "600"
>  INITRAMFS_WATCHDOG_DEVICE ??= "/dev/watchdog"
>  # clevis needs tpm hash algorithm type
>  CRYPT_HASH_TYPE ??= "sha256"
> -
> +CRYPT_KEY_ALGORITHM ??= "ecc"
>  
>  TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD \
> -    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE"
> +    CRYPT_SETUP_TIMEOUT INITRAMFS_WATCHDOG_DEVICE CRYPT_HASH_TYPE \
> +    CRYPT_KEY_ALGORITHM CRYPT_ENCRYPTION_OPTIONAL"
>  TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>  
>  do_install[cleandirs] += " \

Jan

-- 
Siemens AG, Technology
Linux Expert Center


