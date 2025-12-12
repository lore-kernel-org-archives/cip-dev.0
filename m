Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A42D49224
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 13:00:45 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12013.1765544441719301899
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 05:00:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=hlz2Wvnz;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35A6F1038C120;
	Fri, 12 Dec 2025 14:00:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1765544437; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=F1jX2ZfyozDp2N0PB0NE3HrrUuJa4IKoJ54dqDxCJrg=;
	b=hlz2Wvnzvu8H/PZ3CI6qdrOS+nvbDurhnue7NZLg/VqBJydL2RkGTCWnNQol3o1SKnE0X6
	kc2O2ZuBTY1YXsE2bhZ3CvcnEx7lLkqxRRNwTdmv2pyRC7btAUPG/vKtgnYjwAtL3qq1Mc
	RfB2nEslF4HjX3ovZ6eklhdrtZX9NvWiqaTDCU5n2r+iZBx3JQFIV9m0a7xpk7SLLsOav8
	rpI2r/TjvIc2Ocs7xSuji+ZWeP2VZZ+n1f0pDbNv5jA792o1C3ebq/ZHmdppRYDL7RuJHZ
	YzX7XKFjl3L4nOhUYiMkQrM4KQVIrd1THqPKVg9M+hPcsC7juLH6QCXuEi0l7A==
Date: Fri, 12 Dec 2025 14:00:31 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 6.12.y-cip 25/38] pinctrl: renesas: Add support for RZ/T2H
Message-ID: <aTwR71CtNKZxBrRj@duo.ucw.cz>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251205143258.13748-26-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aV/isvOMg+9uaQiZ"
Content-Disposition: inline
In-Reply-To: <20251205143258.13748-26-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 13:00:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20986


--aV/isvOMg+9uaQiZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
>=20
> commit 34d4d093077a5c60d452a2f42d0c1a08e55b8614 upstream.
>=20
> Add a pin control and GPIO driver for the Renesas RZ/T2H (R9A09G077)
> SoC.


> +static int rzt2h_gpio_register(struct rzt2h_pinctrl *pctrl)
> +{
=2E..> +	ret =3D devm_gpiochip_add_data(dev, chip, pctrl);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "gpiochip registration failed\n");
> +
> +	return ret;
> +}

This is strange way of saying "return 0".

Best regards,
								Pavel
--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--aV/isvOMg+9uaQiZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaTwR7wAKCRAw5/Bqldv6
8kuUAJ9Mm8CdVFML7E16NddxtMuGmjJU2QCgqD7QxUPHRdCiFGhEXWZhNDM5VPI=
=yczP
-----END PGP SIGNATURE-----

--aV/isvOMg+9uaQiZ--

