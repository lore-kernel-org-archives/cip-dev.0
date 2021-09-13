Return-Path: <SRS0=eQ7C=OD=lists.cip-project.org=bounce+64572+6733+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB673C433F5
	for <cip-dev@archiver.kernel.org>; Mon, 13 Sep 2021 19:01:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B0360E8B
	for <cip-dev@archiver.kernel.org>; Mon, 13 Sep 2021 19:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 44B0360E8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TJHDYY4521723xRvV1nIUL4G; Mon, 13 Sep 2021 12:01:35 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.1441.1631559694156712762
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Sep 2021 12:01:35 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id EE1BF1C0B7A; Mon, 13 Sep 2021 21:01:16 +0200 (CEST)
Date: Mon, 13 Sep 2021 21:01:16 +0200
From: "Pavel Machek" <pavel@denx.de>
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org, SZ.Lin@moxa.com,
	Chris.Paterson2@renesas.com
Subject: [cip-dev] [ANNOUNCE] v4.19.206-cip57-rt22 (-rt87)
Message-ID: <20210913190116.GA12232@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: dkEAtAcGsLPMmXuYRuQYHo4wx4520388AA=
Content-Type: multipart/mixed; boundary="f18XtclfMwjrm1BpG4R2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631559695;
 bh=cqLRXfe11fyvmELKE7Nm5oLpUWzJYeyYqG17fU5U+Z4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=HjpvHui5DLxK6sSSG7Bw7dyrjc1c/eWMifoSFhKRQqed6/F2jRg1zYnFcRIEqdWKfKF
 tXod6zBTxt+IQVfqyFlFhU0Ltf9MtamYCANO/i9KSB4r2A0Aq173ngD1AKY12lVxstZMf
 FJxhp/KN6vXZGdFJy/hGjpR+loAelWE6ets=

--f18XtclfMwjrm1BpG4R2
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

New realtime trees should be available at kernel.org.

Trees are available at

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt
https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=3D=
linux-4.19.y-cip-rt-rebase

And their content should be identical.

Best regards,
                                                                Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmE/n/sACgkQMOfwapXb+vLpHwCgik2OYMmGzHqXJraaTJombQoZ
VoQAn0SFDAP6XTEB83HgdPFF4xnQU7R+
=3NGQ
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

--f18XtclfMwjrm1BpG4R2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6733): https://lists.cip-project.org/g/cip-dev/message/=
6733
Mute This Topic: https://lists.cip-project.org/mt/85583818/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--f18XtclfMwjrm1BpG4R2--
