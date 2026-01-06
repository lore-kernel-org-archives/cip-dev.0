Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E306CDC192
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 12:50:30 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89184.1767703828969921290
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:50:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Cp0xxALh;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7334610360B;
	Tue,  6 Jan 2026 13:50:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767703826;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lAB/rIbhIdwms8EAUNhLRE6ykhBnAC8EGdkrEm4AZPE=;
	b=Cp0xxALh+pYW7VWHmGxUiSJ8DMhSaQhlAZATylNJdYiJTalfYLG51nmv/nw2GpDadwba4v
	MxK3XSofoX+f/0RngA4HBfgrHVCjFiAIllXeNp0D+jt/JWb+ITkMe9ah8hSgFPPfwLML+S
	J/sAxgHSU4L6gS/NMQoCabHvvouh4mXrY6rWRQaWaAI0/yGIdVEU14dAlE0heNAwGiOCR8
	q/gzh7bYwLOZCKxdliPcRxIvg991LfDnW8goLSnJkU32EykJUIAcwNOJgPk6JgNtsWlUt0
	OqEaB4kPNZyMrBJu8gcxnxZJfEL6BL41EPMPYFGdpCBbMFpL7BE0ANT0MRmfog==
Date: Tue, 6 Jan 2026 13:50:22 +0100
From: Pavel Machek <pavel@nabladev.com>
To: biju.das.jz@bp.renesas.com
Cc: Pavel Machek <pavel@nabladev.com>,
	"biju.das.au" <biju.das.au@gmail.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip v2 00/24] Add suspend/resume support
 for RZ/G3E CANFD
Message-ID: <aV0FDpWw1CMnP3V8@duo.ucw.cz>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
 <aVz8r/qCX/dzdtmE@duo.ucw.cz>
 <TY3PR01MB113464D7A30824C60A8CE1FA58687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEGA1mnB2dB/oVpa"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB113464D7A30824C60A8CE1FA58687A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 12:50:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21376


--PEGA1mnB2dB/oVpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Add suspend/resume support for RZ/G3E CANFD. On RZ/G3E using PSCI,
> > > s2ram powers down the SoC. After resume, reinitialize the hardware for
> > > CANFD operations. All the patches in this series are cherry picked
> > > from mainline.
> >=20
> > I'm not sure what your plans are; I assume you'll send v2 of this for 6=
=2E1. That's ok.
>=20
> 6.1 is OK, there is no patch conflict. I have send v2 for 6.12 mainly due=
 to patch conflict
> after cip rebase to 6.12 stable.

Aha, ok, thanks for the info.

> > But if you have plans for any more submissions, please consider giving =
us a bit of timeout. There are
> > currently 6 series in flight from 3 different people and it starts bein=
g confusing.
>=20
> OK, Agreed. I don't have any more plans to send patches.
> For the patches send as v2 has the change log that
> details what is changed in v2.

You did well (thank you!) it is just that a bit too many patches
accumulated over the holidays.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--PEGA1mnB2dB/oVpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaV0FDgAKCRAw5/Bqldv6
8vp4AJ0TVqT6NiaqA+m1JuheQXwjzB5aKgCfUEgbIX2Vu4RoF0X63itHXQcX3G0=
=1vHs
-----END PGP SIGNATURE-----

--PEGA1mnB2dB/oVpa--

