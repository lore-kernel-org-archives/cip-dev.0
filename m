Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D80C4450C
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 10:24:09 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3193.1784111043252103565
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 03:24:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=HG/FB9R3;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F00E119ADC;
	Wed, 15 Jul 2026 12:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1784111041;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=DLzXVZB9668YTctkm2pmtNbu0F1Skpnzp/+A8rPa3tc=;
	b=HG/FB9R3IA1P7f3H7HEOB3Aji7v4QiD9cqHmcZAdspeIeOQzm1qAtCinjLJTNOvH0vXQRQ
	tX+f6gpyFxAJL3t42wH7cpMQgnOmVIyuLWN0VAw+4Dd1XN6Dl4gaYzjSdo7yjW9aI3XIJo
	qfJDiDzU6fyS1o7A8yIJNv3kmvkXcJkbN3rI4qrghuNMddHpesPpX2yxRglsYDpRJ1Nl2E
	jIP/5K9cGCZ/k8YzhwLr7q4uNntcAQ7fMECqtVTOyj8aKCJw5tZsIuTMF4pTBWgU/F4NsT
	ZWGBITP1a8ErYG7V5sXTTsFw90XadZNZCxs0Sy5Q1P1hld165k+i8lR5M7N0Mw==
Date: Wed, 15 Jul 2026 12:23:59 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 00/23] Add support for RZ/G3L pincontrol
Message-ID: <aldfv7QGPrBZ4yh6@duo.ucw.cz>
References: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8OeAbUfs752hEOMV"
Content-Disposition: inline
In-Reply-To: <20260703105923.251255-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 10:24:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23593


--8OeAbUfs752hEOMV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series aims to add pinctrl driver support for RZ/G3L SoC.
>=20
> All the patches from this series are cherry-picked from mainline except
> the patch for dropping "syscon" fallback compatible from sysc/sys
> nodes from RZ/G3S, RZ/G3E, RZ/V2H and RZ/V2N to match with the
> documentation after backporting the commit ba5095ebbc7a ("mfd: syscon:
> Allow syscon nodes without a "syscon" compatible") to 6.12.y-cip.

I had some minor comments here, but those should be fixed in mainline,
first, so they should not block the merge.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--8OeAbUfs752hEOMV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaldfvwAKCRAw5/Bqldv6
8hGmAJ0V08iFs9HBhAmeIsUVRJx+bvCDGQCeKAhtg6bGtJOd3XwGGjeSIV1pcMc=
=AHLi
-----END PGP SIGNATURE-----

--8OeAbUfs752hEOMV--

