Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15848C433EF
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 01:02:40 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web12.1422.1658797358802543912
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:02:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=MKcp/B7/;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id
 t2-20020a17090a4e4200b001f21572f3a4so11821919pjl.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Uh9jFLg012n/LIGNBwYVagQrjVgNIKcxBfwgZiZb7rk=;
        b=MKcp/B7/fvlkMxk3tQIJFJu2H1d7SghsdZIUOl5xPkgJNjuWpyplNYJ1xXkaxxBikK
         pxt1X7W5Exrsh00bvNtaYET3ztBiZF3Ls6yyaGI1T1wP8P9Exz2JuUdlUudgE5FUqW45
         KRK7kBMXXKo09VVFjUIPkSNmxzbGZisczIHSzaPj7qhb3+OguuVEoIFw59oUjNrzZpI5
         JeWVGRv2ZBFn1EbioCdSWZk23YxGMjzBqBrG985ba4xp8sEPTLikoruN6B0ChzQHbp6j
         FFoZtuZg+V63DJDZSEZYKFicsMe444ylqrbwNJouNckW39oF+vgtdgtUA7VdoZSx5Hpz
         NbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Uh9jFLg012n/LIGNBwYVagQrjVgNIKcxBfwgZiZb7rk=;
        b=OEHHqi435tbLADvKppNkUNRwFcdi6kR8O/7TP3BOpWOPMeE2BbNAsxJBWyXGRPTkuR
         shNAUXejlfzxaIFUqME+XPtO0t4MCe3Lq2AIcNGJcW+BA/TQezp+wLFcZgz3KCOr2Mj8
         QtSL6E4HrJmIAAps/R4TYZFbOyUbb+7C51+O1WxBGkb9sW2xPXbVGT39yOEjVhA8moEN
         RXy1U3lBmyxjndR2QdttUpsUueWKf+MbRVfDy/94zBvMnfcmgy0tZc2XUZWpwOMcUCzH
         LAVTLJAbe1Q3mG+xspDfJGmSicQXOxc6K+t5nsAQ8Lwwj6caJKHLE/tWn0xNjPdFzZwH
         cE3Q==
X-Gm-Message-State: AJIora/1VbOZd9ClLDLYq3tX+09INrPnEh98DaJpTfnVV+8EMEHx7o0k
	D6ROWVUKq+bEK1Ld594AK7ugO7UheemMxmPY
X-Google-Smtp-Source: 
 AGRyM1va0FR8AaWyCy8aUVMoKB26YMxfFAbEbm0mAyuNkFkvW7ToGGsWZDF0KIZH6rwQOZpyCZ5VPA==
X-Received: by 2002:a17:902:e551:b0:16d:8469:bd91 with SMTP id
 n17-20020a170902e55100b0016d8469bd91mr4927572plf.111.1658797357758;
        Mon, 25 Jul 2022 18:02:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 r22-20020a170902be1600b0016c28a68ad0sm9748646pls.253.2022.07.25.18.02.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:02:37 -0700 (PDT)
Message-ID: <62df3d2d.1c69fb81.bcc85.f5cb@mx.google.com>
Date: Mon, 25 Jul 2022 18:02:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 13 runs,
 1 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 01:02:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8910

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 13 runs, 1 regressions (v5=
.10.129-cip12-36-g21d9d56f4de5a)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.129-cip12-36-g21d9d56f4de5a/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/62df35c657216cd317daf08a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.129-cip12-36-g21d9d56f4de5a/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/baseline-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62df35c657216=
cd317daf08b
        failing since 75 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =20

