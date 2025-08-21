Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A742CA0EEB
	for <webhook@archiver.kernel.org>; Thu, 21 Aug 2025 10:26:31 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.6087.1755771982369849095
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Aug 2025 03:26:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=fDY8VDE2;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2AEC2103F5651;
	Thu, 21 Aug 2025 12:26:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755771980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=JT2QGCj7As26s2JMn97+W1eC78PqFRAcfLt/vCHH0V4=;
	b=fDY8VDE2mab4xLQLHNQXTNJwCih+d3Sy3lGM/8xgi85a1KzW5hHMW2zwM/zoqv0plTYjBy
	n+nXAVvoxgfqSuP3G5WlgDL/sT8/75r6va75FIRzPI4eytjINegDzbpfXLlJyeZHtGf1GJ
	TNht+6GKO5NgE8L9ezBKrdPlf1ImL+OQGLEoC2PaG4tV5cSBtn+Lh8RxcJT3+9i1D0051I
	4eAbuqj75+3RGhQf/LKQ2ivX1K4Xen7W195HuZAifC1LyLgukDzT1bPDM+h2RuLqsTZehu
	JxPs6cWNGd/GjnnlmobQHF7GJ4UvZWizhp6LcJFHOBducOoPPFeAGp32UdRpWQ==
Date: Thu, 21 Aug 2025 12:26:16 +0200
From: Pavel Machek <pavel@denx.de>
To: prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Ulrich Hecht <uli@kernel.org>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Message-ID: <aKb0SIb9QmoTtqx+@duo.ucw.cz>
References: <20250820135622.27414-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EJY6K6+ls/07zNpM"
Content-Disposition: inline
In-Reply-To: <20250820135622.27414-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Aug 2025 10:26:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19931


--EJY6K6+ls/07zNpM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 552ca6b87e3778f3dd5b87842f95138162e16c82 upstream.
>=20
> When performing continuous unbind/bind operations on the USB drivers
> available on the Renesas RZ/G2L SoC, a kernel crash with the message
> "Unable to handle kernel NULL pointer dereference at virtual address"
> may occur. This issue points to the usbhsc_notify_hotplug() function.
>=20
> Flush the delayed work to avoid its execution when driver resources are
> unavailable.

Reviewed-by: Pavel Machek <pavel@denx.de>
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EJY6K6+ls/07zNpM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKb0SAAKCRAw5/Bqldv6
8loLAJ9yKjdsqjaTxKaLHlWQb+ynR97Z6wCfV9zBlb7dfGvWzAMLkE+MbBk+jec=
=NPT6
-----END PGP SIGNATURE-----

--EJY6K6+ls/07zNpM--

