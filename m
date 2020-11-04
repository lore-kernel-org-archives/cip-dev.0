Return-Path: <SRS0=e0ba=EK=lists.cip-project.org=bounce+64572+5734+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB929C2D0A3
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 08:28:49 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F6DF20781
	for <cip-dev@archiver.kernel.org>; Wed,  4 Nov 2020 08:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="h8KNn/Di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6DF20781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5734+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tiqWYY4521723xvNEnl8MBQe; Wed, 04 Nov 2020 00:28:47 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9883.1604478526465532695
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2020 00:28:47 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id D1F901C0B77; Wed,  4 Nov 2020 09:28:41 +0100 (CET)
Date: Wed, 4 Nov 2020 09:28:39 +0100
From: "Pavel Machek" <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{FV}, VSP, FDP1, DU, HDMI, LVDS, PWM and sound support
Message-ID: <20201104082839.GA5821@amd>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSBPR01MB2983B43D8C63FD5AFE24C87892EF0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB2983B43D8C63FD5AFE24C87892EF0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7WgYjoQZqeWWmKa0RvLRKHL5x4520388AA=
Content-Type: multipart/mixed; boundary="3TSkqr8mzo7NrxITgnAP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604478527;
 bh=MyF5PE7x+G4lXS+XfLYzV/zjickikCLT3MLSC4iVpqo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=h8KNn/Diajbkmb56C4SvegJN2hc7kDdbUltXuIVQzBT15/sx/ynIFce584MFDI1KYDs
 kTYYGzW81en6clDB/grJHoyNtmS1n4vAYrw7YoX223+owPkkz4dhX06VV1yrSGZI1S262
 4+OTUqAPPiEkWLW/YexYaJ4KOJ1aiSf9XIU=

--3TSkqr8mzo7NrxITgnAP
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline

--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series adds support for following peripheral to Renesas
> > RZ/G2H,
> > * FCPF, FCPV
> > * FDP1
> > * PWM
> > * DU, HDMI, LVDS
> > * Sound
> >=20
> > All the patches have been cherry picked from Linux kernel
> > v5.10-rc2.

> >  create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-e=
x-idk-1110wr.dts
> >=20
>=20
> I reviewed this patch series. I commented to 17/17.
> I don't think this issue will affect our reference board, but it should b=
e fixed.
>=20
> And looks good to me without 17/17.=20

I don't see any problems with patches up-to 16, and our testing
passes, so I applied that.

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+iZjcACgkQMOfwapXb+vIIEgCfbaG8DJ1hhszOQSSCsEtomjtN
+NEAnjekfqQRKANemE9bBysddEe549PQ
=4bEA
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

--3TSkqr8mzo7NrxITgnAP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5734): https://lists.cip-project.org/g/cip-dev/message=
/5734
Mute This Topic: https://lists.cip-project.org/mt/78011684/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3TSkqr8mzo7NrxITgnAP--
