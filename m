Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4845.1794513547057053335
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 11:59:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=TY7cnjUh;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 733DF10E524;
	Thu, 12 Nov 2026 20:58:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1794513540;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=sLQDyDmErDUX9whI3yqI5+2M6r6m4PjpSXlRh7TD4Yc=;
	b=TY7cnjUheiH7n85Pmx82xYcEouwvXZn5eq8mBLv1emH2EcgJbXuwLIyngmUmPmF1AHVLJE
	hXVxHSpSb3CDzhkpho4Qlj3dojFBQ49De2PLAS+6Vx8H8zd7+qtHzCH1/IuSlHtiHIygiX
	S2CB0kpoZ8UEBZXtoJ06cGyhNm3GS4tcbSguqc5JiGE9NvY60mxhKLSVCTRP0sPLQpDoz0
	ex23eugEj0aPnZhAOGfyVIDlQM+snESkisnMJXVHLLE1skOjT7chzDE63MXbjdbvVFReR5
	QFSTas5tRK3sAKsfAueLH2k985qadCmP6BjJjgTiEPcjn+rcYt8Zvsu1/30/Bw==
Date: Thu, 12 Nov 2026 20:58:57 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 10/24] clk: divider: Add KUnit tests for
 clk_divider_bestdiv() ULONG_MAX handling
Message-ID: <avYagTe3duUCQ328@duo.ucw.cz>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261109121451.6042-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Upi72PXEZ3aDC6ws"
Content-Disposition: inline
In-Reply-To: <20261109121451.6042-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 19:59:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24792


--Upi72PXEZ3aDC6ws
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 50ca555d6ae8205374e406b411ae0e8e9447568d upstream.
>=20
> Add KUnit tests to verify the behaviour of clk_divider_bestdiv() when
> clk_round_rate() is called with ULONG_MAX, which is the canonical way
> to probe the maximum rate a clock can produce.

Do we strictly need the kunit tests in -cip? They should not be
required for functionality.

Best regards,
							Pavel

>  drivers/clk/.kunitconfig       |   1 +
>  drivers/clk/Kconfig            |   8 ++
>  drivers/clk/Makefile           |   1 +
>  drivers/clk/clk-divider_test.c | 153 +++++++++++++++++++++++++++++++++
>  4 files changed, 163 insertions(+)
>  create mode 100644 drivers/clk/clk-divider_test.c

--Upi72PXEZ3aDC6ws
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCavYagQAKCRAw5/Bqldv6
8n+HAKCn+ldhgqvt8C9N5L0v0nMqDi9ThwCfRkvmGFSpfuYvW8YbVu55d4N++m0=
=GYJZ
-----END PGP SIGNATURE-----

--Upi72PXEZ3aDC6ws--
