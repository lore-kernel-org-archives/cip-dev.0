Return-Path: <SRS0=boxa=FV=lists.cip-project.org=bounce+64572+5969+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E49C2BB40
	for <cip-dev@archiver.kernel.org>; Thu, 17 Dec 2020 08:27:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F3923884
	for <cip-dev@archiver.kernel.org>; Thu, 17 Dec 2020 08:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F3923884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5969+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IoyUYY4521723x8zrDfdHQ8l; Thu, 17 Dec 2020 00:27:35 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5157.1608193654165179785
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Dec 2020 00:27:34 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id CFA061C0B78; Thu, 17 Dec 2020 09:27:20 +0100 (CET)
Date: Thu, 17 Dec 2020 09:27:20 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] CIP IRC weekly meeting today
Message-ID: <20201217082719.GA4373@amd>
References: <TY2PR01MB4972735E4759DDDC9896598DA0C40@TY2PR01MB4972.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY2PR01MB4972735E4759DDDC9896598DA0C40@TY2PR01MB4972.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lulpz4uE4O0N9SO5ttX6FBITx4520388AA=
Content-Type: multipart/mixed; boundary="meZ1rOnAyV6NJ0ILHACT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608193655;
 bh=gQ4PEJXSeHqAx3FR41o5lIkJvTLHUtOxrMZ0+HtxdsY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Yojk9WtG18jOoQj1xU28bqqiHlNN1ZgYkAGpMQ5DW1t/pL//HomAhLuFk1obCSswRar
 Owy9eHyXKPoNS19Hm95ydMRRzFV8mU5ngNdo7MUXN0DR9i73XYM5h9T6i6DOz4Kyg8VXH
 7TndwwavEUMoTJg7qBJQZX4Nn84EURGpSi4=

--meZ1rOnAyV6NJ0ILHACT
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> * Kernel maintenance updates

In case I don't make it to the meeting:

I have reviewed patches targetted for 4.19.163 and .164.

I am preparing scripts to make reviews easier once we add 5.10 kernel
to the list.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/bFmcACgkQMOfwapXb+vI5bwCfTCBBtJcDXLFuB07AgHazBa6j
ZIAAn1C9pCbzqewiC/Az47OdOkta8K+E
=9Wtg
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

--meZ1rOnAyV6NJ0ILHACT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5969): https://lists.cip-project.org/g/cip-dev/message=
/5969
Mute This Topic: https://lists.cip-project.org/mt/79028319/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--meZ1rOnAyV6NJ0ILHACT--
