Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4387C282EC
	for <webhook@archiver.kernel.org>; Fri, 14 Mar 2025 08:55:33 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.9363.1741942529543516420
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Mar 2025 01:55:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=bxcREd5q;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C10E10382F09;
	Fri, 14 Mar 2025 09:55:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741942527; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=DmotNsa0ShvgQf9if3FsmTCNwFAQZqpoEnCyaIYmfLI=;
	b=bxcREd5qM3lNTyE+AecyDSmSiSDodYJ1VBxaA4Pishlnk1CzG07q98RdyIsqswRhgIZ1j7
	4Uz5DaW2i2916dsfv7E+J+JBPzggd1U8V/ji3LYTJeCBd4E/R/YUpoDiEpksolDJS4t4Ku
	l3VsDcN0wGpoVOuFZcScURo7IIlVbVgMqKiWjNOOjGINwqyketM4dOnsJP4viQemFGYSuu
	iOACO1SWDmedTtrlNxrCdGXccglsMGcuEbMk5st2LRSe8kiPwF/xngrGm5Iz1H4wfPgvUi
	8dkkLKXiXx2eoypEwgSIRqno8TGfxiejG2B1uvPAMDRFHKph6cByujoqWlFBEQ==
Message-ID: <9f9e4ccc-1b1d-48a8-a552-b2a7be782c62@denx.de>
Date: Fri, 14 Mar 2025 09:55:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] initramfs-crypt-hook: add 'format-if-empty'
 feature
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander <alexander.heinisch@siemens.com>
References: <20250313-initramfs-crypt-hook-patches-2-v5-0-fc62d4a2ad29@denx.de>
 <20250313-initramfs-crypt-hook-patches-2-v5-4-fc62d4a2ad29@denx.de>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <20250313-initramfs-crypt-hook-patches-2-v5-4-fc62d4a2ad29@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Mar 2025 08:55:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18205



On 2025-03-13 1:35 pm, Claudius Heine wrote:
> With the A/B update scheme, the goal is to have two (mostly) independent
> system slots, one that is active and one that is inactive. The active
> system slot writes updates to the inactive system slot and switches the
> active and inactive slot via a reboot. Late when booting the new system,
> it will decide if the current system is stable and then 'bless' it in
> the bootloader, or it will consider the update failed and the system
> reboots, without the updated system slot being blessed.
> 
> In the last case, the system in the old slot will work as a fallback
> system, that reports the failed update back to the backend, and continue
> the service, as it has before the update was applied.
> 
> It is important here that the update does not modify the fallback system
> in any avoidable way, because doing so might break the fallback and make
> the system not remotely recoverable.
> 
> If encryption is added via an update, there are two cases to consider:
> 
> 1. Update is applied to the inactive update slot via the normal update
>     procedure. In this case the fallback system should not be modified.
> 2. A system that uses encryption is flashed via a factory flash. In this
>     case there is no fallback system and all partitions of both update
>     slots need to be encrypted.
> 
> To differentiate between these cases, the content of each fallback
> partition can be looked at, if they contain data, we are in case (1) and
> these partitions should be left alone, if they contain only 0x00, they
> can be formatted, because we are in case (2).
> 
> The `format-if-empty` option is implemented here, will look if the first
> 10 MiB of each partition marked with this option contains 0x00 or not
> and will either format it or leave it alone.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>   doc/README.tpm2.encryption.md                           |  5 ++++-
>   .../initramfs-crypt-hook/files/local-top-complete       | 17 +++++++++++++++++
>   .../initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb    |  2 +-
>   3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
> index 2256f95a039044313807ab75ce219fa3eb7408b6..3c29381209c5bec8aa0b031d941d23b7bf0cfd95 100644
> --- a/doc/README.tpm2.encryption.md
> +++ b/doc/README.tpm2.encryption.md
> @@ -42,12 +42,13 @@ The initramfs-crypt-hook recipe has the following variables which can be overwri
>   ### CRYPT_PARTITIONS
>   
>   The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
> -Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
> +Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt | format-if-empty>`.
>   - The `partition-idenitifer` is used to identify the partition on the disk, it can contain a partition label, partition UUID or absolute path to the partition device, e.g. `/dev/sda`.
>   - The `mountpoint` is used mount the decrypted partition in the root file system
>   - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
>   - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
>   - `noencrypt` will not try to encrypt the partition if it isn't encrypted already, but will open it if it is. See the section [Encrypting the shared partition via an update](#### Encrypting the shared partition via an update) for more information
> +- `format-if-empty` will create an empty LUKS partition and format it, like the `format` option, but only if the first 10 MiB are empty (contain only 0x00). This makes it possible to differentiate if a partition is empty and can be encrypted, because it was freshly flashed via a factory image, or if it might contain an unencrypted fallback system and should be left alone.
>   
>   #### Encrypted root file system
>   
> @@ -78,6 +79,8 @@ The data partition in the fallback system will have the `noencrypt` flag set, wh
>   - Update fails at a later point and is not blessed; system reboots into the fallback system on slot A.
>   - Fallback system now needs to be able to use the shared data partition.
>   
> +In this case, where encryption is added via an update, the `format-if-empty` option is also useful. The system with encryption enabled has the `format-if-empty` option set for the partition(s) in the inactive update slot. This will cause both sets of partitions in both slots to be encrypted after the first boot on a fresh factory flashed system, but will not disturb existing data of any fallback system if booted after an update.
> +
>   ### CRYPT_CREATE_FILE_SYSTEM_CMD
>   
>   The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create a new file system on a newly
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 19df9ac9e22fde09dda8ea3ad76f7ff763d3cf1b..4a533dbe383edd6c8b2964b861499844b312c349 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -365,6 +365,23 @@ for partition_set in $partition_sets; do
>   			eval "${create_file_system_cmd} ${decrypted_part}"
>   			log_end_msg
>   		;;
> +		"format-if-empty")
> +			# Check if first 10MiB contain only zeros
> +			if cmp -s -n "$(( 10 * 1024 * 1024 ))" "${part_device}" /dev/zero
> +			then
> +				log_begin_msg "Encryption of ${part_device}"
> +				/usr/sbin/cryptsetup luksFormat --batch-mode \
> +					 --type luks2 "$part_device" < "$tmp_key"
> +				enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_algorithm" "$pcr_bank_hash_type"
> +				tpm2_key_del
> +				open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> +				eval "${create_file_system_cmd} ${decrypted_part}"

I was just thinking about this a bit more, this process is not 
power-fail save. When power is cut while the partition is formatted to 
luks, it will no longer be 'empty', so on the next boot, this branch 
will not be entered.

That means the tpm2 will contain the initial password for that 
partition, which will either not be removed or used for the next 
partition, and the tpm2 token will never be installed.

The system will not be able to mount it.

So I guess we need extend this branch check to see if it is either empty 
or contains a luks partition without clevis/systemd-tpm2 token.

The time for formatting the partition is much smaller than for the 
reencryption process, but it would still be good to make this power-fail 
save.

regards,
Claudius

> +				log_end_msg
> +			else
> +				# If not empty, leave it alone.
> +				continue
> +			fi
> +		;;
>   		*)
>   			panic "Unknown value ${partition_format}. Cannot create a encrypted partition !"
>   		;;
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> index cde6582fe07981c78d646fe592e0c53ef46a2fb4..a6a33eb4496124e059f673d90261c628834ae68f 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
> @@ -40,7 +40,7 @@ HOOK_ADD_MODULES = " \
>   
>   HOOK_COPY_EXECS = " \
>       mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
> -    e2fsck resize2fs cryptsetup head tr rm \
> +    e2fsck resize2fs cryptsetup head tr rm cmp \
>       tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_startauthsession \
>       tpm2_policypcr tpm2_createprimary tpm2_create tpm2_load tpm2_evictcontrol \
>       tpm2_unseal tpm2_getcap \
> 

-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


