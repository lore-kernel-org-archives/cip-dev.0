Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E6AD637AE
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 20:45:50 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4174.1765917940725883018
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 12:45:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=OWU3lj9e;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CE101009213E;
	Tue, 16 Dec 2025 21:45:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765917934; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=OItulam7R1lKF8zfjrUIE6nkj9JG/KmnoSRVtp/pejA=;
	b=OWU3lj9ev/7F2uSKaDj5vLqLDK26Z+OEqzvA8EGYLEQE1lXTEAE72Lvc/yQPGU7nKvEuPt
	I9NWyD9UHO1qhGlynsWgg8wNnxUmBlAM3n6ECmiq/rUS66iyIekIFCS+Z6FNXdij1hjlT3
	FtPnpxR9LobgLPkgKHg8moNlsiiF4ZfIfbwdnII0upf4vwDBhXfkBJdYD7VPQqT3QvSj+w
	GVUR33+KeAsPHycBPz+ZBMVFzULM2m6Gy9PBinItiMkBwy9+8WA9ceRpuLZd99c4+cizMt
	a5r94Ved6CMJKdbeAS9DNqO57bE5DtTz4B75mZ4iRcg728v8mXVvnkqsDCR3uA==
Date: Tue, 16 Dec 2025 21:45:29 +0100
From: Pavel Machek <pavel@denx.de>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: biju.das.au@gmail.com, cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [PATCH 5.10.y-cip 0/3] Add 64-bit polling support
Message-ID: <aUHE6XvOKaxTK4u2@duo.ucw.cz>
References: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
 <TY7PR01MB148189B8BB07A8AC8B9189DF1CDAAA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nooe2oDaYqYuQanF"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB148189B8BB07A8AC8B9189DF1CDAAA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 20:45:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21090


--nooe2oDaYqYuQanF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >=20
> > As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
> > bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 byt=
es.
> > During testing it is found that, if the DMA buffer is not aligned to 12=
8 bit it
> > fallback to PIO mode. In such cases, 64-bit access is much more efficie=
nt than
> > the current 16-bit.
> >=20
> > Biju Das (3):
> >   mmc: tmio: Add 64-bit read/write support for SD_BUF0 in polling mode
> >   mmc: renesas_sdhi: Enable 64-bit polling mode
> >   mmc: renesas_sdhi: Replace magic number '0xff' in
> >     renesas_sdhi_set_clock()
> >=20
> >  drivers/mmc/host/renesas_sdhi_core.c          |  2 +-
> >  drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
> >  drivers/mmc/host/tmio_mmc.h                   | 15 +++++++++
> >  drivers/mmc/host/tmio_mmc_core.c              | 33
> > +++++++++++++++++++
> >  include/linux/mfd/tmio.h                      |  3 ++
> >  5 files changed, 54 insertions(+), 2 deletions(-)
> >=20
>=20
> I reviewed this series, looks good to me.
> I can apply this series if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, I added your "Reviewed-by" tag and pushed the series.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--nooe2oDaYqYuQanF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaUHE6QAKCRAw5/Bqldv6
8pCrAJ9FvrTR/iyGog6SbSe8I8SKt7Jr6gCgkCmvwuRXEWubxaaRtREt5QKdy+k=
=VtjH
-----END PGP SIGNATURE-----

--nooe2oDaYqYuQanF--

