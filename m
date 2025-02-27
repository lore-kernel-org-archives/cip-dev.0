Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415C9C19F32
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:49:50 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.12245.1740667789148906199
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:49:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=BX12awVn;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 16EDF10382D2E;
	Thu, 27 Feb 2025 15:49:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740667787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ert3qB/o6rxPw3gA7n6Cj8YK1apqLccRI4va4mnfKoo=;
	b=BX12awVnuYXIYwX8IDcsQPtzLrCqBuoxLgV3intEyWOZ3qrpvgTa523BylkhlPIuXPMBiY
	4jOWHlVUcXT3pB8lvN/1JffS6CpHSH85RHWJ/SQChE5Xz6jKoHF8MXbt6eEsEXYMm72fhd
	tDsFYC4Vyn9Ay8L0FFhLHx0lrLBD7m/yiplsBrgxyEf1xk2dLNIWXDagUXyH0rfDe5ViJh
	BvlprdkjqbH+y8ckxM9s0xUNkugU4WGeHC6d9/eihVeG5zmCWqzje9jDR+KCYDv+GGJLob
	JkbdcE6pPvtkpoOMO/a5IStB1Vso9imFd/TDRJSMYVzMqaHCM3V3pgx2MGUMIA==
Message-ID: <01544894-2abd-4f58-ae7f-4ca43e137138@denx.de>
Date: Thu, 27 Feb 2025 15:49:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] initramfs-crypt-hook: implement 'noencrypt' option
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>
References: <20250227143022.323950-1-ch@denx.de>
 <20250227143022.323950-3-ch@denx.de>
 <56a7a225-2213-49b4-980e-0c288b1e8874@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <56a7a225-2213-49b4-980e-0c288b1e8874@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:49:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17949

Hi Qurin,

On 2025-02-27 3:42 pm, Quirin Gylstorff wrote:
>=20
>=20
> On 2/27/25 15:30, Claudius Heine wrote:
>> In case encryption needs to be enabled via an update, while still
>> allowing the update fall back to work. One update step where encryptio=
n
>> is supported, but no reencryption is taking place if the device is not
>> encrypted.
>=20
> The scenario this patch tries to solve is update from A to B:
> - Update is not confirmed
> - the encryption was successful
> -=C2=A0 Error occurs and we fallback to Partition A
>=20
> Is that correct?

Yes, and it is about a shared data partition, that needs to be available=20
on both systems and should eventually be encrypted. The root file=20
systems do not really matter, because they are belong to each update slot=
.

Update slot A needs to be able to mount the encrypted partition, but=20
should not encrypt it.

regards,
Claudius

>=20
> Quirin
>>
>> For this the `noencrypt` hook is implemented, which requires some
>> restructure/reordering of the `local-top-complete` script.
>>
>> Signed-off-by: Claudius Heine <ch@denx.de>
>> ---
>> =C2=A0 doc/README.tpm2.encryption.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++=
-
>> =C2=A0 .../files/local-top-complete=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 24 +=
++++++++++++++----
>> =C2=A0 2 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/doc/README.tpm2.encryption.md b/doc/=20
>> README.tpm2.encryption.md
>> index 3f7e89f..a503095 100644
>> --- a/doc/README.tpm2.encryption.md
>> +++ b/doc/README.tpm2.encryption.md
>> @@ -42,11 +42,12 @@ The initramfs-crypt-hook recipe has the following=20
>> variables which can be overwri
>> =C2=A0 ### CRYPT_PARTITIONS
>> =C2=A0 The variable `CRYPT_PARTITIONS` contains the information which=20
>> partition shall be encrypted where to mount it.
>> -Each entry uses the schema `<partition-=20
>> identifier>:<mountpoint>:<reencrypt or format>`.
>> +Each entry uses the schema `<partition-=20
>> identifier>:<mountpoint>:<reencrypt | format | noencrypt>`.
>> =C2=A0 - The `partition-idenitifer` is used to identify the partition =
on=20
>> the disk, it can contain a partition label, partition UUID or absolute=
=20
>> path to the partition device, e.g. `/dev/sda`.
>> =C2=A0 - The `mountpoint` is used mount the decrypted partition in the=
 root=20
>> file system
>> =C2=A0 - `reencrypt` uses `cryptsetup reencrypt` to encrypt the exitin=
g=20
>> content of the partition. This reduces the partition by 32MB and the=20
>> file system by a similar amount
>> =C2=A0 - `format` creates a empty LUKS partition and creates a file sy=
stem=20
>> defined with the shell command given in `CRYPT_CREATE_FILE_SYSTEM_CMD`
>> +- `noencrypt` will not try to encrypt the partition, if it isn't=20
>> encrypted already, but will open it if it is. This makes it possible=20
>> for an system to support encrypted partitions, while not encrypting=20
>> anything on their own. Useful when updating from a system that is=20
>> unencrypted to one that is, while supporting a fallback system. For=20
>> example, with a shared data partition, the fallback system would have=20
>> the `noencrypt` option, while the encrypted system would have the=20
>> `reencrypt` option set for it. Now the fallback system can still open=20
>> the data partition if the update to the encrypted system failed.
>> =C2=A0 #### Encrypted root file system
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-=20
>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-=20
>> complete
>> index 502fcc1..67722fc 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -211,22 +211,36 @@ for partition_set in $partition_sets; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ ! -e=C2=A0 "$part_device" ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "Could no=
t find device=C2=A0 mapped to '$partition' cannot=20
>> be encrypted!"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> -=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mount_name"
>> -=C2=A0=C2=A0=C2=A0 # check if we are trying to mount root
>> -=C2=A0=C2=A0=C2=A0 if [ "$partition_mountpoint" =3D "/" ]; then
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "ROOT=3D$decrypted_pa=
rt" >/conf/param.conf
>> -=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_expand" =3D "expand" ]=
; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 expand_partitio=
n $part_device
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 # If partition is already encrypted, decrypt and c=
ontinue with=20
>> next partition:
>> +=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mount_name"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batc=
h-mode "$part_device" \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | grep -q "luks2"; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tpm2_parti=
tion "$part_device" "$crypt_mount_name"=20
>> "$tpm_device"
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # check if we are trying t=
o mount root, set ROOT to decrypted=20
>> partition:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_mountpoin=
t" =3D "/" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ec=
ho "ROOT=3D$decrypted_part" >/conf/param.conf
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 # If partition should not be encrypted, continue w=
ith next=20
>> partition:
>> +=C2=A0=C2=A0=C2=A0 if [ "$partition_format" =3D "noencrypt" ]
>> +=C2=A0=C2=A0=C2=A0 then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>> +=C2=A0=C2=A0=C2=A0 fi
>> +
>> +=C2=A0=C2=A0=C2=A0 # check if we are trying to mount root, set ROOT t=
o decrypted=20
>> partition:
>> +=C2=A0=C2=A0=C2=A0 if [ "$partition_mountpoint" =3D "/" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 echo "ROOT=3D$decrypted_pa=
rt" >/conf/param.conf
>> +=C2=A0=C2=A0=C2=A0 fi
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # service watchdog in the background du=
ring lengthy re-encryption
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -z "$watchdog_pid" ]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 service_watchdo=
g &
>=20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


