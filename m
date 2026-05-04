Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A38FF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 09:39:26 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11096.1777887557518763962
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 02:39:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=G8nKXKAm;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B1E01137C0;
	Mon,  4 May 2026 11:39:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777887555;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=R7tL6WsF5G2rt51AUJFua7n2lV5bRpB0nfEhrqfH1M0=;
	b=G8nKXKAm0icWo2hYJ9PWVR4DjfFWwsW5gpiFCSz9nJp78d7Je9rmg2Q/LfvBappdhFw29e
	485NUCk8bX/cuJJc9KmQTJ/KbgBReI4V5DwzzvMjDz37aKEqxDnXeFV5Y2rOzbOaU1Tzt1
	ww9Cmzxa+TFbuRlgmb46iFQ4oJo7DszpvKFSVufO7cc7aNLda7+k7ciUTVH9oxZOAB8Ext
	q1MBLpkUTBCOqnTaEjdz/ISBsnDxMPepo3WfiNheVJdtV5fRnzeHUftOL83VvQ9YH7aDsp
	l2Ml9Y8xBBmlRUYzhEuvdATV0NaOG3Rk+Y7/4+AVlN1/jUcvGz4ubzFpQyQcQw==
Date: Mon, 4 May 2026 11:39:11 +0200
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/9] Add USB3 support for RZ/V2H and
 RZ/V2N
Message-ID: <afhpP9iuTPGkJVoM@duo.ucw.cz>
References: <20260504064804.7021-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="D4NjdiMV4Pwlcw+t"
Content-Disposition: inline
In-Reply-To: <20260504064804.7021-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 09:39:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22858


--D4NjdiMV4Pwlcw+t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds USB3 support for the Renesas RZ/V2H and RZ/V2N SoCs.
>=20
> Patches were cherry-picked from mainline kernel.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--D4NjdiMV4Pwlcw+t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafhpPwAKCRAw5/Bqldv6
8gvkAKCgPGb+Uag8L6fUq33AW6qNi8FpDwCfXd0nr5B3Ye05CssH3v2h2Ye83EE=
=W0Yv
-----END PGP SIGNATURE-----

--D4NjdiMV4Pwlcw+t--

