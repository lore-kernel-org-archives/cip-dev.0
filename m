Return-Path: <SRS0=lTZa=LM=lists.cip-project.org=bounce+64572+6533+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54A7C48BDF
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 07:16:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8D561396
	for <cip-dev@archiver.kernel.org>; Fri, 18 Jun 2021 07:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8D561396
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6533+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id k2AgYY4521723xyEeVGFaoHE; Fri, 18 Jun 2021 00:16:29 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.4729.1624000587512829602
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jun 2021 00:16:28 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 753EF1C0B76; Fri, 18 Jun 2021 09:16:24 +0200 (CEST)
Date: Fri, 18 Jun 2021 09:16:24 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [isar-cip-dev][PATCH] linux-cip-common.inc: Uprev the cip-kernel-config
Message-ID: <20210618071623.GA7812@duo.ucw.cz>
References: <20210615052006.1198664-1-Srinuvasan_A@mentor.com>
 <28258.1623923758706105848@lists.cip-project.org>
MIME-Version: 1.0
In-Reply-To: <28258.1623923758706105848@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: KmXvJcubPYIb6U07U1K9LFDMx4520388AA=
Content-Type: multipart/mixed; boundary="pkhFp2xbtGGQ4J9n6bYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624000589;
 bh=SMmUoLom4JVrx4yV6DuUKV5rnvig3H+6QK0ywkPJPnM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=OB9TQ7BI/6O/NAblODnCnVJyo5GYnBrfcuEQ9C0+FhVL4Pb3El29nUhrGEzEH9I45On
 ibifeO52ewXelzH0fRSqg3Ql2dCs3P9cfXH+xc8kFve6nnQef3hBhDfoy4sga0osRDxhd
 N4ME40a3K1uND1wIx7NnM9kQCWzNIoOtkDY=

--pkhFp2xbtGGQ4J9n6bYb
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> It is ready for review and merge.

I believe something (attachment?) is missing here.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYMxIRwAKCRAw5/Bqldv6
8ty8AKCdNVTEWpcfkNTf5YXGoPm8tlhWZwCgqRtWOo8t+m9BSLxT9fOtpQCDibc=
=NCSq
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

--pkhFp2xbtGGQ4J9n6bYb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6533): https://lists.cip-project.org/g/cip-dev/message=
/6533
Mute This Topic: https://lists.cip-project.org/mt/83525386/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pkhFp2xbtGGQ4J9n6bYb--
