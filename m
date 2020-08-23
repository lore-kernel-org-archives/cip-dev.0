Return-Path: <SRS0=bPUq=CB=lists.cip-project.org=bounce+64572+5228+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCB3C433DF
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 19:03:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6E4206C0
	for <cip-dev@archiver.kernel.org>; Sun, 23 Aug 2020 19:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Rd92tC8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6E4206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5228+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EcbMYY4521723xJEkmxYhMFP; Sun, 23 Aug 2020 12:03:35 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.179472.1598209413390926912
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Aug 2020 12:03:34 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 48EBD1C0BBF; Sun, 23 Aug 2020 21:03:28 +0200 (CEST)
Date: Sun, 23 Aug 2020 21:03:27 +0200
From: "Pavel Machek" <pavel@ucw.cz>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>,
	Chris Paterson <chris.paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 00/36] Add Hihope RZ/G2H basic board support
Message-ID: <20200823190327.GB25365@duo.ucw.cz>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ouUcBZ3kkIauWl3FwigACligx4520388AA=
Content-Type: multipart/mixed; boundary="wHW0O9oi7a2OdfYlzjXP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598209415;
 bh=puzj+htpkXo4gjATPqZPGpCoAz7iGoFZ5k0DfMY0yYg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Rd92tC8+o2e/9xCoUQT4R65NNFF/kj9KOAboi+xyjDJlXS9rOUjV2Fns4FX+V7igHQe
 UiHbRIHrkvdvvZ19L66f5tUJwpPPhr30D5jLj5/svS4X3R6HRq8FBijzamJ7Serlld9gj
 PLsozAYhl09vAi3+0TMFqDVc7zwClarrWAQ=

--wHW0O9oi7a2OdfYlzjXP
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline

--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This patch series add basic support for Hihope RZ/G2H based on
> r8a774e1 SoC to 4.19.y-cip kernel. All patches in this series
> are cherry-picked from mainline.

> This patch series depends on [1]
> [1]:
> https://patchwork.kernel.org/project/cip-dev/list/?series=3D335409

For the record, these patches look good to me.

So we need to decide what to do with that dependency.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX0K9fwAKCRAw5/Bqldv6
8mApAKCEBujuWPG5SVWC63VlXu1GyxjMwwCeNDs+ra2KMHGM5KXThDvuCgraVc0=
=nXfv
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

--wHW0O9oi7a2OdfYlzjXP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5228): https://lists.cip-project.org/g/cip-dev/message=
/5228
Mute This Topic: https://lists.cip-project.org/mt/76326718/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wHW0O9oi7a2OdfYlzjXP--
