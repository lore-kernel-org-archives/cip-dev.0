Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06C5D116F6
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 12:12:50 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6414.1764677566502811937
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 04:12:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=in/CRD9F;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7AF76101CB307;
	Tue,  2 Dec 2025 13:12:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764677563; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=wrtwc/CocQMJo+EVIKx8FDGQiKTYpYU4GMNzbZ1QnSA=;
	b=in/CRD9Foh5cgHfYRAW5DcPVTwgUE+ktnmSNbf3x2vNO4tnQOaaHcHXxGT19lozB1NGCOh
	9W4V5deWYQ0c20EcukZk0wl2fu6+FqD7tEgSTdatAQt6vR5JscQGC4Ytls4kLbSoqcemnp
	6t3jOCA8agOOKOjnn9dwcAXXo+FGOI+qoKd9KknIAGjojX+tLT59hHUtekmqGk3z6XA5sC
	UzXatPlL1aERP2kk0IlCm/7X63VXMEQx9S5tm2TS7KlPB7lI8RUokv8E8PWCm1E6A+2Yhz
	ind3jrdTlwuxXDu85u1xSp/nIFxT/bcNCD0pPDqWUGjJWrxOF6WrZjH4PY+bmg==
Date: Tue, 2 Dec 2025 13:12:38 +0100
From: Pavel Machek <pavel@denx.de>
To: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/V2H DMAC support
Message-ID: <aS7Xtv7D+hxAyKG6@duo.ucw.cz>
References: <20251127113012.55325-1-ovidiu.panait.rb@renesas.com>
 <CACe6DC57Z28GLrWP_xOiDm0YPATqi+UWjiugvN+6poZjzwucnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EiVUzapekKuetxbU"
Content-Disposition: inline
In-Reply-To: <CACe6DC57Z28GLrWP_xOiDm0YPATqi+UWjiugvN+6poZjzwucnQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 12:12:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20808


--EiVUzapekKuetxbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This series adds DMAC support for the Renesas RZ/V2H SoC.
> >
> > Patches were cherry-picked from mainline kernel.
>=20
> I reviewed this series, and it looks good to me.
> I can apply to this series if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, applied.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EiVUzapekKuetxbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaS7XtgAKCRAw5/Bqldv6
8iUtAJ9hcRj91Ew815IwOazv90dYYw+ZyACfTGndiQO3eHJjeOdNKlTgXdZc7OQ=
=RZq5
-----END PGP SIGNATURE-----

--EiVUzapekKuetxbU--

