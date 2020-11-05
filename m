Return-Path: <SRS0=n2ZM=EL=lists.cip-project.org=bounce+64572+5739+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3094BC00A89
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 07:55:35 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203782071A
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 07:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BSs2xT3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203782071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5739+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uJZDYY4521723xFCezvHDlwa; Wed, 04 Nov 2020 23:55:33 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.4453.1604562932032186205
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Nov 2020 23:55:32 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 417E61C0B8A; Thu,  5 Nov 2020 08:55:27 +0100 (CET)
Date: Thu, 5 Nov 2020 08:55:26 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20201105075526.GA1658@amd>
References: <TY2PR01MB4972AB11B2F26872FFA47FD2A0EF0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB4972AB11B2F26872FFA47FD2A0EF0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6tPWVwRb7MNbkbMwl2gaSD7Ix4520388AA=
Content-Type: multipart/mixed; boundary="Fw2V0YVeM3FtSCTnfP8S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604562933;
 bh=daUILcvt83jBHB7w3I099jVndDqi9d9YqBzgwh00geo=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BSs2xT3p5MYGnxrIWYyR9OKSf1aAgmnFt5qz5mqasBk2gkcjIJutUOpjFmg7NiLlc/3
 OA+ezxqod0VAYyXhG+VWiUs3v3ZQ7Jz5UOblbwrRSNOGQ4f7FxXSSpX38eLv6HpjfZdZN
 P03aMndBHVcmW+M7NOhwvGrI0ZDvcMmhdvk=

--Fw2V0YVeM3FtSCTnfP8S
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline

--uAKRQypu60I7Lcqm
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
nth=3D11&day=3D05&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D=
37&p5=3D241&p6=3D248
>=20
> USWest	USEast	UK	DE	TW	JP
> 02:00		05:00	10:00	11:00	17:00	18:00

Daylight saving time kicked in, and 9 UTC is now 10 CET. Similarily,
other times are shifted for UK, USWest & USEast.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+jr+4ACgkQMOfwapXb+vJayQCeJ9wdSVwcOzVr9FO/lwPXUzgm
JtsAniI4q9c60047ZqzqjDGIGReLz82y
=OMIB
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

--Fw2V0YVeM3FtSCTnfP8S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5739): https://lists.cip-project.org/g/cip-dev/message=
/5739
Mute This Topic: https://lists.cip-project.org/mt/78041044/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Fw2V0YVeM3FtSCTnfP8S--
