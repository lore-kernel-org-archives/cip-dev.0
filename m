X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web09.8.1649864899199050550
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Apr 2022 08:48:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=OVoGHYpQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id 12so2286895pll.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Apr 2022 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=YrWUu2Cg0kXjFfTwnjo5CfpSJNmzakkIr/nTArQzzfE=;
        b=OVoGHYpQc0/lIm2paMFG8HPffoSI2JKs2Do0OQJ7EfyCEVP/Jw7Nds507/dYYALxQk
         4O+2daFwmfUSBefCItuqRpAj/YtWaZPtF+9xpCMjwIU1T0CChUb5oiWT7GY11XL/UPAb
         8IeXRjb874zQKUp0jNxeRmVJYdVrUK8jB5UtWhvWVPOd6cQnqOEv4ltXXychIK1subJX
         BrZ3c5OtnlGK/gorlIIKdFRr2o1n17CBXGSf/+AAsDthnjaSyNzM3A2DcNU3EklfNdxj
         gG0SE0FLF+NoLRzvOKTBj9CkYUnt3pkMjFeaU1fr6ESEp0H5DDGU2GV6QvdYb5Ytb3en
         /s9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=YrWUu2Cg0kXjFfTwnjo5CfpSJNmzakkIr/nTArQzzfE=;
        b=ehm/1Z7g8pyITo4e37hFpKsPollzgpa5FVZFG/fk5OSdVHvZ0zPwCzWluQ8TBSOyZj
         IZfsNsXu9m0bZHcQbgkSKNlwjF0K2lwbwaTg1RlEk9tsDzaYguJ4nEnO4tnHJYKjMqL+
         OYix4r5P7x4VpBt5h17vQVziGKbODqJYqCd+BHZPjrUDsPtG9fleiUarh6O3OrveZekf
         EEwL6ELKEUG0i/e+/HzokSL4MXo+IReM7eKxdMy7PA/mw31bishxQSq94B+EAq2bzBI7
         Y1Edh0zrpAKLeHhJVY4unz3pmtuSxInOgTdoYtvIUA5KJfc/Vp5OisjxxcdgP/Rj9nGc
         dsXg==
X-Gm-Message-State: AOAM532JU2qUKqk1dMPavZOMUxawIiaDIER/ExbaXULzx7wFvJoyfYQ+
	V2J/CLmPCLafohjPC+vLNWvo3YZOk4Ux5rYC
X-Google-Smtp-Source: ABdhPJxJt2tUinISwoVbuzLzXInlBrj0m428NoyHseSrvINt1DMVjXFQBJLfOQPCTcbBQX6zVz5Vvw==
X-Received: by 2002:a17:90a:c504:b0:1bf:6d9f:65a6 with SMTP id k4-20020a17090ac50400b001bf6d9f65a6mr11536778pjt.204.1649864898491;
        Wed, 13 Apr 2022 08:48:18 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j6-20020aa79286000000b004fdf02851eesm35029504pfa.4.2022.04.13.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:48:18 -0700 (PDT)
Message-ID: <6256f0c2.1c69fb81.4e572.c307@mx.google.com>
Date: Wed, 13 Apr 2022 08:48:18 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.237-cip71
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline: 34 runs, 1 regressions (v4.19.237-cip71) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip/linux-4.19.y-cip baseline: 34 runs, 1 regressions (v4.19.237-cip71)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.237-cip71/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.237-cip71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      281476f1d7ee9f59c39dc78e7adb7238cfa54bd0 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6256ea1f388b5ef1b9ae06bc

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.237=
-cip71/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.237=
-cip71/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220401.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6256ea1f388b5ef1b9ae06de
        failing since 15 days (last pass: v4.19.229-cip67, first fail: v4.1=
9.235-cip70)

    2022-04-13T15:19:48.169497  <8>[   35.695698] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>   =

 =20

