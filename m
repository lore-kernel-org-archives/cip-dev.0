Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C365F8D77D
	for <webhook@archiver.kernel.org>; Thu, 16 Apr 2026 20:53:48 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26184.1776372825498132039
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Apr 2026 13:53:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=fVGWgt8o;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 74EDF112487;
	Thu, 16 Apr 2026 22:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1776372823;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=w3cDTIWiice2p41XBW9Y6g/SjkZBKVeI9kNwL8lvkSM=;
	b=fVGWgt8oHiBaoezzR2GHD/AUT3wJpv32vJosfhJleG65FLYtWBHBB65Ufb4nezic3j82Xc
	ViSSQIg+2ov+MzAN8CkHbezv/nlngG+0e5jLOh76lHuF+1SpmWAFQ3Vvf+73q8nG34Uuok
	u73gyvHPNRMlzxkCzCxlOQXF9xchGWOrnBoDW/veRtAWK9//njKyGwYRD8tlZCC7dG6eHM
	CYPi5OAEF4kzIEMfEgZSIOnufJHbMCcdfTDaE9OCgmIiPkkJbGvNexlpv/Cj8BL0aX2eWk
	0vwFzIrDiMg4KsMvSAcThzdA97CX/5q9DjknxCtyK5Ww3sqghzN6/kAYHzWtxg==
Date: Thu, 16 Apr 2026 22:53:42 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/5] Add RSPI support for RZ/V2H and RZ/V2N
Message-ID: <aeFMVuHp-BUoO6DH@duo.ucw.cz>
References: <20260415132056.95570-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zGkKmX7PsVGgTSUV"
Content-Disposition: inline
In-Reply-To: <20260415132056.95570-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Apr 2026 20:53:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22752


--zGkKmX7PsVGgTSUV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds RSPI support for the Renesas RZ/V2H and RZ/V2N SoCs.
>=20
> Patches were cherry-picked from mainline kernel.

I had some minor comments on 6.1 version, but those should be fixed in
mainline, first, so they should not block the merge.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--zGkKmX7PsVGgTSUV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaeFMVgAKCRAw5/Bqldv6
8kz+AJ9ZNDnU+k56c2T1Wy3tlhxUaEGrQACfQ2MlBv6io3YeAyruMWRrjNUhty4=
=OGJy
-----END PGP SIGNATURE-----

--zGkKmX7PsVGgTSUV--

