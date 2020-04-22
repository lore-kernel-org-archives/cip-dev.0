Return-Path: <SRS0=PAYY=6G=lists.cip-project.org=bounce+64572+4595+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D291C5518A
	for <cip-dev@archiver.kernel.org>; Wed, 22 Apr 2020 07:13:15 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092872075E
	for <cip-dev@archiver.kernel.org>; Wed, 22 Apr 2020 07:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="h5youhkA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092872075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4595+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9MGyYY4521723xYcbmGaMTe9; Wed, 22 Apr 2020 00:13:14 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.1642.1587538311120287589
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2020 23:51:51 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 990761C00B7; Wed, 22 Apr 2020 08:51:49 +0200 (CEST)
Date: Wed, 22 Apr 2020 08:51:49 +0200
From: Pavel Machek <pavel@denx.de>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] [PATCH 0/2] Add HiHope RZ/G2M board with idk-1110wr display
Message-ID: <20200422065149.GB12827@amd>
References: <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200420202445.GA22198@duo.ucw.cz>
 <OSBPR01MB3590E5EA28170A1E12750991AAD50@OSBPR01MB3590.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <OSBPR01MB3590E5EA28170A1E12750991AAD50@OSBPR01MB3590.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EDMtkYxPcVki70g9d4ff61yBx4520388AA=
Content-Type: multipart/mixed; boundary="aYO6sErjmSL9QlZsb09T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587539594;
 bh=PxLEVhRPMA5l6c7ygPyF17kFVExF2PUOyjWbuN16C/M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=h5youhkA/Ua5eNXpLLh7kSKzoOtDBgXG6T9/rn4HjqBNXqNaIc28qeX+JPoXKDozBTe
 uWnIvvT8etlNpuYz4uW+4eeS1k9UKYbQrf90HYYSds0psBXSCt7GeVAEFi4SmBbQ3Nkxu
 qGwGbSCsQrX5iG/RMSAe16tMeyiAIziv2Po=

--aYO6sErjmSL9QlZsb09T
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline

--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > This patch series adds support idk-1110wr display on RZ/G2M board.
> >
> > I assume it is for 4.19; subject does not say. Otherwise it looks good,
> > so I'll test it and apply unless someone sees problem with it.
> >
> Oops my bad, yes it's for 4.19.

Thanks, I applied the series.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6f6YUACgkQMOfwapXb+vLUewCguawRjZegMkcwVSi3Z+Y6Ru8p
pRAAoIGKSh1JbN3xaqHVcD+H9geC2TIQ
=4FC/
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

--aYO6sErjmSL9QlZsb09T
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4595): https://lists.cip-project.org/g/cip-dev/message=
/4595
Mute This Topic: https://lists.cip-project.org/mt/73158050/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--aYO6sErjmSL9QlZsb09T--
