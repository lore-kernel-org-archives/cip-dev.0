Return-Path: <SRS0=cJ0T=M7=lists.cip-project.org=bounce+64572+6660+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93FCC4338F
	for <cip-dev@archiver.kernel.org>; Sun,  8 Aug 2021 09:33:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0824A60C41
	for <cip-dev@archiver.kernel.org>; Sun,  8 Aug 2021 09:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0824A60C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id vXNPYY4521723xHHvFDhd9co; Sun, 08 Aug 2021 02:33:19 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.7920.1628415198025043480
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Aug 2021 02:33:18 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id BE1EE1C0B7C; Sun,  8 Aug 2021 11:33:12 +0200 (CEST)
Date: Sun, 8 Aug 2021 11:33:12 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] lts-commit-lists updated: up to 5.10.55 and 4.19.200
Message-ID: <20210808093312.GA4923@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: OPuZkF4cgY6gIenTzqbdTSZjx4520388AA=
Content-Type: multipart/mixed; boundary="VK2fdrSiGF5k93th6510"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628415199;
 bh=ERX+HgoMBC3TnOnA6/GLtua0mqWfMGW4eqe7iyOE/nU=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PoIUf9tAr3+kvnfN7Fno72KhB1zUkPocmwttb6NpWBmwq7u8t8iA92+ns/qYiRk4suB
 YbXc412BH84w/eFnlInWJfvEZU7AkIXInmnpd7NcdLUn6058LDbyzQPgKyEfJ/5pZnGya
 X7zazLSO6lOzvEvL24aZvCMyq1/X95yC+KQ=

--VK2fdrSiGF5k93th6510
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I have pushed updates to lts-commit-lists, it should now include
reviews up-to 5.10.55 and 4.19.200.

I'm not primarily focusing on reviewing 4.4.X patches, but due to way
reviews are done, I have some reviews for 4.4.X, too. I'll merge them
soon, unless someone objects.

Best regards,
       		  	      		      	       	   Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYQ+k2AAKCRAw5/Bqldv6
8olJAKCqdbMv3hV5FGdBVOudMDpoLdDBswCeIfErmkzVeGWoxi3QYKABF85lm+8=
=2UnF
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--VK2fdrSiGF5k93th6510
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6660): https://lists.cip-project.org/g/cip-dev/message/=
6660
Mute This Topic: https://lists.cip-project.org/mt/84743932/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--VK2fdrSiGF5k93th6510--
