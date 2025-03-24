Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885DAC36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 09:16:11 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.34872.1742807761863563194
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 02:16:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=X1znCDC0;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0D585102A4AE1;
	Mon, 24 Mar 2025 10:15:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742807759; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6pmttvmLq19FUMCBZKXkub1o383jNKOdV2Q2TSEtT+A=;
	b=X1znCDC0CzRyaDO0VY7aRqd8aSJbDcavWZCEFj1wuFp1WisaPVUcdIKOhh9wACqPVQpLjd
	XRQ4toOZxkI/rK8NT1WFDdiCQUuWhbcg0KtipeXCatmNfKAvRoIeT8Mj/+Z9H5rA1V8Ljv
	FhLKOi5cFD0mGQkWV6BljxDYVQg7KK2EuytHnTONMRSF/jIspFxnH/10+8WTAdWsnYFQty
	Qqu6DuCCvjFIZK+Nqkw5iuZSCzKGlQ/Ko4qcE3lvmx21+5umYD313YW0/5aPRNEgmtuNWM
	WSvcZnfr+OyTyi7+TobAB/ze8eGt3m/mO5jQSWJ1i08K4VnGeNW5SpMy0Vy+Rw==
Date: Mon, 24 Mar 2025 10:15:52 +0100
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/21] Add support for Renesas RZ/G3E SoC and
 SMARC-EVK platform
Message-ID: <Z+EiyAmCkDjd9/0/@duo.ucw.cz>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
 <Z93ILAaLP1+LR2gP@duo.ucw.cz>
 <Z-Ef99PHhg9P9kWP@tom-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zkbjI0QCWQvIohZZ"
Content-Disposition: inline
In-Reply-To: <Z-Ef99PHhg9P9kWP@tom-desktop>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 09:16:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18337


--zkbjI0QCWQvIohZZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series adds initial support for the Renesas RZ/G3E SoC and
> > > RZ/G3E SMARC EVK platform to linux-6.1.y-cip kernel. The RZ/G3E devic=
e is a
> > > general-purpose microprocessor with a quad-core CA-55, single core CM=
-33,
> > > Ethos-U55 NPU, Mali-G52 3-D Graphics and other peripherals.
> > >=20
> > > All patches are cherry-picked from mainline kernel.
> >=20
> > Ok, thanks for the series, it looks good to me.
> >=20
> > Should I simply try to apply it to both 6.1 and 6.12? I guess I can do
> > that if there are no other comments.
>=20
> I tested on my side and I can share that the following patches are needed
> to boot the board on top of be95b49207284 (linux-6.12.y-cip):
>=20
> abf61442f5523 (HEAD) arm64: defconfig: Enable R9A09G047 SoC
> 5fe2ef2536b4b soc: renesas: Add RZ/G3E (R9A09G047) config option
> 0b2bbca0cccdc arm64: dts: renesas: Add initial device tree for RZ/G3E SMA=
RC EVK board
> b39f424adff45 arm64: dts: renesas: Add initial support for RZ/G3E SMARC S=
oM
> b1f6a3f53e512 arm64: dts: renesas: r9a09g047: Add OPP table
> a89ab4d1d72ad arm64: dts: renesas: Add initial DTSI for RZ/G3E SoC
> 0545748b50260 clk: renesas: r9a09g047: Add CA55 core clocks
> 53902b5dba919 clk: renesas: rzv2h: Add support for RZ/G3E SoC
> a1721e1ab4092 clk: renesas: rzv2h: Add MSTOP support
> c5e58c15e5b02 clk: renesas: r9a09g057: Add support for PLLVDO, CRU clocks=
, and resets
> 6e9acef8a72fd clk: renesas: r9a09g057: Add clock and reset entries for ICU
> 13f8ef8afecea clk: renesas: r9a09g057: Add CA55 core clocks
> f53d5c3439ebf clk: renesas: rzv2h: Add selective Runtime PM support for c=
locks
> 510f8e3823b22 dt-bindings: clock: renesas: Document RZ/G3E SoC CPG
> bcb927d43ed05 dt-bindings: soc: renesas: Document RZ/G3E SMARC SoM and Ca=
rrier-II EVK
> 541305514cdf5 dt-bindings: soc: renesas: Document Renesas RZ/G3E SoC vari=
ants
>=20
> Patches need some really small rework, (just moving up/down things to be
> applied).

Can you submit them as a series, please?

Best regards,
									Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--zkbjI0QCWQvIohZZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ+EiyAAKCRAw5/Bqldv6
8gVzAJ0ZdQ+NdY0rUt/eOdmcVyYwqycK5wCguFEGdbsZQmmnJ/UNT2l/8WVTpdU=
=CgBa
-----END PGP SIGNATURE-----

--zkbjI0QCWQvIohZZ--

