Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B1FC369CB
	for <webhook@archiver.kernel.org>; Sat, 26 Apr 2025 07:59:39 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.5530.1745654370057265945
 for <cip-dev@lists.cip-project.org>;
 Sat, 26 Apr 2025 00:59:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=dsa8vaUZ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C3EA102A4BFC;
	Sat, 26 Apr 2025 09:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745654367; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dS50/03/PtCq7YknD8G36Dxf6zwSMlIgrsFa7Bahc+8=;
	b=dsa8vaUZ1jcOH7M5lpg3hrPP4oDgnJ5GP1Ao3GSuisMfE6bvwFhYaaL3i33bQoMma9bPch
	3iLGT1h2grhkdB97a7xz3M3+723MuIZLn6bgNt3SAPdamKc04QsAdPRZaNXHgpvMagvSDF
	G0XHGyRWAO4u58rC9YOTsSwZBr52u1TpYra0RKxpHOlDbwVHJlsZK2U/L88Ys5+b3xYGFF
	4JDntZrOjfqfIRzyoXfS6TmsBrpD2rqWcwsRrRpAvCSSQ+8OSBte3H/qGQYK2mw8f333Ey
	/i0uQX+zBNRssmlIOkhyhZstN9WRRzTGGueIKlyI0pFkArD1DusgEEMLIfMbzA==
Date: Sat, 26 Apr 2025 09:59:20 +0200
From: Pavel Machek <pavel@denx.de>
To: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 00/15] i2c: riic: miscellaneous code
 cleanup and improvements
Message-ID: <aAySWHLwA2JG4ZRQ@duo.ucw.cz>
References: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aAti7FKVCHFN4Tdu@duo.ucw.cz>
 <CACe6DC64Hpc1870ucfH4P401M8YuVNgq5+RktY+ePT+RMArrgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rkTwsrDX4X2UH+69"
Content-Disposition: inline
In-Reply-To: <CACe6DC64Hpc1870ucfH4P401M8YuVNgq5+RktY+ePT+RMArrgQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Apr 2025 07:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18646


--rkTwsrDX4X2UH+69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series includes miscellaneous code cleanup and improvements
> > > to RIIC driver used by Renesas RZ SoCs. Below are the features which
> > > are backported:
> > > - Runtime PM support
> > > - Suspend/Resume support
> > > - Fast Mode Plus
> > >
> > > Note,
> > > - Patches 9-15 have been recently posted to 6.12-cip
> > > - All the patches have been cherry-picked from v6.15-rc3.
> >
> > Thank you, these look good. I can apply them if they pass testing and
> > there are no other comments.
>=20
> I reviewed this series, looks good to me, too.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Thank you, I added your reviewed-by tag and applied the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--rkTwsrDX4X2UH+69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAySWAAKCRAw5/Bqldv6
8p8tAKCg09qkrwiCl6u5O6EODSsc2dxtHQCdGxx8P7T/uXmnQ7nmyJmUNv/5Bxs=
=c1mY
-----END PGP SIGNATURE-----

--rkTwsrDX4X2UH+69--

