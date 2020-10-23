Return-Path: <SRS0=0e2w=D6=lists.cip-project.org=bounce+64572+5672+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2D4C55178
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 20:34:23 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DC621D6C
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 20:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="JqQrf4Vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DC621D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5672+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ROSGYY4521723xmEhsJPQ63d; Fri, 23 Oct 2020 13:34:21 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.2707.1603485260503415148
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 13:34:20 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EF3BD1C0B8F; Fri, 23 Oct 2020 22:34:18 +0200 (CEST)
Date: Fri, 23 Oct 2020 22:34:18 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 4/6] PCI: rcar: Add endpoint mode support
Message-ID: <20201023203418.GB10156@duo.ucw.cz>
References: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201023165805.1910-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201023194131.GC6002@duo.ucw.cz>
 <OSBPR01MB50487F84AAFD3B0C556CBE33AA1A0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB50487F84AAFD3B0C556CBE33AA1A0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dLYfT3ZFoAnQKDUScWosiLlUx4520388AA=
Content-Type: multipart/mixed; boundary="7T4LkgmusQbSI8rZGQ4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603485261;
 bh=q3qUKAFbume7C/6w/qCUN6QUAhU+mjnPgytDlVQaIKc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=JqQrf4VddsGRTvdm3rF4IoIrxu4OorwHyTjm7l42TOYXWFRez90t7kQLlB+ZUAJ3H5u
 0XokmX8DTeC5zig4NXpmsCBZKrOBlZDjk0UogZURScPH7sMHZ0rTAAXMTGVXVLli7pSW+
 HeYAuznnrJYlp/BQt4BN++E8Bx7haZCGMDk=

--7T4LkgmusQbSI8rZGQ4a
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > +	pm_runtime_enable(dev);
> > > +	err =3D pm_runtime_get_sync(dev);
> > > +	if (err < 0) {
> > > +		dev_err(dev, "pm_runtime_get_sync failed\n");
> > > +		goto err_pm_disable;
> > > +	}
> >=20
> > I believe this should go to pm_put.
> >=20
> Agreed pm_runtime_get_sync() increments the runtime PM usage counter even=
 when it fails. I'll fix this in upstream first and then backport.
>

Thank you. This one is worth backporting, I don't believe we need the
other cleanups in -cip.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5M+SgAKCRAw5/Bqldv6
8ur1AKCs/s/a2oLyMo9Xblyz+rAO25UEKgCgmgtim4hHV3pQZ+JfGIhYkehAK2M=
=Joby
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

--7T4LkgmusQbSI8rZGQ4a
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5672): https://lists.cip-project.org/g/cip-dev/message=
/5672
Mute This Topic: https://lists.cip-project.org/mt/77756297/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7T4LkgmusQbSI8rZGQ4a--
