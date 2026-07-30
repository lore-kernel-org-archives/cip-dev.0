Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C97C54FD2
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 10:10:14 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8216.1785406210173032811
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2026 03:10:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=OIyyQ++g;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E36D11B7F7;
	Thu, 30 Jul 2026 12:10:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1785406203;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8KYWP8lMd8NLoPw4euvGbEKV117kvpWZV3VxdSs6p4A=;
	b=OIyyQ++gWwmgauNBs88gq+746hcysKyWLOs7ZLuUeNh1ksBB7qFKTJvMHb7CsKZ1uk86iR
	MNhbCp8x795KDv+AC4ZtoBHCK1b/BXv7uE6efklw07oBlIytXFWTdrD+XQfOX8FTzYCmHg
	TL0NVsQIfdxwniJ74pTFqy+sSRcdAKiPBLJFBLUkNU6ux7bT+1WYBHqVtPLACY7MUcXOzJ
	W3JM1AUHxUQQvDWw+e9Agffq0ejnp3EuThzyiCDgk+CUF1ZwYYnKA3DwffxzAiIi4tyUfj
	vupr66NTyOysnuLcAVB8yF0vo28d8ogAMXQck4aYqaIMvzMXer5n+G+G73N8Pg==
Date: Thu, 30 Jul 2026 12:10:00 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Raymond Zwarts <raymond@kelvaneos.eu>
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] linux-6.12.y-cip: maintenance scope for EROFS
 Zstandard support
Message-ID: <amsi-IaPnI4Bujgc@duo.ucw.cz>
References: <9e61f628ca2331b2822aeaf82caa4ef7@kelvaneos.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fWbr8rqUu15+7gSa"
Content-Disposition: inline
In-Reply-To: <9e61f628ca2331b2822aeaf82caa4ef7@kelvaneos.eu>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jul 2026 10:10:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23817


--fWbr8rqUu15+7gSa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I am evaluating linux-6.12.y-cip for a non-member industrial Linux
> distribution using a read-only EROFS root filesystem.
>=20
> Our required configuration includes:
>=20
>     CONFIG_EROFS_FS=3Dy
>     CONFIG_EROFS_FS_ZIP=3Dy
>     CONFIG_EROFS_FS_ZIP_ZSTD=3Dy
>=20
> I understand that:
>=20
> 1. EROFS and its Zstandard decoder are present in linux-6.12.y-cip.
> 2. EROFS is enabled in the CIP 6.12 merged and QEMU configurations,
>    although not in the container defconfig.
> 3. Linux 6.12 describes EROFS Zstandard support as experimental.
> 4. Upstream commit 8f2fb72fd17e ("erofs: update compression algorithm
>    status") subsequently promoted Zstandard out of experimental status
>    after more than a year of testing.
> 5. The CIP maintenance policy says that features labelled experimental
>    may potentially be excluded after upstream LTS maintenance ends.

In case of ZSTD, I don't really foresee problems. You should be able
to simply use -cip; in unlikely case there are problems you can submit
patches.

> Could you clarify the intended SLTS maintenance scope?
>=20
> - Does CIP currently intend to carry applicable bug and security fixes
>   for EROFS core and CONFIG_EROFS_FS_ZIP_ZSTD through the projected
>   linux-6.12.y-cip EOL in June 2035?
>=20
> - Does EROFS being enabled in the CIP merged configurations place it
>   within the reference maintenance scope, or is that scope limited to
>   configurations submitted by CIP members?
>=20
> - Would an upstream contribution adding explicit EROFS-Zstd functional
>   testing to the CIP test pipeline help clarify or strengthen its
>   maintenance coverage?

If EROFS_.._ZSTD is important to you, I suggest you start testing
required functionality in -cip kernels, and we can talk if you run
into problems.

But these would be questions for TSC.

Best regards,
								Pavel

--fWbr8rqUu15+7gSa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCamsi+AAKCRAw5/Bqldv6
8szdAJ9E+tx+WlO1K7+H05l8C8VTNODi5wCaA2XZ6AlKfkEmBK1GxyaVtW7zBWM=
=ao98
-----END PGP SIGNATURE-----

--fWbr8rqUu15+7gSa--

