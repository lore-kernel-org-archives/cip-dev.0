Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B8ACD0439
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 17:05:21 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.94788.1767719117285803875
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 09:05:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=hzCpWv/O;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1C719102C32;
	Tue,  6 Jan 2026 18:05:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767719115;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=T55fnlLspH0IQNN9E6G2yY9sJzPRJ0eDEkEc/3kTnk4=;
	b=hzCpWv/O40pAaVMYdgXZEs+Wgs/3ci2KESz2apRSkVGY3/HaBgI/xIwNFkb9LwFdxmyTRp
	7Tb1S8T9/4s1Sn4sVi6c1SXfGcfciI9f7Nf7QIk15LN8CR8Ba7LH62tkkTz0nCsHilUqNB
	fC+k+NFlfZRWFoyCDmxcuyhCioaTVjkdR36SuMAH6ftBDiOqoEk32HLyZUsm4iO5+C4RvU
	YpSssqC0o2ksb599iAYy84TNSRjSDRaxOdHUI4yD1C6HdrIJQYZDnm0P7EooopcDo0HanU
	Qgrgg/TFGKYsUIVFwQE2Vv/iayIL6m4PqWY71dLwnX1iUZKRXlkGpYtD0eyHQg==
Date: Tue, 6 Jan 2026 18:05:10 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 0/5] Add RZ/V2N GBETH support
Message-ID: <aV1AxlTQA3cW3Tt2@duo.ucw.cz>
References: <20251229084011.3611-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SNQ9r8AS6/Q+ExJQ"
Content-Disposition: inline
In-Reply-To: <20251229084011.3611-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 17:05:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21389


--SNQ9r8AS6/Q+ExJQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds GBETH support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--SNQ9r8AS6/Q+ExJQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV1AxgAKCRAw5/Bqldv6
8smBAJ9hH/FjiDjcQezjwAKTbYEts1jVAQCgkPJ2AD65U0Hojhd0ZccH0pGhJF4=
=1XW9
-----END PGP SIGNATURE-----

--SNQ9r8AS6/Q+ExJQ--

