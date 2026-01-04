Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C65BC2A070
	for <webhook@archiver.kernel.org>; Sun,  4 Jan 2026 23:54:56 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.46621.1767547889654477137
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Jan 2026 09:31:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=VlO5oFhj;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55387FFF10;
	Sun,  4 Jan 2026 18:31:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1767547887;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=QDVnMOzTDS5yk+3AvlpukCKtlUspHKW6L351GwlJOCY=;
	b=VlO5oFhjKtYTx9M26bmstWm1Ca2o9ngrZJxUgeFq2qhRyMQnpaGIEgifv/fWG91nwcZKNX
	TxQjUQLDS7u3TnX8D+dsQBJRBLMV0PD981YpkQ8Hsl6MrzLcWFJoowMUclFcym4sBWLJ1H
	T1AUWWURxRPcuBxkbGAjwJdajBVcuzEx40zhl34aBrk0sHECmbapVR3daBHX6YDJwRb6rM
	jHu5plr8Z4n0SNxvdV6bgYq2yzP8cAy9gIp+W93iiV+wo2UCqsCPOTEMUAZA1Cv00Z3avj
	ipXLfE42S0NEhoNXQv8uYpU6ZO2T8ds/kMW6I6SvHW00kVuKq3E3MBgo/kTtBQ==
Date: Sun, 4 Jan 2026 18:31:25 +0100
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.1.y-cip 0/5] Add RZ/V2N GBETH support
Message-ID: <aVqj7ZbsHPUgtG/7@duo.ucw.cz>
References: <20251229084011.3611-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
In-Reply-To: <20251229084011.3611-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qV01ejRFpjWyuKvP"
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Jan 2026 23:54:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21303

--qV01ejRFpjWyuKvP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds GBETH support for the Renesas RZ/V2N SoC.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel
--=20
In cooperation with Nabla.

--qV01ejRFpjWyuKvP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaVqj7QAKCRAw5/Bqldv6
8s1ZAJ0TQkVBZ+toCj1K8i8C82jRPFW7QwCfcy3NQKWmg/st3Ey3eODEw2ROb1o=
=BnKk
-----END PGP SIGNATURE-----

--qV01ejRFpjWyuKvP--

