Return-Path: <SRS0=tn6u=AG=lists.cip-project.org=bounce+64572+4811+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF868C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 07:00:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86EBA207E8
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 07:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LhzRge+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EBA207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4811+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fUmkYY4521723xr5MfQCUvym; Thu, 25 Jun 2020 00:00:53 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.5185.1593068451859284816
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 00:00:52 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 908D81C0C0F; Thu, 25 Jun 2020 09:00:47 +0200 (CEST)
Date: Thu, 25 Jun 2020 09:00:47 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20200625070047.GA30576@duo.ucw.cz>
References: <TY2PR01MB49729620B56F4A404F4E709AA0920@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB49729620B56F4A404F4E709AA0920@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Zz6oi8IYkRVbKzJYS4NeMnWWx4520388AA=
Content-Type: multipart/mixed; boundary="8Rk4cv0jGHw6zhnJvfxp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593068453;
 bh=R3jU5wtdDGpU5ZP8/vqjejQGWHjxW5BthBbSD7OMVV8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LhzRge+7QwqWlrxNHSCmJvzLSipLSVXAuN+kE9mde8MTqPT9cAaepDobM/u36a93n//
 ytAh7/swh5VCglxo4F/rkGZjF4KbLkyUJEnzeJEicrv48+UpO2s9RYo9INphI5rMLC42r
 l768EnlEhq/gW6WyfXKxbrRnNdCTyoUkCak=

--8Rk4cv0jGHw6zhnJvfxp
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
nth=3D6&day=3D25&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248
>=20
> USWest	USEast	UK	DE	TW	JP
> 02:00	05:00	10:00	11:00	17:00	18:00

Not sure if I'll be able to make it today.

=46rom last meeting, I have been reviewing patches for 4.19.129 and
4.19.130.

Best regards,
                                                                        Pav=
el
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXvRLnwAKCRAw5/Bqldv6
8juQAKCxHowSIAcnfG3RF0mq0zBPk5l0PgCeJPZAClVf96E+UEHPHb0WU7g6aag=
=3Os8
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--

--8Rk4cv0jGHw6zhnJvfxp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4811): https://lists.cip-project.org/g/cip-dev/message=
/4811
Mute This Topic: https://lists.cip-project.org/mt/75095440/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--8Rk4cv0jGHw6zhnJvfxp--
