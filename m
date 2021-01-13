Return-Path: <SRS0=IUE7=GQ=lists.cip-project.org=bounce+64572+6081+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816CDC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 18:21:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2C023436
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 18:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2C023436
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6081+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3v3WYY4521723xsPA5UaPVZa; Wed, 13 Jan 2021 10:21:03 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.459.1610562062058942091
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 10:21:02 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 159AF1C0B9B; Wed, 13 Jan 2021 19:20:59 +0100 (CET)
Date: Wed, 13 Jan 2021 19:20:58 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 0/9] Renesas RZ/G1 add support for DU, TPU, PWM, LCD
Message-ID: <20210113182058.GA25010@duo.ucw.cz>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bshlusbfspMw8G2pFRa5c8vpx4520388AA=
Content-Type: multipart/mixed; boundary="eCqzKaW5jQn9r7q1xQX2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610562063;
 bh=y4cCkadZNeULIsk76af54A3MrvS21pW5LwBh0suAHyg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bH1/VZUEolil1vGTC/Z2NjEGAab58aDCqhDZmDqfEwHiDT1IIcnASoCzA6x9ehCIY8h
 a4AtFZi0jZRitpHeOiZ2ZwSL5lG94xrPCXs+e73hhxCa2SkBvrJFcvroXcFLlL09PsY27
 6GHixTlqtsq3O8A2yptk/R7Sv6AiyT+CXQE=

--eCqzKaW5jQn9r7q1xQX2
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


> This patch series adds support for TPU, PWM, DU to R8A7742 SoC and
> enable LCD on iwg21d board.
>=20
> All the patches have been cherry picked from v5.11-rc3.

Series looks okay to me. I can apply it if there are no other
comments.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/86CgAKCRAw5/Bqldv6
8shOAJ0SDixK8QgdX4/XyC8wpTj1f4skFwCcCOkWYkHe7tm+efHHhxzmQWIDTDI=
=HppY
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--

--eCqzKaW5jQn9r7q1xQX2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6081): https://lists.cip-project.org/g/cip-dev/message=
/6081
Mute This Topic: https://lists.cip-project.org/mt/79653996/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--eCqzKaW5jQn9r7q1xQX2--
