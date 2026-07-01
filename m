Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C2DC43458
	for <webhook@archiver.kernel.org>; Wed,  1 Jul 2026 10:44:18 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41877.1782902653181683606
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Jul 2026 03:44:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=NCDLzZ5V;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E934114D4D;
	Wed,  1 Jul 2026 12:44:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1782902650;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Ba9paSbAyTBvMGtSoaKLI59ejp3FvCh/2rrfLRa16cE=;
	b=NCDLzZ5V6gr5XTGXo2JD78Jexl+wz92eIzW/B5O49S8PmcwX0KoFE3b4XqVts819N+ZH2R
	hvVqOVqPXpd1nPQHUlmM5Y6VeLV4hxS8wvs0lqhrXnkfHUrIxSKMHNpcy3RejnvH8ANJrv
	Y313RWulYzgEka2vRmrKO6ivvdnfymtjd8c8PKVfffiJKOgLmFg9vCUXnFG/vz02OXmuRM
	/WpIF6jfgTlxTazOX1xjMzKJ7z1ecp01csdmfVPppwJwMXQIWOyAdKk9fZiL37KGbvKjFs
	WewwrgYlcBd94SIYOye9PA8FeY75KIEeQH5h+10PtvKciRVv4ecEcZ+QF++LbA==
Date: Wed, 1 Jul 2026 12:44:05 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Biju <biju.das.au@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 00/39] Add RZ/G3L SMARC EVK support
Message-ID: <akTvddty7PcGX7rx@duo.ucw.cz>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+uU9lyunH6yF/5/+"
Content-Disposition: inline
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Jul 2026 10:44:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23366


--+uU9lyunH6yF/5/+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> This patch series add minimal boot support for RZ/G3L SMARC EVK. All patches
> in this series are cherry-picked from mainline.

It was not as bad as series of 39 patches looked at first look; thanks
to simple patches.

This looks okay to me.

Reviewed-by: Pavel Machek <pavel@nabladev.com>

I can apply the series if it passes testing and there are no other
comments.

Best regards,
                                                                Pavel

--+uU9lyunH6yF/5/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCakTvdQAKCRAw5/Bqldv6
8nzGAJ9x9a5pq+6JA47rMVllReK/lQPJHQCghSAvt32HurJ6f38E5ZkOHoBrWDc=
=JtDW
-----END PGP SIGNATURE-----

--+uU9lyunH6yF/5/+--

