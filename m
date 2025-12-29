Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B58E92FE2
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 21:28:55 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.52077.1767043731879611643
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 13:28:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=V1rKYuQt;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03BD010092128;
	Mon, 29 Dec 2025 22:28:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1767043730; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=jv0ShNXehPk9OXbA6rfnUpODHfXH5mjeTKjd8xtDjzU=;
	b=V1rKYuQtt1xfjVZAHmcHBFIyKTb+J6UgCbRHlcZzlCVJSSnk1CYqpNN1MifA2SVnc0RIid
	tL2sP+pmxacy/iq3gV5n8H3DwWbVbfBSCC69BVP9vlb9nq9JQZccKL2YB/dQPkNF0c1O/F
	eGYNnIaZTebb6GHQdPi8+Jcc72a8DL/jHCmx7eo8++Btq93FdzfBgn11iAD3iHzGNobISq
	eSdjXFW3KiAqsbNyagnxiZz239hwz6x6sIgTEPGZdZf94yc0ruaXNZycechXyh6lb23DmL
	UwTwdNwhkJPLP+UKshhwSahWYMt7QQVTKThIkHrQ6aWVQa7B/g6n5k6js63QJw==
Date: Mon, 29 Dec 2025 22:28:47 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 00/12] Add gpio keys/sleep button support for
 RZ/G3E
Message-ID: <aVLyj6jhBHzuHuDf@duo.ucw.cz>
References: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="snWDbPgMW04LZ/fh"
Content-Disposition: inline
In-Reply-To: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 21:28:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21257


--snWDbPgMW04LZ/fh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> Add gpio keys support for waking up from s2idle and sleep button support
> for entering to STR. Wakeup of STR is by pressing and holding power
> button. All the patches in this series are cherry-picked from
> mainline.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@denx.de>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--snWDbPgMW04LZ/fh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVLyjwAKCRAw5/Bqldv6
8iccAJ96ZQCajwMXRgmKZmNsEbQmDp1NRACgnhB6NWjrq8oOmN7ITwqsnL7LTT0=
=r26D
-----END PGP SIGNATURE-----

--snWDbPgMW04LZ/fh--

