Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B8DC433EF
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 09:05:04 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web08.2412.1655283895750542978
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:04:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=bSayu50i;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id f65so10809470pgc.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 15 Jun 2022 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=tbFKQMKLQBbRd51+EsDlPSy4IPFeyaAnJm94ZGGpF9g=;
        b=bSayu50il9bAopiYqeiCfQ/efH8bC4himpN7fCVLWpanTDdB4gWH3AUF7+sLi1Nifa
         tyr53dGbgeNpz9g9BvKuYSlkHlFuKf44pt31ceKAXtBpdyBJBJwvW0KgY3do20cOu6Tr
         NImgmWP97NfUkorbfHLA0Jo6eI6UjS0rAsovLPA/2JaQkhDWrzL8CiRZ+hZMlmkC3YX3
         LbtnPRv6vvC6Hd3qw4fxNKhNebHjV8CdzUrY0EI7Z518scXXHnvYVa+3hFBW0jBzx1p4
         UhBBEKxBeqLFRa1AfBpPSMmS77N4eNAssyPFMZAW4SiqMMJgU6he8Ma38kaM9w1Wvpbc
         a97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=tbFKQMKLQBbRd51+EsDlPSy4IPFeyaAnJm94ZGGpF9g=;
        b=mYuzFRLA64MHroPQI+R1HcmwZ7wy3TXNQSMocy9RSgFPBtlAlFU4jbIDR9TlloURN5
         +Sc1VsLf6qtl5uQ7jMJLniAKglcZ8oqG1Sx5g/SOFB348mZ3ddX7XWi9LiOn0zmXBGsM
         UUqBDtg3ZP+qofBShhuDhXOHp0xM0ZemQH7LWJYLvXWBbeN5pas6L/RVpyRpFK6WN8Yj
         i9bYR7xA7lYlNX6Na5iLrLsRueQIN0oqzqSbM414i9ozq0S/lC9ll7n9yVbc3XqTYvNd
         vH68bmrNtZYr46zmOX3BkLRBico065HDNH0uS8pPQArY6Mm4N8n+Wmx2xtNLKTr6RMVt
         4vxA==
X-Gm-Message-State: AOAM533gLpELx1I0ou0+01QZsI7Y0Q1Qe490mIWR+mIJBaNErNrumo5e
	ahJcKqDjO3bxWmpA7e2SoyzVXMUI08A3R/KwvvQ=
X-Google-Smtp-Source: 
 AGRyM1veaVJZm2tx1MWmj5rMFk0k0SpX5IWKeATGu/OJZO4QWfWdgKH2HITt7axzB9vq5ULvWxZI1w==
X-Received: by 2002:aa7:88d2:0:b0:50a:cf7d:6ff1 with SMTP id
 k18-20020aa788d2000000b0050acf7d6ff1mr8761726pff.67.1655283894730;
        Wed, 15 Jun 2022 02:04:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 v17-20020a170902d09100b0016168e90f2csm8700563plv.208.2022.06.15.02.04.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:04:54 -0700 (PDT)
Message-ID: <62a9a0b6.1c69fb81.3e3d6.b2e1@mx.google.com>
Date: Wed, 15 Jun 2022 02:04:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-312-g3a12bf5207d81
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 2 runs,
 2 regressions (v4.4-st5-312-g3a12bf5207d81)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jun 2022 09:05:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8559

cip-gitlab/ci/pavel/linux-test baseline-cip-nfs: 2 runs, 2 regressions (v4.=
4-st5-312-g3a12bf5207d81)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-312-g3a12bf5207d81/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-312-g3a12bf5207d81
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a12bf5207d810922b696a4c99c88e2841af6212 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/62a758df7fd51aab4da39bd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-broonie/base=
line-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/62a758df7fd51=
aab4da39bd3
        failing since 33 days (last pass: v5.10.109-cip5-384-g722204542e8a,=
 first fail: v4.4-st5-260-gb0fe64f485ff) =

 =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/62a7566aba9e217037a39be5

  Results:     3 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-312-g3a12bf5207d81/arm/multi_v7_defconfig/gcc-10/lab-cip/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20211105/qemu=
-arm/cip-core-image-kernelci-cip-core-buster-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.dmesg.crit: https://kernelci.org/test/case/id/62a7566a=
ba9e217037a39be8
        failing since 15 days (last pass: v5.10.112-cip6, first fail: v4.4-=
st5-297-gc0d53c2a5c03d)
        1 lines

    2022-06-13T15:23:04.705760  / # =

    2022-06-13T15:23:04.713207  =

    2022-06-13T15:23:09.746029  / # export NFS_ROOTFS=3D'/var/lib/lava/disp=
atcher/tmp/697172/extract-nfsrootfs-1zssbssy'
    2022-06-13T15:23:09.756852  export NFS_ROOTFS=3D'/var/lib/lava/dispatch=
er/tmp/697172/extract-nfsrootfs-</lib/lava/dispatcher/tmp/697172/extract-nf=
srootfs-1                         zssbssy'
    2022-06-13T15:23:11.817894  / # export NFS_SERVER_IP=3D'172.16.3.3'
    2022-06-13T15:23:11.828631  export NFS_SERVER_IP=3D'172.16.3.3'
    2022-06-13T15:23:11.940192  / # #
    2022-06-13T15:23:11.947294  #
    2022-06-13T15:23:12.059637  / # export SHELL=3D/bin/sh
    2022-06-13T15:23:12.065730  export SHELL=3D/bin/sh =

    ... (13 line(s) more)  =

 =20

