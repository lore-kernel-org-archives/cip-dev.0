Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8003C5B549
	for <webhook@archiver.kernel.org>; Mon,  2 Jun 2025 08:20:14 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.44476.1748852411604480924
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Jun 2025 01:20:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=BUIb6a7h;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C59010397298;
	Mon,  2 Jun 2025 10:20:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1748852409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nfYYbjyVbLIQnACyD2q/HZvzo3EAID0X8Of/sU5wgqE=;
	b=BUIb6a7h0TS0g/DQzfTiOBr95CgQB66in6ixAUjOPk2spDnyMrnfohc+UDgPCGIzUyxjAw
	SK2GpDXudBUNZwJ3qAtG3f3P7PT8xVZqRInxZ2pXmvgXsJR5zUEl3pSbYZCefY/rKcoYpT
	/QECljtWiS1ISA08ufOG3fgxyEPLr3gQwuioIQO/SHmMCtFuTaRf9zvQeVyMUYEACqC2kN
	freu+d2WzTD4Pufb7eLeRIaXmmmO66rJLjCCsOzTx5oRbnczscl/keyXxxkjHX1FyIvs+4
	NlmOjykASVCNYEl1YorGq9SYsadFnpGM7SgXmP8bUglbs1KGPAkSAbJ8/ps/Zg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Jun 2025 10:20:07 +0200
Message-Id: <DABWFSN87AVE.H2RGOY175Z6S@denx.de>
Cc: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>, "Alexander"
 <alexander.heinisch@siemens.com>, "Cetin, Gokhan"
 <gokhan.cetin@siemens.com>
From: "Claudius Heine" <ch@denx.de>
To: "Jan Kiszka" <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [PATCH v6 0/4] initramfs-crypt-hook patch
X-Mailer: aerc 0.20.0
References: <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de> <69ab7fad-b2e4-4fe7-bb16-1d6e0bbb4d5a@siemens.com>
In-Reply-To: <69ab7fad-b2e4-4fe7-bb16-1d6e0bbb4d5a@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Jun 2025 08:20:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18959

On Fri May 30, 2025 at 4:19 PM CEST, Jan Kiszka wrote:
> On 20.03.25 08:43, Claudius Heine wrote:
>> Hi,
>>=20
>> here is v6 of my patchset.
>>=20
>> I fixed the issue I found in the last patchset, now the `format-if-empty=
` process is a bit more power-fail save.
>>=20
>> But I suppose that if the luks header could not be written fully, and th=
e `luks` fs type is not detected, it might still cause issues, but I am not=
 sure I can prevent that effectively.
>>=20
>> Kind regards,
>> Claudius
>>=20
>> ---
>> Changes in v6:
>> - luks formatting of format-if-empty will now be redone when if it is a
>>   luks partition without a TPM2 token, this makes it a bit more
>>   power-fail save
>> - Link to v5: https://lore.kernel.org/r/20250313-initramfs-crypt-hook-pa=
tches-2-v5-0-fc62d4a2ad29@denx.de
>>=20
>> Changes in v5:
>> - Switch to use TPM2 protected password instead of static initial
>>   password for encryption
>> - Link to v4: https://lore.kernel.org/r/20250305-initramfs-crypt-hook-pa=
tches-2-v4-0-4170912e5261@denx.de
>>=20
>> Changes in v4:
>>  - improve documentation and commit messages
>>  - reorder commits, to put re-encryption recovery up front
>>  - extract static temporary encryption key patch into its own
>>  - switch from lsblk to blkid
>>=20
>> Changes in v3:
>>  - Rebase on current next
>>  - Extended `noencrypt` documentation
>>  - support clevis tokens for re-encryption recovery
>>=20
>> Changes in v2:
>>  - Added more descriptive commit message
>>  - Added more descriptive documentation about noencrypt option
>>  - Fixed typos in documentation
>>  - removed unnecessary setting of /conf/param.conf in initramfs-crypt-ho=
ok
>>  - added re-encryption recovery patch
>>=20
>> ---
>> Claudius Heine (4):
>>       initramfs-crypt-hook: store initial encryption key in TPM2
>>       initramfs-crypt-hook: add re-encryption recovery
>>       initramfs-crypt-hook: implement 'noencrypt' option
>>       initramfs-crypt-hook: add 'format-if-empty' feature
>>=20
>>  doc/README.tpm2.encryption.md                      |  25 +++-
>>  .../initramfs-crypt-hook/files/local-top-complete  | 127 ++++++++++++++=
+++++--
>>  .../initramfs-crypt-hook_0.7.bb                    |  12 +-
>>  3 files changed, 146 insertions(+), 18 deletions(-)
>> ---
>> base-commit: f5661b18b9721eee984ffc3b75169b40508469cb
>> change-id: 20250305-initramfs-crypt-hook-patches-2-9cc4a027c89a
>>=20
>> Best regards,
>
> Seems this got lost after 1.7, G=C3=B6khan just reminded me. Any updates =
for
> this in the meantime?

From my side v6 is still awaiting review. You mentioned that you will
not merge it now, but in the future, and I have not received any further
comments about this code so far.

regards,
Claudius




--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


