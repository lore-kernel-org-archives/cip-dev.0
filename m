Return-Path: <SRS0=2/Ko=K6=lists.cip-project.org=bounce+64572+6492+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD0C4743C
	for <cip-dev@archiver.kernel.org>; Fri,  4 Jun 2021 19:35:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4D061414
	for <cip-dev@archiver.kernel.org>; Fri,  4 Jun 2021 19:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4D061414
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6492+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id J0u1YY4521723xlCPQ6sFZHc; Fri, 04 Jun 2021 12:35:56 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.3890.1622835354737646318
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jun 2021 12:35:55 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E22BC1C0B7A; Fri,  4 Jun 2021 21:35:50 +0200 (CEST)
Date: Fri, 4 Jun 2021 21:35:50 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
Message-ID: <20210604193550.GB11805@duo.ucw.cz>
References: <TY2PR01MB4972DFDBCA2B63FF9FE7F5CEA03C9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB4972DFDBCA2B63FF9FE7F5CEA03C9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: acNzqFH4yPxdAC86ZQLvunAHx4520388AA=
Content-Type: multipart/mixed; boundary="EX1QSRJkGVLKgpA9Fpyv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622835356;
 bh=3mZmtTlv8NsBJtztB9qRAUS3MX0r5p8LBSoZdJIerEs=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=bs44swI/lbjmJ1wIc/ubuLWF2mJPiRgWqZUIzMAjVg9XwBu2meb9mC8aXLMRJyhjxif
 NBSjD9M5C3IRKF1zAOHCLdDmV6zPOpAliIzP3ZoBbZvVsV1l6O0M3j80QSIyuZwSovIAR
 UOnm4Dfcd8HKWONjtTQ0IPTU26lydP2PIME=

--EX1QSRJkGVLKgpA9Fpyv
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Content-Disposition: inline

--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Kindly be reminded to attend the weekly meeting through IRC to discuss te=
chnical topics with CIP kernel today.
>=20
> Please note that we move from Freenode to the new channel (libera.chat) a=
s follows:
>               irc:irc.libera.chat:6667/cip
>=20
> *Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 star=
ting from the first week of Apr. according to TSC meeting*

I forgot to mention... I'll be traveling next week. I should still
have email access, but I'll probably not make it on Zoom, and no
promisses about meeting on the IRC.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYLqAlgAKCRAw5/Bqldv6
8pkyAKCzCNMfnESHMpZk0dl82aXaQ3xZXACfXghgQK4CpkcAutEt52ky7Lt3v1I=
=xy05
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--

--EX1QSRJkGVLKgpA9Fpyv
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6492): https://lists.cip-project.org/g/cip-dev/message=
/6492
Mute This Topic: https://lists.cip-project.org/mt/83274323/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--EX1QSRJkGVLKgpA9Fpyv--
