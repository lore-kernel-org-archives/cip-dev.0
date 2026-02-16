Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61349E83825
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 19:14:34 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1694.1771269270903382832
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Feb 2026 11:14:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=Hk/IHBKU;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EF2910F801;
	Mon, 16 Feb 2026 20:14:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1771269268;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rgRuIMIWxx7zlV+uxlgadd4zO+qwq4PquM+ZRpnF+qw=;
	b=Hk/IHBKUCp9eoyVYYGMXWwwStGwBNn1MBaLLe4uGmSoFl6NAe5W69uuWYpgR3ZrJ+M2wSX
	qh+6brCcZXRONyvZH6UyzVqtOgXPrE4HwRf+C0ilgHZIRdjswnlr1qZz5chCh0YkU7T5DC
	Fn+zLMAe1jiheT4v6UCxpOXalLoNFOmp31ysykAfo7qMvFkYpD3suMRDMLmxj+v/V6iDwb
	eQEmLhZeF6en3lUHdC2NJlO0Ph1ae45u2ZxlQioPyFY+QXL2MuyxI4QTlXIykXpOYX6Pg3
	A7tWd7XFqQuKUAeS8sabjk2Bsf5Xp+Z0ZKFr1/Ciw7t/OVdqsSTSs+E+FZZW4Q==
Date: Mon, 16 Feb 2026 20:14:22 +0100
From: Pavel Machek <pavel@nabladev.com>
To: ovidiu.panait.rb@renesas.com
Cc: cip-dev@lists.cip-project.org, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/3] Add RZ/V2H GPU support
Message-ID: <aZNsju4RrLWChenE@duo.ucw.cz>
References: <20260216151751.92635-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aak13lqCxc6ronqP"
Content-Disposition: inline
In-Reply-To: <20260216151751.92635-1-ovidiu.panait.rb@renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Feb 2026 19:14:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21889


--aak13lqCxc6ronqP
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

--aak13lqCxc6ronqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaZNsjgAKCRAw5/Bqldv6
8mNnAJ9dQ5Oeoycehvj9VKvF1ObmBSIYiwCfbQP7IL1P+YdLuc7T8qMs1RQ0QHQ=
=wORn
-----END PGP SIGNATURE-----

--aak13lqCxc6ronqP--

