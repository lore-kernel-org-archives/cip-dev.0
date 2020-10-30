Return-Path: <SRS0=EmU5=EF=lists.cip-project.org=bounce+64572+5696+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342B6C4363A
	for <cip-dev@archiver.kernel.org>; Fri, 30 Oct 2020 10:26:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDF9221FA
	for <cip-dev@archiver.kernel.org>; Fri, 30 Oct 2020 10:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MCaepcqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDF9221FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5696+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DkUtYY4521723x2BqAwFsMYO; Fri, 30 Oct 2020 03:26:03 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.11515.1604053561960742442
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2020 03:26:02 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9F4601C0B76; Fri, 30 Oct 2020 11:25:56 +0100 (CET)
Date: Fri, 30 Oct 2020 11:25:56 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Pavel Machek <pavel@denx.de>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/4] Add SATA support to RZ/G2N
Message-ID: <20201030102556.GA21753@duo.ucw.cz>
References: <20201029114602.9107-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201029130451.GA6691@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20201029130451.GA6691@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5ngGNHqx3v89npIMnsUJ8KbIx4520388AA=
Content-Type: multipart/mixed; boundary="PeDRWCUeg0xhwi3aoTo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604053563;
 bh=4NzXfGV/HIE12aEuvGwSn0/KJIgO1u3mLzHem0OUHPg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MCaepcqo0BBdlwveDeuMVNQ7tTw15lESAdpmIkrp3fE7wfm2qq575e2AnhEJNPh22Ty
 xCWFqXE7Aau/efA7S4TNMc8JoXOV/2UDb8z1Ko5zVXFrkcu5zHxtJYGZDVJ9lKHaREMb9
 BcLh34PODC2iR3iFNlMy5TWxPcG8fmClNPg=

--PeDRWCUeg0xhwi3aoTo7
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series adds SATA support to RZ/G2N SoC and enables
> > sata node in Hihope RZ/G2N board, alongside a fix to sata driver.
>=20
> Series looks okay to me, it is currently being tested. I can
> apply/push it if there are no other comments.

Thanks for patches, I pushed out the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5vqNAAKCRAw5/Bqldv6
8rSDAJ9/CCn0L93v8jmjUn2uCxHnJALnMgCgrZV1zMtwlFekV8/b7P6/Ig4A8XA=
=onW9
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

--PeDRWCUeg0xhwi3aoTo7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5696): https://lists.cip-project.org/g/cip-dev/message=
/5696
Mute This Topic: https://lists.cip-project.org/mt/77885348/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--PeDRWCUeg0xhwi3aoTo7--
