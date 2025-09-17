Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C352FCA0EE8
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 09:29:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.18626.1758101369592979016
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 02:29:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=CrTMAPjL;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 56AB91038C113;
	Wed, 17 Sep 2025 11:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1758101367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ifxOOFlQzMScl2hdwFhWx4FrnVgchficpgni8lHuAGU=;
	b=CrTMAPjLBiffTh00LHnH4PvleMkjk3RmddWBk9ottoMbdBx4Drr3ZvggEszAVl8GgH07an
	XnxQ6NpbziR8BUTHrgyagxlpxEZpITbLvtAnJRo35bA5LWmkUtHiySuRHTicMDDw0ZMu/m
	Fe6Ybqp8Yn7CppoA7zRRVyxpv4msAX+IsAg1EsA9mvwL6yu7PYvO13b2PE5ohJMUGiERhG
	Yn5KgMrRJ8s6UaPQzCSvWr8rTY+DxRwJ5FdsVrSYwYyKLiAfLXp9pHREWArv7AEwEnmyt4
	HZ6RNcKaNeaR8kGuED4JxXccNBGv5KlTxPsW45AdvzdvyUhyqOADupg454XV4w==
Date: Wed, 17 Sep 2025 11:29:23 +0200
From: Pavel Machek <pavel@denx.de>
To: sohaibfacebook396@gmail.com
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] GCC Toolchain Requirements for Linux v4.4.302-cip102
 Build
Message-ID: <aMp/c1nAo3Mpxjum@duo.ucw.cz>
References: <CAC=y2wxfBD8ZEc_wmCtyW147kCw2P_sCrfWXdthZyYxYYxHeAQ@mail.gmail.com>
 <CAC=y2wzPB8rBrhyTN7G7MU8vzpav8SpsniiedZ=ie8Z096ZY=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S01NHa8k/gFB+OkV"
Content-Disposition: inline
In-Reply-To: <CAC=y2wzPB8rBrhyTN7G7MU8vzpav8SpsniiedZ=ie8Z096ZY=A@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 09:29:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20071


--S01NHa8k/gFB+OkV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I am currently trying to build Linux kernel v4.4.302-cip102 and
> encountering several warnings during the build process. I suspect these m=
ay
> be related to using a more recent toolchain (GCC 14.x) than what is
> officially supported for this kernel version.

Why are warnings a problem?

> *Build Warnings Encountered:*
>=20
> LD      arch/arm/mm/built-in.o
>=20
> warning: arch/arm/mm/l2c-l2x0-resume.o: missing .note.GNU-stack section
> implies executable stack
>=20
> NOTE: This behaviour is deprecated and will be removed in a future version
> of the linker

So this tells you than newer toolchain versions may be bad idea.

> *Questions:*
>=20
>    1. What are the minimum and maximum supported GCC versions for building
>    this CIP kernel?
>    2. Is there official documentation specifying the recommended toolchain
>    versions for Linux CIP 4.4?

See Documentation/Changes for minimums. Whatever was available when
4.4.1 was released would be suitable maximum.

Best regards,
									Pavel

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--S01NHa8k/gFB+OkV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaMp/cwAKCRAw5/Bqldv6
8kLMAJ4/cKdI/cXnmGCAC1q1ud6OGlkyrgCfazVRxcp7ZXYCn4UnoMdblWXXXgA=
=SkIK
-----END PGP SIGNATURE-----

--S01NHa8k/gFB+OkV--

