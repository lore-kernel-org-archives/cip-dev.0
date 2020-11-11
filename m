Return-Path: <SRS0=vUOm=ER=lists.cip-project.org=bounce+64572+5792+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83533C388F9
	for <cip-dev@archiver.kernel.org>; Wed, 11 Nov 2020 21:19:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4480D20679
	for <cip-dev@archiver.kernel.org>; Wed, 11 Nov 2020 21:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lO00iBqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4480D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5792+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZIy8YY4521723xlcXWHiiGvy; Wed, 11 Nov 2020 13:19:02 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.13361.1605129541165992469
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2020 13:19:01 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EC0EE1C0B88; Wed, 11 Nov 2020 22:18:56 +0100 (CET)
Date: Wed, 11 Nov 2020 22:18:56 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Leaving Codethink and CIP
Message-ID: <20201111211856.GB2792@duo.ucw.cz>
References: <35ba5a3c63dd41c15f1cf63e99ba01e99316bce4.camel@codethink.co.uk>
MIME-Version: 1.0
In-Reply-To: <35ba5a3c63dd41c15f1cf63e99ba01e99316bce4.camel@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cmgoRd1HoSSw195LbOSBeQT0x4520388AA=
Content-Type: multipart/mixed; boundary="Y3K3FgunxjSGwCqI2L5w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605129542;
 bh=xLhmN2Xd69yr2jCzHJaVyhJM8XSrMyMAGcDxXL7r4f8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=lO00iBqrjszJksG8iCtp1MBbTOGoFAkWoDAoCY+8wOSC9MK8dOHk0ar34CgNsk7qLes
 TXq2RCaL7wotOu56snPKAI4FWAJ8ijvCNEYrrNK6C37ZMFN+Dn1GpN/LmUWK7KYwrrFdS
 2MLWUk44ExiMZt9aiInup2sLzd8M0XMHx4c=

--Y3K3FgunxjSGwCqI2L5w
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline

--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I will be leaving Codethink next month, and will no longer be working
> directly on CIP.  (With my Debian hat on, I may still submit merge
> requests to the cip-kernel-sec repository.)  My last working day here
> will be 11 November.
>=20
> I want to thank everyone who's worked to make super-long-term Linux
> kernel maintenance possible.  CIP has a great kernel team now and I'm
> confident that you'll carry on doing a fine job without me.

Thanks for all the great work, and good luck in whatever you do next.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX6xVQAAKCRAw5/Bqldv6
8vAWAJ45jdX1zcKHwOuL34HDpgjdwQpl1gCgmSxIa++vFiApywRMIdCHHmmj9ng=
=Yv3U
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

--Y3K3FgunxjSGwCqI2L5w
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5792): https://lists.cip-project.org/g/cip-dev/message=
/5792
Mute This Topic: https://lists.cip-project.org/mt/77850039/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Y3K3FgunxjSGwCqI2L5w--
