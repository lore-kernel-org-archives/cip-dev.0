Return-Path: <SRS0=K6X/=EQ=lists.cip-project.org=bounce+64572+5789+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960C0C388F7
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 12:44:31 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD2520781
	for <cip-dev@archiver.kernel.org>; Tue, 10 Nov 2020 12:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LDmVSHB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD2520781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5789+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tXlNYY4521723xz0fB7xJrC7; Tue, 10 Nov 2020 04:44:29 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.26846.1605012268355988803
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Nov 2020 04:44:29 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 681951C0B8B; Tue, 10 Nov 2020 13:44:23 +0100 (CET)
Date: Tue, 10 Nov 2020 13:44:22 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-members@lists.cip-project.org
Cc: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] [cip-members] Report from Real Time meeting
Message-ID: <20201110124422.GB20497@duo.ucw.cz>
References: <16461E21526983EA.10479@lists.cip-project.org>
MIME-Version: 1.0
In-Reply-To: <16461E21526983EA.10479@lists.cip-project.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: e33cFTmiSjVjIOCQJ9wlM3I2x4520388AA=
Content-Type: multipart/mixed; boundary="XSrrdH0Pmtt8k5w0le6S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605012269;
 bh=gNfKN9HeFEUwn5ENifo6SjC74YZUF5LV2ByRxHh78zs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LDmVSHB+zQnQlYPoW0c9UrZK6LDIcxKbq4RiyhRHY09QrajNU4haVpKoisagIA9B9WR
 NBJ5iEtnheO/S1aDlX0E8+zKaNcmwTSyf9Gotz0kDftCQpBpXDS6bKtl2LtZ6azYODZ0P
 OvWaFszkrqWuhXLIJEzH9PDlirynmuZamV4=

--XSrrdH0Pmtt8k5w0le6S
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline

--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> There was (virtual) Real Time meeting yesterday.

The meeting was with Thomas Gleixner (and company), about upstreaming
efforts; it was not a CIP meeting.

We still make our own plans, and likely next CIP LTS kernel will be
5.10-based, and likely we'll maintain 5.10-cip and 5.10-cip-rt
branches.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX6qLJgAKCRAw5/Bqldv6
8q9JAKCiKknlR+BQLi1Ajsye0qUzGir/TQCgiiF8gYIhAKtt2Hx/5J3y8fO0/nU=
=wEny
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--

--XSrrdH0Pmtt8k5w0le6S
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5789): https://lists.cip-project.org/g/cip-dev/message=
/5789
Mute This Topic: https://lists.cip-project.org/mt/78158127/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XSrrdH0Pmtt8k5w0le6S--
