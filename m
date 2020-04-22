Return-Path: <SRS0=Ys6w=6G=lists.cip-project.org=bounce+64572+4594+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786FCC5518B
	for <cip-dev@archiver.kernel.org>; Wed, 22 Apr 2020 07:13:15 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A682074F
	for <cip-dev@archiver.kernel.org>; Wed, 22 Apr 2020 07:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="UHj+uhvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A682074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4594+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Ak9PYY4521723xcApDLqNdx3; Wed, 22 Apr 2020 00:13:14 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1671.1587538284277690755
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2020 23:51:25 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 85C891C00B7; Wed, 22 Apr 2020 08:51:20 +0200 (CEST)
Date: Wed, 22 Apr 2020 08:51:20 +0200
From: Pavel Machek <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] [PATCH 1/2] dt-bindings: display: Add idk-1110wr binding
Message-ID: <20200422065120.GA12827@amd>
References: <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1587412250-16752-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200420201554.GA15616@duo.ucw.cz>
 <OSBPR01MB359064AC4D27A061E7671640AAD50@OSBPR01MB3590.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB359064AC4D27A061E7671640AAD50@OSBPR01MB3590.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: arQMjDC64T8HrNnv9XR1r7CMx4520388AA=
Content-Type: multipart/mixed; boundary="Pu4agvcA591z71hlicp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587539594;
 bh=78dHF77PLEG1b8+VFghSjwIGlkDskznBfEUb+j9nzPE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=UHj+uhvUM/e3xUJaijqeU9cVE4bzDssYc2uZuExZzghmjazS/68IdEFmvaEDJk5xPjN
 OquDl0hxL+l4e5Fvvpg0V/dFzMC7hAQrci37lTWXuAjgPtdX6K2TUSIMsbEgSbHt6Vt5m
 arPRbACb/2wL2avlXGgQpwtVwYM4ljtYSRw=

--Pu4agvcA591z71hlicp0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Add binding for the idk-1110wr LVDS panel from Advantech.
> > >
> > > Some panel-specific documentation can be found here:
> > > https://buy.advantech.eu/Displays/Embedded-LCD-Kits-LCD-Kit-Modules/m=
odel-IDK-1110WR-55WSA1E.htm
> > >
> > > This patch is based on commit d26087162857b12bd9d0424f2dea2cd9654e50a0
> > > upstream ("dt-bindings: display: Add idk-1110wr binding") which adds =
yaml
> > > bindings.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Okay. In future, I believe we can take yaml binding, even for kernel
> > where yaml support is not included. The markup is designed to be
> > human-readable anyway.
> >
> Thanks I shall do that in future. Just for reference in case a yaml bindi=
ng has a reference to other yaml binding  so should there be a patch for co=
nverting to yaml format (for example panel.txt -> panel.yaml) ?
>=20

Goal here is to save work, and this is just a documentation, so no, I
don't believe we need to do more conversions.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6f6WgACgkQMOfwapXb+vJ9CACbBwgE93mUlSTR0W9T+u6EdTzm
x5AAn3+qjntoh2eKwpQdnI49tZHutzqr
=q7w+
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

--Pu4agvcA591z71hlicp0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4594): https://lists.cip-project.org/g/cip-dev/message=
/4594
Mute This Topic: https://lists.cip-project.org/mt/73158052/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Pu4agvcA591z71hlicp0--
