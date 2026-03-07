Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D25F55103
	for <webhook@archiver.kernel.org>; Sat,  7 Mar 2026 16:50:08 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12617.1772902203202408818
 for <cip-dev@lists.cip-project.org>;
 Sat, 07 Mar 2026 08:50:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=I+JS6zKg;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E88E10BEBC;
	Sat,  7 Mar 2026 17:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1772902200;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Hqw3ZHgLoscSAWxyRdP6b5S+30tlEeU8tG1VOTC23ek=;
	b=I+JS6zKgEdedJiRvXBNSnz6RftWHLYgO9A/wwpJsQXVC8eA8RW3g69n2ww7iIxlMBjsc3a
	0MvcXeNZxzRf63L9kkIEAkKgiAMeXSgow62rL9vPP/Ot+UjINF4ptB7/vKRo8BY/qnGyq1
	Y3k7hqPuC+SxxLdM6cLf4cjZ8lUHsl6gkaHRqrgSc0CsvlKC6HTK050pB8tYJZ4maIMSBs
	38wloK8B2p3C2mYmoC83c1OeCzFV/Xw1GDAPOAUzhB6lJSOCjogbBRPcKJm3OhvTXoULEf
	V76KOf9RAnQw/NmzlbEZ00aYgUEgjbF1APE2fP7QGyn7d51H6DAjjXkbb3DZQg==
Date: Sat, 7 Mar 2026 17:49:56 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/8] Add RZ/V2N display support
Message-ID: <aaxXNCvXO5KiRQJ/@duo.ucw.cz>
References: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I9+BkiEY78MlqqAF"
Content-Disposition: inline
In-Reply-To: <20260305153725.19821-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 07 Mar 2026 16:50:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22146


--I9+BkiEY78MlqqAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds display support for the Renesas RZ/V2N SoC and EVK
> board.
>=20
> All patches were cherry-picked from mainline kernel.
>=20
> Note: This series depends on:
> https://lore.kernel.org/cip-dev/20260225121232.129678-1-ovidiu.panait.rb@=
renesas.com/

Thank you, applied.

Best regards,
									Pavel

--I9+BkiEY78MlqqAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaaxXNAAKCRAw5/Bqldv6
8ugDAJwLYcHQgn6EzXkUk+cIkOc6jR6x+wCeNRgIbluUWvb/wERWYqyJphKXThU=
=pCWF
-----END PGP SIGNATURE-----

--I9+BkiEY78MlqqAF--

