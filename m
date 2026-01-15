Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DCFD44C60
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 14:56:14 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37531.1768488965082123981
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 06:56:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=cU9mnZEh;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2835310A1D5;
	Thu, 15 Jan 2026 15:56:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768488963;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=kfzUXmClCGw6Il1Kkhm4ZmHPvfPJUzdMO4PNQvZJTKo=;
	b=cU9mnZEhEuxs3qYADgn6yyyM2u4B6lxDceZe0Eym72MkU/v/jIJ1WmVRWrFt7ugp9Me2BW
	myDAriDLgjVa/vvKbc/rVb7K02GZXGusnFkc/p6JzlyVMRNw4tk4e+DgKoG1ymB6ELymIc
	GczLUxrKyM+bXje7xYAN5rttj6gVWB7dJo+Ir6cvgXmzPcJZleC/2p9CWaMI8z9wfyKtKs
	v/6T5tXDkgNobbccxWhrHEGT1oj0KWOYwFolhBbRiv0YQkxP33o1ia/peALJ/LYKhXMz1A
	R5euUjzE5h3wJoszeoebV6r7YsQN5uD8y7loGzuH5amIoLQNxbMCko8zd4CmYA==
Date: Thu, 15 Jan 2026 15:55:58 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/4] Add RZ/V2N I2C support
Message-ID: <aWj//tWAvrRib/0L@duo.ucw.cz>
References: <20260114125324.8630-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xxjyHwtVCgHxNbgW"
Content-Disposition: inline
In-Reply-To: <20260114125324.8630-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 14:56:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21626


--xxjyHwtVCgHxNbgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds I2C support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

Thank you, applied and pushed out.

Best regards,
								Pavel
--=20
In cooperation with Nabla.

--xxjyHwtVCgHxNbgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaWj//gAKCRAw5/Bqldv6
8nmZAJ9a21le0SqWb7491JWHfEMo3zDA1wCfQHVegBBk/wI7x2hUmCTS8Z5SowQ=
=LajY
-----END PGP SIGNATURE-----

--xxjyHwtVCgHxNbgW--

