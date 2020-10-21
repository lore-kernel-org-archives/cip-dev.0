Return-Path: <SRS0=z7FW=D4=lists.cip-project.org=bounce+64572+5635+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0071C4363A
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 19:06:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB6D2177B
	for <cip-dev@archiver.kernel.org>; Wed, 21 Oct 2020 19:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rYNE6GKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB6D2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5635+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SWF0YY4521723xUmkSiVDRaV; Wed, 21 Oct 2020 12:06:51 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.17028.1603307211090980643
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2020 12:06:51 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C31CE1C0B9D; Wed, 21 Oct 2020 21:06:47 +0200 (CEST)
Date: Wed, 21 Oct 2020 21:06:47 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>, Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [RFC PATCH 4.19.y-cip 38/50] PCI: rcar: Move shareable code to a common file
Message-ID: <20201021190647.GC10468@duo.ucw.cz>
References: <20201012141933.9652-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201012141933.9652-39-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20201012141933.9652-39-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: aSAsYYNKP4ixlzLsvQeqHJ70x4520388AA=
Content-Type: multipart/mixed; boundary="mxp2hGjMbjrEoo8yKEkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603307211;
 bh=T/vjViZH3ImgCOQFap6advPnUtZSPwo2DIIy1lBHLDI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rYNE6GKfU6BhT8bENfPkMNjHPsrbtOYzBXrXiIhy8hBHBkI75TC4kKwhjKJvcDh650I
 I+8vNDj76iyCxo71Rah1cBxcqGsobOVbLbUsiAv45sF2A3fdzieQISUz30f5GwRSPuAxk
 laaR6AIBIJEQXJK3/nVInYOGp9ua8rlJYW8=

--mxp2hGjMbjrEoo8yKEkJ
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline

--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> commit 78a0d7f2f5a31357bce68012d886507b4cf33598 upstream.
>=20
> Move shareable code to common file pcie-rcar.c and the #defines to
> pcie-rcar.h so that the common code can be reused with endpoint driver.
> There are no functional changes with this patch for the host controller
> driver.

Whoa.

So... original patch _moved_ shared code to new place.

This version creates another copy of shared code, probably subtly
different from the other one.

Is that good idea? Won't two copies cause problems depending on
=2Econfig? Could we share code, as the mainline does?

Anyway, patches up to previous one -- [37/50] arm64: defconfig: Enable
CONFIG_PCIE_RCAR_HOST look okay to me, so if you can send them as
non-RFC version, I cal likely apply them.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--yVhtmJPUSI46BTXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5CGxwAKCRAw5/Bqldv6
8m02AKCHL4T/5dF+23/AWaL/XCPqdowMiACgkyQBESy34Mzzh2mM9colVxuCCjU=
=TbgW
-----END PGP SIGNATURE-----

--yVhtmJPUSI46BTXb--

--mxp2hGjMbjrEoo8yKEkJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5635): https://lists.cip-project.org/g/cip-dev/message=
/5635
Mute This Topic: https://lists.cip-project.org/mt/77461717/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--mxp2hGjMbjrEoo8yKEkJ--
