Return-Path: <SRS0=RDBd=CW=lists.cip-project.org=bounce+64572+5448+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4474FC43461
	for <cip-dev@archiver.kernel.org>; Sun, 13 Sep 2020 21:10:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B2C21897
	for <cip-dev@archiver.kernel.org>; Sun, 13 Sep 2020 21:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LpCs2spQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B2C21897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5448+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QzJRYY4521723xIXEKD9o1cD; Sun, 13 Sep 2020 14:10:56 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.46809.1600031454710639755
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2020 14:10:55 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2A2CB1C0B82; Sun, 13 Sep 2020 23:10:51 +0200 (CEST)
Date: Sun, 13 Sep 2020 23:10:50 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org,
	pavel@denx.de, chris.paterson2@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/4] Add RZ/G1H Audio support
Message-ID: <20200913211050.GA3924@amd>
References: <20200911123201.7820-1-biju.das.jz@bp.renesas.com>
 <TYAPR01MB29901B8A1A5A2E227EF2E8BF92240@TYAPR01MB2990.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB29901B8A1A5A2E227EF2E8BF92240@TYAPR01MB2990.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: osbQMadzpApFBOjbDoOfC8Mwx4520388AA=
Content-Type: multipart/mixed; boundary="FF6CU5Ttauu12WTOhfY7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600031456;
 bh=h9rIRZikVsSWrYwkpRPK8zBU9qZEnSz/Dq9VZtfPHcQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LpCs2spQO2OE+sTsDCXNRe/G92a5Yp3CbJZ5vVg2AkPXKXgoXolN7Ji644jSXMlf3hl
 h89NfcwuhJvGJeRKICGVYE6P3npGTp/Yu273mTHuGyPzauYzBx1LkFhuq2JXpEGzVFwIC
 fxIdegZZn8Er3buxrk3j0zezrA5s0U9t174=

--FF6CU5Ttauu12WTOhfY7
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series add audio support for iWave RZ/G1H board based on
> > r8a7742 SoC to 4.4.y-cip kernel. All patches in this series
> > are cherry-picked from mainline.
> >=20
> > Lad Prabhakar (4):
> >   dt-bindings: ASoC: renesas,rsnd: Add r8a7742 support
> >   ARM: dts: r8a7742: Add audio support
> >   ARM: dts: r8a7742-iwg21d-q7: Enable SGTL5000 audio codec
> >   ARM: dts: r8a7742-iwg21d-q7: Sound DMA support via DVC on DTS
> >=20
> >  .../bindings/sound/renesas,rsnd.txt           |   1 +
> >  arch/arm/boot/dts/r8a7742-iwg21d-q7.dts       | 100 +++++++
> >  arch/arm/boot/dts/r8a7742.dtsi                | 272 ++++++++++++++++++
> >  3 files changed, 373 insertions(+)
> >=20
>=20
> I reviewd this patch series.
> Looks good to me. If If no objection, I will apply and push this.
> And I am testing on https://gitlab.com/cip-project/cip-kernel/linux-cip/-=
/pipelines/188827239.
>

Looks good to me, too. I have no objections.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9eitkACgkQMOfwapXb+vJq5wCeLI4fUwDSoPb5N7iT/fGfoDnS
ZlwAoJ0WYy6dRFb+WFzMQucGJmGEzOmX
=Bp5I
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

--FF6CU5Ttauu12WTOhfY7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5448): https://lists.cip-project.org/g/cip-dev/message=
/5448
Mute This Topic: https://lists.cip-project.org/mt/76778357/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--FF6CU5Ttauu12WTOhfY7--
