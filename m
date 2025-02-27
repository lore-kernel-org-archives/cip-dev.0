Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46049C19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:46:40 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.12026.1740667594698574411
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:46:35 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=KSTbL1Vz;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1526F10382D2E;
	Thu, 27 Feb 2025 15:46:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1740667592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4u6Yb9GpyxeWpnvMubb1XNxvRHxqbELR/V2RVu512t8=;
	b=KSTbL1VzoJPHUybsJEvfmVbvJMKiqu792tqyADoKfMT3tupVzY3dzkL7G7JVEpZimsavxN
	eCXCLgr50qDrPIzI+U5ru7OE1DAfFr7RoUvXi1U7MvVBVcXGCKBcorm6IysdXh2SQ9cA7b
	n6q6IfVYksK5zDbUWFeqNex8BYwj6/VLzw74aViDr9uXIDkOAtwCV3tPCsfOZyxkvmxKvm
	WrmgPqplrxpJqQ5rxu7S01MWBI63hPpszXJ/WQXlcW/GmUjQWHRG/w/OxPUJilI79vLOon
	qhva4KiuvAQvFOCWyyc7B1W+FIklIlFXdPArhhVi3ifj5MP7/Q2+6ihJ8hYyTw==
Message-ID: <49f3a657-5c55-41bd-be89-5f40ffb0e87a@denx.de>
Date: Thu, 27 Feb 2025 15:46:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] initramfs-crypt-hook: add re-encryption recovery
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>
References: <20250227143022.323950-1-ch@denx.de>
 <20250227143022.323950-5-ch@denx.de>
 <8f3bbc52-69e3-4187-a229-8d9356b22fd0@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <8f3bbc52-69e3-4187-a229-8d9356b22fd0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:46:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17948

Hi Quirin,

On 2025-02-27 3:37 pm, Quirin Gylstorff wrote:
>=20
>=20
> On 2/27/25 15:30, Claudius Heine wrote:
>> Integrate detection and recovery of power failures while a partition i=
s
>> being encrypted.
>>
>> There are possible scenarios:
>> 1. Power-fail happens while the partition is reencrypted:
>> =C2=A0=C2=A0 - The LUKS header contains `online-reencrypt-v2` and need=
s to be
>> =C2=A0=C2=A0=C2=A0=C2=A0 repaired with `cryptsetup repair` before it c=
an continue.
>> =C2=A0=C2=A0 - Also no resizing of the file system is necessary
>> 2. Power-fail happens before the systemd-tpm2 token can be installed
>> =C2=A0=C2=A0 - The LUKS header does not contain 'systemd-tpm2', thus i=
t needs to be
>> =C2=A0=C2=A0=C2=A0=C2=A0 registered and the temporary encryption key n=
eeds to be removed
>>
>> In both scenarios the system after the reboot needs to have access to
>> the temporary encryption key that was initially used. So using a rando=
m
>> one, generated via `openssl rand` is not possible. Since it is only a
>> temporary key and gets removed after the systemd-tpm2 token was
>> installed, a known password can be used.
>>
>> The list of these scenarios is not complete, there might be other
>> instances where a sudden power-fail could be fatal to the system, but
>> these where the most obvious and risky ones.
>>
>> Signed-off-by: Claudius Heine <ch@denx.de>
>> ---
>> =C2=A0 .../files/local-top-complete=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 +=
++++++++++++++----
>> =C2=A0 .../initramfs-crypt-hook_0.6.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++-
>> =C2=A0 2 files changed, 29 insertions(+), 9 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-=20
>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-=20
>> complete
>> index 4b6451a..6034175 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -72,6 +72,9 @@ reencrypt_existing_partition() {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size=3D"$(expr "$part_size_bloc=
ks" - 65536 )"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size_in_byte=3D"$(expr "$reduce=
d_size" \* 512)"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size_in_kb=3D"$(expr "$reduced_=
size_in_byte" / 1024)K"
>> +
>> +=C2=A0=C2=A0=C2=A0 CRYPTSETUP_PARAMS=3D"--reduce-device-size ${reduce=
_device_size}k"
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case $partition_fstype in
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ext*)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # reduce the fi=
lesystem and partition by 32M to fit the LUKS=20
>> header
>> @@ -90,14 +93,25 @@ reencrypt_existing_partition() {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 squashfs|swap|erofs|"")
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ "$debug" =3D =
"y" ] && echo "skip disk resize as it is not=20
>> supported or unnecessary for fstype: '$partition_fstype'"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>> +=C2=A0=C2=A0=C2=A0 luks)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Check if reencrypt was a=
borted
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup lu=
ksDump --batch-mode "$1" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | grep -q "online-reencrypt-v2"; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /u=
sr/sbin/cryptsetup repair --batch-mode "$1" < "$2" || \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 panic "cryptsetup repair was not successful"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # already luks partition, =
don't resize
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CRYPTSETUP_PARAMS=3D""
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "cannot r=
esize partition, unsupported fstype:=20
>> '$partition_fstype'"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -x /usr/sbin/cryptsetup-reencrypt =
]; then
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup-reenc=
rypt --new --reduce-device-size=20
>> "$reduce_device_size"k "$1" < "$2"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup-reenc=
rypt --new ${CRYPTSETUP_PARAMS}=20
>> "$1" < "$2"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup reenc=
rypt --encrypt --reduce-device-size=20
>> "$reduce_device_size"k "$1" < "$2"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup reenc=
rypt --encrypt ${CRYPTSETUP_PARAMS}=20
>> "$1" < "$2"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0 }
>> @@ -219,7 +233,7 @@ for partition_set in $partition_sets; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If partition is already encrypted, de=
crypt and continue with=20
>> next partition:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mo=
unt_name"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batc=
h-mode "$part_device" \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
grep -q "luks2"; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
grep -q "systemd-tpm2"; then
> This should break encryption with clevis.

I don't have a test setup for clevis, so any input on how to fix this,=20
would be great.

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tpm2_parti=
tion "$part_device" "$crypt_mount_name"=20
>> "$tpm_device"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # check if we a=
re trying to mount root, set ROOT to=20
>> decrypted partition:
>> @@ -230,6 +244,12 @@ for partition_set in $partition_sets; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0 # If partition contains an aborted reencrypt luks =
header, switch=20
>> to reencrypt mode:
>> +=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batch-mode "${p=
art_device}" \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
grep -q "online-reencrypt-v2"; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition_format=3D"reencr=
ypt"
>> +=C2=A0=C2=A0=C2=A0 fi
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If partition should not be encrypted,=
 continue with next=20
>> partition:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_format" =3D "noencrypt=
" ]
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 then
>> @@ -247,10 +267,11 @@ for partition_set in $partition_sets; do
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watchdog_pid=3D=
$!
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> -=C2=A0=C2=A0=C2=A0 # create random password for initial encryption
>> -=C2=A0=C2=A0=C2=A0 # this will be dropped after reboot
>> +=C2=A0=C2=A0=C2=A0 # use partuuid of the partition for initial encryp=
tion password,=20
>> this key
>> +=C2=A0=C2=A0=C2=A0 # will be removed after the reencryption has finis=
hed and the=20
>> TPM2 token is
>> +=C2=A0=C2=A0=C2=A0 # registered:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_key=3D/tmp/"$(basename "$part_devic=
e")-lukskey"
>> -=C2=A0=C2=A0=C2=A0 openssl rand -base64 32 > "$tmp_key"
>> +=C2=A0=C2=A0=C2=A0 lsblk -no partuuid "$part_device" > "$tmp_key"
>=20
> This has the security implication that until the tpm key is used the=20
> device is insecure.

Yes. As I noted in the commit message.

The other method, I thought about was using the tpm2, where I am=20
encrypting a known key, like the partuuid with an internal tpm2 key, and=20
using the resulting encrypted blob as a hexstring for the password.

But I am not very familiar with TPM2 on how to properly do that.

Other options would be to create a password and store it in the TPM2=20
NVRAM, but that would not be very secure as well.

So any suggestions for improvment here would be great.

regards,
Claudius

>=20
> Quirin
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case "${partition_format}" in
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "reencrypt")
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-=20
>> hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-=20
>> hook_0.6.bb
>> index c9a7f89..5e82521 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.=
bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.=
bb
>> @@ -14,7 +14,6 @@ require recipes-initramfs/initramfs-hook/hook.inc
>> =C2=A0 DEBIAN_DEPENDS .=3D ", \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cryptsetup, \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 awk, \
>> -=C2=A0=C2=A0=C2=A0 openssl, \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e2fsprogs, \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2-tools, \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 coreutils, \
>> @@ -40,8 +39,8 @@ HOOK_ADD_MODULES =3D " \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ecb aes_generic xts"
>> =C2=A0 HOOK_COPY_EXECS =3D " \
>> -=C2=A0=C2=A0=C2=A0 openssl mke2fs grep awk expr seq sleep basename uu=
idparse=20
>> mountpoint \
>> -=C2=A0=C2=A0=C2=A0 e2fsck resize2fs cryptsetup cmp \
>> +=C2=A0=C2=A0=C2=A0 mke2fs grep awk expr seq sleep basename uuidparse =
mountpoint \
>> +=C2=A0=C2=A0=C2=A0 e2fsck resize2fs cryptsetup cmp lsblk \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2_pcrread tpm2_testparms tpm2_flushc=
ontext \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/lib/*/libgcc_s.so.1"
>=20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


