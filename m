Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7876ACD98C7
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 21:05:06 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.56802.1781211898593686588
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 14:04:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=TDRWe0lI;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4C93011591D;
	Thu, 11 Jun 2026 23:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781211895;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=NPS/rREO7T1HYM9FztR9n1ri3/CYBaE0GL/NPPZ4vDs=;
	b=TDRWe0lIcjOACCw6TxtLGiVF1flxndHlk+MK6xZYCRvToTewuPZXttwNwz3QpMDQZDUXBd
	wjMOkOOYd0cKK8y4Uh/eXH5EOp8AyHtfwKg7Z1GnVDCdD0L9vwQVyCD6rcrvt/aMRQysZl
	ayrw1oRQQdrEoZUTHkh4/RRYKur6vZCLwAo6Xa/lqMqCrURgdRGE1TB9dfG0VSvoGFFNBR
	/W244XMEfCIirOZinWfywxMcpXi6iyIQgV7XSa1ukkp7etR7w0xaXvsOIMiKKNh7XeoAcQ
	wzeeNyLBm9ye+Saxt6N/sWQAEVoB6lzUNqoqY/idFxb7ZXZegvRfBVIP8KOmvw==
Date: Thu, 11 Jun 2026 23:04:51 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@kernel.org, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.12.y-cip 00/17] Backport RZ/G3S USB support
Message-ID: <aisi82Eui1N1svgC@duo.ucw.cz>
References: <20260610194849.2502517-1-claudiu.beznea@kernel.org>
 <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fW4C42EIiDgkUpfx"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB1481870E0F531E41AE63C8462CD1B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 21:05:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23131


--fW4C42EIiDgkUpfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Thanks for your patch.
> I reviewed this and other series, these seems to be fine.
> I can apply this if tests are OK and there are no other comments.
>   Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

I'm looking into it. As this modifies generic code, I suggest we are
cautious here.

Thanks and best regards,
								Pavel

--fW4C42EIiDgkUpfx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaisi8wAKCRAw5/Bqldv6
8pTGAKCVtJIeEl8zUwywaLFGkiC8f/cfDACeNWTEv0pC1TTQXY0JqBmg9oCSZuc=
=D0Zd
-----END PGP SIGNATURE-----

--fW4C42EIiDgkUpfx--

