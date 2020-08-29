Return-Path: <SRS0=+GQx=CH=lists.cip-project.org=bounce+64572+5328+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CE8C433E6
	for <cip-dev@archiver.kernel.org>; Sat, 29 Aug 2020 11:51:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D60207DF
	for <cip-dev@archiver.kernel.org>; Sat, 29 Aug 2020 11:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="n26POU1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D60207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5328+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Tn9UYY4521723xIgjWecsLyJ; Sat, 29 Aug 2020 04:51:40 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9733.1598701899530910261
 for <cip-dev@lists.cip-project.org>;
 Sat, 29 Aug 2020 04:51:40 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EE5DF1C0B82; Sat, 29 Aug 2020 13:51:36 +0200 (CEST)
Date: Sat, 29 Aug 2020 13:51:36 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip 00/30] Add iWave RZ/G1H basic board support
Message-ID: <20200829115136.GB19324@duo.ucw.cz>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
 <20200828182857.GC10270@duo.ucw.cz>
MIME-Version: 1.0
In-Reply-To: <20200828182857.GC10270@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XOWE7EEiYkb2UDE9B70NLwPhx4520388AA=
Content-Type: multipart/mixed; boundary="cDG7h0hiu3z5w1uohd52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598701900;
 bh=04Mblfdxpe8NZCQeIBINFBAcA4I7g266fPAnRpXbAcw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=n26POU1fVPPYvdiJBQzxJ5XCB/lMvbPjqedJE6EHkhtK0uJErot2DdnfFILAX3jZctt
 f9UAkPpcW0IFKFspUbvAO4bqL/Mwc2uqbPC7wgspL/SPeZ02UmrdQ5OCo/ZHG3iSIOWV9
 IGHq/ywyePchN13sfIDGriPaC0z/T4SGZYM=

--cDG7h0hiu3z5w1uohd52
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline

--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > This patch series add basic support for iWave RZ/G1H platform based on
> > r8a7742 SoC to 4.4.y-cip kernel. Most of the patches in this series
> > are cherry-picked from mainline.
>=20
> Series looks okay to me, I can apply it if there are no comments (and
> if gitlab cooperates).

Applied and pushed out.

Thanks,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0pBSAAKCRAw5/Bqldv6
8iKYAJwJNUBy9Gnd6OUfsw0udRkmojIZ4gCfb7nm4qyXg+HKZbhEk4c7WxX0bt8=
=ftF3
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--cDG7h0hiu3z5w1uohd52
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5328): https://lists.cip-project.org/g/cip-dev/message=
/5328
Mute This Topic: https://lists.cip-project.org/mt/76477073/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--cDG7h0hiu3z5w1uohd52--
