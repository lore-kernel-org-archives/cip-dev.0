Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D3CC433EF
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 22:12:56 +0000 (UTC)
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.20098.1643235174802364180
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 14:12:55 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=neutral (domain: denx.de, ip: 46.255.230.98, mailfrom: pavel@denx.de)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3A4D51C0B98; Wed, 26 Jan 2022 23:12:50 +0100 (CET)
Date: Wed, 26 Jan 2022 23:12:49 +0100
From: Pavel Machek <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH 5.10.y-cip] can: rcar_canfd: rcar_canfd_channel_probe():
 make sure we free CAN network device
Message-ID: <20220126221249.GB26019@duo.ucw.cz>
References: <20220126202213.31975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <20220126202213.31975-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 22:12:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7492


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 72b1e360572f9fa7d08ee554f1da29abce23f288 upstream.
>=20
> Make sure we free CAN network device in the error path. There are
> several jumps to fail label after allocating the CAN network device
> successfully. This patch places the free_candev() under fail label so
> that in failure path a jump to fail label frees the CAN network
> device.

Are they? I see fail label being unused in our 5.10 tree (but mainline
uses it and I don't think we need it removed).

But more importantly... staring at the code some more:

	err =3D register_candev(ndev);
	if (err) {
                dev_err(&pdev->dev,
	                "register_candev() failed, error %d\n", err);
	        goto fail_candev;
        }
	spin_lock_init(&priv->tx_lock);
        devm_can_led_init(ndev);
	gpriv->ch[priv->channel] =3D priv;
        dev_info(&pdev->dev, "device registered (channel %u)\n", priv->chan=
nel)\
;
	return 0;

Device is registered before being fully ready, and I don't see
anything preventing the device from being used. Should register_candev
be done last?

(And sorry for not noticing that earlier).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYfHHYQAKCRAw5/Bqldv6
8m79AJ9NogNY3UoKh/UfpiYsxDDfnxKJhgCdEqLW73Rak+xrLFuu0eoKyYuKJO8=
=oE2g
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--

