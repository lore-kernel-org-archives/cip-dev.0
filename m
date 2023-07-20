Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A771EB64DC
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 14:42:16 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.14716.1689864135089665573
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 07:42:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ze6qqe+w;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1b9c368f4b5so13972525ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689864134; x=1690468934;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7RoU1lZ5gJu2495lOybK0Q9xO+MweriVlC6znlB3Cy4=;
        b=ze6qqe+wryNFsqDqLn9TDi2QEo2XcIaJ9i77866ZlXS6F0jHjLqQrydZJ4seYCZMKJ
         O+MW3ZlU0K1Qhr92LnkGXV7Wb0sx8ICC/c+K58krtQm/2Lo77oRTi51HiHrS5Uz0GJiM
         VMQwveMrOgRSXwmjtNWr1ofowxogRWh7PvxRbvMdnwto2VVFRhLWJttmrXkyieUglqu4
         vTwbIq48+pf3tWt5LPsUKHA55qOYZwV3GMlNF1vCT6uW/IKR5FJ5G5T723rkqvQ5fVJg
         HxGSRCXvClZotrv9L4XQAdbQIEAbMJ1N3pUiYTnxZD3oXvOqyOHJ2iHDROfCoNrmPrCa
         /3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864134; x=1690468934;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RoU1lZ5gJu2495lOybK0Q9xO+MweriVlC6znlB3Cy4=;
        b=Jq5O1bC2xVgRSDq/OB3Arr4yPZ0lp1mpW0xlLeqm+ReLUP/xlvCL2vuotmU69XtZKB
         JPje6drSwLTYS1MspdxmAd91Os2AusX8milotBDRxtscyR2bjwZMy5soTg9Z2WhK8xmR
         WW3SHP8BLNk/FAvI+BbzkOPxWjj5wirpQphi8MqPtkciVF1M/ry0A4S/6ndwrNn80aKA
         Ma+NODFPzOBY9f7bdfMInfyA2sNVP1eNzk4SXSIvFmGA4A50H+hJLz37v2kbh/5xnoWA
         bbR6qfBPsDUcFIZlLJdDSlmlhig/JzNRpRESYdohrA9RgWLO4TshPYzVbdgmSxX8hKZU
         A8Dg==
X-Gm-Message-State: ABy/qLagtUSQrI0HKkb6j52+VWf4apAE9040u2vf2eFHq6GAcNKBnbRh
	vTQ8CfDq1jVUKMIaIdQFBV+RPilYIepdTcaHClhpEw==
X-Google-Smtp-Source: APBJJlHVb+XKaOReK/a3idvFtggK80IvnKlVPMZSOAWF7lYXgQ6vOeDYHBH9roySzSxZkvz8xbA6nw==
X-Received: by 2002:a17:902:d485:b0:1ba:fe6a:3845 with SMTP id c5-20020a170902d48500b001bafe6a3845mr8191274plg.11.1689864134123;
        Thu, 20 Jul 2023 07:42:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001b89612dc7dsm1454083plb.142.2023.07.20.07.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 07:42:13 -0700 (PDT)
Message-ID: <64b947c5.170a0220.b17f9.211c@mx.google.com>
Date: Thu, 20 Jul 2023 07:42:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.38-cip1-10-gf4eb42f19246
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline-nfs: 4 runs,
 1 regressions (v6.1.38-cip1-10-gf4eb42f19246)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 14:42:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12474

cip/linux-6.1.y-cip baseline-nfs: 4 runs, 1 regressions (v6.1.38-cip1-10-gf=
4eb42f19246)

Regressions Summary
-------------------

platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.38-cip1-10-gf4eb42f19246/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.38-cip1-10-gf4eb42f19246
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f4eb42f1924629d499c0622f4aa8616d1d719851 =



Test Regressions
---------------- =



platform   | arch | lab         | compiler | defconfig           | regressi=
ons
-----------+------+-------------+----------+---------------------+---------=
---
imx6q-udoo | arm  | lab-broonie | gcc-10   | imx_v6_v7_defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64b9450b92b8b7f71e8ace26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-10-gf4eb42f19246/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-10-gf4eb42f19246/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b9450b92b8b7f71=
e8ace27
        new failure (last pass: v6.1.31-65-ge66be31505fa) =

 =20

