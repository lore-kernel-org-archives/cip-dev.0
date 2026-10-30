Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10775.1793365020221341379
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 05:57:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=VIa4fOQ1;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 921F4106715;
	Fri, 30 Oct 2026 13:56:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1793365013;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=6A/qHSmEOQeHrCbCuUMfYeGECA+jv/s1+UOErmIi24E=;
	b=VIa4fOQ1w6QyrmAMJLpisxjGTo16UeuCR/jZtuEih1UQaupQQ8jJlijq4iJheqs6CWGGvV
	yNehKsBh8SZSDrgbfWiG0/8FX6wQK5qWAi4HOYaQzxTJpGO5RHP+p+LN7WuZhGjNJrDskJ
	9pvz00Uw7LagI86brUDEkCCbAYwn8V2zPqw/gTQ2Wbg2kzvsZ4ZSRfTJmjfDr4iJIG41mR
	TC9oAYFlGzivI/DjaHTIq+c6iFBI9RMzd70q7Gjun9/TOUNrIBxwysYJ+bsnfHzy7VjEJp
	63AN+5Inc24ni9Su7sKkaGaGgVoF11J2ncvEGlL+wFOMsT2wifnck1oO+PwR2g==
Date: Fri, 30 Oct 2026 13:56:50 +0100
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: pavel@nabladev.com, cip-dev@lists.cip-project.org, uli@fpond.eu,
	biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 6.12.y-cip] irqchip/renesas-rzv2h: Restore
 function parameter for suspend/resume
Message-ID: <auSUEvghM0rgNVT5@duo.ucw.cz>
References: <1793341067-15723-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uvU9C4JicXqLC2lQ"
Content-Disposition: inline
In-Reply-To: <1793341067-15723-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 12:57:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24592


--uvU9C4JicXqLC2lQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Commit 20a4a45ee35f ("syscore: Pass context data to callbacks") modified
> the callback functionality in `syscore`. This commit also included updates
> to the relevant drivers; however, irqchip/renesas-rzv2h was not included =
in
> these changes and therefore requires its own fix.
> This restore function parameter for rzv2h_irqc_irq_{suspend,resume}(), and
> use register_syscore() instead of register_syscore_ops().
>=20
> Fixes: f443abb80780 ("irqchip/renesas-rzv2h: Add suspend/resume support")
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> ---
>=20
> NOTE: This is an issue that occurs after merging v6.12.114.

As this depends on 6.12.114, it can't be (easily) tested now, and
should not be applied now, but I'm okay with applying it after
dependencies are merged.

Reivewed-by: Pavel Machek <pavel@nabladev.com>

Thanks,
								Pavel

--uvU9C4JicXqLC2lQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCauSUEgAKCRAw5/Bqldv6
8mjTAKCHBbnk5WaIBelO4uCfx70Ck5/1AgCeLVJPTI/YAucJequDNOvS/Zy3nRg=
=Phi6
-----END PGP SIGNATURE-----

--uvU9C4JicXqLC2lQ--
