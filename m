Return-Path: <SRS0=AxtX=EL=lists.cip-project.org=bounce+64572+5750+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B0BC00A89
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 12:12:10 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3976720729
	for <cip-dev@archiver.kernel.org>; Thu,  5 Nov 2020 12:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MqRzPAnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3976720729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5750+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3I2KYY4521723xqw5qWlnOQv; Thu, 05 Nov 2020 04:12:08 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.6539.1604578326893819342
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Nov 2020 04:12:07 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 564DA1C0B82; Thu,  5 Nov 2020 13:12:03 +0100 (CET)
Date: Thu, 5 Nov 2020 13:12:03 +0100
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/6] Renesas RZ/G2H add USB{2,3} support
Message-ID: <20201105121203.GA11467@duo.ucw.cz>
References: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201105095039.4751-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: BX8PhIYuwkt2YOyUzN0ie3Mrx4520388AA=
Content-Type: multipart/mixed; boundary="3pzIs40H3IQKSiXYFqgs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604578328;
 bh=uO4Y/IgV7U39mW+PYt2qsaapxvn9tsLr0Tb3sjKyi3k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MqRzPAnS7+h/9b1kALFc7LtLf3W9q1tGt2BgfJPzkTroovng/jTdcK9aCsL1ExC/HLd
 nfNtaGMUL3PYfHKpysMbJCFqKD1mUyB52C04voOmE0ORtKWzHlFQFjgStNOPsGnnjuPIq
 I/bniZ7EKPkAmOmi2Y5JiFB56wlkmSd2SbQ=

--3pzIs40H3IQKSiXYFqgs
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series adds USB{2,3} support to Renesas RZ/G2H SoC.
>=20
> All the patches have been cherry-picked from Linux v5.10-rc2.

Series looks ok to me and passes our testing, I can apply it if there
are no other comments.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX6PsEwAKCRAw5/Bqldv6
8iwIAKCNkDEzdqij0nhycBr4WC+/WWRUhACdH0vZgsg7t6N0G78bW+rwR0F01/I=
=0hV8
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

--3pzIs40H3IQKSiXYFqgs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5750): https://lists.cip-project.org/g/cip-dev/message=
/5750
Mute This Topic: https://lists.cip-project.org/mt/78047670/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3pzIs40H3IQKSiXYFqgs--
