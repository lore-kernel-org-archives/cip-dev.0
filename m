Return-Path: <SRS0=rlbx=HN=lists.cip-project.org=bounce+64572+6168+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC90C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 09:20:40 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C30A64E6F
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 09:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C30A64E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6168+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jz8fYY4521723xcXAvh210Gm; Thu, 11 Feb 2021 01:20:38 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.6372.1613035237657394688
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Feb 2021 01:20:38 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 378541C0B8A; Thu, 11 Feb 2021 10:20:32 +0100 (CET)
Date: Thu, 11 Feb 2021 10:20:31 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20210211092031.GA1881@duo.ucw.cz>
References: <TY2PR01MB4972B6A2FC89273767335506A08C9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB4972B6A2FC89273767335506A08C9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Dc7P1BBEvZWRBiI3ahxHvNsEx4520388AA=
Content-Type: multipart/mixed; boundary="NvI5nh5AM0apnHaSaTlR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613035238;
 bh=GBzKeU+v/fS6qNnmzzV4FsBsmnvzSE15w34iNdGVJG4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=a8o088HXGqMEqZ2kFw3N65tVHJ4gXQLTDMuApy2qrNBdUcG2LNAVLHToNNhprBGAHJs
 s4g2pc+yQFZxHZ5nKsO1yyZ4Rk9VeJUTkNbeFdenehbttYzvJdfM7aY3zFmQ30vwzg5ym
 mJL/oetGWop2sPXDJiU+MJGHFwnhpQ4ncmw=

--NvI5nh5AM0apnHaSaTlR
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline

--LQksG6bCIzRHxTLp
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
nth=3D2&day=3D11&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248
>=20
> USWest	USEast	UK	DE	TW	JP
> 01:00	04:00	9:00	10:00	17:00	18:00
>

I missed the meeting, I'm sorry. I'll go through the meeting logs.

My activity for last week were reviews on 5.10.14 and 5.10.15 and
corresponding older kernels.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYCT23wAKCRAw5/Bqldv6
8oSLAJ9FLK0tGlF0RLugr36OvDh8mUthuACgkh3OvNFG2GUb+Wqje5cDJR3Houg=
=lWAn
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--

--NvI5nh5AM0apnHaSaTlR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6168): https://lists.cip-project.org/g/cip-dev/message=
/6168
Mute This Topic: https://lists.cip-project.org/mt/80547932/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NvI5nh5AM0apnHaSaTlR--
