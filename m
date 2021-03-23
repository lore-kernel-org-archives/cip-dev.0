Return-Path: <SRS0=eBVD=IV=lists.cip-project.org=bounce+64572+6321+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B445EC433DB
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 22:55:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDE5619A9
	for <cip-dev@archiver.kernel.org>; Tue, 23 Mar 2021 22:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDE5619A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6321+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jAVhYY4521723xdI5mVLuZBh; Tue, 23 Mar 2021 15:55:02 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web10.774.1616540101059578538
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Mar 2021 15:55:01 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 9073B1C0B77; Tue, 23 Mar 2021 23:54:55 +0100 (CET)
Date: Tue, 23 Mar 2021 23:54:55 +0100
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: [cip-dev] 4.19-rt tests on zynqmp
Message-ID: <20210323225455.GA22020@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uaxuXuPtz1sY2dg2W8jFXzCxx4520388AA=
Content-Type: multipart/mixed; boundary="GWJukmXaiGLosuTzjMpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616540102;
 bh=gNSRMuiMczkg639OFX1mGPgYOW5J7gUgnob3s87xYEc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=paCwb1YnAQj0Aej5mKwN6PzROZaLFEMPx83xcNowmz0RtOVdEFvPcDosklmKXleSFAF
 6+BY6nzs5Odf+75gLKb+J4PhXBkNa+elksIh4rgDv+vXCzqPJ9uV/tN0YxQIfRJByiGRV
 CXRYLQbl1evefrkkvI438c08a+Xw4dRj7Io=

--GWJukmXaiGLosuTzjMpq
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm preparing new 4.19-rt release, and I see tests failing on zynqmp.

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/275281028

But they fail on old release, too, and IIRC 4.19 simply does not
support zynqmp.

So I believe this is not a kernel failure. If I'm wrong, let me know.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYFpxvwAKCRAw5/Bqldv6
8ruKAJ4yzwLt/D82dXyUE+mh70DHfWyvNACeKA8ZOoPvrFFIU/5Pn2+HjTR+aXM=
=6bFr
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

--GWJukmXaiGLosuTzjMpq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6321): https://lists.cip-project.org/g/cip-dev/message=
/6321
Mute This Topic: https://lists.cip-project.org/mt/81564242/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GWJukmXaiGLosuTzjMpq--
