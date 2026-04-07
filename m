Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B70FFEEF26
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 11:36:27 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.79124.1775561778909014858
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2026 04:36:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=OliQHGKo;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1F37F10C95F;
	Tue,  7 Apr 2026 13:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1775561776;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3re4md6Z+Yav26lL20TyT+klsCZmh9iZgC8ek1MrbeQ=;
	b=OliQHGKoTwCbfZcYBVeJkCiCAY7ozIvdqSeDI09xnWGM7Dqt4BL6fwrEboo93XmLqMKdG0
	yT1IZqTurTreI1CiG7X9VlEfoIXQC1zJYblNkkWUtcG7V7BwCAX8mvfS2P5s6xQiTPissT
	/QMwoI9MfPOOtuNY4L30zc8wgEDBj0D8RlR9Yh6oCnZ/j1X3Nn7lCP5MO8pT2h/C+7aFLj
	9P29kf+FFwwSuJCZ7SzKF+NAmAfXjEi+uJBUKKRSnXOzJ0bLJktFix0yAN58R4BJf5yW9/
	wuCPWWMf5hmXrGW+iL4MB3/xevLg65xYRszMp+oItc4AnZiFj6zIHXw0XVG48A==
Date: Tue, 7 Apr 2026 13:36:13 +0200
From: Pavel Machek <pavel@nabladev.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev, pavel@nabladev.com,
	cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 1/1] arm64: dts: renesas:
 rzg3s-smarc-som: Set bypass for Versa3 PLL2
Message-ID: <adTsLWXKfaKFJV8l@duo.ucw.cz>
References: <20260402160937.2002534-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB14818351766CF1AF2A8D2C3BECD5AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S2hOVisrJmzE0TqU"
Content-Disposition: inline
In-Reply-To: <TY7PR01MB14818351766CF1AF2A8D2C3BECD5AA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2026 11:36:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22632


--S2hOVisrJmzE0TqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > commit 6dcbb6f070cccabc6a13d640a5a84de581fdd761 upstream.
> >=20
> > The default settings for the Versa3 device on the Renesas RZ/G3S SMARC =
SoM board have PLL2 disabled. PLL2 was later
> > enabled together with audio support, as it is required to support both =
44.1 kHz and 48 kHz audio.
> >=20
> > With PLL2 enabled, it was observed that Linux occasionally either hangs=
 during boot (the last log message being related
> > to the I2C probe) or randomly crashes. This was mainly reproducible on =
cold boots. During debugging, it was also noticed
> > that the Unicode replacement character ( ) sometimes appears on the ser=
ial console. Further investigation traced this to
> > the configuration applied through the Versa3 register at offset 0x1c, w=
hich controls PLL enablement.
> >=20
> > The appearance of the Unicode replacement character suggested an issue =
with the SoC reference clock. The RZ/G3S
> > reference clock is provided by the Versa3 clock generator (REF output).
> >=20
> > After checking with the Renesas Versa3 hardware team, it was found that=
 this is related to the PLL2 lock bit being set
> > through the renesas,settings DT property.
> >=20
> > The PLL lock bit must be set to avoid unstable clock output from the PL=
L.
> > However, due to the Versa3 hardware design, when a PLL lock bit is set,=
 all outputs (including the REF clock) are
> > temporarily disabled until the configured PLLs become stable.
> >=20
> > As an alternative, the bypass bit can be used. This does not interrupt =
the
> > PLL2 output or any other Versa3 outputs, but it may result in temporary=
 instability on PLL2 output while the configuration
> > is applied. Since PLL2 feeds only the audio path and audio is not used =
during early boot, this is acceptable and does not
> > affect system boot.
> >=20
> > Drop the PLL2 lock bit and set the bypass bit instead.
> >=20
> > This has been tested with more than 1000 cold boots.
> >=20
> > Fixes: a94253232b04 ("arm64: dts: renesas: rzg3s-smarc-som: Add versa3 =
clock generator node")
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Link: https://patch.msgid.link/20260302135703.162601-1-claudiu.beznea.u=
j@bp.renesas.com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> I reviewed each version, looks good to me.
> If tests are OK and there is no comment, I can apply.
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2433101=
088
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2433102=
394
>   https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/2433103=
164
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Looks good to me, 5.10, 6.1 and 6.12 versions:

Reviewed-by: Pavel Machek <pavel@nabladev.com>

Best regards,
                                                                Pavel

--S2hOVisrJmzE0TqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCadTsLQAKCRAw5/Bqldv6
8isrAJ0dS0Z545g8l5e8fLDYUCzrE6gr5wCfdI6vY2c4P8gOfRba1zcFYW2ytA4=
=npkE
-----END PGP SIGNATURE-----

--S2hOVisrJmzE0TqU--

