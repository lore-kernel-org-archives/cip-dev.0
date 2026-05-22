Return-Path: <pavel@nabladev.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE79CD5BAC
	for <webhook@archiver.kernel.org>; Fri, 22 May 2026 21:02:55 +0000 (UTC)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.26318.1779483764509762314
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 May 2026 14:02:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nabladev.com header.s=dkim header.b=KPTFcCe4;
 spf=pass (domain: nabladev.com, ip: 178.251.229.89, mailfrom: pavel@nabladev.com)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC677111BCA;
	Fri, 22 May 2026 23:02:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1779483762;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=W3ezQPtfr5lXbOj9nmodMHkNkyKD5mcqFOuDg/K/yQc=;
	b=KPTFcCe4IFV+oCFeVDvzVcwN2UYh4Pf/R2tkghZX49un4ITdweqA/vXtXCoQ67Dx5UKBef
	sZZ2jFbVZuJirg7TExRR4J1JEMrNx5wWh04utayOvrj7/bsJ1s2Vf0pSO+daZN/n/jtq6g
	sMNYgPLfKR9F7xve+357xxbOvY9GOqta5ZFCHgoYM0kUEBJo6Qukbhzmh//ZGOveCD1oCL
	+X7/GGV0b2L/pgIFQQAVYuLVLnErZry64IcmxsHA01Jo4THuJ5ZpjVfl8p8PKAH6dKUa7V
	TtpVgNHHmg3RGDVFjsYUz9j0QpmErD0PVeQhte/M9CgflpVwkZXdwpr0aCLVuw==
Date: Fri, 22 May 2026 23:02:36 +0200
From: Pavel Machek <pavel@nabladev.com>
To: john.madieu.xa@bp.renesas.com
Cc: Pavel Machek <pavel@nabladev.com>,
	"KernelCI bot via lists.cip-project.org" <bot=kernelci.org@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"kernelci-results@groups.io" <kernelci-results@groups.io>,
	"gus@collabora.com" <gus@collabora.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: field_get problem in 6.12 -- Re: [cip-dev] [REGRESSION]
 cip/linux-6.12.y-cip: (build) "field_get" redefined [-Werror] in
 sound/usb/mixer_quirks.o (sound...
Message-ID: <ahDEbDKLo7YlX2EG@duo.ucw.cz>
References: <177941154371.3955.14567547508285219672@330cfa3079ca>
 <ahAYjl0g7RuivHQJ@duo.ucw.cz>
 <TY6PR01MB17377025B3BE5EB9806D02FE4FF0F2@TY6PR01MB17377.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WLajv5XEizDnR1ue"
Content-Disposition: inline
In-Reply-To: <TY6PR01MB17377025B3BE5EB9806D02FE4FF0F2@TY6PR01MB17377.jpnprd01.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 May 2026 21:02:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23001


--WLajv5XEizDnR1ue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > We recently added
> >=20
> > include/linux/bitfield.h:#define field_get(mask, reg) \
> >=20
> > in renesas series (arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe=
):
> >=20
> >     bitfield: Add non-constant field_{prep,get}() helpers
> >=20
> >     [ Upstream commit c1c6ab80b25c8db1e2ef5ae3ac8075d2c242ae13 ]
> >=20
> >     Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> >     Reviewed-by: Pavel Machek <pavel@nabladev.com>
> >     Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshib=
a>
> >=20
> > and now it is causing warnings, one was reported by kernelci, and likely
> > more are coming:
> >=20
> > drivers/clk/at91/pmc.h:#define field_get(_mask, _reg) (((_reg) & (_mask=
))
> > >> (ffs(_mask) - 1))
> > drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c:#define
> > field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > drivers/iio/temperature/mlx90614.c:#define field_get(_mask, _reg)
> > (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > drivers/irqchip/irq-renesas-rzv2h.c:#define field_get(_mask, _reg)
> > (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > drivers/pinctrl/nuvoton/pinctrl-ma35.c:#define field_get(_mask, _reg)
> > (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > drivers/soc/renesas/rz-sysc.c:#define field_get(_mask, _reg) (((_reg) &
> > (_mask)) >> (ffs(_mask) - 1)) sound/usb/mixer_quirks.c:#define
> > field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> >=20
> > Likely similar problem will appear in 6.1.x-cip, shortly.
>=20
> Sorry about that. I'll drop the two field_get-related patches and define
> it locally like other drivers do.

Yes please. I guess something to apply on top of existing patches
would be best.

Thanks and best regards,
								Pavel

--WLajv5XEizDnR1ue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCahDEbAAKCRAw5/Bqldv6
8nhLAJ9bLAVeeTYpdxW8SPtMCqQfSwDAuQCdEzXwPkNBSQoKLbiXo8QRphtLW14=
=YfHa
-----END PGP SIGNATURE-----

--WLajv5XEizDnR1ue--

