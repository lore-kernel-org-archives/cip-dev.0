Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB18FC282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 10:11:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.9473.1741255881846740949
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 02:11:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@denx.de header.s=mx-20241105 header.b=epAMVAqQ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7B3AC10382C18;
	Thu,  6 Mar 2025 11:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741255879; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KiysIF2g2t+oVsa0uaWIn5x7rcv3XIEUa1FU2yLdmwQ=;
	b=epAMVAqQnKeWCB5d5Aykf1Oslk7rppx4vEhbIYvCj7c1G0l07jUsFF9G1Q9iOKVgoQRoDO
	VW8+VNcM98tiqPOjpbaEAmPPNbfsmeMVOEUVV3Ghex2km6dhZOq2wLktYazsjAMjU0kVfE
	OqFkYWyeH56DlnpK9B3WTL7e87VHDDSiUiHPUU5pSUwVt58vOM0PSKZa6eBaZFVXSqnFe8
	oPsXKFSebybNim+l6y/1Z3DLWC6RtnZ2ZUwXja4rZbmwRQ8q+T2kLeytZXlPl09dw7ZXJa
	eS/AgZllBgeRsiCIuFrp/AEjbVF1UYsGyfrH/L0uo5Nhdy3oUzUuR0bM5+TD7A==
Message-ID: <602ce0bb-ada2-4eb4-87e8-e917a2388c65@denx.de>
Date: Thu, 6 Mar 2025 11:11:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH v4 2/5] initramfs-crypt-hook: use static
 temporary encryption key
To: "Heinisch, Alexander" <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>,
 "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
References: <20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de>
 <20250305-initramfs-crypt-hook-patches-2-v4-2-4170912e5261@denx.de>
 <AM7PR10MB3320E9FCB6FBE8D3FA69DA0686CA2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Claudius Heine <ch@denx.de>
Organization: Denx Software Engineering
In-Reply-To: <AM7PR10MB3320E9FCB6FBE8D3FA69DA0686CA2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 10:11:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18053

Hi Alexander,

On 2025-03-06 10:35 am, Heinisch, Alexander wrote:
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On=
 Behalf Of Claudius Heine via lists.cip-project.org
>> Sent: Mittwoch, 5. M=C3=A4rz 2025 13:00
>> To: cip-dev@lists.cip-project.org
>> Cc: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>; Gylstorff, Quir=
in (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>; Claudius Heine <ch=
@denx.de>
>> Subject: [cip-dev] [PATCH v4 2/5] initramfs-crypt-hook: use static tem=
porary encryption key
>>
>> Using a temporary random value for the temporary encryption key makes =
it impossible to continue encryption if it was aborted at a later date.
>>
>> Instead a static key can be used, which will allow the continuation of=
 the encryption process.
>=20
> During that phase, an attacker could derive the volume key using that s=
tatic key!
> e.g. `cryptsetup luksDump --dump-volume-key`
>=20
>>
>> Security wise the partially encrypted volume, with a static temporary =
encryption key can be considered the same as the un-encrypted partition t=
hat was there before the system has booted. So using a known temporary en=
cryption key should not affect the system security in that way.
>=20
> For new devices, during device bootstrapping / setup that's probably tr=
ue,
> but such assumption is not generalizable!
> But even if it was, once the device is in the field, probably sensitive=
 data is
> added during onboarding or gathered during operation.
>=20
> Thus, once the volume key is retrieved (as described above) attackers c=
ould
> potentially unencrypt content after years, getting access to sensitive =
data which
> wasn't there initially.

That is true, I wasn't considering that.

I guess the only real option would be to try to use the TPM2 to generate=20
a static key... I will have to research how that works.

regards,
Claudius

>=20
> BR Alexander
>=20
>>
>> It is just important to let the re-encryption process properly finish =
until the temporary encryption key is removed.
>>
>> Signed-off-by: Claudius Heine <ch@denx.de>
>> ---
>>   recipes-initramfs/initramfs-crypt-hook/files/local-top-complete    |=
 7 ++++---
>>   recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb |=
 3 +--
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-co=
mplete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index ae0dcef4cb62a135beb6d4229237144b6d4edf8b..ea9b6352daadbea625d616=
8d1dc75ad616028fe0 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -259,10 +259,11 @@ for partition_set in $partition_sets; do
>>   		watchdog_pid=3D$!
>>   	fi
>>  =20
>> -	# create random password for initial encryption
>> -	# this will be dropped after reboot
>> +	# use partuuid of the partition for initial encryption password, thi=
s key
>> +	# will be removed after the reencryption has finished and the TPM2 t=
oken is
>> +	# registered:
>>   	tmp_key=3D/tmp/"$(basename "$part_device")-lukskey"
>> -	openssl rand -base64 32 > "$tmp_key"
>> +	blkid -s PARTUUID -o value "$part_device" > "$tmp_key"
>>  =20
>>   	case "${partition_format}" in
>>   		"reencrypt")
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-ho=
ok_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0=
.6.bb
>> index df335c9f75d6e74b3e167689ec9c73dd3781a890..69d204e9539c2e5024db83=
2e5b305fe73396317b 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.=
bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.=
bb
>> @@ -14,7 +14,6 @@ require recipes-initramfs/initramfs-hook/hook.inc
>>   DEBIAN_DEPENDS .=3D ", \
>>       cryptsetup, \
>>       awk, \
>> -    openssl, \
>>       e2fsprogs, \
>>       tpm2-tools, \
>>       coreutils, \
>> @@ -40,7 +39,7 @@ HOOK_ADD_MODULES =3D " \
>>       ecb aes_generic xts"
>>  =20
>>   HOOK_COPY_EXECS =3D " \
>> -    openssl mke2fs grep awk expr seq sleep basename uuidparse mountpo=
int \
>> +    mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
>>       e2fsck resize2fs cryptsetup \
>>       tpm2_pcrread tpm2_testparms tpm2_flushcontext \
>>       /usr/lib/*/libgcc_s.so.1"
>>
>> --
>> 2.47.2
>>

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


