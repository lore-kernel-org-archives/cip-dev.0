Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985B8C7EE33
	for <webhook@archiver.kernel.org>; Thu, 26 Jun 2025 09:09:21 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.4056.1750928956546637321
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jun 2025 02:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=HcY2qL5q;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6990C10397286;
	Thu, 26 Jun 2025 11:09:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1750928954; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=so7q37ChP1sHo6Fm9b4j5kMKO2URPoyPJ+7vWreOW2M=;
	b=HcY2qL5qPLOyuyIsZ6Ly8rXaIr+xfx/rPAtR2H2Dx7EGZmEx+4pddLUWU17wY73H6WUIeR
	D3amtaCbAAUUupm76oGyCPY00+tcgf6s7y/s4kCvOduv2tHcMsw46KPk6OKkE/+y8Za6tp
	JbfPxfOINBaWrvpoBVueL+IyVj8uAyxdpanVOG6y4PC4lcuG4XtZKQMsXaTHksRlyzlGWb
	Gk9NZwC0yQd8MQ1xAvGdlMyb24uUZMdF7yePADQXiDx9/GOKvHYuaj+8chFGzZ4MEQ2Evv
	mZVUMKTOU8ltUTteMYDkXFQNmDAfzuzuvSsCbscNCi0vfTRIM98NF24jxc70qg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 11:09:12 +0200
Message-Id: <DAWCIGASLNSS.7IYFZ3C6183I@denx.de>
To: "Jan Kiszka" <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH v7 1/4] initramfs-crypt-hook: store initial encryption
 key in TPM2
Cc: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>, "Heinisch Alexander"
 <alexander.heinisch@siemens.com>, "Cetin Gokhan" <gokhan.cetin@siemens.com>
From: "Claudius Heine" <ch@denx.de>
X-Mailer: aerc 0.20.0
References: <20250616-initramfs-crypt-hook-patches-2-v7-0-82dc9d0dbbcf@denx.de> <20250616-initramfs-crypt-hook-patches-2-v7-1-82dc9d0dbbcf@denx.de> <ad98c6ad-d8e4-4e04-8e15-8281b087c88f@siemens.com>
In-Reply-To: <ad98c6ad-d8e4-4e04-8e15-8281b087c88f@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Jun 2025 09:09:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19238

On Mon Jun 16, 2025 at 12:06 PM CEST, Jan Kiszka wrote:
> On 16.06.25 11:30, Claudius Heine wrote:
>> cryptsetup and systemd-cryptenroll do not currently support encrypting
>> partitions directly with keys stored in the TPM. For that reason a
>> temporary random password is used for the initial encryption, which will
>> get removed once the TPM2 token is added to the partition.
>
> BTW, did you already try to discuss this use case with systemd at least?
> Not to see as pushback for these changes, but maybe we can once simplify
> things again if upstream address this as well.

I talked with systemd-devel about this:
https://lists.freedesktop.org/archives/systemd-devel/2025-June/051456.html

And from what I gather is that reencryption isn't supported by systemd
and likely will stay that way.

I was pointed to systemd-repart, but that doesn't have reencryption
support:
https://github.com/systemd/systemd/pull/29731

From what I gather, they have a very different approach to encrypting
file systems, that isn't compatible to the custom scripting that was
done here in cip-core.

IIUC: They already assume that some key was programmed into the TPM2
(SRK-key), and then use systemd-repart to create new encrypted
partitions using that key and use `CopyFiles` directive to copy plain
text files to the encrypted file system from somewhere.

regards,
Claudius

>
> Jan
>
>>=20
>> However this process does not allow continuing with the encryption
>> process in case of power failure.
>>=20
>> For that reason store the initial encryption password in the TPM,
>> protected via measured boot based on the TPM2-PCR:7 register, which is
>> the default for `systemd-cryptenroll` and load it if it exists.
>>=20
>> Signed-off-by: Claudius Heine <ch@denx.de>
>> ---
>>  .../initramfs-crypt-hook/files/local-top-complete  | 56 +++++++++++++++=
+++++--
>>  .../initramfs-crypt-hook_0.7.bb                    | 13 ++---
>>  2 files changed, 60 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-comp=
lete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index ae0dcef4cb62a135beb6d4229237144b6d4edf8b..e511e8ef2d0bd4f4c8fd2fca=
248312dee173d224 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -216,6 +216,54 @@ if [ ! -e "$tpm_device" ]; then
>>  	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type'=
 or '$tpm_key_algorithm' - cannot create a encrypted device!"
>>  fi
>> =20
>> +export TPM2TOOLS_TCTI=3D"device:${tpm_device}"
>> +TPM2_HANDLE=3D"0x81080001"
>> +tpm2_key_get() {
>> +	key_file=3D"$1"
>> +	TPM2_WORKDIR=3D"/tmp/tpm2"
>> +
>> +	if ! tpm2_getcap handles-persistent | grep -q "$TPM2_HANDLE"; then
>> +		mkdir -p "${TPM2_WORKDIR}"
>> +		# Open session:
>> +		tpm2_startauthsession -S "${TPM2_WORKDIR}/session.ctx"
>> +		tpm2_policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" \
>> +			-l "${HASH_TYPE}:7" \
>> +			-L "${TPM2_WORKDIR}/pcr7.${HASH_TYPE}.policy"
>> +		tpm2_flushcontext "${TPM2_WORKDIR}/session.ctx"
>> +
>> +		# Add new key to tpm:
>> +		tpm2_createprimary -Q -C o -c "${TPM2_WORKDIR}/prim.ctx"
>> +		echo "$(tr -dc 'A-Za-z0-9_' </dev/urandom | head -c 32)" | \
>> +			tpm2_create -Q -g "sha256" \
>> +				-u "${TPM2_WORKDIR}/pcr_seal_key.pub" \
>> +				-r "${TPM2_WORKDIR}/pcr_seal_key.priv" \
>> +				-i- \
>> +				-C "${TPM2_WORKDIR}/prim.ctx" \
>> +				-L "${TPM2_WORKDIR}/pcr7.${HASH_TYPE}.policy"
>> +		tpm2_load -Q \
>> +			-C "${TPM2_WORKDIR}/prim.ctx" \
>> +			-u "${TPM2_WORKDIR}/pcr_seal_key.pub" \
>> +			-r "${TPM2_WORKDIR}/pcr_seal_key.priv" \
>> +			-n "${TPM2_WORKDIR}/pcr_seal_key.name" \
>> +			-c "${TPM2_WORKDIR}/pcr_seal_key.ctx"
>> +		tpm2_evictcontrol -c "${TPM2_WORKDIR}/pcr_seal_key.ctx" \
>> +			"$TPM2_HANDLE" -C o
>> +
>> +		rm -rf "${TPM2_WORKDIR}"
>> +	fi
>> +
>> +	mkdir -p "${TPM2_WORKDIR}"
>> +	tpm2_startauthsession --policy-session -S "${TPM2_WORKDIR}/session.ctx=
"
>> +	tpm2_policypcr -Q -S "${TPM2_WORKDIR}/session.ctx" -l "${HASH_TYPE}:7"
>> +	tpm2_unseal -p "session:${TPM2_WORKDIR}/session.ctx" -c "$TPM2_HANDLE"=
 >"$key_file"
>> +	tpm2_flushcontext "${TPM2_WORKDIR}/session.ctx"
>> +	rm -rf "${TPM2_WORKDIR}"
>> +}
>> +
>> +tpm2_key_del() {
>> +	tpm2_evictcontrol -C o -c "$TPM2_HANDLE"
>> +}
>> +
>>  prepare_for_encryption
>> =20
>>  for partition_set in $partition_sets; do
>> @@ -259,16 +307,17 @@ for partition_set in $partition_sets; do
>>  		watchdog_pid=3D$!
>>  	fi
>> =20
>> -	# create random password for initial encryption
>> -	# this will be dropped after reboot
>> +	# create random password, store it in the tpm2 encrypted and protected=
 with
>> +	# PCR:7 registers to allow continuing reencryption in case of power-fa=
ilure.
>>  	tmp_key=3D/tmp/"$(basename "$part_device")-lukskey"
>> -	openssl rand -base64 32 > "$tmp_key"
>> +	tpm2_key_get "${tmp_key}"
>> =20
>>  	case "${partition_format}" in
>>  		"reencrypt")
>>  			log_begin_msg "Encryption of ${part_device}"
>>  			reencrypt_existing_partition "$part_device" "$tmp_key"
>>  			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_=
algorithm" "$pcr_bank_hash_type"
>> +			tpm2_key_del
>>  			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>>  			log_end_msg
>>  		;;
>> @@ -277,6 +326,7 @@ for partition_set in $partition_sets; do
>>  			/usr/sbin/cryptsetup luksFormat --batch-mode \
>>  				 --type luks2 "$part_device" < "$tmp_key"
>>  			enroll_tpm2_token "$part_device" "$tmp_key" "$tpm_device" "$tpm_key_=
algorithm" "$pcr_bank_hash_type"
>> +			tpm2_key_del
>>  			open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
>>  			eval "${create_file_system_cmd} ${decrypted_part}"
>>  			log_end_msg
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook=
_0.7.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.b=
b
>> index 80a4755e4e0acfc96bb2d0f8e175e2787473e384..b48c6e89384f7f43737fdbb3=
438d5be15bb5945e 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
>> @@ -14,7 +14,6 @@ require recipes-initramfs/initramfs-hook/hook.inc
>>  DEBIAN_DEPENDS .=3D ", \
>>      cryptsetup, \
>>      awk, \
>> -    openssl, \
>>      e2fsprogs, \
>>      tpm2-tools, \
>>      coreutils, \
>> @@ -40,19 +39,21 @@ HOOK_ADD_MODULES =3D " \
>>      ecb aes_generic xts"
>> =20
>>  HOOK_COPY_EXECS =3D " \
>> -    openssl mke2fs grep awk expr seq sleep basename uuidparse mountpoin=
t \
>> -    e2fsck resize2fs cryptsetup \
>> -    tpm2_pcrread tpm2_testparms tpm2_flushcontext \
>> +    mke2fs grep awk expr seq sleep basename uuidparse mountpoint \
>> +    e2fsck resize2fs cryptsetup head tr rm \
>> +    tpm2_pcrread tpm2_testparms tpm2_flushcontext tpm2_startauthsession=
 \
>> +    tpm2_policypcr tpm2_createprimary tpm2_create tpm2_load tpm2_evictc=
ontrol \
>> +    tpm2_unseal tpm2_getcap \
>>      /usr/lib/*/libgcc_s.so.1"
>> =20
>>  HOOK_COPY_EXECS:append:clevis =3D " \
>>      clevis clevis-decrypt clevis-encrypt-tpm2 clevis-decrypt-tpm2 \
>>      clevis-luks-bind clevis-luks-unlock \
>>      clevis-luks-list clevis-luks-common-functions \
>> -    tpm2_createprimary tpm2_unseal tpm2_create tpm2_load tpm2_createpol=
icy \
>> +    tpm2_createpolicy \
>>      bash luksmeta jose sed tail sort rm mktemp pwmake file"
>>  HOOK_COPY_EXECS:append:systemd =3D " \
>> -    systemd-cryptenroll tpm2_pcrread tpm2_testparms \
>> +    systemd-cryptenroll \
>>      /usr/lib/systemd/systemd-cryptsetup \
>>      /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so"
>> =20
>>=20




--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


