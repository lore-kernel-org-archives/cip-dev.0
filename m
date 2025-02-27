Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA92C19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 09:55:38 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.7451.1740650134711175867
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 01:55:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Rzt8EW4e;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89AC510382D2E;
	Thu, 27 Feb 2025 10:55:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740650132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GHHm9K0IAAuY+QFte6gBCMxIexCgU5cyy2wBAwCDGHs=;
	b=Rzt8EW4eh2XAM51ma16vN0IlW/sKLwEsrz34RSg1n0GPWPUPqBU898qaMHnTbd7nlAw9ES
	siykdHkkaHu8nrtDo0+Qxi/RLec/Hh5pIX0oN8ds6dZxfH/vtQPD7G6cB0syH1spBp3hLK
	R1XDKHzSHrgT/6ieT/+f1FOs/zX/MU0R/Sn7Ytd97JZtNFTGGevi2epAtXJjRh8Q+EPk6p
	hY5qnu0eGk3zVc02ozGQuAlW7ppXNMqyrvcOWpteCSIpVn3SBseH+IEcA7+OEd2dUjgEV4
	GNFBsIxlHxKUJ6qdKvuTlJ4OY7xP3gSF6GKSoti25kX7or6yiINRcn1qQooQEg==
Message-ID: <e9ca4969-3123-4411-a19b-3afe1becef2e@denx.de>
Date: Thu, 27 Feb 2025 10:55:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] initramfs-crypt-hook: implement 'noencrypt' option
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20250226095921.168962-1-ch@denx.de>
 <20250226095921.168962-5-ch@denx.de>
 <2977fbac-b0d9-44ce-8f23-a4fca025cdf6@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <2977fbac-b0d9-44ce-8f23-a4fca025cdf6@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 09:55:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17934

Hi Jan,

On 2025-02-27 10:17 am, Jan Kiszka wrote:
> On 26.02.25 10:59, Claudius Heine wrote:
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
>>   doc/README.tpm2.encryption.md                 |  3 +-
>>   .../files/local-top-complete                  | 29 +++++++++++++++----
>>   2 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
>> index 3f7e89f..515348a 100644
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
>> +- `noencrypt` will not try to encrypt the partition, it it isn't encrypted already, but will open it if it is.
> 
> "it it" -> "if it"
> 
>> This makes it possible for an image to support encrypted systems, while not encrypting anything on their own. Useful when updating from a system that is unencrypted to one that is, while supporting a fallback system.
>>   
> 
> Please elaborate a bit more on how things are supposed to work this way,
> which scenarios should be addressed - and which not because they are
> inherently insecure.

Well. Switching in-field from an unencrypted system into an encrypted 
one is inherently insecure. I agree.

It seems security requirements have changed in an existing project and 
now they wanted to add encryption via an update afterwards.

If your decision is to NAK this feature, since it promotes insecure 
approaches, then I can understand.

The reason I submitted it here, is because it might be useful for others 
as well. Eventually encrypting systems is still better than leaving them 
unencrypted.

> 
>>   #### Encrypted root file system
>>   
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index b907ea7..1214a63 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -216,22 +216,41 @@ for partition_set in $partition_sets; do
>>   	if [ ! -e  "$part_device" ]; then
>>   		panic "Could not find device  mapped to '$partition' cannot be encrypted!"
>>   	fi
>> -	decrypted_part=/dev/mapper/"$crypt_mount_name"
>> -	# check if we are trying to mount root
>> -	if [ "$partition_mountpoint" = "/" ]; then
>> -		echo "ROOT=$decrypted_part" >/conf/param.conf
>> -	fi
>>   
>>   	if [ "$partition_expand" = "expand" ]; then
>>   		expand_partition $part_device
>>   	fi
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
>> +		# check if we are trying to mount root, set ROOT to plain partition:
> 
> And this is exactly where all alarms go off: We should not promote the
> inherently insecure scenario of trying to post-mortem secure the rootfs
> via an in-field update to encryption unless it is backed by some
> integrity protection mechanism already (dm-verity in our case).
> 
> We may encrypt certain data partitions post deployment if data on it is
> not sensitive or is integrity-protected at application level. I don't
> see other scenarios here, in the official isar-cip-core layer because
> they are simply bad practice.

I agree. Security requirements shouldn't just change after a product was 
released. But apparently that happened in the project where this feature 
was required.

Question here is about if cip-core is trying to deal with it 
pragmatically and support it, or if cip-core rather wants to demonstrate 
the best-practice security implementation.

I am fine with both options.

Thank you and kind regards,
Claudius

> 
>> +		if [ "$partition_mountpoint" = "/" ]; then
>> +			echo "ROOT=$part_device" >/conf/param.conf
>> +		fi
>> +
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


