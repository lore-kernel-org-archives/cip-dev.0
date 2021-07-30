Return-Path: <SRS0=yYH0=MW=lists.cip-project.org=bounce+64572+6644+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A9FC432BE
	for <cip-dev@archiver.kernel.org>; Fri, 30 Jul 2021 10:26:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E279660EE6
	for <cip-dev@archiver.kernel.org>; Fri, 30 Jul 2021 10:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E279660EE6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GqL2YY4521723xEf4oIu6Bsy; Fri, 30 Jul 2021 03:26:38 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.22223.1627640797035373805
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Jul 2021 03:26:37 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6CDC21C0B79; Fri, 30 Jul 2021 12:26:33 +0200 (CEST)
Date: Fri, 30 Jul 2021 12:26:32 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [cip-dev] 4.4.277-rt224 released
Message-ID: <20210730102632.GA3234@duo.ucw.cz>
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
X-Gm-Message-State: hStAECI03CvFe4oIdTbH3pQkx4520388AA=
Content-Type: multipart/mixed; boundary="RzYqnnCZL1ukW9Rzn2nf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627640798;
 bh=734LVHaTKqCNQokHKaJx5JWBiyoX5pH9zuOCoflmSjw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=u3kXN31MLCHiGRNcY+1kRbD6estNDjmLQiClZJkeZhW6Ob9iEvWVzSZyq8rbmGyn5J0
 4pLBhv+2mgVWO5QlAC0mpM00EEwiP0dzFmImVdIBZlZlnVkJrQqBZsTlkZQpgcJRfhNNL
 7hFE7zdI+z5vb8WsZtii9sHi8dxBGGdhBE8=

--RzYqnnCZL1ukW9Rzn2nf
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

4.4.277-rt224 is out, and it would be useful to do -cip-rt release
based on that. Would it be possible to do -cip release based on
4.4.277?

Thank you,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYQPT2AAKCRAw5/Bqldv6
8q1mAJ9HUB0WoJOWcmXTdD2M97tfs8v7igCgq2Dwg+YJDSksC6ZkhNFAmNANEUM=
=RpMd
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

--RzYqnnCZL1ukW9Rzn2nf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6644): https://lists.cip-project.org/g/cip-dev/message=
/6644
Mute This Topic: https://lists.cip-project.org/mt/84547413/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--RzYqnnCZL1ukW9Rzn2nf--
