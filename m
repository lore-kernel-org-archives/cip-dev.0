Return-Path: <SRS0=Qjyp=JX=lists.cip-project.org=bounce+64572+6395+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F1CC433ED
	for <cip-dev@archiver.kernel.org>; Mon, 26 Apr 2021 11:15:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820DA61177
	for <cip-dev@archiver.kernel.org>; Mon, 26 Apr 2021 11:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820DA61177
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6395+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jt3ZYY4521723xBuazyjphgn; Mon, 26 Apr 2021 04:15:48 -0700
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web11.5477.1619435746387676262
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Apr 2021 04:15:47 -0700
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 48E2C1C0B77; Mon, 26 Apr 2021 13:15:42 +0200 (CEST)
Date: Mon, 26 Apr 2021 13:15:41 +0200
From: "Pavel Machek" <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: [cip-dev] Failing -stable-rc testing
Message-ID: <20210426111541.GA16094@duo.ucw.cz>
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
X-Gm-Message-State: XwQUHbEZ9IuZ9rPpFwEyIMLbx4520388AA=
Content-Type: multipart/mixed; boundary="7qRp1H5vLpbUcofBs1UP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619435748;
 bh=iGs9Veeh2YBc5Z4knCv9+ngfs9no5pTrrtPL1GkCrpI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=mAfk/xYdYpe7hsq0mQa5UH1FpUJ0mFKWDNkyA46kJhMzuZajMAf+EDfD5SZrzG1HJ9n
 DyEg/1Mkhk4T/+P/8s15fL1wL19g2EBT7xeANvTlWTyFHhlDA86B/rfzKsxk2/PnnCtcv
 LWfPCXBqgahtzLUBb3XvSXrq+J0CgwLmKsc=

--7qRp1H5vLpbUcofBs1UP
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This happened several times now:

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/jobs/121116=
8409

Waiting for pod gitlab/runner-z9bugs8s-project-14394223-concurrent-9kltbz t=
o be running, status is Pending
477Running on runner-z9bugs8s-project-14394223-concurrent-9kltbz via cip-pr=
oject-v4-small-gitlab-runner-65458d45f8-nsqq6...
479
Skipping Git repository setup
00:02
480Skipping Git checkout
481Skipping Git submodules setup
484
Downloading artifacts for build:arm64_defconfig (1211168356)...
02:05
485Downloading artifacts from coordinator... ok        id=3D1211168356 resp=
onseStatus=3D200 OK token=3DU-WPxTXQ
487
$ /opt/submit_tests.sh
34:12
488-----------------
489Creating test job
490-----------------
491Version: Image_defconfig_5.10.33-rc1_f52b4f86d
492Arch: arm64
493Config: defconfig
494Device: r8a774a1-hihope-rzg2m-ex
495Kernel: Image
496DTB: r8a774a1-hihope-rzg2m-ex.dtb
497Modules: N/A
498Test: boot
499------------------
500Uploading binaries
501------------------
502upload: output/Image_defconfig_5.10.33-rc1_f52b4f86d/arm64/defconfig/mod=
ules/modules.tar.gz to s3://download.cip-project.org/ciptesting/ci/Image_de=
fconfig_5.10.33-rc1_f52b4f86d/arm64/defconfig/modules/modules.tar.gz
506ERROR: Job failed: execution took longer than 2h0m0s seconds

Leading to -stable-rc test failure. It may have something to do with
4.19 and 5.10 -stable-rc's arriving closely together. I suspect
reruning the job will solve it.

(I don't want to do that now to preserve the debug info; but if you
could re-run it when you are done debugging, that would be nice.)

Best regards,	     	     	  	     	  	   Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYIag3QAKCRAw5/Bqldv6
8rjvAKCPxR2Dm7JFZIdIOLXOhGZ4NFZOkwCferhOcWK0RkINO/+153zCzBBFaP8=
=RYjq
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--7qRp1H5vLpbUcofBs1UP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6395): https://lists.cip-project.org/g/cip-dev/message=
/6395
Mute This Topic: https://lists.cip-project.org/mt/82375214/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7qRp1H5vLpbUcofBs1UP--
