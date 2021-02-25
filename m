Return-Path: <SRS0=yzz6=H3=lists.cip-project.org=bounce+64572+6199+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95BFC433DB
	for <cip-dev@archiver.kernel.org>; Thu, 25 Feb 2021 11:23:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C7BE64EF5
	for <cip-dev@archiver.kernel.org>; Thu, 25 Feb 2021 11:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7BE64EF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6199+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IrGXYY4521723xx5Eyo3wkcA; Thu, 25 Feb 2021 03:23:55 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.9944.1614252234751184367
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Feb 2021 03:23:55 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 88B1A1C0B81; Thu, 25 Feb 2021 12:23:49 +0100 (CET)
Date: Thu, 25 Feb 2021 12:23:49 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] i915 -- c784e5249e -- backporting
Message-ID: <20210225112349.GA22158@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9DfwJRZA2hB3aZFy7OxVldudx4520388AA=
Content-Type: multipart/mixed; boundary="fMIUFmpiMHxKLBIyVHGs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614252235;
 bh=JfPNEgdxLcaVhmbaWInuEI/1q0B5qlxGngVMIWt8T+Y=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=GcCefoDDKoalXwHZKQ1Smwv/SQsob8CucT8UKWy4BaRZsIHO4oJBSThEFTDwB5nRwJz
 6U7uMb2khRD/75NeSKemt+9uHMlEPV3M+m83onwSZj5VaqGbqB0GiPBJnXPrs8bYYLKNV
 PF8XMSIzM/opNDGzGSBsA82/tiKlIXeZuBM=

--fMIUFmpiMHxKLBIyVHGs
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I took a look at c784e5249e and it does not seem to be easy to
backport. Files are at different locations, defines it wants to change
have different values, ... I did not get anywhere.

Best regards,

								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYDeIxQAKCRAw5/Bqldv6
8usvAKCSxtwY1aCpvUTCz9MVPmnuuUaVhACfVhkDctwXalIFKQwI0xdpvmUX+jE=
=fa7m
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--fMIUFmpiMHxKLBIyVHGs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6199): https://lists.cip-project.org/g/cip-dev/message=
/6199
Mute This Topic: https://lists.cip-project.org/mt/80899579/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fMIUFmpiMHxKLBIyVHGs--
