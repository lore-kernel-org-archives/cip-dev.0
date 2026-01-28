Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72110D3F06F
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 14:23:13 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14398.1769610176508774493
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 06:22:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=CQ0k1UKo;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37FE810A932;
	Wed, 28 Jan 2026 15:22:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769610174;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=7UflJcoUrTXuAcVzrhyk1HE/trEQczAie6n47zPVUFw=;
	b=CQ0k1UKoxjn+UbVhm68XhUAjoUafMIWI/SUkm+qLUAltgLmK+MUrMGHE4XdZpedRqGAJDQ
	he4BaYTinbZHHawMZYKfK0RzhJu4MjFnAa9nWXZ6LiGfP8czvPEobwzmy5IsHM4uCENEsy
	oNd40lZtVqN7VGpZbyxzeT5viBUDh4z1WJfoYUEgg9IWsZGuxlV6X87OqpWpT6e8+vGPdW
	LVmess1y6gEbc/n0cMkd7kxu97z3yTIPY3uOCTKuDiy/nJ/zK/NgMok5AlT66uHKtnUkuy
	MgFFQwN8ammqJwEgvjK9DSyKxjSGAh6ChrN+oMUoYxH1gtP9Llk+qHAKzh/NIw==
Date: Wed, 28 Jan 2026 15:22:50 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip] thermal/drivers/renesas/rzg3s: Fix
 inverted reset logic in devm cleanup
Message-ID: <aXobun68mrXuVr45@duo.ucw.cz>
References: <20260128125840.6801-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KMQSgWqHONAqKxr7"
Content-Disposition: inline
In-Reply-To: <20260128125840.6801-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 14:23:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21763


--KMQSgWqHONAqKxr7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The devm reset callback that should undo the reset_control_deassert() done
> during probe is incorrectly calling reset_control_deassert() again,
> instead of reset_control_assert().
>=20
> Fix this by calling reset_control_assert() and rename the callback
> function accordingly.

Quick note here what if there is upstream equivalent or why not would
be nice.

I have my guesses, but...

Thanks and best regards,
								Pavel
--=20
In cooperation with Nabla.

--KMQSgWqHONAqKxr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaXobugAKCRAw5/Bqldv6
8iNXAJ0Z0fd36njcHI11k2qa7llGs08+aQCfS83vsdfV9Ivv7bnRI20FpqbIryI=
=zLUm
-----END PGP SIGNATURE-----

--KMQSgWqHONAqKxr7--

