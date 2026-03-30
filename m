Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4968FB3D02
	for <webhook@archiver.kernel.org>; Mon, 30 Mar 2026 10:28:29 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.47806.1774866500124002458
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Mar 2026 03:28:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=NqrVFlwr;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8A5F10DDEC;
	Mon, 30 Mar 2026 12:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774866497;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ur/4jXxY0do+I3qRBeXVKQ4Hdi0kLJadwDy0SRIi/RA=;
	b=NqrVFlwr/+//qJNhcyLEvY1vhQVsd0LgzCDzpEjbhZLDRXRF1BQ3b/cfwzeYsjNXvW2+Ki
	TZ7iBNhzMBl0RZxB0SND+LtbwUSc3ffU1pUTrRv9wwFfK35uhUW1oDqGsfIDNZNkB7W1vp
	0WIbTTsGrcYIczH+WKrx90NzzCjLQ8nC9zoB3X+3bjbFHK0e4zM3m23wzj285V3m4HSbqt
	P8geyChicaihfO4IB9muFMm559BIE1P95dJhxg4nwMo4TR9zkFfuKroAHGlivyydCJaB9p
	HFPrvVPrHICxgkl648eYF1MIsPVzozJztPUmsD917tdTF4JTdesJ5e1SJx2IeA==
Date: Mon, 30 Mar 2026 12:28:13 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 0/5] Add CANFD support to RZ/{V2H,V2N} SoCs
Message-ID: <acpQPSbwftumR6Ez@duo.ucw.cz>
References: <20260327094231.34974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZQDDL1M3rnPvkaEt"
Content-Disposition: inline
In-Reply-To: <20260327094231.34974-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Mar 2026 10:28:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22604


--ZQDDL1M3rnPvkaEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add CANFD support on the Renesas
> RZ/V2H and RZ/V2N SoCs. CANFD has been tested with external
> CAN PHY transceiver as the EVK isn't fitted with one.
>=20
> Note,
> - All the patches have been cherry-picked from upstream kernel.
> - Patches apply cleanly on top of v6.12.78-cip19

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--ZQDDL1M3rnPvkaEt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCacpQPQAKCRAw5/Bqldv6
8q1cAJ9LTbR17AZ+YA+0tJ7vE4ne+xh5IgCfbLI7bawY6Elp1LmaQwZ10gnwZYA=
=STK2
-----END PGP SIGNATURE-----

--ZQDDL1M3rnPvkaEt--

