Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B0BE83828
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 19:15:34 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1704.1771269332194067916
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Feb 2026 11:15:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=PYR1ej9b;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DBDFE10FA83;
	Mon, 16 Feb 2026 20:15:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1771269329;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=T+N3eSlBAzqtjlI12QRFw1BsLqHnouzR8UySfe52BSU=;
	b=PYR1ej9bAyglajSiGBH/rZYIvo3l5L/tn3gR2qvAFgHrbXPe7jXmFC9dBTRWuG1Be2j9Yg
	7GPsn9K2cwZD9vVnGedw8AL68V/FbD8IJQbKCM0oxEa0GSlRpwvDZC0Y9AbY6nYjkSFrp5
	Nk+RBa6cinEXUWy0WzFs/PEtV7+FJ8T6jEoKYgkDcvzS9CCsgcCtuQOABda18JA5scVt3k
	Cfn5PdNbOz9FJrD7RCmbGL96xXLTC/yepw74+UkDZB168rvvA1Qqo71h3g2Xrxtdab838e
	pSgAUAX//CUXO0HuT4m/0zmivKy67JCOTXhbQWbq+i/isV8a8n15ntkjCc1ymQ==
Date: Mon, 16 Feb 2026 20:15:27 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/3] Add RZ/V2H GPU support
Message-ID: <aZNszwTG0dY27FJa@duo.ucw.cz>
References: <20260216151819.92667-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nR/dmm3O9fKogHSQ"
Content-Disposition: inline
In-Reply-To: <20260216151819.92667-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Feb 2026 19:15:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21890


--nR/dmm3O9fKogHSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds GPU (Mali-G31) support for the Renesas RZ/V2H SoC.
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

--nR/dmm3O9fKogHSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZNszwAKCRAw5/Bqldv6
8hQoAJ98Rx8MAnH3785pdjWtkFO3HuweawCfUUCTo0XXqCGXsnCzvRkAXntmJyk=
=KHEu
-----END PGP SIGNATURE-----

--nR/dmm3O9fKogHSQ--

