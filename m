Return-Path: <SRS0=q90H=7V=lists.cip-project.org=bounce+64572+4770+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85901C433DF
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 21:30:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C827D20760
	for <cip-dev@archiver.kernel.org>; Mon,  8 Jun 2020 21:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="QdcZep+K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C827D20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4770+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Pe7jYY4521723xvRKzFjudlj; Mon, 08 Jun 2020 14:30:25 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1158.1591651823378887740
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2020 14:30:24 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 25A3A1C0C0D; Mon,  8 Jun 2020 23:30:20 +0200 (CEST)
Date: Mon, 8 Jun 2020 23:30:19 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Johnson CH Chen =?utf-8?B?KOmZs+aYreWLsyk=?= <JohnsonCH.Chen@moxa.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/3] ARM: dts: am335x: Replace numeric pinmux address with macro defines
Message-ID: <20200608213019.GA2851@amd>
References: <HK2PR01MB3281084A8DA1542518F65818FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <HK2PR01MB32818C637F6FB1F0AE969A95FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
MIME-Version: 1.0
In-Reply-To: <HK2PR01MB32818C637F6FB1F0AE969A95FA850@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bRj4ZPDtjOE22IxuvHRAQrhux4520388AA=
Content-Type: multipart/mixed; boundary="3YcCBW9ekIhotRrRK46J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591651825;
 bh=1N54kSBmGYgAEIKF5rrnf7v3dONJ20a1mUyDGOiGwUY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=QdcZep+KKLrPPlWz/kZAxE3vzZXswfwNPM1Qif0nuJcNaC1oX1a3qwYtR/jik+wF3ZO
 q5XOCE0gD3b/FqeyxrgGHOj6Hq+I8HkqEiN9syEKoqmQpVAQ+t3IvhDfOfI6xxtcHfbI7
 QxnjbiUpmcEN6YvmqbZLJQ+q/pM9TZn3zgs=

--3YcCBW9ekIhotRrRK46J
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Tony Lindgren (1):
> >   ARM: dts: am33xx: Added AM33XX_PADCONF macro
> >
> >  arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts | 116 +++++++++++------=
-----
> >  include/dt-bindings/pinctrl/am33xx.h           | 130 +++++++++++++++++=
+++++++-
> >  include/dt-bindings/pinctrl/omap.h             |   1 +
> >  3 files changed, 188 insertions(+), 59 deletions(-)
> >
> These should be the following:
>=20
> Christina Quast (3):
>   ARM: dts: am33xx: Added macros for numeric pinmux addresses
>   ARM: dts: am33xx: Added AM33XX_PADCONF macro
>   ARM: dts: am335x: moxa-uc-8100-me-t: Replaced register offsets with
>     defines

There's nothing obviously wrong with the patches (and they won't break
anything but am335x-moxa platform, so they are low risk).

On the other hand, I don't see any obvious benefit. Whether we use hex
constants or symbolic constants affects readability, but has no effect
on functionality.

Do you have any patches on top of these that rely on symbolic
constants in the dts? Are there any changes in the generated .dtb?
What is the benefit of this series (besides cleanup)?

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7eresACgkQMOfwapXb+vKaVQCeKIgfKS5wwXUP4o/E6ATVJBAJ
90oAoMBNxC7M9WNNpss0wb85ieQfdBdQ
=/vNa
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

--3YcCBW9ekIhotRrRK46J
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4770): https://lists.cip-project.org/g/cip-dev/message=
/4770
Mute This Topic: https://lists.cip-project.org/mt/74749053/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--3YcCBW9ekIhotRrRK46J--
