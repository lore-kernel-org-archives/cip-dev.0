Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59934D637B3
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 20:50:30 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4242.1765918226869710458
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Dec 2025 12:50:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=bPVMLKkB;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E12D610078553;
	Tue, 16 Dec 2025 21:50:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765918221; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hVY3zDjc4v3dohI8IfH2glhGaBUrfsBGGCWXE/ikgP0=;
	b=bPVMLKkBrXLKfJfC0vxNm4aYZEQFzZrFIfXExiUIJb81U8akT4qz28DHVCM11bccFvvH7W
	l5SHYcKiLOiURrZDfmmlVkuBBIfgW9cvdJkSB2kD2oXL0J/fliy7pm83F+pFcrVn4YfXzv
	TAzamoJ9tcXIiOFI9ypSSphPJyuxtoH5mCJtj46Kn/5C8BEkjOXGDWFSL8/Lz5lt2I8T8A
	le6Fk/h6qxjOLcK0rdYcPOau3HjOdPb39xUBU5iIBPmlNFzMoFwERFmA6GTeZFPFOBFR0H
	ZuV3LknitlDM00QbYr8hV66Z9WwkCyn3e+y4LDxXbF7VI5bGot/x7MC4aBPEng==
Date: Tue, 16 Dec 2025 21:50:19 +0100
From: Pavel Machek <pavel@denx.de>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/3] Add 64-bit polling support
Message-ID: <aUHGCx5zr00VPR5G@duo.ucw.cz>
References: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DAEXqga9IKdYEpd+"
Content-Disposition: inline
In-Reply-To: <20251214121034.4352-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 20:50:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21092


--DAEXqga9IKdYEpd+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> As per the RZ/{G2L,G3E} HW manual SD_BUF0 can be accessed by 16/32/64
> bits. Most of the data transfer in SD/SDIO/eMMC mode is more than 8 bytes.
> During testing it is found that, if the DMA buffer is not aligned to 128
> bit it fallback to PIO mode. In such cases, 64-bit access is much more
> efficient than the current 16-bit.

Thank you, applied and pushed out.

Best regards,
     								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--DAEXqga9IKdYEpd+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaUHGCwAKCRAw5/Bqldv6
8jklAKCmicwzv6WU8XFY6JF4FyrT3nQb/ACgvQxvfWrwqTR6KFiCWUgXaSMrQGM=
=qmB8
-----END PGP SIGNATURE-----

--DAEXqga9IKdYEpd+--

