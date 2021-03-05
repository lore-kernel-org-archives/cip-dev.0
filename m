Return-Path: <SRS0=6reT=ID=lists.cip-project.org=bounce+64572+6213+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B20C433E0
	for <cip-dev@archiver.kernel.org>; Fri,  5 Mar 2021 08:49:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AEAD64F59
	for <cip-dev@archiver.kernel.org>; Fri,  5 Mar 2021 08:49:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AEAD64F59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6213+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id xkFQYY4521723x96fecOvG7Y; Fri, 05 Mar 2021 00:49:11 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.9452.1614934150202536492
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Mar 2021 00:49:10 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 950891C0B79; Fri,  5 Mar 2021 09:49:05 +0100 (CET)
Date: Fri, 5 Mar 2021 09:49:04 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] v5.10.20 review
Message-ID: <20210305084904.GA11274@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sJPeyZhHjUWFNwu4LkbFVgELx4520388AA=
Content-Type: multipart/mixed; boundary="P4OCWAJbylMdzf7oYMtJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614934151;
 bh=B1w9/YXlQKjZoFAfR0qXK1+i/uvGxsx+3LiJ08oX3L8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=igWyS3rGF1JeFbYAoPmh3qoB0lCfQ1402ZLibu4YR4EtmJUeu/mB3ZnWEVDWOucAAD0
 /K02JkLi3nXECa82lsp14UlKA7Zkb+oidFvGJ/gu4YqgPxGFMv7klht6VUIeg2wT3+EfH
 K0wNL+M8hblpnn7aKUgUSBvmmIFDmbJNsDY=

--P4OCWAJbylMdzf7oYMtJ
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

5.10.20 is huge, so I pushed work-in-progress
linux-kernel-v5.10.20-commit.list to the repository.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBB8IAACgkQMOfwapXb+vJiQQCfVMCIwMITp4rDtFkF0Xo6CMlm
Y7UAnjJn5VvuhRt8FSW7k+2X2bqYmC1m
=6KW1
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

--P4OCWAJbylMdzf7oYMtJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6213): https://lists.cip-project.org/g/cip-dev/message=
/6213
Mute This Topic: https://lists.cip-project.org/mt/81098710/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--P4OCWAJbylMdzf7oYMtJ--
