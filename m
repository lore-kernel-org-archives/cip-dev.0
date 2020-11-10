Return-Path: <SRS0=lG9e=EQ=lists.cip-project.org=bounce+64572+5785+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BB9C388F7
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 07:54:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A6F2080A
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 07:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DdMGLh+9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A6F2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5785+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fdGmYY4521723xoFSmDdaUy1; Mon, 09 Nov 2020 23:54:41 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.24848.1604994880516966029
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2020 23:54:41 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 732DF1C0B77; Tue, 10 Nov 2020 08:54:32 +0100 (CET)
Date: Tue, 10 Nov 2020 08:54:31 +0100
From: "Pavel Machek" <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/14] Renesas RZ/G1H add support for CAN, IPMMU, QSPI, RTC
Message-ID: <20201110075431.GA1029@amd>
References: <20201109155011.10291-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSBPR01MB2983D2D88A4E9CE78F41627692E90@OSBPR01MB2983.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2983D2D88A4E9CE78F41627692E90@OSBPR01MB2983.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: e3ldIPz57jIdmnIEHtuDpOCjx4520388AA=
Content-Type: multipart/mixed; boundary="zSeT5jpEcup0JB9uJ3F9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604994881;
 bh=bBKsiVkmAhbcX97/HNYwGii4Fe5CgjcpUPXRGURAhfE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DdMGLh+9erjVuvBzVeKx+sfGGXsUn7TSNr/b52vx2WircSN9Ag4ncLE7IzrwtmwjFdv
 pz0JQ/FfI6focAzBYQAROT40PgPFw5sIWjBaGpRcigNPfUZL5SFTfhUvsFfGeGiiW8E0K
 5wqRkPmgdSKFgL7i+6E+XR1koMOO2fM420U=

--zSeT5jpEcup0JB9uJ3F9
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >  .../devicetree/bindings/net/can/rcar_can.txt  |   3 +-
> >  .../devicetree/bindings/spi/spi-rspi.txt      |   1 +
> >  .../boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts    |  11 ++
> >  arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       |  52 ++++++++
> >  arch/arm/boot/dts/r8a7742-iwg21m.dtsi         |  79 +++++++++++-
> >  arch/arm/boot/dts/r8a7742.dtsi                |  90 ++++++++++++++
> >  drivers/pinctrl/sh-pfc/pfc-r8a7790.c          | 112 +++++++++++++++++-
> >  drivers/spi/spi-sh-msiof.c                    |  92 +++++++++++---
> >  8 files changed, 418 insertions(+), 22 deletions(-)
>=20
> I reviewed this patch series, there is not issue.
> I can apply and push if there is no objection.

I don't see any problems either, so no objections from me.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+qRzcACgkQMOfwapXb+vKYxACffcFu1Kg7OEBnrUAHPCCuO7/2
5nAAn11OQfAMHTczvfUZWiwzrJSez0aD
=pTVI
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--

--zSeT5jpEcup0JB9uJ3F9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5785): https://lists.cip-project.org/g/cip-dev/message=
/5785
Mute This Topic: https://lists.cip-project.org/mt/78138424/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zSeT5jpEcup0JB9uJ3F9--
