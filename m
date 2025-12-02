Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FB3CFD2F6
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 12:15:30 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6294.1764677724077503529
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 04:15:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=G85TSe9J;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC73A101CB7FF;
	Tue,  2 Dec 2025 13:15:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1764677722; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=DO+GvZz2YIx/1BHcd4klr4/o54t86f1CE1wluSOblTk=;
	b=G85TSe9JpSZscLHY9MmjpyzrCw0cuWP+zxo9dU8CaIniJE6LrHe++JQcUi8vsbPLu7rxj9
	gpY0LE8mbcLb4qeVvbWm9qjsa071zwiUQ0OdVX7i7ZX1MOCG+tHlv0JirjFNsP2aflGd5L
	/ukdPi1MGo1PjamH1i4tFOy/DKPgrQ3Ao0oECmYmJJ6l0TZ0eJiC7I/rt9zr1CCkl3IsPT
	JvzyKIUzrEMH0odYcBw+jDFvbHYqZH9IJAljeLRbLtC7vIAMQMysHwiP4KMsRlxTs5gO7e
	aEDfohQhVulfd3ES5zVbvQTRpiusAiux0OA2oRWxdzcnkM6bA4Ebk8jzz6QJQQ==
Date: Tue, 2 Dec 2025 13:15:15 +0100
From: Pavel Machek <pavel@denx.de>
To: iwamatsu@gmail.com
Cc: ovidiu.panait.rb@renesas.com, cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/6] Add RZ/V2H DMAC support
Message-ID: <aS7YU1FbxmmtywFT@duo.ucw.cz>
References: <20251127112941.55300-1-ovidiu.panait.rb@renesas.com>
 <CACe6DC4HpsHngXRgjpt+MmR1Qi211fgDWv=+3vx7n9d9EXq=6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8ly1FfptAJFcCIQ8"
Content-Disposition: inline
In-Reply-To: <CACe6DC4HpsHngXRgjpt+MmR1Qi211fgDWv=+3vx7n9d9EXq=6Q@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 12:15:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20809


--8ly1FfptAJFcCIQ8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This series adds DMAC support for the Renesas RZ/V2H SoC.
> >
> > Upstream commit 1b86d3ecde5c ("dmaengine: dmatest: prevent using swiotlb
> > buffer with nobounce parameter") was cherry-picked to allow dmatest to
> > validate DMA controller functionality with and without swiotlb. The
> > remaining patches add the actual support for the RZ/V2H DMAC.
>=20
> I reviewed this series, looks good to me.
> I can apply this series if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thank you, applied.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--8ly1FfptAJFcCIQ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaS7YUgAKCRAw5/Bqldv6
8rwqAJ9Rc75GICgY503QOAZB73vdEPUsdgCfaaKR75B6dYek236MHsxVBf02YJs=
=stN6
-----END PGP SIGNATURE-----

--8ly1FfptAJFcCIQ8--

