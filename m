Return-Path: <SRS0=H/dz=LL=lists.cip-project.org=bounce+64572+6526+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7503FC2B9F4
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 06:50:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88F1611BE
	for <cip-dev@archiver.kernel.org>; Thu, 17 Jun 2021 06:50:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88F1611BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6526+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id p4grYY4521723xqgwtdYquTp; Wed, 16 Jun 2021 23:50:06 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.4358.1623912604680294939
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Jun 2021 23:50:05 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 7D17B1C0B76; Thu, 17 Jun 2021 08:49:52 +0200 (CEST)
Date: Thu, 17 Jun 2021 08:49:51 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <20210617064951.GA18475@amd>
References: <TY2PR01MB49722592CFA2D688628B3328A00E9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB49722592CFA2D688628B3328A00E9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: pbxlNONEpOrixv91LPXfF2iSx4520388AA=
Content-Type: multipart/mixed; boundary="PZpsXPZcAPorzmn8Qwyy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623912606;
 bh=PUtYpROi3SoqqStMc38Z2aRSivlVeAnScFFkgjMOWUo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PqAC2cZcuCF2B+XRJPUsbn29p9rGcxWeY4dq6IdqJCqaUL7vzhlzLwpNWeMBvY8o4Dy
 LsLv/iZqtadHWqN9nii3TEASHgj0zNYLJ8/qdZnennrrFI7OCEw9PFiyPfYyWX2bh9uF3
 OQK6HVloj7+GoIWMwuSDZnKst/STMAdcNvA=

--PZpsXPZcAPorzmn8Qwyy
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Kindly be reminded to attend the weekly meeting through IRC to discuss te=
chnical topics with CIP kernel today.
>=20
> Please note that we already moved from Freenode to libera.chat, and our c=
hannel is the following:
>               irc:irc.libera.chat:6667/cip
>=20
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 star=
ting from the first week of Apr. according to TSC meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mo=
nth=3D6&day=3D17&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248
>=20
> USWest USEast  UK         DE         TW        JP
> 02:00     05:00     10:00     11:00     17:00     18:00

I'm not sure if I'll be able to make it today.

=46rom last meeting, I reviewed 5.10.43, .44 and .45. I attempted to
create -rt releases, but it proved to be tricky, and it may be better
to wait for next -rt releases to do the update.

Best regads,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmDK8I8ACgkQMOfwapXb+vIt0ACgtZJvI08gcjsQNRUGDtCU4yKf
zfAAnjcBrXfTENluQ4hCW5DyBonuwp/o
=C3PV
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--PZpsXPZcAPorzmn8Qwyy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6526): https://lists.cip-project.org/g/cip-dev/message=
/6526
Mute This Topic: https://lists.cip-project.org/mt/83595580/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PZpsXPZcAPorzmn8Qwyy--
