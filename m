Return-Path: <SRS0=0c2n=NC=lists.cip-project.org=bounce+64572+6670+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9067FC4338F
	for <cip-dev@archiver.kernel.org>; Wed, 11 Aug 2021 06:39:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99D360720
	for <cip-dev@archiver.kernel.org>; Wed, 11 Aug 2021 06:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E99D360720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id iNExYY4521723xpQwHpuqweV; Tue, 10 Aug 2021 23:39:49 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.4297.1628663987379508919
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Aug 2021 23:39:48 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6962B1C0B76; Wed, 11 Aug 2021 08:39:43 +0200 (CEST)
Date: Wed, 11 Aug 2021 08:39:43 +0200
From: "Pavel Machek" <pavel@denx.de>
To: chris.paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: [cip-dev] -stable-rc tests failing
Message-ID: <20210811063943.GA23723@duo.ucw.cz>
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
X-Gm-Message-State: crIo0q38x0zL6ldYJo7fCysTx4520388AA=
Content-Type: multipart/mixed; boundary="tUcmQiIwVRI13ylS2i8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628663989;
 bh=CcLi0hmWuFWuKmzbQaaNKJiBCVljXg/Fw5elZApfraw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=A5MkjcqxgoGhAWx/cR7pMorW1kF4ebXF4Kj7t029tlT3sNE3XxX+bq2xErVnncfi1MG
 v75ZamDR7jSshoQ+0m5SGFlb+oTIdb4IDMmVYjSl5H1IK8H7mM57vBXHe6xvplDsgposc
 m1OnBs6MJcWTBAm5sjOqX96TZ1deoLYpgWU=

--tUcmQiIwVRI13ylS2i8s
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

-stable-rc testing seems to be failing more than usual.

This is the "usual" failure:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/149307=
7012

WARNING: Retrying...                                error=3Dinvalid argument
2170ERROR: Downloading artifacts from coordinator... error couldn't execute=
 GET against https://gitlab.com/api/v4/jobs/1492901612/artifacts?: Get http=
s://gitlab.com/api/v4/jobs/1492901612/artifacts?: dial tcp: i/o timeout  id=
=3D1492901612 token=3D9gNGsuaZ
2171FATAL: invalid argument                           =20
2173
Uploading artifacts for failed job

But I don't usually see this one:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/149290=
1660

Job #371616: Submitted
219Health: Unknown
220Device Type: r8a7743-iwg20d-q7
221Device: None
222Test: boot
223URL: https://lava.ciplatform.org/scheduler/job/371616
224=20
226ERROR: Job failed: execution took longer than 2h0m0s seconds

Links where all the failures can be seen are:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.4.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
4.19.y
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

I'll try hitting some resubmit buttons, but help would be welcome.

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYRNwrwAKCRAw5/Bqldv6
8uIUAKDByDsSV5oSdPqDSSIQ8gJuQSC17ACeNCfctLJ0tTIFIsyXoRGrGu/gcf8=
=5kcd
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

--tUcmQiIwVRI13ylS2i8s
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6670): https://lists.cip-project.org/g/cip-dev/message/=
6670
Mute This Topic: https://lists.cip-project.org/mt/84811238/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--tUcmQiIwVRI13ylS2i8s--
