Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8386C7EE39
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 07:25:06 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.7876.1751008382243809137
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Jun 2025 00:13:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=LW1DJwa3;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0B4B110397285;
	Fri, 27 Jun 2025 09:12:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1751008380; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mcb8BTqxERZxKGt56Y5jWtWgJ9U0vwxCl2PzaRlPeY8=;
	b=LW1DJwa3f6Cy2kzJmwOqdml4XcXnnl3PXf7sZcj/eeU32XrYcRfnh5Bgu1NbiNac9cbvlE
	6yyL7GweG4b6sksDj/CvzO8JUVW84df3fqhy6YLmlXanmB+0Vv6b8JZ/BcfLc2azkx0h1K
	OY09DqpG36e3sKR/YhL+9llTrfZ7JnR1xC1Ntd9mW7eouai/BtiG6SDg3U1+o0V2adipRn
	M3jbF5X2j62mLM8C5/7m4+XB4mJU4HZKI1fLhJPdk9ehe3IaGKM89DhRW30e9BLl7BYw6W
	LUn8YKkiEQBRhLjjITgMnS6ZchnMrPuUMRXclNNeuBIdKc3kgqo7VAdYIXhwHw==
Mime-Version: 1.0
Date: Fri, 27 Jun 2025 09:12:57 +0200
Message-Id: <DAX4NZUB0TGA.39A4KRN82TL6I@denx.de>
Subject: Re: [PATCH v8 1/4] initramfs-crypt-hook: store initial encryption key in TPM2
Cc: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>, "Heinisch Alexander"
 <alexander.heinisch@siemens.com>, "Cetin Gokhan" <gokhan.cetin@siemens.com>
From: "Claudius Heine" <ch@denx.de>
To: "Jan Kiszka" <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
X-Mailer: aerc 0.20.0
References: <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de> <20250626-initramfs-crypt-hook-patches-2-v8-1-46f000788686@denx.de> <d2ae69df-f426-4317-840a-10b6e488da3f@siemens.com>
In-Reply-To: <d2ae69df-f426-4317-840a-10b6e488da3f@siemens.com>
X-Last-TLS-Session-Version: TLSv1.3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 07:25:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19255

Hi Jan,

On Thu Jun 26, 2025 at 6:32 PM CEST, Jan Kiszka wrote:
> On 26.06.25 11:09, Claudius Heine wrote:
>> cryptsetup and systemd-cryptenroll do not currently support encrypting
>> partitions directly with keys stored in the TPM. For that reason a
>> temporary random password is used for the initial encryption, which will
>> get removed once the TPM2 token is added to the partition.
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
>>  .../initramfs-crypt-hook_0.8.bb                    | 13 ++---
>>  2 files changed, 60 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-comp=
lete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> index 2b4bed02484bface7b0370e6ef1b9953e8ae4eff..9e7525117a03debdf2c526ab=
742e9428372cd0cf 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>> @@ -216,6 +216,54 @@ if [ ! -e "$tpm_device" ]; then
>>  	panic "No tpm device exists or supports pcr_hash '$pcr_bank_hash_type'=
 or '$tpm_key_algorithm' - cannot create a encrypted device!"
>>  fi
>> =20
>> +export TPM2TOOLS_TCTI=3D"device:${tpm_device}"
>> +TPM2_HANDLE=3D"0x81080001"
>
> Is this address something we may want to or have to make configurable to
> avoid collisions?

Maybe, but it might also be good to get to learn about any conflicts, so
that we can choose an address that is very likely conflict free.

`0x81000001` is used by systemd as the SRK handle, which is not
configurable.

For this temporary 'storage key', I selected a non-reserved handle [1].

So currently I would say that this would be premature optimization. If
downstream encounters an issue, making this configurable is a easy fix.
But it will also be good to know about those conflicts, and maybe find a
better address...

regards,
Claudius

[1] https://trustedcomputinggroup.org/wp-content/uploads/Registry-of-Reserv=
ed-TPM-2.0-Handles-and-Localities-Version-1.2-Revision-1.00_pub.pdf

--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-54 Fax: (+49)-8142-66989-80 Email: ch@denx.de


