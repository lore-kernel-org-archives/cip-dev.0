Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B7FCD5BB0
	for <webhook@archiver.kernel.org>; Fri, 22 May 2026 08:49:34 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12880.1779439765572103345
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 May 2026 01:49:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=VxHYIC1r;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2971D113A8B;
	Fri, 22 May 2026 10:49:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779439762;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+bwWxWtnFlxy9YY4w0+g/iP36FxZQLynQ1JfCtx1dQA=;
	b=VxHYIC1rA4oasH/kv9OcZw6FoFjuPJC6L+0jjZrGSnOHe0kToZu1w1ht6Ig6RAT5e/y5ib
	TZOzn0V1ZNlyWmYCFRGoDv4ddIdDJBnpF1zCeDJckQIJap7jkgYM2OgPEVrb7c6q0kZMAi
	vLJxeyctAeBfG4JhaHQxEsl+6vnbJ7apvrtcs7Mx7rwpXQLvXgVfEPLBvY8Eob5sBmdMzu
	DuFCPWlj3TAZV/9uVzc4piInxiWWaKhXUk9OfUmo+EEFfgZvTY4rzsmVOTS7yWj9O5C0VL
	BTvxRfQJMbLWTMX19SCThdigAAAP4zy720VvPQotQ6mY+124e7vON/+T1f3Lig==
Date: Fri, 22 May 2026 10:49:18 +0200
From: Pavel Machek <pavel@nabladev.com>
To: "KernelCI bot via lists.cip-project.org" <bot=kernelci.org@lists.cip-project.org>,
	john.madieu.xa@bp.renesas.com, nobuhiro.iwamatsu.x90@mail.toshiba
Cc: kernelci-results@groups.io, gus@collabora.com,
	cip-dev@lists.cip-project.org
Subject: field_get problem in 6.12 -- Re: [cip-dev] [REGRESSION]
 cip/linux-6.12.y-cip: (build) "field_get" redefined [-Werror] in
 sound/usb/mixer_quirks.o (sound...
Message-ID: <ahAYjl0g7RuivHQJ@duo.ucw.cz>
References: <177941154371.3955.14567547508285219672@330cfa3079ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6ZBam5x3A7cVWR39"
Content-Disposition: inline
In-Reply-To: <177941154371.3955.14567547508285219672@330cfa3079ca>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 May 2026 08:49:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22998


--6ZBam5x3A7cVWR39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

We recently added

include/linux/bitfield.h:#define field_get(mask, reg)
\

in renesas series (arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe):

    bitfield: Add non-constant field_{prep,get}() helpers
   =20
    [ Upstream commit c1c6ab80b25c8db1e2ef5ae3ac8075d2c242ae13 ]

    Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
    Reviewed-by: Pavel Machek <pavel@nabladev.com>
    Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

and now it is causing warnings, one was reported by kernelci, and
likely more are coming:=20

drivers/clk/at91/pmc.h:#define field_get(_mask, _reg) (((_reg) & (_mask)) >=
> (ffs(_mask) - 1))
drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c:#define field_get=
(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
drivers/iio/temperature/mlx90614.c:#define field_get(_mask, _reg)       (((=
_reg) & (_mask)) >> (ffs(_mask) - 1))
drivers/irqchip/irq-renesas-rzv2h.c:#define field_get(_mask, _reg) (((_reg)=
 & (_mask)) >> (ffs(_mask) - 1))
drivers/pinctrl/nuvoton/pinctrl-ma35.c:#define field_get(_mask, _reg)   (((=
_reg) & (_mask)) >> (ffs(_mask) - 1))
drivers/soc/renesas/rz-sysc.c:#define field_get(_mask, _reg) (((_reg) & (_m=
ask)) >> (ffs(_mask) - 1))
sound/usb/mixer_quirks.c:#define field_get(_mask, _reg) (((_reg) & (_mask))=
 >> (ffs(_mask) - 1))

Likely similar problem will appear in 6.1.x-cip, shortly.

Best regards,
							Pavel

--6ZBam5x3A7cVWR39
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahAYjgAKCRAw5/Bqldv6
8lM4AJ4kUdsA6LBdZdaa3BCXsMLwdtyKIwCffa6iJ0PtuD4fDHsoV9fn66kFEoA=
=8gq3
-----END PGP SIGNATURE-----

--6ZBam5x3A7cVWR39--

