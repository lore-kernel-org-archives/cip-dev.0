Return-Path: <SRS0=4SkY=AU=lists.cip-project.org=bounce+64572+4915+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135D4C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  9 Jul 2020 07:06:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60E9120674
	for <cip-dev@archiver.kernel.org>; Thu,  9 Jul 2020 07:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="HY8drwyQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E9120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4915+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id i7sJYY4521723xxMmEgIJCz5; Thu, 09 Jul 2020 00:06:35 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1553.1594278392804672912
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jul 2020 00:06:33 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 50BB11C0BD4; Thu,  9 Jul 2020 09:06:27 +0200 (CEST)
Date: Thu, 9 Jul 2020 09:06:26 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20200709070626.GA498@amd>
References: <TY2PR01MB4972D3A51538BD7A8477772FA0670@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB4972D3A51538BD7A8477772FA0670@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SP4AMpEbujgqRaH4rlt2WbDox4520388AA=
Content-Type: multipart/mixed; boundary="4FCjRe6CQ37yciwFqPFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1594278395;
 bh=ZDVN8urP4H9/lAgXpPRuEMzbHNb21UudpcARDaajJYQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=HY8drwyQXJwGentKX3otTY0nEx223lOcIJmF5A1qzkg91CdwVd8XpJ4ecM0h+rjN4zn
 tnw6jdX2aZ3H6BizUHKp/Byt+id3cLjjei3VfZx0isAB440W+TxCOjsh/h5gpQdm9VP/L
 zC9xBpKBBhclhm4Yo++7TyPdESpcy4eOKXI=

--4FCjRe6CQ37yciwFqPFz
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Kindly be reminded to attend the weekly meeting through IRC to discuss te=
chnical topics with CIP kernel today.
>=20

I am not sure if I'll be able to make it to the meeting.

My work last week: reviews of patches for 4.19.131 and 4.19.132. I
took a look at "PM / OPP v2 & cpufreq backports part 2" and will have
some comments there.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8GwfIACgkQMOfwapXb+vIy0ACeMatAra3N5mbQ7ZbjF9spmskQ
GCsAn2dWOGgVnmqwzHiZYA6f/HLhSJ9D
=iRrp
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

--4FCjRe6CQ37yciwFqPFz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4915): https://lists.cip-project.org/g/cip-dev/message=
/4915
Mute This Topic: https://lists.cip-project.org/mt/75387533/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--4FCjRe6CQ37yciwFqPFz--
