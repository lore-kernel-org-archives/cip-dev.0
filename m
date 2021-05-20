Return-Path: <SRS0=TSQg=KP=lists.cip-project.org=bounce+64572+6470+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3478AC433B4
	for <cip-dev@archiver.kernel.org>; Thu, 20 May 2021 11:27:42 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A9260FF0
	for <cip-dev@archiver.kernel.org>; Thu, 20 May 2021 11:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A9260FF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6470+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HBLIYY4521723xP85YbJaWkI; Thu, 20 May 2021 04:27:41 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.6829.1621510059543686291
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 May 2021 04:27:40 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DABF01C0B7F; Thu, 20 May 2021 13:27:34 +0200 (CEST)
Date: Thu, 20 May 2021 13:27:34 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20210520112733.GC414@amd>
References: <TY2PR01MB4972884F2C226E1D81FD7F7EA02A9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB4972884F2C226E1D81FD7F7EA02A9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Niv1uSrwts9JteR0fRInO6eBx4520388AA=
Content-Type: multipart/mixed; boundary="OttyVGvYWQxRVNkVm7gL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1621510061;
 bh=a1c1/RtHGG4YB4F5sBYwd3BmX9a8UWvDHAURzdc3Be8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=MYH0HLD1RUmwxUqIbXuTHmAFK2Z9fqPSPxloPdQ0adTRYFFoS8s5qZtb8MF9+Jzq18b
 gG3aDJr2bMcc1/M0sUMfItxCTJJIBXnUlOkv75FluqUgcingsDgnsTvmOfjdCtWSqPCWm
 4N9ZdA5xnmLJrF89m6ocAWR1StAxxCr2wOc=

--OttyVGvYWQxRVNkVm7gL
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline

--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Kindly be reminded to attend the weekly meeting through IRC to discuss te=
chnical topics with CIP kernel today.
>=20
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 star=
ting from the first week of Apr. according to TSC meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mo=
nth=3D5&day=3D20&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248
>=20
> USWest USEast  UK         DE         TW        JP
> 02:00     05:00     10:00     11:00     17:00     18:00
>=20
> Channel:
> * irc:chat.freenode.net:6667/cip

I noticed irc issues today... and now this jumped on me:

https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DFree-Software-Exits=
-Freenode

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCmR6UACgkQMOfwapXb+vJq+ACfYzkZPCAqIapFoLjvU5ok5Aju
N3kAoLTBvfIFtrlw1y8E742eWmKc5mPD
=rv2S
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--

--OttyVGvYWQxRVNkVm7gL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6470): https://lists.cip-project.org/g/cip-dev/message=
/6470
Mute This Topic: https://lists.cip-project.org/mt/82953874/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OttyVGvYWQxRVNkVm7gL--
