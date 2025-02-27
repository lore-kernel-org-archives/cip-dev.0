Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDBCC19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:04:19 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.11048.1740665058928529854
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:04:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=AdFwWUzt;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BBDB10382D2E;
	Thu, 27 Feb 2025 15:04:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740665056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qh2IC9XEv3srDOmK5fydzCwgWiBojGJLXqaifFre3/0=;
	b=AdFwWUztOCC1Cuo8UeRdxykb066f88tQuNuFSW8dRvt7p2PaKnylDNsB0JN4cWQTEI+G5j
	OYSposWT7ZwMyOe2JlwIsAPqiVE7+5X1uG/uW8VlJBtnA2GCOeccRdEbhoDgo13ANJWhAC
	+wyorBX/uKFPwDu93uXZLy1Fk81lkpD76kf2QheRuqNgeHQ73ZH9CwtemNolcowBEyVXrh
	x9jbpDJcjFOygcosIAbiC0/7hMzoLrAG/ocbbWkZIp0r6glvsTCR4YDLakGihxLYrQFYrU
	1mwhP1b9Cu8/FOuVDiukjcT41/m0C/hv5ToKgJzLD0XaTfddIE3iBaPQxE5pjw==
Message-ID: <6f3e7b4f-94d9-42e0-8bd2-b26e4d101398@denx.de>
Date: Thu, 27 Feb 2025 15:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 4/5] initramfs-crypt-hook: implement 'noencrypt'
 option
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250226095921.168962-1-ch@denx.de>
 <20250226095921.168962-5-ch@denx.de>
 <b66ed9d8-2d90-4519-88b9-21b72f596928@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <b66ed9d8-2d90-4519-88b9-21b72f596928@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:04:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17940

Hi Quirin,

On 2025-02-27 2:16 pm, Quirin Gylstorff wrote:
>=20
>=20
> On 2/26/25 10:59, Claudius Heine via lists.cip-project.org wrote:
>> In case encryption needs to be enabled via an update, while still
>> allowing the update fall back to work. One update step where encryptio=
n
>> is supported, but no reencryption is taking place if the device is not
>> encrypted.
>>
>> For this the `noencrypt` hook is implemented, which requires some
>> restructure/reordering of the `local-top-complete` script.
>>
>> Signed-off-by: Claudius Heine <ch@denx.de>
>> ---
>> =C2=A0 doc/README.tpm2.encryption.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +-
>> =C2=A0 .../files/local-top-complete=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 29 +=
++++++++++++++----
>> =C2=A0 2 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/doc/README.tpm2.encryption.md b/doc/=20
>> README.tpm2.encryption.md
>> index 3f7e89f..515348a 100644
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
>> +- `noencrypt` will not try to encrypt the partition, it it isn't=20
>> encrypted already, but will open it if it is. This makes it possible=20
>> for an image to support encrypted systems, while not encrypting=20
>> anything on their own. Useful when updating from a system that is=20
>> unencrypted to one that is, while supporting a fallback system.
>> =C2=A0 #### Encrypted root file system
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-=20
>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-=20
>> complete
>> index b907ea7..1214a63 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -216,22 +216,41 @@ for partition_set in $partition_sets; do
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
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # check if we are trying t=
o mount root, set ROOT to plain=20
>> partition:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_mountpoin=
t" =3D "/" ]; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ec=
ho "ROOT=3D$part_device" >/conf/param.conf
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
> Is this check really necessary? In case root is not encrypted the Root=20
> partition should be given by abrootfs/verity/cmdline ?

Good point.

>=20
> Quirin
>> +
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
>>
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#17922): https://lists.cip-project.org/g/cip-dev/=20
>> message/17922
>> Mute This Topic: https://lists.cip-project.org/mt/111393564/1753640
>> Group Owner: cip-dev+owner@lists.cip-project.org
>> Unsubscribe: https://lists.cip-project.org/g/cip-dev/=20
>> leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>=20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


