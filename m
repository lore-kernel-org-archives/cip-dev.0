Return-Path: <SRS0=LLEs=G4=lists.cip-project.org=bounce+64572+6141+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2A7C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 25 Jan 2021 20:17:43 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D95A22582
	for <cip-dev@archiver.kernel.org>; Mon, 25 Jan 2021 20:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D95A22582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6141+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZTWXYY4521723xL00IXnsFxE; Mon, 25 Jan 2021 12:17:40 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web12.1696.1611605859544314965
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Jan 2021 12:17:40 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 652E11C0B78; Mon, 25 Jan 2021 21:17:35 +0100 (CET)
Date: Mon, 25 Jan 2021 21:17:34 +0100
From: "Pavel Machek" <pavel@ucw.cz>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: [cip-dev] Siemens board failed to boot testing 5.10
Message-ID: <20210125201734.GA26811@duo.ucw.cz>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: perJtB0XF0bae72EWWfh9dl9x4520388AA=
Content-Type: multipart/mixed; boundary="vO7LfQfRG7fVZIJxioSj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611605860;
 bh=KsvV8Fs5KS+vKs3WWTVtoB7PXaLcoQE6M/VlcP+bAFY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=PfkM4yJ6ha3wG2yNAJWuO7HZXH2bb/mXae8T+g4GvNoPV1gboxMTZuj0YMBXm24z/+d
 xVv94NF2yajDJZNS+yp2QsdmkvE9WrwdFt/oXC9EdHrEJqpCytHWH31sZjVi1uh9T2h4y
 vVettMDPXfubQJmCro6Y9mFpt/MRBS/RGG4=

--vO7LfQfRG7fVZIJxioSj
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Something went wrong on siemens board... I'll try to resubmit the job.

https://lava.ciplatform.org/scheduler/job/148648#L266

Best regards,
								Pavel

InfrastructureError: The Infrastructure is not working correctly. Please re=
port this error to LAVA admins.
case: job
case_id: 3494716
definition: lava
error_msg: bootloader-commands timed out after 96 seconds
error_type: Infrastructure

--=20
http://www.livejournal.com/~pavelmachek

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYA8nXgAKCRAw5/Bqldv6
8m6TAJ9c21sSGUZ0waXzg7j/HiVB2pr1lgCfRuTs5AKAFWJFFuNE+lrfyGniOxg=
=73b4
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

--vO7LfQfRG7fVZIJxioSj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6141): https://lists.cip-project.org/g/cip-dev/message=
/6141
Mute This Topic: https://lists.cip-project.org/mt/80114267/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--vO7LfQfRG7fVZIJxioSj--
