Return-Path: <SRS0=oPpK=6E=lists.cip-project.org=bounce+64572+4586+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C476C3815B
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 18:54:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F25020782
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 18:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lQPjp/5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F25020782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4586+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ywuZYY4521723xPCrMVfJWEM; Mon, 20 Apr 2020 11:54:12 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.759.1587408849521389379
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2020 11:54:11 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E06EB1C01E0; Mon, 20 Apr 2020 20:54:05 +0200 (CEST)
Date: Mon, 20 Apr 2020 20:54:05 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Neal Caidin <ncaidin@linuxfoundation.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Konstantin Ryabitsev <mricon@kernel.org>,
	cip-members@lists.cip-project.org, cip-dev@lists.cip-project.org,
	cip-board@lists.cip-project.org, cip-security@lists.cip-project.org
Subject: Re: [cip-members] [cip-dev] Migration complete - Re: Mailman2 to Groups.io reminder
Message-ID: <20200420185405.GB11328@duo.ucw.cz>
References: <CAODMxsK_vgo-=FikL1Z2iYXtetRh+KpRJNL4MchmfXvLMqBTUA@mail.gmail.com>
 <CAODMxsJ5anJK+heh9rnWtAsvCCFLhVnm40cffABgG686_312mQ@mail.gmail.com>
 <CAODMxsKB87WswBCwDHcpaB1TyO6QmTy_vy4qVzdni8OrmEwr7A@mail.gmail.com>
 <20200406224358.GC14162@amd.ucw.cz>
 <874ktwysrj.fsf@kokedama.swc.toshiba.co.jp>
 <03bf3028-3ea5-55fa-cead-861db2f980ed@siemens.com>
 <20200407151223.5nj4433u3il264zk@chatter.i7.local>
 <eced03e3-465b-2b81-ee43-a78cce6ee35c@siemens.com>
 <CAODMxsK7xCTJW4NMTqjn_nZcm8JLEL87w2siTSggymGBxmbhnA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODMxsK7xCTJW4NMTqjn_nZcm8JLEL87w2siTSggymGBxmbhnA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BgGv0EJvMnJfWVoyb3PE6zofx4520388AA=
Content-Type: multipart/mixed; boundary="0gIM6Eslrzmn5zUOPSNH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587408852;
 bh=vKpz4Q7Z9j4wOway5qTme3l7h0Aq3dqQa+tFWL2Oztg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lQPjp/5BNIsKMBTg1ilQgqPwEMb4RV//hxRWtFiavnl0HY923WRQ2z/FLK/iJQRas2O
 1MNY+2d3i9La/fl34eLEZ8anMACWk2Tak7wavE+i+3RSLAHlXo+/BN3NGONhynjFuueIW
 hImPKUmkVXEs2J0LKH3Y4jB1ZNejSp23VZY=

--0gIM6Eslrzmn5zUOPSNH
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I just set it for cip-dev . See if that is working now?
>=20
> Happy to do it for other lists if needed.

I believe it makes sense for all the lists, as signed emails make
sense in all cases. Especially cip-security should get it. If it works
now -- we'll see after this email. I'll let you know if not.

Best regards,
								Pavel
							=09
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXp3vzQAKCRAw5/Bqldv6
8iChAKCWLN6vuQa6lsMhwwSUAmsaf9f9sACgkBpHa3i7aAzZoKVWCAq9YS5A7Xs=
=2WWS
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--

--0gIM6Eslrzmn5zUOPSNH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4586): https://lists.cip-project.org/g/cip-dev/message=
/4586
Mute This Topic: https://lists.cip-project.org/mt/72845465/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0gIM6Eslrzmn5zUOPSNH--
