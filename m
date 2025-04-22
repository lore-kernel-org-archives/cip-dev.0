Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0984DC369D7
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 10:20:25 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web11.36573.1745317224348508628
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 03:20:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=JhOHvDoK;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03644103B92C6;
	Tue, 22 Apr 2025 12:20:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745317222;
	h=from:subject:date:message-id:to:mime-version:content-type:in-reply-to:
	 references; bh=Pr16zELsZH2tSaWENbpQbHpiOmVls3GtCQ1h5sOg/A0=;
	b=JhOHvDoKBir47ROgmqTxffsja8hk7GAOZoOK/wDwh/31BUAHCxxho2eDUo6AwxK+P37eFG
	46cBelQXVQrdBTysk9+KNDQ2COLhuiikeI8cSmb8X6FZBa2cOQx53wZ94yhV4E7fEkc/1P
	eOJF8zxHdqhrhiq4pPFvRfzYI3IZKhhT+eCXOdSh5JsoaZni8vE4iy5vKqo+K+CuwwylJr
	Vo6G0JZlpNUkokrcJnN7UaJxHOZV5Z3WOAJC+dYVktJ/ZhXIZwYFwbg97tBz2PcJ6BcDSQ
	iGojYspw5MDKwVyKr8Ui8fwmQYWpDjEoOfo2HfYvHBRzqUopZP+EpJbztga0cQ==
Date: Tue, 22 Apr 2025 12:20:17 +0200
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 5.10.y-cip] clk: renesas: r9a07g044: Add clock
 and reset entry for DRP-AI
Message-ID: <aAdtYQPQAHQ9Jx7/@duo.ucw.cz>
References: <20250421184657.633352-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <18389BCA0DAE4776.21966@lists.cip-project.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4cTmABzJR+eBuFvW"
Content-Disposition: inline
In-Reply-To: <18389BCA0DAE4776.21966@lists.cip-project.org>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 10:20:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18548


--4cTmABzJR+eBuFvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > commit 989d673ff7c461b2abd472227fdb7df69860d23f upstream.
> >=20
> > Add clock and reset entries for the DRP-AI block, which is available on=
ly
> > on the Renesas RZ/V2L SoC.
>=20
> Looks ok to me. Both 5.10 and 6.1 versions:
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>

So, sorry for the noise. Patches are ok, but we'll need to get this to
6.12, too.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4cTmABzJR+eBuFvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaAdtYQAKCRAw5/Bqldv6
8rNFAKDCDR3hlj1R3RJkSdSDhFdAtLiPWgCeMZfemkIgzi4k6yuw/Q53YRh8PR4=
=njZ9
-----END PGP SIGNATURE-----

--4cTmABzJR+eBuFvW--

