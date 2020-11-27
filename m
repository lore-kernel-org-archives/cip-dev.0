Return-Path: <SRS0=xBLM=FB=lists.cip-project.org=bounce+64572+5887+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8ADC3E8C5
	for <cip-dev@archiver.kernel.org>; Fri, 27 Nov 2020 23:07:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F9222228
	for <cip-dev@archiver.kernel.org>; Fri, 27 Nov 2020 23:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="rnLRid1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F9222228
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5887+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ILTXYY4521723xKvk4zwlQ6V; Fri, 27 Nov 2020 15:07:38 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web09.26299.1606518457016511160
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Nov 2020 15:07:37 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 882FD1C0B7C; Sat, 28 Nov 2020 00:07:23 +0100 (CET)
Date: Sat, 28 Nov 2020 00:07:23 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] arm64: dts: renesas: r8a774c0: Fix MSIOF1 DMA channels
Message-ID: <20201127230723.GD19743@duo.ucw.cz>
References: <20201126113711.5176-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20201126171153.GA27329@duo.ucw.cz>
 <OSBPR01MB50485C4015CA09B8AF42A156AAF80@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB50485C4015CA09B8AF42A156AAF80@OSBPR01MB5048.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: MJnxrI9wBY1K6Gnw7ipRr6uRx4520388AA=
Content-Type: multipart/mixed; boundary="WVK6s50xMpah99IfX2Mz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606518458;
 bh=Wl+4JH5Yed67cR+UNg1Z9WAVeVVfZJb1ZTNALMRKrok=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=rnLRid1UzFYReCK7sZe3V1qoPm3YsRwJT4ADQQAxtwqNZcEDmbOv6V9gYxxYS54hHLJ
 p8lQ8l3+FLrG/PRtaERTq5BQtSOIQ//VnaAX9IXDQYJCp7Ks9oCe0Cn5tnEzx/LdAa9Aq
 OfTj/y8QyLQSqZ7cHYrH+ICoQvazwEqFBcs=

--WVK6s50xMpah99IfX2Mz
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qGV0fN9tzfkG3CxV"
Content-Disposition: inline

--qGV0fN9tzfkG3CxV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Looks good to me, I can apply it if there are no other comments.
> >=20
> > (I note you switched from dmac1 + dmac2 to dma_0_ only. I believe you
> > double checked that's okay, but I wonder how it worked before the
> > patch?)
> >=20
> Yes I have cross checked this information. Luckily MSIOF1 wasn't populate=
d on the dev board.
>

Aha, MSIOF1 not being on dev board explains things.

Applied and pushed out.

Thanks and best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qGV0fN9tzfkG3CxV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX8GGqwAKCRAw5/Bqldv6
8ikeAKCZKTj5o2s376ocUA6vI8ufy1y0LgCglGbjuyuSWqviiYbDi6lRegaxdv4=
=kV5E
-----END PGP SIGNATURE-----

--qGV0fN9tzfkG3CxV--

--WVK6s50xMpah99IfX2Mz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5887): https://lists.cip-project.org/g/cip-dev/message=
/5887
Mute This Topic: https://lists.cip-project.org/mt/78527519/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WVK6s50xMpah99IfX2Mz--
