Return-Path: <SRS0=yc2y=ET=lists.cip-project.org=bounce+64572+5801+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95422C55ABD
	for <cip-dev@archiver.kernel.org>; Fri, 13 Nov 2020 18:10:26 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DF4208D5
	for <cip-dev@archiver.kernel.org>; Fri, 13 Nov 2020 18:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bED4+3AV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DF4208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5801+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OaTOYY4521723xQirGfBHtq2; Fri, 13 Nov 2020 10:10:24 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.8209.1605291023567169380
 for <cip-dev@lists.cip-project.org>;
 Fri, 13 Nov 2020 10:10:24 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 40EFD1C0B7D; Fri, 13 Nov 2020 19:10:18 +0100 (CET)
Date: Fri, 13 Nov 2020 19:10:17 +0100
From: "Pavel Machek" <pavel@denx.de>
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, pavel@denx.de,
	biju.das.jz@bp.renesas.com
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{FV}, VSP, FDP1, DU, HDMI, LVDS, PWM and sound support
Message-ID: <20201113181017.GB2082@duo.ucw.cz>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSBPR01MB2983B43D8C63FD5AFE24C87892EF0@OSBPR01MB2983.jpnprd01.prod.outlook.com>
 <20201104082839.GA5821@amd>
 <OSBPR01MB5048C1E56BE8E9C5BC4CF78DAAEF0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
 <OSBPR01MB29833BA3F208593382EF399B92E60@OSBPR01MB2983.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB29833BA3F208593382EF399B92E60@OSBPR01MB2983.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: srYEDNF1Gvros9CM6LueWMjEx4520388AA=
Content-Type: multipart/mixed; boundary="lm74Q8BE3rSKg9WD5hnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605291024;
 bh=RksvMbZcH+9nrFrcanKkur4VpDke5hF5+x/PYar8EHk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bED4+3AV3sb6yOQr4uQTw22aFRMLPSTKQzhsTzm+CI6B93YhAdWlYwOELGq6HnI2uQ2
 A03Kl6WEuPlHz5f4Rz/twrLlKkV5iG94uwX5JVyUBzpIDuBLc7AFrl9TPRTHkydHKmyVb
 p2f1xcRmOfbdMzQKNbcCYgqBc8KZmPUi9fU=

--lm74Q8BE3rSKg9WD5hnq
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline

--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> Sorry, I noticed that the commits in this patch series did not have the s=
igned-off-by tag by CIP kernel maintainers.
> I force-pushed with signed-off-by tag. Please note that the commit-hash o=
f git tree will change and you
> will not be able to update it with 'git pull'. Please use 'git remote upd=
ate' or other git command instead of.
>

This is my fault; thanks for fixing it up and sorry for the confusion.

Best regards,
									Pavel

> Best regards,
>   Nobuhiro
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.o=
rg] On Behalf Of Lad Prabhakar
> > Sent: Wednesday, November 4, 2020 8:04 PM
> > To: Pavel Machek <pavel@denx.de>; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =
=E4=BF=A1=E6=B4=8B =E2=96=A1=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=
=EF=BC=A3=EF=BC=B4) <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Cc: cip-dev@lists.cip-project.org; Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{=
FV}, VSP, FDP1, DU, HDMI, LVDS, PWM and sound
> > support
> >=20
> > Hi Pavel, Nobuhiro,
> >=20
> > > -----Original Message-----
> > > From: Pavel Machek <pavel@denx.de>
> > > Sent: 04 November 2020 08:29
> > > To: nobuhiro1.iwamatsu@toshiba.co.jp
> > > Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>; =
cip-dev@lists.cip-project.org; pavel@denx.de;
> > Biju Das
> > > <biju.das.jz@bp.renesas.com>
> > > Subject: Re: [PATCH 4.19.y-cip 00/17] Renesas RZ/G2H add FCP{FV}, VSP=
, FDP1, DU, HDMI, LVDS, PWM and sound support
> > >
> > > Hi!
> > >
> > > > > This patch series adds support for following peripheral to Renesas
> > > > > RZ/G2H,
> > > > > * FCPF, FCPV
> > > > > * FDP1
> > > > > * PWM
> > > > > * DU, HDMI, LVDS
> > > > > * Sound
> > > > >
> > > > > All the patches have been cherry picked from Linux kernel
> > > > > v5.10-rc2.
> > >
> > > > >  create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-r=
zg2h-ex-idk-1110wr.dts
> > > > >
> > > >
> > > > I reviewed this patch series. I commented to 17/17.
> > > > I don't think this issue will affect our reference board, but it sh=
ould be fixed.
> > > >
> > > > And looks good to me without 17/17.
> > >
> > > I don't see any problems with patches up-to 16, and our testing
> > > passes, so I applied that.
> > >
> > Thank you.
> >=20
> > Cheers,
> > Prabhakar

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX67MCQAKCRAw5/Bqldv6
8rDHAJ9NXCp8uNqBXB/zGo0cM4KcOsuFqgCeLe9/egfwZmsq2Ro8eMR3rDcfHqA=
=h3it
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--

--lm74Q8BE3rSKg9WD5hnq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5801): https://lists.cip-project.org/g/cip-dev/message=
/5801
Mute This Topic: https://lists.cip-project.org/mt/78011684/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--lm74Q8BE3rSKg9WD5hnq--
