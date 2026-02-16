Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3E2E7BDA4
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 11:50:42 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18008.1771242636270648638
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Feb 2026 03:50:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=L179WqiQ;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 142B510E0D1;
	Mon, 16 Feb 2026 12:50:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1771242632;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=FgypMqfLkklUBoMAITnNtHXsUXdhGxjY6hX19hI6yA8=;
	b=L179WqiQ0gExmjr+txSKAYMpMRstFB9xdH7t3Uh0ztBZE/xo6yJBEd+mCogqQL0NA3N2RX
	h/gB6EkEIoYsAEGE/1/QOTuBsCprLdYkR6uaw3M1gUK+loEBAf+CmljPecwNrGIxpcMolp
	TE1ZuaQdYm4bLUeWN6wGj+eXHxvdd3rdJ2gbUx6OGU+X1u83+ClrEAnX5EUOMAQcl8Pd/O
	Apb+V5zCyCdLqQ+kMWIg1x3W/arShl0GnzV+IuZ3FF1WgrXkVUrg3p0oGleg3Eu8kxF8JR
	9lhWUp5aFkvack8ppfPMVRKO+dglwLSbmV6vgUanuRIiA7VJliA7To5sF0L19Q==
Date: Mon, 16 Feb 2026 12:50:27 +0100
From: Pavel Machek <pavel@nabladev.com>
To: tommaso.merciai.xr@bp.renesas.com
Cc: Pavel Machek <pavel@nabladev.com>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [cip-dev] [PATCH 6.1.y-cip] i2c: riic: Move suspend handling to
 NOIRQ phase
Message-ID: <aZMEg+Ls7kkwNAca@duo.ucw.cz>
References: <20260210102747.484082-1-tommaso.merciai.xr@bp.renesas.com>
 <aYyRTRXYwG57A9B/@duo.ucw.cz>
 <aYymQmVrJ2Tt49Zf@tom-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pNe/2Wrlxt3Pi6a0"
Content-Disposition: inline
In-Reply-To: <aYymQmVrJ2Tt49Zf@tom-desktop>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Feb 2026 11:50:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21877


--pNe/2Wrlxt3Pi6a0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > commit e383f0961422f983451ac4dd6aed1a3d3311f2be upstream.
> > >=20
> > > Commit 53326135d0e0 ("i2c: riic: Add suspend/resume support") added
> > > suspend support for the Renesas I2C driver and following this change
> > > on RZ/G3E the following WARNING is seen on entering suspend ...
> >=20
> > I don't see anything obviously wrong with this patch, but ... do we
> > need 6.12 version, too?
>=20
> I see that this patch is already into linux-6.12 stable branch [0].
>=20
> [0] https://github.com/gregkh/linux/blob/linux-6.12.y/drivers/i2c/busses/=
i2c-riic.c
>=20
> Please correct me if I'm wrong.

Aha, I was checking -cip but not -stable, it is now in both.

Patch looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply it if it passes testing and there are no other comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--pNe/2Wrlxt3Pi6a0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZMEgwAKCRAw5/Bqldv6
8ivVAKCZVKNXR6tyBYUGk55I0OL/k3DzGwCfS/G/lPm/Wd810oJk3e8LLs3I33g=
=A18x
-----END PGP SIGNATURE-----

--pNe/2Wrlxt3Pi6a0--

