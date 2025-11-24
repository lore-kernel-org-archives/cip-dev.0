Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45418CFD313
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 13:28:38 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16668.1763990912459776305
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Nov 2025 05:28:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Un9WKWp7;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0B5610092116;
	Mon, 24 Nov 2025 14:28:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1763990905; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tcaVUZIVlQ9ti/N+a6ymRr/d0Lpzaga04jhhNG1BlUA=;
	b=Un9WKWp7lza292jzpBeNIhMbkbMfeq9bc1aocKhIwhbKEI++7MHLZTIMBbOEMSmDxX/B6x
	aSHI+mRVCcN8sDphy7C9MKGLIiL8tfPBnB4lKSVfixQwKOCYXOtdBRz3Df7xk3PNBdpDm2
	pn0q1xFnTNGhud2TvrRvDFczUkhTeT6RqM9EclgOf7SbGohkUfDT/77wOCatyBTO2b7Y+5
	yVqkFpxfzqN2wGlDFJ7gXfdzKAQTQhQoTfEdeHiCTGLA0GSizmjwVTXqT4+BqOVLVSF3hy
	nOTM5CcS20F392wx9VWklHAaC8qWMVgrMxvpd+aALyhrqi6v1+qcrCc7msfFMA==
Date: Mon, 24 Nov 2025 14:28:18 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, cip-dev@lists.cip-project.org
Subject: Re: [PATCH 5.10.y-cip 2/2] ASoC: renesas: rz-ssi: Use proper
 dma_buffer_pos after resume
Message-ID: <aSRdOwDFhrIArMdK@duo.ucw.cz>
References: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com>
 <20251122105116.2782841-3-claudiu.beznea.uj@bp.renesas.com>
 <aSQxv6iREysaFLVQ@duo.ucw.cz>
 <27a51129-2e2e-4358-b1e7-c6475644c9b1@tuxon.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ScikhIjCks4sFGN4"
Content-Disposition: inline
In-Reply-To: <27a51129-2e2e-4358-b1e7-c6475644c9b1@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Nov 2025 13:28:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20716


--ScikhIjCks4sFGN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2025-11-24 15:23:41, Claudiu Beznea wrote:
> Hi, Pavel,
>=20
> On 11/24/25 12:21, Pavel Machek wrote:
> > Hi!
> >=20
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> commit 22897e568646de5907d4981eae6cc895be2978d1 upstream.
> >>
> >> When the driver supports DMA, it enqueues four DMA descriptors per
> >> substream before the substream is started. New descriptors are enqueue=
d in
> >> the DMA completion callback, and each time a new descriptor is queued,=
 the
> >> dma_buffer_pos is incremented.
> >>
> >> During suspend, the DMA transactions are terminated. There might be ca=
ses
> >> where the four extra enqueued DMA descriptors are not completed and are
> >> instead canceled on suspend. However, the cancel operation does not ta=
ke
> >> into account that the dma_buffer_pos was already incremented.
> >=20
> > Ok. So if you suspend the board in the middle of music playback, few
> > notes may be dropped or something?
>=20
> Yes, few samples from the audio buffer will be dropped.
>=20
> > Don't do that, then. Suspending in
> > the middle of audio playback will sound horrible, anyway.
>=20
> OK.
>=20
> I think audio subsystem is trying its best to avoid glitches and other
> unwanted sounds.

Yep, no problem, we can easily apply this. Its just... suspending
while audio is playing will not be ok either way.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ScikhIjCks4sFGN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaSRdcgAKCRAw5/Bqldv6
8pNVAJ95pITGYca07FLL1yh5tIPtfheTygCfeHJuEScC0m4tvmzHWn25PIF0kH8=
=y3TU
-----END PGP SIGNATURE-----

--ScikhIjCks4sFGN4--

