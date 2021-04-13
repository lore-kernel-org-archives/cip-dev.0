Return-Path: <SRS0=6bzi=JK=lists.cip-project.org=bounce+64572+6368+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E736C433ED
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 11:22:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7960361249
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 11:22:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7960361249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6368+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PgXJYY4521723xTa7fioAPsD; Tue, 13 Apr 2021 04:22:05 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.7526.1618312923818370402
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Apr 2021 04:22:04 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5E8751C0B7C; Tue, 13 Apr 2021 13:21:59 +0200 (CEST)
Date: Tue, 13 Apr 2021 13:21:58 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] drm: rcar-du: Fix crash when using LVDS1 clock for CRTC
Message-ID: <20210413112158.GA13447@duo.ucw.cz>
References: <20210409161436.10953-1-biju.das.jz@bp.renesas.com>
 <20210413101210.GC26782@amd>
 <OS0PR01MB592230BE36B888893653B0D7864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OS0PR01MB592230BE36B888893653B0D7864F9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: zzM1FqYZzhQbmRfPmsHqIXzgx4520388AA=
Content-Type: multipart/mixed; boundary="ZuA1dBIAkCm8kLnxg5z2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618312925;
 bh=kcgWCbVSqztVKTjs+pXXpe080Rz2mVQ2o6o8Nc5/z/0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=OuC4T+cOnrxQT9mRR3Rm9ZoWQL29csVilRIw784jh9LvngGlHOI2l6o8umkXI7b4TOh
 pzUKKiLl9lK7jluofvR34Eo5/KvnjCvdxy2cKwB+LcvjhgJ297UIV53YLO8+mNgmILHqi
 +jrM6wBQ0E/2r1AKpIqFBS/B2qMux+RvN8E=

--ZuA1dBIAkCm8kLnxg5z2
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > On D3 and E3 platforms, the LVDS encoder includes a PLL that can
> > > generate a clock for the corresponding CRTC, used even when the CRTC
> > > output to a non-LVDS port. This mechanism is supported by the driver,
> > > but the implementation is broken in dual-link LVDS mode. In that case,
> > > the LVDS1 drm_encoder is skipped, which causes a crash when trying to
> > > access its bridge later on.
> > >
> > > Fix this by storing bridge pointers internally instead of retrieving
> > > them from the encoder. The rcar_du_device encoders field isn't used
> > > anymore and can be dropped.
> >=20
> > The patch looks okay to me. I'll test it and can apply it if it works
> > okay.
> >=20
> > But I don't believe it is in our 5.10, so I'd like it to be submitted f=
or
> > 5.10, too.

Applied and pushed out.

> > Or just tell me it is okay and I'll apply it there, too.
>=20
> Please apply  to 5.10-cip as well, since it is present in 5.10 stable.

Aha, ok, that changs things. (I checked our trees but not stable).

In such case, nothing needs to be done at the moment, and it is easier
to wait till we merge that through the stable tree.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYHV+1gAKCRAw5/Bqldv6
8sCEAJ9IAkWltaD8T0poW1iMJXH0RXNmyQCcDLnm5KBKSFvk8Q8Ogn2HYrAwsdc=
=+5Np
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--ZuA1dBIAkCm8kLnxg5z2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6368): https://lists.cip-project.org/g/cip-dev/message=
/6368
Mute This Topic: https://lists.cip-project.org/mt/82032629/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZuA1dBIAkCm8kLnxg5z2--
