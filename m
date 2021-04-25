Return-Path: <SRS0=Qxoe=JW=lists.cip-project.org=bounce+64572+6390+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FED0C433ED
	for <cip-dev@archiver.kernel.org>; Sun, 25 Apr 2021 21:31:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C52361181
	for <cip-dev@archiver.kernel.org>; Sun, 25 Apr 2021 21:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C52361181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6390+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GdjaYY4521723x2nmzXVKauL; Sun, 25 Apr 2021 14:31:24 -0700
X-Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web10.7008.1619386283382682406
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 25 Apr 2021 14:31:23 -0700
X-Received: by mail-pj1-f46.google.com with SMTP id f11-20020a17090a638bb02901524d3a3d48so3992186pjj.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 25 Apr 2021 14:31:23 -0700 (PDT)
X-Gm-Message-State: 7oA8cQPm6vZTfZHxFmPoVYVex4520388AA=
X-Google-Smtp-Source: ABdhPJzEG1G8tOBQMve3RxXVGEc0GD8BX/IDJeZ2BCGn6CkAbVqe690uNUEIr89XRA3Ls1Rxx5z8+w==
X-Received: by 2002:a17:902:ea89:b029:ea:c781:daad with SMTP id x9-20020a170902ea89b02900eac781daadmr15324438plb.62.1619386282784;
        Sun, 25 Apr 2021 14:31:22 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p126sm9675060pga.86.2021.04.25.14.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 14:31:22 -0700 (PDT)
Message-ID: <6085dfaa.1c69fb81.16993.d239@mx.google.com>
Date: Sun, 25 Apr 2021 14:31:22 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.19.188-cip48
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1 regressions (v4.19.188-cip48) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="nH9nJcP0ZFa3YmfahabV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619386284;
 bh=cZ48jEEw2gGGJ+eCGlMPL+Jx0QoJTEAtJXfAkCQJ0oY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=EixljdBWTVRDQEQpPnYp9mjND45NJLF4bQ3siPeTyThoJM9qG5meqbIOza1EuhnU0KZ
 RJuFQ1OtertiEXKfyHQO8DDQqr9sr7o+YrIctHlLLyJcYhynw6obh9sIJzLcuCx/tqvdy
 oC8sxK53tsswi3LDxXz4mT7iiGqRUcgcz38=

--nH9nJcP0ZFa3YmfahabV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 12 runs, 1 regressions (v4.19.188-cip48)

Regressions Summary
-------------------

platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
dove-cubox | arm  | lab-pengutronix | gcc-8    | multi_v7_defconfig | 1    =
      =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.188-cip48/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.188-cip48
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      46c40361addfc061df66c8296e9dc3e717281464 =



Test Regressions
---------------- =



platform   | arch | lab             | compiler | defconfig          | regre=
ssions
-----------+------+-----------------+----------+--------------------+------=
------
dove-cubox | arm  | lab-pengutronix | gcc-8    | multi_v7_defconfig | 1    =
      =


  Details:     https://kernelci.org/test/plan/id/6085d82bdf309379bd9b7799

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0419.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6085d82bdf309379b=
d9b779a
        new failure (last pass: v4.19.186-cip47-1-g4c2cb7ba796b) =

 =20

--nH9nJcP0ZFa3YmfahabV
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6390): https://lists.cip-project.org/g/cip-dev/message=
/6390
Mute This Topic: https://lists.cip-project.org/mt/82364526/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--nH9nJcP0ZFa3YmfahabV--
