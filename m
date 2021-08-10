Return-Path: <SRS0=S3/K=NB=lists.cip-project.org=bounce+64572+6669+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608A4C4320A
	for <cip-dev@archiver.kernel.org>; Tue, 10 Aug 2021 16:23:04 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DAF460F02
	for <cip-dev@archiver.kernel.org>; Tue, 10 Aug 2021 16:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DAF460F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zXdRYY4521723xBKZKNGKbCd; Tue, 10 Aug 2021 09:23:03 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.2739.1628612581448697567
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Aug 2021 09:23:02 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 46FAB1C0B77; Tue, 10 Aug 2021 18:22:43 +0200 (CEST)
Date: Tue, 10 Aug 2021 18:22:42 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] Duplicity & python3
Message-ID: <20210810162242.GA8539@duo.ucw.cz>
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
X-Gm-Message-State: M7J9h88GRI54RfH8kYLzgTLkx4520388AA=
Content-Type: multipart/mixed; boundary="MCYHZG8VM19dYKiP2sLx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628612583;
 bh=TecbnbEwTlCWUvUNLs48g/Q8jU4qfF38dEvye6h01jY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=CyUY3HGYAk7s735QY5v00Pc4OyR8LpYKjWhm6wkr+Aj1HDINnTW5MJ3U0I9rP63Xo09
 S+1l+vqayoa8o5x5Q4n9cErEBCRhV16AuqzGEYmcKKwAMD2XU8lSfJ9U0cIXPz+v0OOAo
 9/ba4yrcodHBejh1elM3aCbdKhVljqIKlI4=

--MCYHZG8VM19dYKiP2sLx
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline

--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There was a lot of talk about Duplicity alternatives because of
python3 issues. I believe we should re-evaluate Duplicity, because
AFAICT it should work with python3 from version 0.8.10+:

http://duplicity.nongnu.org/vers8/CHANGELOG.md

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYRKn0gAKCRAw5/Bqldv6
8i/DAJwK+dbUWFbYLT5EzPDa3SwB3RbQzwCeOFzdEWO8rWNdsQ1s6Ve/UE/MOO0=
=8Fbi
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--

--MCYHZG8VM19dYKiP2sLx
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6669): https://lists.cip-project.org/g/cip-dev/message/=
6669
Mute This Topic: https://lists.cip-project.org/mt/84796821/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MCYHZG8VM19dYKiP2sLx--
