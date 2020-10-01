Return-Path: <SRS0=61Sv=DI=lists.cip-project.org=bounce+64572+5489+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D68C4727C
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 08:11:26 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C0C208B8
	for <cip-dev@archiver.kernel.org>; Thu,  1 Oct 2020 08:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="gUyi/uha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C0C208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5489+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 1BxhYY4521723xAcNXpvAvGV; Thu, 01 Oct 2020 01:11:24 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.7580.1601539881126975960
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Oct 2020 01:11:21 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 712541C0BA1; Thu,  1 Oct 2020 10:11:14 +0200 (CEST)
Date: Thu, 1 Oct 2020 10:11:13 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20201001081113.GA30554@amd>
References: <TY2PR01MB49725DFFB3B4CD4E0A1777E0A0300@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB49725DFFB3B4CD4E0A1777E0A0300@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3TMuq8FS8kKHG0jugVIIgDOvx4520388AA=
Content-Type: multipart/mixed; boundary="d3q1yE0XeaUJMgz0Bulx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1601539884;
 bh=HDZhkLe6O7cIeh2zlU+82vNok4trCpx+xwv1MoTwe8I=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=gUyi/uhaTRUa8RBhWJQITN/NSZJWr0BoGQDrn5xQMWBLNaPNSIcev9C2UBx+LSWiehY
 ROWkQRsArmWK/ot8HcJ+J959lfSxbPBdQ+FNNfnH66xk5nq1b2c8BZpkAzxsDgCkcPq1w
 ck5GgEarpSOIROgvtpg5r2V+CXcKkyfg3pg=

--d3q1yE0XeaUJMgz0Bulx
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline

--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Kindly be reminded to attend the weekly meeting through IRC to discuss te=
chnical topics with CIP kernel today.
>=20
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 star=
ting from the first week of Apr. according to TSC meeting*
> https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2020&mo=
nth=3D10&day=3D1&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248
>=20
> USWest	USEast	UK	DE	TW	JP
> 02:00	05:00	10:00	11:00	17:00	18:00

I may be able to make it, but in case I will not:

I reviewed 4.19.148 and 4.19.149.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl91jyEACgkQMOfwapXb+vI38wCgpF/1iqL75e85rTRjbKOhskZb
dOoAoKEyn6QyeIWR4CQj9Zf76M5SgplQ
=+CYu
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

--d3q1yE0XeaUJMgz0Bulx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5489): https://lists.cip-project.org/g/cip-dev/message=
/5489
Mute This Topic: https://lists.cip-project.org/mt/77230659/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--d3q1yE0XeaUJMgz0Bulx--
