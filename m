Return-Path: <SRS0=f5On=NJ=lists.cip-project.org=bounce+64572+6692+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50A7C4338F
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 18:31:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E55FB610A6
	for <cip-dev@archiver.kernel.org>; Wed, 18 Aug 2021 18:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E55FB610A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zdQtYY4521723xJxmQ5XW5tP; Wed, 18 Aug 2021 11:31:11 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.59175.1629311470015455606
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Aug 2021 11:31:10 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 121351C0B77; Wed, 18 Aug 2021 20:31:01 +0200 (CEST)
Date: Wed, 18 Aug 2021 20:31:00 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] IRC meeting start time
Message-ID: <20210818183100.GA839@duo.ucw.cz>
References: <TY2PR01MB49724B0C88AF035E898804DEA0FF9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB49724B0C88AF035E898804DEA0FF9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 0G5eral4GiX2y7jfDmaQ0nYvx4520388AA=
Content-Type: multipart/mixed; boundary="DzLJAdM1Ic5TpIhQRwy6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629311471;
 bh=UiG0i97YdbVX7D4p7e7fZnMAxjxc0NknBev8EYz3ipc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Z/DFTG9JtSIUXRqDTYvx9KtPzt7kO0wjg9ITU3AyS3RG0O0lBigGni0VDPw024mTzqw
 N+swq+fMsHXqCWd0f69hnD358KyrHBavzThawZ8edu9MtAeLxZmmIaBTEj3TpAGsJAXX7
 ap/VsgZ5pzx2UZEaivWAAaoVKNWZd/j/OJQ=

--DzLJAdM1Ic5TpIhQRwy6
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We will change start time of IRC meetings held every Thursday.=20
> We will start the meeting at UTC 13:00. That is:
>   - Summer Time: USWest 06:00, USEast 09:00, UK 14:00, DE 15:00, TW 21:00=
, JP 22:00
>   - Winter Time: USWest 05:00, USEast 08:00, UK 13:00, DE 14:00, TW 21:00=
, JP 22:00
>=20
> This change is effective starting tomorrow.

I was at TSC Zoom meeting but did not realize consequences. I have
scheduling conflict this week, so I'll most likely not make it.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYR1R5AAKCRAw5/Bqldv6
8uqMAJ9JqcpWEOXygHYpNw8x61IEsYd6ugCfdehesmSMhwhKZ4+vcTRZmpzaYeM=
=rkXV
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

--DzLJAdM1Ic5TpIhQRwy6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6692): https://lists.cip-project.org/g/cip-dev/message/=
6692
Mute This Topic: https://lists.cip-project.org/mt/84967414/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DzLJAdM1Ic5TpIhQRwy6--
