Return-Path: <pavel@ucw.cz>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D52D41D74
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:04:24 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47051.1765800258434024712
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 04:04:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ucw.cz header.s=gen1 header.b=Cv5uaj71;
 spf=pass (domain: ucw.cz, ip: 46.255.230.98, mailfrom: pavel@ucw.cz)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 014FA1C01B5; Mon, 15 Dec 2025 13:04:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1765800257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qPkthYAOtx9baaN6Qs0vU9Pxc4xL3RHQq5LeAlgahi4=;
	b=Cv5uaj71xYsV8gtNyg6kuV4eiHwJCdGa8D+2U/pDjcNWleIF78omHLet05V0JLIUBm0pMu
	rjSkilMjsp98VJDn7f8l/yX5E7DjR8exXdetOrX1c7bkPEYIC1GKWHVHzGOdo2FIzGQqvW
	/IRaokcLG1Xjay1NSu/hce8NBsLN8Ls=
Date: Mon, 15 Dec 2025 13:04:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Biju <biju.das.au@gmail.com>, nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip] net: stmmac: dwmac-renesas-gbeth: Add PM
 suspend/resume callbacks
Message-ID: <aT/5QC1zjay6H0OY@duo.ucw.cz>
References: <20251214120313.3924-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oSS0cL2jwp+JgFCm"
Content-Disposition: inline
In-Reply-To: <20251214120313.3924-1-biju.das.jz@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 12:04:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21052


--oSS0cL2jwp+JgFCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> [ Upstream commit 72b4612af36fec844857415f14fd07126dc4499a ]
>=20
> Add PM suspend/resume callbacks for RZ/G3E SMARC EVK.

This looks okay to me. I can apply it if it passes testing and there
are no other comments.

Best regards,
                                                                Pavel

--=20
I don't work for Nazis and criminals, and neither should you.
Boycott Putin, Trump, Netanyahu and Musk!

--oSS0cL2jwp+JgFCm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaT/5QAAKCRAw5/Bqldv6
8q/lAJ4/Av0eZyRV1g41tyfZ15LdJDOdwwCdFZmo8ctYTyrHaaoriFk3jTPnSP4=
=8sY+
-----END PGP SIGNATURE-----

--oSS0cL2jwp+JgFCm--

