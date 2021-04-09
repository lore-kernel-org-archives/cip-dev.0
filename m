Return-Path: <SRS0=yG4I=JG=lists.cip-project.org=bounce+64572+6355+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755A0C433ED
	for <cip-dev@archiver.kernel.org>; Fri,  9 Apr 2021 11:23:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7379760238
	for <cip-dev@archiver.kernel.org>; Fri,  9 Apr 2021 11:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7379760238
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6355+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZxExYY4521723xNC7Uhgr1zK; Fri, 09 Apr 2021 04:23:05 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.7574.1617967383868862705
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Apr 2021 04:23:04 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id C0FCE1C0B77; Fri,  9 Apr 2021 13:22:58 +0200 (CEST)
Date: Fri, 9 Apr 2021 13:22:57 +0200
From: "Pavel Machek" <pavel@denx.de>
To: cip-dev@lists.cip-project.org, chris.paterson2@renesas.com
Subject: [cip-dev] gitlab problems: -stable mirring broken, testing broken?
Message-ID: <20210409112257.GA13478@amd>
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
X-Gm-Message-State: TKCySKtQIfkrFe9gIe99PKO0x4520388AA=
Content-Type: multipart/mixed; boundary="i9m3oCgGvdwSkgBqaS07"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617967385;
 bh=A2WZI/Tf2kYYC3nD4CiT5id3QaCElsFJQ6dJBWywX1U=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Z6+EaIa6t3IvsltJwj48FUkNGdx2lsZltmXFk0rZBGqBOhGIOKfpUtR3F0VqFfZHqDL
 mhXJ5NFzc+5/hVu3diq9tTs5m6hrjXKoimAj6FkviebUfjXQj0Fv1/nN+o5RPOlmbmE06
 b+jWVxGbCCRgf9CQNZFIRLMzs1EtkCErNDE=

--i9m3oCgGvdwSkgBqaS07
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

gitlab seems to have some problems. 5.10.29-rc1 is not mirrored in
gitlab:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-=
5.10.y

And I'm getting strange error while attempting to test 4.4 kernel:

https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/283833338

Found errors in your .gitlab-ci.yml:
Remote file
`https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/raw/master/=
linux-cip-pipeline.yml`
could not be fetched because of HTTP code `429` error!
You can also test your .gitlab-ci.yml in CI Lint

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBwOREACgkQMOfwapXb+vKBSgCgmQ05AcVQZsJMBLr9f7YnOUYM
MqwAoKqGwv0jUJN6WsNo260jdDE33BvJ
=6E6n
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--

--i9m3oCgGvdwSkgBqaS07
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6355): https://lists.cip-project.org/g/cip-dev/message=
/6355
Mute This Topic: https://lists.cip-project.org/mt/81965841/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--i9m3oCgGvdwSkgBqaS07--
