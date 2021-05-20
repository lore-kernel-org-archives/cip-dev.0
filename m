Return-Path: <SRS0=mM+O=KP=lists.cip-project.org=bounce+64572+6469+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA8C433B4
	for <cip-dev@archiver.kernel.org>; Thu, 20 May 2021 08:59:21 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F9A8610CB
	for <cip-dev@archiver.kernel.org>; Thu, 20 May 2021 08:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9A8610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6469+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id i3YLYY4521723xNxebM0wD83; Thu, 20 May 2021 01:59:19 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.5758.1621501158256705573
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 May 2021 01:59:18 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 064A51C0B7F; Thu, 20 May 2021 10:59:14 +0200 (CEST)
Date: Thu, 20 May 2021 10:59:13 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20210520085913.GA25986@amd>
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
X-Gm-Message-State: 9SiJ0tlf3o4ZTe5jiR2BHTeJx4520388AA=
Content-Type: multipart/mixed; boundary="Smv6co1FaD02bneGm5zW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1621501159;
 bh=0OTUuM9eXgITA6nbmaMbKv1yYqt2jGE5LuV7HKIddds=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=YkxPwNuy20FipjT5W3SCaaS6+VXA/KAEMcgqnM7Df7Bw31+7GFA8dG663wWfWa67Jvi
 4171fjBZ4mayOap9b5+AlTlifRXgufILMLGtaPJHzw8BKhfL5l5drSTEIlVikK7xNoesR
 kq7S9ZWCYwmjwvDR/HJf0ZejWFs1eWqpQQU=

--Smv6co1FaD02bneGm5zW
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
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

I have trouble connecting to irc.freenode.net...

In case it works for others... I worked on 5.10.37 and 5.10.38
reviews.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmCmJOAACgkQMOfwapXb+vJe8QCgxL08BtQF6fUuRPLA9I1SKm27
LfgAoIglhv7Z9HxysPeU0hlAzKyWuizH
=l60u
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

--Smv6co1FaD02bneGm5zW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6469): https://lists.cip-project.org/g/cip-dev/message=
/6469
Mute This Topic: https://lists.cip-project.org/mt/82953874/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Smv6co1FaD02bneGm5zW--
