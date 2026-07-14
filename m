Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5E6C44507
	for <webhook@archiver.kernel.org>; Tue, 14 Jul 2026 18:30:19 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.998.1784053809483176306
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Jul 2026 11:30:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=S/DGNFwz;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A678D119C63;
	Tue, 14 Jul 2026 20:30:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784053806;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=K86aLvcqZHJBmhp7x/3EDOohlbgOu7HdOOIH3pav5N4=;
	b=S/DGNFwzD7VWy1fMK2CI9mRIAzDMWzOwQWM19JGcvMmtLiJ8MBBeZ5uKYyg1CAnqJmMMgc
	pAeDRa1WbXN2lJ3KNQkdr4iId4AhRhuRB3UirCfXLeWV861Ohknx5ypoPl/FuOKfLGe9ZQ
	7hS7hQjcB7U9aUl1h5Eg43p7ziwQzYdqVDXrqOQ9qpP5nDmK22+EZE3HHBuI4QHGnBIwON
	AC287Q0xufZGLx8Y4P9ZqDV7SEKHr/2NShkVlSJTAnaFQnxt5MskuXA6OYOx9LX3RORYXJ
	z6s60I+H5WubfNSVZTr+oWTkUAvCSHsmRg5MI4tQX5/llXu6VCz8gSygzDTa6A==
Date: Tue, 14 Jul 2026 20:30:01 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.1.y-cip 0/3] arm64: dts: renesas: Add max-frequency to
 SDHI nodes
Message-ID: <alaAKVuZVNS4dwYw@duo.ucw.cz>
References: <20260714090532.6843-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fXmItNFRtBK5ZL8G"
Content-Disposition: inline
In-Reply-To: <20260714090532.6843-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Jul 2026 18:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23582


--fXmItNFRtBK5ZL8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi!

> This patch series aims to add the max-frequency property set to
> 133333333 Hz (133.33 MHz) to both SDHI0 and SDHI1 MMC controller nodes in
> the RZ/G2{L,LC,UL}/RZ/V2L device tree.
>=20
> This change results in approximately 33% performance improvement as
> it sets the SD clk to 100 MHz instead of the max 133 MHz.
>=20
> All the patches in this series are cherry-picked from mainline.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--fXmItNFRtBK5ZL8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCalaAKQAKCRAw5/Bqldv6
8runAJsF67ayg09u41JHDWv4K3jFwyYe1ACgg9vPXEl1DOdzKmnh2ZZ+wCPypjw=
=SVhs
-----END PGP SIGNATURE-----

--fXmItNFRtBK5ZL8G--

