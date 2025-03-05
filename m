Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582F4C19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 08:21:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.8821.1741162884027081432
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 00:21:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Fyf3wEl+;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 814FF10382C18;
	Wed,  5 Mar 2025 09:21:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741162882; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fyNH48Q25lUdazls+p/DNaeD2RDiGAgWf/X7OuC2+IQ=;
	b=Fyf3wEl+E08C87k3OihfGdAhDFhM0O02B05SmjgHvQbjsAYkvchd5+cFC9mJsEvy5hHR1a
	WdLcpuyUdLIFGKwax5Mc6eQrvQphmWcDFY+I4RrMBIrG4aEihjAcPkzI8eTc48N8LmD1yq
	vztnITuxoUtFf7hwKxaisCue1kAFFwfgB0eQPnI20Nik2upSGxKOF2YOc8x2n3FpQEHBQI
	WqicJqa0EmC3EPHAZ/AxzBUSp0Y/zJnguHtR1ObN5ja7t+R0pcbxNGS7V4RE1a4uf7sjxV
	CymWxyVlsgZqWfy8s8PktUh7edvwhoJF3PLKMTK5IjtT592GTRNWMtUsKgLkOA==
Message-ID: <12212010-abfc-4e1d-a6bc-0a89754c2b86@denx.de>
Date: Wed, 5 Mar 2025 09:21:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] initramfs-crypt-hook: implement 'noencrypt' option
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250304130743.2812183-1-ch@denx.de>
 <20250304130743.2812183-3-ch@denx.de>
 <c98de579-e33f-486f-b964-4f4a0aebd1d5@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <c98de579-e33f-486f-b964-4f4a0aebd1d5@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 08:21:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18031

Hi Jan,

On 2025-03-04 4:11 pm, Jan Kiszka wrote:
> On 04.03.25 14:07, Claudius Heine wrote:
>> In case encryption needs to be enabled via an update, while still
>> allowing the update fall back to work. One update step where encryption
>> is supported, but no reencryption is taking place if the device is not
>> encrypted.
>>
>> For this the `noencrypt` hook is implemented, which requires some
>> restructure/reordering of the `local-top-complete` script.
>>
>> Signed-off-by: Claudius Heine <ch@denx.de>
>> ---
>>   doc/README.tpm2.encryption.md                 | 22 ++++++++++++++++-
>>   .../files/local-top-complete                  | 24 +++++++++++++++----
>>   2 files changed, 40 insertions(+), 6 deletions(-)
>>
>> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
>> index 3f7e89f..a97425c 100644
>> --- a/doc/README.tpm2.encryption.md
>> +++ b/doc/README.tpm2.encryption.md
>> @@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following variables which can be overwri
>>   ### CRYPT_PARTITIONS
>>   
>>   The variable `CRYPT_PARTITIONS` contains the information which partition shall be encrypted where to mount it.
>> -Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt or format>`.
>> +Each entry uses the schema `<partition-identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
>>   - The `partition-idenitifer` is used to identify the partition on the disk, it can contain a partition label, partition UUID or absolute path to the partition device, e.g. `/dev/sda`.
>>   - The `mountpoint` is used mount the decrypted partition in the root file system
>>   - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exiting content of the partition. This reduces the partition by 32MB and the file system by a similar amount
>>   - `format` creates a empty LUKS partition and creates a file system defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
>> +- `noencrypt` will not try to encrypt the partition, if it isn't encrypted already, but will open it if it is. See the section [Encrypting the shared partition via an update](#### Encrypting the shared partition via an update) for more information
> 
> "...encrypt the partition if it isn't..." (not sure about the second
> comma as non-native speaker, though)

fixed, thx.

> 
>>   
>>   #### Encrypted root file system
>>   
>> @@ -58,6 +59,25 @@ The mountpoint is empty as the root partition is mounted  by a seperate initramf
>>   Both partitions are encrypted during first boot. The initramfs hook opens `${ABROOTFS_PART_UUID_A}` and `${ABROOTFS_PART_UUID_B}`
>>   during boot.
>>   
>> +#### Encrypting the shared partition via an update
>> +
>> +With the following requirements, special handling is necessary:
>> +
>> +- A/B update scheme is used
>> +- Both slots have a shared volume, that needs to be encrypted as well
>> +- The system in field is currently unencrypted and encryption should be added via an update
>> +- When the update failed, the fallback system needs to deal with an encrypted data partition
>> +
>> +If this case the fallback system needs to support an encrypted shared data partition, but would not encrypt it themselves. For this the `noencrypt` flag can be used.
> 
> "In this case"? Sounds strange.

fixed, thx.

> 
> "themselves" - where is the plural coming from?

There is the rule: "He, she, it; das S muss mit"

I went ahead and let languagetool decide, and it also wants there to be 
"themselves" instead of "themself", but just to be sure, I rewrote 
'themselves' to 'on its own' there. (notice the s there as well :)

> 
>> +
>> +The data partition in the fallback system will have the `noencrypt` flag set, while the update system will set the flag to `reencrypt`, this will handle the following case, for example
>> +
>> +- Un-encrypted system on slot A is running, shared data partition has set `noencrypt` flag and is not encrypted
>> +- Update for enabling encryption is applied to slot B, where the shared data partition has the `reencrypt` flag
>> +- System reboots to slot B, encrypting the shared data partition
>> +- Update fails at a later point and is not blessed, system reboots into the fallback system on slot A
>> +- Fallback system now needs to be able to use the shared data partition
> 
> Where do you describe the "format-if-empty" usage of patch 3? Seems that
> is an important element as well.

I will add a note there in the format-if-empty patch.

regards,
Claudius

> 
>> +
>>   ### CRYPT_CREATE_FILE_SYSTEM_CMD
>>   
>>   The variable `CRYPT_CREATE_FILE_SYSTEM_CMD` contains the command to create a new file system on a newly
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index cf49e63..1ef784d 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -240,18 +240,32 @@ for partition_set in $partition_sets; do
>>   	if [ ! -e  "$part_device" ]; then
>>   		panic "Could not find device  mapped to '$partition' cannot be encrypted!"
>>   	fi
>> -	decrypted_part=/dev/mapper/"$crypt_mount_name"
>> -	# check if we are trying to mount root
>> -	if [ "$partition_mountpoint" = "/" ]; then
>> -		echo "ROOT=$decrypted_part" >/conf/param.conf
>> -	fi
>>   
>> +	# If partition is already encrypted, decrypt and continue with next partition:
>> +	decrypted_part=/dev/mapper/"$crypt_mount_name"
>>   	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>>   			| grep -q "luks2"; then
>>   		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>> +
>> +		# check if we are trying to mount root, set ROOT to decrypted partition:
>> +		if [ "$partition_mountpoint" = "/" ]; then
>> +			echo "ROOT=$decrypted_part" >/conf/param.conf
>> +		fi
>> +
>>   		continue
>>   	fi
>>   
>> +	# If partition should not be encrypted, continue with next partition:
>> +	if [ "$partition_format" = "noencrypt" ]
>> +	then
>> +		continue
>> +	fi
>> +
>> +	# check if we are trying to mount root, set ROOT to decrypted partition:
>> +	if [ "$partition_mountpoint" = "/" ]; then
>> +		echo "ROOT=$decrypted_part" >/conf/param.conf
>> +	fi
>> +
>>   	# service watchdog in the background during lengthy re-encryption
>>   	if [ -z "$watchdog_pid" ]; then
>>   		service_watchdog &
> 
> Jan
> 

-- 
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


