Return-Path: <SRS0=1Btb=D3=lists.cip-project.org=bounce+64572+5624+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2476AC4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 20:41:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9F72224A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 20:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="im7E6lSa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9F72224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5624+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2chnYY4521723xdJD6fIHfza; Tue, 20 Oct 2020 13:40:57 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1339.1603226456324330735
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 13:40:57 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 5158C1C0B77; Tue, 20 Oct 2020 22:40:47 +0200 (CEST)
Date: Tue, 20 Oct 2020 22:40:46 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 00/26] Fixes and extension to PCIe EPF
Message-ID: <20201020204046.GA29993@duo.ucw.cz>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WZrtMgzK4nj0tIDSdVOK0hqhx4520388AA=
Content-Type: multipart/mixed; boundary="25Rd1cqy7QYYOWmr8Am7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603226457;
 bh=Yl7ffo10zEmpMtUgsSG+Y0RH+HK0DyIN3MUyR8bnv1o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=im7E6lSaHHMVpxjF4JsvjvNqW30fUjRkJnfyMrz76D70/q8zvYS49H7V7jao41edjMM
 2BDbEDx2Ve/uvGJPna1SXK9HD4ym4hcoRjaPXQpZ0NnqipYHfY+E/sJtUrq6wwns0Itzb
 kgwk046JttksdLBx7wKMg48My3XCIm1ZcJ4=

--25Rd1cqy7QYYOWmr8Am7
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline

--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series is part of RFC series [1] ("Add PCIe EP support for
> Renesas R-Car Gen3 and RZ/G2x"). For making it more cleaner and easier
> to review series [1] is split up as suggested by Pavel, patches 1-22,
> 30, 32, 49, 50  are included in this set from [1].

Thanks, applied and pushed out.

Our automated testing did not find anything wrong (but I don't think
that means much).

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX49LTgAKCRAw5/Bqldv6
8t16AJ4vjpJ1LfwOP1qkJMcQBqvPJcoK7QCfVCryls7/lHSZAG0/Se9A3InOutA=
=PJ4Q
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

--25Rd1cqy7QYYOWmr8Am7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5624): https://lists.cip-project.org/g/cip-dev/message=
/5624
Mute This Topic: https://lists.cip-project.org/mt/77683509/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--25Rd1cqy7QYYOWmr8Am7--
