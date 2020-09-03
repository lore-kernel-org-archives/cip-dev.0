Return-Path: <SRS0=cFQN=CM=lists.cip-project.org=bounce+64572+5406+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659C1C433E2
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 17:54:39 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72702072A
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 17:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VKB1pwH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72702072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5406+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id V5sJYY4521723xPITfVBzNQ2; Thu, 03 Sep 2020 10:54:38 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.20017.1599155676611405399
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 10:54:37 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 57FDB1C0B76; Thu,  3 Sep 2020 19:54:33 +0200 (CEST)
Date: Thu, 3 Sep 2020 19:54:31 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] gpio: rcar: use gpiochip data pointer
Message-ID: <20200903175431.GC7795@duo.ucw.cz>
References: <20200903141052.12720-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200903141052.12720-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fsva0tPPacpDZUGLyQPKdcVPx4520388AA=
Content-Type: multipart/mixed; boundary="SkLmvHL8Gj5y8waGHatE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599155678;
 bh=wWXJcuUDDQ9ZykC+1wnNB21THXyUbRILvcvgmuHz2Xo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VKB1pwH0Byjd27No0PxjXyHtXCG3dY7RqjeXvA2FPOTSMANNLDVsWhlVmF9kXkcpip2
 zNF212kPllyjxtnNuhYQWCbr+OrYi3pZo/FswRLcRPRP6YqfrLSRoGSNik2xNgfQr4cwO
 50SAo7n/WaZiE05ynpwnnFL5/AJpQdmXeQ4=

--SkLmvHL8Gj5y8waGHatE
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline

--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This makes the driver use the data pointer added to the gpio_chip
> to store a pointer to the state container instead of relying on
> container_of().

Okay, so this is a cleanup that makes sense for mainline.

> [PL: Fixes 6e52cced1aa58 ("gpio: rcar: Implement  gpiochip.set_multiple()=
")]

Does it fix set_multiple? ... seems so.

Fixing set_multiple is possible with this oneliner, right?

> @@ -541,7 +532,7 @@ static int gpio_rcar_probe(struct platform_device *pd=
ev)
>  	irq_chip->irq_release_resources =3D gpio_rcar_irq_release_resources;
>  	irq_chip->flags	=3D IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
> =20
> -	ret =3D gpiochip_add(gpio_chip);
> +	ret =3D gpiochip_add_data(gpio_chip, p);
>  	if (ret) {
>  		dev_err(dev, "failed to add GPIO controller\n");
>  		goto err0;

The patch is okay and now I understand why you want it. It would have
been nice if changelog told me directly.

Can set_multiple use container_of() too? We get less differences
between 4.4 and 4.4-cip that way, and it is still one-liner.

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX1Et1wAKCRAw5/Bqldv6
8q2gAJ0XjbV7Mcaahb1kwn6h+FVRHC1bQgCgi5MMHU8B6ODotzfIqxvFCeBM+W4=
=i/8A
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--

--SkLmvHL8Gj5y8waGHatE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5406): https://lists.cip-project.org/g/cip-dev/message=
/5406
Mute This Topic: https://lists.cip-project.org/mt/76607574/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--SkLmvHL8Gj5y8waGHatE--
