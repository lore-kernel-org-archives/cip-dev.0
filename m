Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D68C46467
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 16:05:34 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.19518.1674057925411326825
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 08:05:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=bDeyjSge;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id z13so9533277plg.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 08:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q+RGMI75tWodagShoWn/iAIFGN+rCjqz8iD2xdICQg0=;
        b=bDeyjSgeqYHhczUzi7IkxzRlm5iWoc9J6SN58OqxRxCGu+i3++hka37BGIan3xXAs5
         rigGal7G/prLnAfLT0kao0fTBkk5WSTSQqP+XI48UVN8MdBKNX+E5F6UNn+xa7rJ5nvP
         V+ejLs74Uds0tUiDIfoTE+bbObKj5Vx1NL5PE7c3WtjivocYRHaBpZWP2RZ8KSYn44NY
         CSj5OD9jKUtOq+br9mHCt561T+iFvExwrcDJVghFxJaoxGJ68v4qh93yJs1N1wbzIIrH
         gjntNSd3VF7LnlLMAgQjPzISbirzGxj+M6wOKhNJWEWldt/4I7DVFfUrV/WWa6u3Rr5c
         sRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+RGMI75tWodagShoWn/iAIFGN+rCjqz8iD2xdICQg0=;
        b=z6NXTkSxc0nhRDhjoWU5H3uVfm+42LWWV3iNIdKVDO2j8f6DLNsszM5suC2OBKh1cp
         yvEPq4GXHFeUV1jBRq7xT3nqQB2fTzmTUwcFbIhp1Vn2mrDYzdgqYjxsFiLY0c39BG7f
         YwH4OT/+138cGok8aW3Cmb2TtO1HI6UyA+urR/M+9/X2rRmINt77IHkxOriInrg5sDzT
         8Px+TSiWX/wy4hH/zl+BjpPZ7mYSwLD85P7mmoGY80M4hWDZfNKOMdmuPo/6OqFxQnJu
         m7eE1rYAnF1xsK+fZi3ewAK8+NObkpSmuBJxTJd2j4zCEX/WsMyDsn/rfInt3QHhtOXG
         pltQ==
X-Gm-Message-State: AFqh2kowo+I2yKhjRhz1WytqXbgJBudd4dVMlcwg3OEo3DYHb/YTlFmr
	nU++FqbJI49aXbPcw2FNboS9IhfBxAMgg4e7ieq+SQ==
X-Google-Smtp-Source: AMrXdXvx86C5HEFVh6ZitoFtT8g+0mD30B8eFvX+DWMw7CuXrfh1KSLFUGk5QVCC2KFsCI27eMlwSw==
X-Received: by 2002:a05:6a21:3946:b0:b8:8153:50fc with SMTP id ac6-20020a056a21394600b000b8815350fcmr7749924pzc.41.1674057924259;
        Wed, 18 Jan 2023 08:05:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x73-20020a62864c000000b0058d8f23af26sm7277884pfd.157.2023.01.18.08.05.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:05:23 -0800 (PST)
Message-ID: <63c818c3.620a0220.27d77.b9f1@mx.google.com>
Date: Wed, 18 Jan 2023 08:05:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.162-cip24-853-g709bb3738fde
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 170 runs,
 3 regressions (v5.10.162-cip24-853-g709bb3738fde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 16:05:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10390

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 170 runs, 3 regression=
s (v5.10.162-cip24-853-g709bb3738fde)

Regressions Summary
-------------------

platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
beaglebone-black  | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1=
          =

beaglebone-black  | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1=
          =

r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig  | 1=
          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-853-g709bb3738fde/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-853-g709bb3738fde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      709bb3738fde9ab95ab1303d161730f508a6659e =



Test Regressions
---------------- =



platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
beaglebone-black  | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/63c80a55bf89ffe492915ec9

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm/omap2plus_defconfig/gcc-=
10/lab-broonie/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c80a55bf89ffe492915ece
        failing since 14 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-01-18T15:03:30.967626  <8>[   19.316043] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 135157_1.5.2.4.1>
    2023-01-18T15:03:31.075787  / # #
    2023-01-18T15:03:31.177996  export SHELL=3D/bin/sh
    2023-01-18T15:03:31.178435  #
    2023-01-18T15:03:31.280037  / # export SHELL=3D/bin/sh. /lava-135157/en=
vironment
    2023-01-18T15:03:31.281367  =

    2023-01-18T15:03:31.384210  / # . /lava-135157/environment/lava-135157/=
bin/lava-test-runner /lava-135157/1
    2023-01-18T15:03:31.385512  =

    2023-01-18T15:03:31.389681  / # /lava-135157/bin/lava-test-runner /lava=
-135157/1
    2023-01-18T15:03:31.497234  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
beaglebone-black  | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/63c80a40cabb7661df915ecc

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm/omap2plus_defconfig/gcc-=
10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/63c80a40cabb7661df915ecf
        failing since 14 days (last pass: v5.10.155-cip21-405-g26d566555c3d=
e, first fail: v5.10.161-cip23-65-gca8c192cb189)

    2023-01-18T15:03:14.823799  <8>[   13.118807] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 827722_1.5.2.4.1>
    2023-01-18T15:03:14.933566  / # #
    2023-01-18T15:03:15.034993  export SHELL=3D/bin/sh
    2023-01-18T15:03:15.035310  #
    2023-01-18T15:03:15.136480  / # export SHELL=3D/bin/sh. /lava-827722/en=
vironment
    2023-01-18T15:03:15.136799  =

    2023-01-18T15:03:15.238008  / # . /lava-827722/environment/lava-827722/=
bin/lava-test-runner /lava-827722/1
    2023-01-18T15:03:15.238534  =

    2023-01-18T15:03:15.244472  / # /lava-827722/bin/lava-test-runner /lava=
-827722/1
    2023-01-18T15:03:15.350995  + export 'TESTRUN_ID=3D1_bootrr' =

    ... (11 line(s) more)  =

 =



platform          | arch | lab         | compiler | defconfig           | r=
egressions
------------------+------+-------------+----------+---------------------+--=
----------
r8a7743-iwg20d-q7 | arm  | lab-cip     | gcc-10   | shmobile_defconfig  | 1=
          =


  Details:     https://kernelci.org/test/plan/id/63c809bb953cd7a6ac915ec2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-853-g709bb3738fde/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/63c809bb953cd7a6ac915=
ec3
        failing since 84 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =20

