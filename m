Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B6FFF885A
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 09:39:46 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11131.1777887579627321197
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 May 2026 02:39:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Clvd3BUj;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C1061137C0;
	Mon,  4 May 2026 11:39:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777887577;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hwuyeHFvmLgF6Cu+OUgnHklCP2csi0VTclfPQbUd2Wg=;
	b=Clvd3BUjzfprfstrQvzmNEaX+qwoK/CV6myiqiIhZIb/f0GxDMF8NRt1pHwiP2VT9tQpm/
	vlersNp4vyYPWg7gJVvQ5xXR+epnRtesOL3pWnchUkgy916Bs0H/a6qev67YhBxG1+Hg2K
	zA7cd09kCxOSop9dPg1F4jHr1y0mE7BWiPvcVrs+HgqkdVrkjNkEsGsrjm7SgYXnQ8mevy
	iW+qjirZHlTebU3ptJyZuHED+9gDQcRtbACtstSLuEXMnh+JWZLL/ihbYietFM/p6e1NBB
	G94voOaHnO1JdD+pzLuASdWZ0cinch/tzV/2Bjmbei51Fmk/IrL4RLxhXwO7Ow==
Date: Mon, 4 May 2026 11:39:36 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [PATCH 6.12.y-cip 0/9] Add USB3 support for RZ/V2H and RZ/V2N
Message-ID: <afhpWFsB2NFh6K9m@duo.ucw.cz>
References: <20260504064943.7237-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kDfK0TuLMQQv1LYN"
Content-Disposition: inline
In-Reply-To: <20260504064943.7237-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 09:39:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22859


--kDfK0TuLMQQv1LYN
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

--kDfK0TuLMQQv1LYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCafhpWAAKCRAw5/Bqldv6
8pmzAJ9YOrBX+YMqTHsyRxpgoh4IGEZhCQCghzZn8H3z8ZLOooRQzGpC0ynnlrI=
=sG4o
-----END PGP SIGNATURE-----

--kDfK0TuLMQQv1LYN--

