Return-Path: <SRS0=VdPb=CS=lists.cip-project.org=bounce+64572+5431+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBA3C433E2
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 06:07:21 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC58207DE
	for <cip-dev@archiver.kernel.org>; Wed,  9 Sep 2020 06:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vSXlL+IE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC58207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5431+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id W5qEYY4521723xi2NLI3HGwt; Tue, 08 Sep 2020 23:07:19 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7490.1599631637732234273
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Sep 2020 23:07:18 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3C9EE1C0B79; Wed,  9 Sep 2020 08:07:13 +0200 (CEST)
Date: Wed, 9 Sep 2020 08:06:57 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] gpio: rcar: use gpiochip data pointer
Message-ID: <20200909060657.GA27139@duo.ucw.cz>
References: <20200903141052.12720-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200903175431.GC7795@duo.ucw.cz>
 <OSBPR01MB5048BAC612ADD9CA1A3F143AAA2C0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
 <OSBPR01MB5048C5D63E5DF533E9AA5822AA2D0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB5048C5D63E5DF533E9AA5822AA2D0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OHhXvuTUMGDAEK4FVOzYlZV2x4520388AA=
Content-Type: multipart/mixed; boundary="G11nPzjhVwD8p6iksX1B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599631639;
 bh=7zu8ZGA4qpiBBFjjQzH5irkiyXpuk+sE8LOlUXWZ+C8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vSXlL+IEDaMTB+MW7W0egygsWcE/IwFxrUCrT5AF0tasS73SyOBwE0gLSvfNHmrLc33
 xTrJ3d5XZ2NN+5Ulns7D+to8K4ifDk3lz6nXXMu/4/KH0lgLrT/LmSGMVtpmiYRxOLSOz
 aBQ5mbYONBTYMCY3h4AUlGY7jFyPvrr9kEc=

--G11nPzjhVwD8p6iksX1B
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Fixing set_multiple is possible with this oneliner, right?
> > >
> > > > @@ -541,7 +532,7 @@ static int gpio_rcar_probe(struct platform_devi=
ce *pdev)
> > > >  irq_chip->irq_release_resources =3D gpio_rcar_irq_release_resource=
s;
> > > >  irq_chip->flags=3D IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPE=
ND;
> > > >
> > > > -ret =3D gpiochip_add(gpio_chip);
> > > > +ret =3D gpiochip_add_data(gpio_chip, p);
> > > >  if (ret) {
> > > >  dev_err(dev, "failed to add GPIO controller\n");
> > > >  goto err0;
> > >
> > > The patch is okay and now I understand why you want it. It would have
> > > been nice if changelog told me directly.
> > >
> > My bad.
> >
> > > Can set_multiple use container_of() too? We get less differences
> > > between 4.4 and 4.4-cip that way, and it is still one-liner.
> > >
> > It could use gpio_to_priv(), but since there was an commit upstream alr=
eady I just pulled it in.
> >
> I have now posted a oneliner patch (https://patchwork.kernel.org/patch/11=
756155/)
>=20
> > Let me know if you if you are OK with the patch or I shall post a one-l=
iner.
> >
> Please drop the current patch

Done, thanks... and let me take a look.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1hxAQAKCRAw5/Bqldv6
8jOdAJ9Aev9UzW6yvpxz8n9ZXgkwR16v7gCeIXuu/GYudy4B1DMh16XjA+IJIXU=
=81FK
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

--G11nPzjhVwD8p6iksX1B
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5431): https://lists.cip-project.org/g/cip-dev/message=
/5431
Mute This Topic: https://lists.cip-project.org/mt/76607574/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--G11nPzjhVwD8p6iksX1B--
