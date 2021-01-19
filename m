Return-Path: <SRS0=DgU6=GW=lists.cip-project.org=bounce+64572+6110+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B0CC433DB
	for <cip-dev@archiver.kernel.org>; Tue, 19 Jan 2021 18:48:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A526422E00
	for <cip-dev@archiver.kernel.org>; Tue, 19 Jan 2021 18:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A526422E00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6110+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 05rxYY4521723x4lo3omZ5zZ; Tue, 19 Jan 2021 10:48:13 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.15360.1611080492174527937
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Jan 2021 10:21:32 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id DED111C0B85; Tue, 19 Jan 2021 19:21:25 +0100 (CET)
Date: Tue, 19 Jan 2021 19:21:25 +0100
From: "Pavel Machek" <pavel@denx.de>
To: masashi.kudo@cybertrust.co.jp, nobuhiro1.iwamatsu@toshiba.co.jp,
	cip-dev@lists.cip-project.org
Subject: [cip-dev] Starting 5.10.y branch?
Message-ID: <20210119182125.GA17515@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qAY0kegISbi92WDs6SEG5bCnx4520388AA=
Content-Type: multipart/mixed; boundary="ME7ksH4e2sVsiQV6k1EQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611082093;
 bh=U647VbUVDq8pMaa1o7iMVutno8T2FI5HXdU82hi2W8s=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=se/WgTRF75+mjXTKxzIGkdqKdO09d8J/khAj2KB/ZHAVeG1sm4h3/dNr4cxv6WD6jeS
 grqJ//vFaQIrBmbsEmauIRdka2bhHIkR2d43FGI4yOku/s7bJuw16swdy5KYK1fTxLU9h
 H+JruAZk9GZFTkvkWLETtE6OdXbR8JqTkzI=

--ME7ksH4e2sVsiQV6k1EQ
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I believe the next step with 5.10.y is to create linux-5.10.y-cip
branch at kernel.org. I'd propose to start with whatever is newest
stable at the moment, so probably 5.10.8 or 5.10.9. Is it okay for me
to do that?

Next steps probably are:

* Verify mirroring to gitlab
* Put required .gitlab-ci.yml
* Gather test results

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYAcjJQAKCRAw5/Bqldv6
8kysAJ0f9Lwyu9+gqIT98z2+wWZmB4KKCACeMN6Ngk3Zk5GdnIE7WnsLU0ryiqc=
=gXfy
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--

--ME7ksH4e2sVsiQV6k1EQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6110): https://lists.cip-project.org/g/cip-dev/message=
/6110
Mute This Topic: https://lists.cip-project.org/mt/79958721/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ME7ksH4e2sVsiQV6k1EQ--
