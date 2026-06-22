Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFE8CDB46F
	for <webhook@archiver.kernel.org>; Mon, 22 Jun 2026 09:15:35 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39112.1782119726085891669
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Jun 2026 02:15:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=YX1/2/t3;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8CC101151D5;
	Mon, 22 Jun 2026 11:15:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782119723;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lvvkJBXItDX/TNw3iaZZNFb5sa5QwdSfPZEJ8NJ5oz8=;
	b=YX1/2/t366ih/7UbobAxFIb+CLr6Qsn3SM6uei5VwMJlX25KiFvfByqaJtdmZ8eUygpxrT
	DU4zVCZ9A3EzRPRQq/CCcc/aBaDqAky2hYQesmNGzuZWf8wMNJuX1GQN1YvKnaloEuD5u/
	2TP24dCKm40d1G+ShNvj6K7tpTUSpSbM9a3GtrUkJTWuwJD08Bz5aWTL0oV9Rrs0rRNwJG
	WnGjfIeHbggl6CsvQvytPGlQXAaVGHTp6yKtlBomxAzPQdog11oL1zppx/BZ5Ry52ywi5u
	dLYivlUreXOyDAo5JL4jbeIWDoFNJ8phSKa9/+5hCk5wever4385D7qFcd0OeQ==
Date: Mon, 22 Jun 2026 11:15:18 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 00/32] Add RSPI support for RZ/G3E SoC
Message-ID: <ajj9JpDbCcGuSyCR@duo.ucw.cz>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sBDgHJ21XirGVLgk"
Content-Disposition: inline
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Jun 2026 09:15:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23243


--sBDgHJ21XirGVLgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds RSPI support for the Renesas RZ/G3E SoC, which
> features three RSPI controllers. The series also enables DMA support in
> the RSPI driver, and backports the necessary infrastructure changes
> into linux-6.1.y-cip.
>=20
> The series is structured as follows:
>  - Clock entries for the three RSPI instances on RZ/G3E SoC
>  - DT binding updates: document DMA properties and add RZ/G3E compatible
>  - Device tree nodes for RZ/G3E RSPI controllers and SMARC board enableme=
nt
>  - Driver improvements backported from mainline: DMA support, device-mana=
ged
>   APIs, bug fixes for clock setup and FIFO thresholds

I'm still reviewing this, and will have some comments, but it looks
good so far. I will likely apply this, if it passes testing and there
are no other comments.

Best regards,
                                                                Pavel

--sBDgHJ21XirGVLgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCajj9JgAKCRAw5/Bqldv6
8h75AJ45gMgayAZ7mW2Gaa7agfncEQ29bACbBo5VjjhFNumePwoGTZxFB7hGy/0=
=3HQg
-----END PGP SIGNATURE-----

--sBDgHJ21XirGVLgk--

