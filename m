Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19602C282D3
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 07:25:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.8238.1741159529611936314
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Mar 2025 23:25:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=cLz9Dx7A;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD3EA10382C18;
	Wed,  5 Mar 2025 08:25:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741159527; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=THWJXeXVNsBlPesMRnm5R4RmxUa1cAwT+TXKfWUBNVw=;
	b=cLz9Dx7ArufA4a87joknuc1NKmsSn3lhEW1YsHizxFpUdj1vseNifdYRv/impu2t1vJ69K
	zEQfovxFo+x/HOZVlRpUFByDsrej4FGxaKkupENeRN5dcpYKQss1qHkySfFLEBQhHGtlFU
	QFQl3zSOr/Mh3SejBWVxAJ7MKSbdj6YKjsjgstff0cIJXWp1KE1VtgzaXJAY1wLM6AsanH
	bfkklBWuEWUepwe7UiEN04fJvcslgK4zmfXqST8x34+SZ6YyiYqQACdpxN5RusXIePbfRW
	DA/92QALRm04wdafkgQHpMnyjYGlg3JwdCEAoAw7efNpX5th8SBcHywCmTzfKg==
Message-ID: <cfd82623-e973-468e-99a1-1ea2c505acae@denx.de>
Date: Wed, 5 Mar 2025 08:25:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] initramfs-crypt-hook: add re-encryption recovery
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250304130743.2812183-1-ch@denx.de>
 <20250304130743.2812183-5-ch@denx.de>
 <3d4d80f3-64c0-4d2c-aa32-f4987f370eed@siemens.com>
 <24d1b6ba-f774-4616-9c1f-6de0b555932a@siemens.com>
 <57d7ae71-ec8e-4acb-b14f-9b5e93d20f09@siemens.com>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <57d7ae71-ec8e-4acb-b14f-9b5e93d20f09@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 07:25:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18030

Hi Jan,

On 2025-03-04 4:12 pm, Jan Kiszka wrote:
> On 04.03.25 16:10, Quirin Gylstorff wrote:
>>
>>
>> On 3/4/25 15:52, Jan Kiszka wrote:
>>> On 04.03.25 14:07, Claudius Heine wrote:
>>>> Integrate detection and recovery of power failures while a partition=
 is
>>>> being encrypted.
>>>>
>>>
>>> Why is this at the end of the series? It can already help the existin=
g
>>> implementation during encrypt-on-first-boot.

Because that was the order this feature was implemented, to us the=20
support for 'noencrypt' was more important than the re-encryption recover=
y.

I can look into reordering it.

>>>
>>>> There are possible scenarios:
>>>> 1. Power-fail happens while the partition is reencrypted:
>>>>  =C2=A0=C2=A0 - The LUKS header contains `online-reencrypt-v2` and n=
eeds to be
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 repaired with `cryptsetup repair` before i=
t can continue.
>>>>  =C2=A0=C2=A0 - Also no resizing of the file system is necessary
>>>> 2. Power-fail happens before the systemd-tpm2/clevis token can be
>>>> installed
>>>>  =C2=A0=C2=A0 - The LUKS header does not contain 'systemd-tpm2'/'cle=
vis', thus it
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 needs to be registered and the temporary e=
ncryption key needs to be
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 removed
>>>>
>>>> In both scenarios the system after the reboot needs to have access t=
o
>>>> the temporary encryption key that was initially used. So using a ran=
dom
>>>> one, generated via `openssl rand` is not possible. Since it is only =
a
>>>> temporary key and gets removed after the systemd-tpm2/clevis token w=
as
>>>> installed, a known password can be used.
>>>>
>>>> The list of these scenarios is not complete, there might be other
>>>> instances where a sudden power-fail could be fatal to the system, bu=
t
>>>> these where the most obvious and risky ones.
>>>
>>> For recovery of the first boot, this might be enough. But when propos=
ing
>>> this for in-field recovery, we should be stricter with thinking the
>>> details through. If we fix them, immediately or later (or never if
>>> unfixable) is on a different page.
>>>
>>>>
>>>> Signed-off-by: Claudius Heine <ch@denx.de>
>>>> ---
>>>>  =C2=A0 .../files/local-top-complete=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3=
3 +++++++++++++++----
>>>>  =C2=A0 .../initramfs-crypt-hook_0.6.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++-
>>>>  =C2=A0 2 files changed, 29 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>>>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-
>>>> complete
>>>> index 47533b5..e67f26f 100644
>>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complet=
e
>>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complet=
e
>>>> @@ -72,6 +72,9 @@ reencrypt_existing_partition() {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size=3D"$(expr "$part_size_b=
locks" - 65536 )"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size_in_byte=3D"$(expr "$red=
uced_size" \* 512)"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size_in_kb=3D"$(expr "$reduc=
ed_size_in_byte" / 1024)K"
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 CRYPTSETUP_PARAMS=3D"--reduce-device-size ${redu=
ce_device_size}k"
>>>> +
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case $partition_fstype in
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ext*)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # reduce the=
 filesystem and partition by 32M to fit the
>>>> LUKS header
>>>> @@ -90,14 +93,25 @@ reencrypt_existing_partition() {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 squashfs|swap|erofs|"")
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ "$debug" =3D=
 "y" ] && echo "skip disk resize as it is not
>>>> supported or unnecessary for fstype: '$partition_fstype'"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>> +=C2=A0=C2=A0=C2=A0 luks)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Check if reencrypt was=
 aborted
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup =
luksDump --batch-mode "$1" \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | grep -q "online-reencrypt-v2"; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
/usr/sbin/cryptsetup repair --batch-mode "$1" < "$2" || \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 panic "cryptsetup repair was not successful"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # already luks partition=
, don't resize
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CRYPTSETUP_PARAMS=3D""
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "canno=
t resize partition, unsupported fstype:
>>>> '$partition_fstype'"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -x /usr/sbin/cryptsetup-reencry=
pt ]; then
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup-ree=
ncrypt --new --reduce-device-size
>>>> "$reduce_device_size"k "$1" < "$2"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup-ree=
ncrypt --new ${CRYPTSETUP_PARAMS}
>>>> "$1" < "$2"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup ree=
ncrypt --encrypt --reduce-device-
>>>> size "$reduce_device_size"k "$1" < "$2"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup ree=
ncrypt --encrypt
>>>> ${CRYPTSETUP_PARAMS} "$1" < "$2"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>>  =C2=A0 }
>>>>  =C2=A0 @@ -244,7 +258,7 @@ for partition_set in $partition_sets; do
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If partition is already encrypted,=
 decrypt and continue with
>>>> next partition:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt=
_mount_name"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --b=
atch-mode "$part_device" \
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| grep -q "luks2"; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| grep -q "systemd-tpm2\|clevis"; then
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tpm2_pa=
rtition "$part_device" "$crypt_mount_name"
>>>> "$tpm_device"
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # che=
ck if we are trying to mount root, set ROOT to
>>>> decrypted partition:
>>>> @@ -255,6 +269,12 @@ for partition_set in $partition_sets; do
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>>  =C2=A0 +=C2=A0=C2=A0=C2=A0 # If partition contains an aborted reenc=
rypt luks header,
>>>> switch to reencrypt mode:
>>>> +=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batch-mode "$=
{part_device}" \
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| grep -q "online-reencrypt-v2"; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition_format=3D"reen=
crypt"
>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>> +
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If partition should not be encrypt=
ed, continue with next
>>>> partition:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_format" =3D "noencr=
ypt" ]
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 then
>>>> @@ -272,10 +292,11 @@ for partition_set in $partition_sets; do
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watchdog_pid=
=3D$!
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 # create random password for initial enc=
ryption
>>>> -=C2=A0=C2=A0=C2=A0 # this will be dropped after reboot
>>>> +=C2=A0=C2=A0=C2=A0 # use partuuid of the partition for initial encr=
yption password,
>>>> this key
>>>> +=C2=A0=C2=A0=C2=A0 # will be removed after the reencryption has fin=
ished and the
>>>> TPM2 token is
>>>> +=C2=A0=C2=A0=C2=A0 # registered:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_key=3D/tmp/"$(basename "$part_de=
vice")-lukskey"
>>>> -=C2=A0=C2=A0=C2=A0 openssl rand -base64 32 > "$tmp_key"
>>>> +=C2=A0=C2=A0=C2=A0 lsblk -no partuuid "$part_device" > "$tmp_key"
>>>
>>> This should be factored out into a separate commit. I don't disagree
>>> about it, it just deserves an own, clear reasoning. Without recovery,=
 it
>>> looks to me like a nice size optimization for the initramfs by droppi=
ng
>>> the openssl dependency.
>>
>> Why `lsblk` instead of `blkid -s PARTUUID -o value`, as blkid is alrea=
dy
>> used in initramfs-verity-hook and initramfs-abrootfs-hook this would
>> save more space.

Good idea.

>=20
> Or just use "some-long-hardcoded-temporary-password". From a security
> perspective, there should be no difference.

That is was we did initially downstream, but I thought that just=20
inserting some fixed hard-coded password string might have even more=20
issues being accepted here upstream than using some device parameter.

We could also use `dmidecode -s system-uuid`, that at least would=20
require to readout the uuid of the system. Having the storage medium=20
alone would not be enough.

regards,
Claudius

>=20
> Jan
>=20

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


