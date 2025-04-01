Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7509C36018
	for <webhook@archiver.kernel.org>; Tue,  1 Apr 2025 10:46:41 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.15868.1743504393943624492
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Apr 2025 03:46:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=hapyVktZ;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E699E10167185;
	Tue,  1 Apr 2025 12:46:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743504391; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rnkfgWd5QMEvpHG+xEB6msuHNenfBfadRaftSdrJohc=;
	b=hapyVktZ0x0FKohOVTBakUbyglbHknRpUJNjBuXhM9xO9euqM2s0meIDhZ0S1pBWEKY30o
	tQ0CCHULjJKbw2iTkLaFD/UOgN3CUIK2j9bPRzjfHv+DhK+THwz/vk3ECX3c0J0nxfGnkV
	eOv2XBQKL5qEu9V5BJXYCGoM1+dL0Vo6p6QpsTgmmSiiquH3E5lJ/WdvBHNl2aHV5jea9E
	LU9/2C4Mr5uP4oMd3WkVx2TefOFdkFxYUDOXBbLEbpoaJ088gwaFC/WXVO3qC6Y7QagvUI
	wp1ltR2RSPcMXVGA5eIx7PECkJMK9gQPAx9LYPIQXGmSAok+RqMOGBA9yL6K/w==
Date: Tue, 1 Apr 2025 12:46:27 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/43] Add RZ/G3E pinctrl support
Message-ID: <Z+vEA5mqFqMug2Y1@duo.ucw.cz>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o8njfSfmsno2bnrU"
Content-Disposition: inline
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Apr 2025 10:46:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18454


--o8njfSfmsno2bnrU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds pin controller support for the Renesas RZ/G3E(R9A0=
9G047)
> SoC to linux-6.1.y-cip kernel, this series adds also device node for SCIF
> pincontrol into RZ/G3E SMARC EVK board dts.
> The RZ/G3E PFC (Pin Function Controller) is almost similar to the one fou=
nd
> into the RZ/V2H which is in turn similar to the one found into the RZ/G2L=
 SoC,
> for this reason pinctrl-rzg2l.c has been re-used.

I had some minor comments, but I can apply this to 6.1-cip provided it
compiles and there are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--o8njfSfmsno2bnrU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+vEAwAKCRAw5/Bqldv6
8tpRAJ415ibb0rfNR6JGXFY5CpI0MnzrmwCaAnO15jN1TRV3bt01axA8oJl+rgY=
=Gjbt
-----END PGP SIGNATURE-----

--o8njfSfmsno2bnrU--

