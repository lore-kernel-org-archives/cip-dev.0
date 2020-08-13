Return-Path: <SRS0=0uiB=BX=lists.cip-project.org=bounce+64572+5121+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2AAC433E1
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 20:48:51 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AA420675
	for <cip-dev@archiver.kernel.org>; Thu, 13 Aug 2020 20:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="v9eTRMGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AA420675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5121+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id emd8YY4521723xyVe7E1xI6s; Thu, 13 Aug 2020 13:48:49 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4515.1597351727799052873
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2020 13:48:48 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 27C191C0BD2; Thu, 13 Aug 2020 22:48:43 +0200 (CEST)
Date: Thu, 13 Aug 2020 22:48:42 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH] drm: of: Fix linking when CONFIG_OF is not set
Message-ID: <20200813204842.GA24086@duo.ucw.cz>
References: <20200811144040.4398-1-biju.das.jz@bp.renesas.com>
 <20200812192435.GA19363@amd>
 <TYBPR01MB5309E07DED8A1ACFB0DDA8BA86430@TYBPR01MB5309.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYBPR01MB5309E07DED8A1ACFB0DDA8BA86430@TYBPR01MB5309.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QBPYRIp1I7ePyckUrRLMBLoYx4520388AA=
Content-Type: multipart/mixed; boundary="TL3zCXBhz8A4ErzpWz4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597351729;
 bh=c4h2Sdy/BoFkPApXUfsAXnR6jcMGz3sAvXhMWTw7ABw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=v9eTRMGD1sbwacmsMwKx9EeMWMZiNVXmr9dK+bt3AdVoCNmd6W1E9cQ9ZwIgU4vmyiV
 8PRfuQE3pUs1l9+bs9L+2vxXX2gjvh2960MtyAYuz+fhmpyQCZCottWUZ87xkradbfrNQ
 tXWhAVh8QfYY3seuTtTTjPd02sEl4gEaj4Y=

--TL3zCXBhz8A4ErzpWz4u
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-08-13 06:39:55, Biju Das wrote:
> Hi Pavel,
>=20
> Thanks for the feedback.
>=20
> > Subject: Re: [PATCH] drm: of: Fix linking when CONFIG_OF is not set
> >
> > Hi!
> >
> > I assume this patch is for 4.19-cip?
>=20
> Yes, it is for 4.19-cip.
>=20
> > > commit 528d06d41b80a4acb2a9efd33bfc87495147f75e upstream.
> > >
> > > The new helper drm_of_lvds_get_dual_link_pixel_order() introduced in
> > > commit 6529007522de has a fallback stub when CONFIG_OF is not set, but
> > > the stub is declared in drm_of.h without a static inline. This causes
> > > multiple definitions of the function to be linked when the CONFIG_OF
> > > option isn't set. Fix it by making the stub static inline.
> >
> > So this is pretty obvious, and I'll likely apply it.
>=20
> Thanks for applying it.

Applied.
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXzWnKgAKCRAw5/Bqldv6
8puSAJ9CWMbsaK7tuAXzoV4Qr4Tt0Bs8rACgiOQ9Oh8iP970aWh3PFanDNiOMuI=
=qlfm
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--TL3zCXBhz8A4ErzpWz4u
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5121): https://lists.cip-project.org/g/cip-dev/message=
/5121
Mute This Topic: https://lists.cip-project.org/mt/76127518/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--TL3zCXBhz8A4ErzpWz4u--
