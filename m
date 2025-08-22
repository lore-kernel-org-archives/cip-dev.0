Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8E3CA0EFC
	for <webhook@archiver.kernel.org>; Fri, 22 Aug 2025 11:35:33 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.7736.1755862531825106709
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Aug 2025 04:35:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=G7tuWAhM;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D2D591038C11E;
	Fri, 22 Aug 2025 13:35:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1755862529; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=vdOPjSLnU4cXijpapYTaTFGSv8Vm8XOdynwSvJXGgOg=;
	b=G7tuWAhMC5FPMb+01lQKgiUeErFhI/s7t/jieEdmm52ppYsCeH4gLJvSjvszhqbmK1zkO5
	Dm/3BYNy8XQ5LH6zCqEuCNuIvxv+9PR87NX03kNZ7WXS+tOn/F68buatTs7Eoh71MLqmmS
	2wYIHAs5K4aSIhhVrI1H2rbKYKMDNMsyrRR7MYgu6Rtqebb5bf7YkndO0RPYqvEUATJlZU
	oo6hLq7TdxRzsY5gz/3JnCkvWiFMl3FWse9Hd2CVKZBxAKd411ZnNPQ+lJRMkOJ9WKjyw0
	hAOz2OGB2ei+V85DDRcmLZsbUABTEL6fTuEi8HMB7gEpx+lKPQuD4jQAtrrYnA==
Date: Fri, 22 Aug 2025 13:35:24 +0200
From: Pavel Machek <pavel@denx.de>
To: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>, tomm.merciai@gmail.com
Subject: Re: [PATCH 6.1.y-cip 50/55] media: i2c: ov5645: Refactor
 ov5645_set_power_off()
Message-ID: <aKhV/HFqmppq+b2A@duo.ucw.cz>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
 <20250820160413.801341-51-tommaso.merciai.xr@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7r6an5rY+KP5y+aE"
Content-Disposition: inline
In-Reply-To: <20250820160413.801341-51-tommaso.merciai.xr@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Aug 2025 11:35:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19947


--7r6an5rY+KP5y+aE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Ricardo Ribalda <ribalda@chromium.org>
>=20
> commit 820d81a167d422027ca4af7f0511e101f21aa214 upstream.
>=20
> Factor out all the power off logic, except clk_disable_unprepare(), to a
> new function __ov5645_set_power_off().
>=20
> This allows ov5645_set_power_on() to excplicitly clean-out the clock
> during the error-path.
>=20
> The following smatch warning is fixed:
> drivers/media/i2c/ov5645.c:690 ov5645_set_power_on() warn: 'ov5645->xclk'=
 from clk_prepare_enable() not released on lines: 690.
>

Do we really need to take these? Maybe cleanup, but no real
impact... I'd be inclined not to take ov5645 series... stuff will work
ok without it.

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--7r6an5rY+KP5y+aE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaKhV/AAKCRAw5/Bqldv6
8iOFAJsFAjAOyTWqaMOiv0Jfc7tNTBrESgCeLD+rYbKSmxSuVGK0eaNtqlO5EIY=
=1iZX
-----END PGP SIGNATURE-----

--7r6an5rY+KP5y+aE--

