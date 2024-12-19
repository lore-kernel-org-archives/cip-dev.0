Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC66E77184
	for <webhook@archiver.kernel.org>; Thu, 19 Dec 2024 18:25:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.135719.1734632744582947466
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Dec 2024 10:25:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=bFoljS0W;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B91B101ECB02;
	Thu, 19 Dec 2024 19:25:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734632742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KW2FpDPGytYmFRTwlyh6vMoF9//F/7B80MYe32/WiJU=;
	b=bFoljS0WtRf6TxBGbk3E3QraZ12dnFVLlxP4JDWSLx27LHj781Q+PiaeqJYonp4hovHeKw
	/V7qBqukXTcBZk6Vg4qjvNYRQ9S0qAEWmBIP0OtXkypthSivGtqXP4RGj6Q1Na9nDYwsxi
	zE7ycXUkEjuMhIpuXe+bJAnf5dfqIQ6lbSUQiYb9cRr71x8wfWHy0dstbbng71PXdM7DNz
	b0BcneueX7pkepb+QrWkBAZ9yUkdA03u8UXfq5usHe6xhgQG/E6U/Fz9f5ux3i1HPxdIBJ
	iJWUY6zGNPO8NLKd4QC68Ew6FWPM3PEgE7M5zpo94zMSbh+ZmE+JTvjG0atdEQ==
Date: Thu, 19 Dec 2024 19:25:37 +0100
From: Pavel Machek <pavel@denx.de>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@denx.de,
	cip-dev@lists.cip-project.org, biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip dev][PATCH 6.1.y-cip 0/8] watchdog: rzg2l_wdt: Backport
 RZ/G3S support
Message-ID: <Z2RlIUU0vCUjnmTF@duo.ucw.cz>
References: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s3RptZ4yWl4LDylB"
Content-Disposition: inline
In-Reply-To: <20241218122246.2365189-1-claudiu.beznea.uj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Dec 2024 18:25:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17482


--s3RptZ4yWl4LDylB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Series backports the watchdog support for the Renesas RZ/G3S SoC.

Applied, but there may be more work to do there.

rzg2l_wdt.c:
rzg2l_wdt_start
/* Enable watchdog timer*/
->                "timer */"

static int rzg2l_wdt_stop(struct watchdog_device *wdev)

We can now fail to stop the watchdog.. not sure how well core can
handle that. If pm_runtime_put fails, we return error, but we already
toggled the reset control. Should we undo that? Does error handling
here make sense at all?

rzg2l_wdt_restart:
Similar problem. If reset_control_deassert() fails, we should probably
do pm_runtime_put().

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--s3RptZ4yWl4LDylB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZ2RlIQAKCRAw5/Bqldv6
8qsYAJwMYZVOEVmVat11e5O+5Q+swnmLawCgrT3Ht77lYxotwN6/KEeZclIzKzk=
=7cY5
-----END PGP SIGNATURE-----

--s3RptZ4yWl4LDylB--

