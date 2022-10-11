Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD05C433FE
	for <webhook@archiver.kernel.org>; Tue, 11 Oct 2022 15:02:51 +0000 (UTC)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web12.8539.1665500559949973185
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=d0eOQbQI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.54,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f54.google.com with SMTP id
 l1-20020a17090a72c100b0020a6949a66aso13496883pjk.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Oct 2022 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8lNxwT7oX3FLLe9ZkJhEMyrfMgxqr37m7uo1dxERaCc=;
        b=d0eOQbQIgyvU9Q3yhnKdcjIzqBTtS8Gdblf8ulfvv3iOL7h+AKcNW5tBkYxJZdo8Up
         jDqQWhRtwXwIvVKCc2K6hCBy7QmX9K9vKXVo6JsW6fEGW4YeKGgIYryZW6JthirO/1Wh
         g7lKav5vNItj5qF/asmZp+MloM3E8c5frzo9kp4DTE9XC0TeQQF+2JEDNnaKp/MK02iK
         MeF8exmUSx5jVqzjXQi6plgfPY6oFmgOjLgQfX7Zf4aPyqa3ooGYBdE3OPoJHqu090+K
         0fVoma7kMzFOBncDBWENi9PFqNm+pFzuQmJ+F7yMpeOK6tFiOAICrF5a4vixkoVFrOQY
         /Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lNxwT7oX3FLLe9ZkJhEMyrfMgxqr37m7uo1dxERaCc=;
        b=WaLD317vMbaTqBUzo80nJ+ntVlC+GYcEHW1+20wBKFPnz2zTySH5m+bqfE27cw/PgL
         CaQmLfZIxDcegm46JRqsxWamRv5y3yVRo+LWDV6J4K/AO1UZDnvBVStzePwLwSYunvnM
         YHfILD1vHPbdAR0BBSmrzWxkDE9KDUtptYCGmHt4YXG+TMx1Ws1HwKABWbTZEyI/2De3
         RPmwfKJjjmrQMyxnxqI1nzyHBxmxKbPm/QUSeZ/N536lC0VwOyr6/If9Dsto6n1vknVO
         6MhMikbHXiY65wwFf6nG3Q1yGxHIrvYynoM0HdbOZoh2U175DfVOoqCj35epqzrPAo32
         DP6Q==
X-Gm-Message-State: ACrzQf1VwZ2r7QV/WvKu+JECRRkTWeZamkDAqqvvBpJ5yK3rIBC8jTrC
	TGw38DCKg11tsPCMd6YVirJwdFVIXa1yzOlTkj8=
X-Google-Smtp-Source: 
 AMsMyM4+aUqwKxptkjBMi52FyU2Xx0ElTrs4+JrGykNFEANVj2sJB6yrwEWX5O234K/d5ln6Naruqw==
X-Received: by 2002:a17:902:c241:b0:182:a32f:4db7 with SMTP id
 1-20020a170902c24100b00182a32f4db7mr9836245plg.131.1665500558981;
        Tue, 11 Oct 2022 08:02:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 i1-20020aa796e1000000b0056203db46ffsm9398968pfq.172.2022.10.11.08.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:02:38 -0700 (PDT)
Message-ID: <6345858e.a70a0220.3c4d1.05e3@mx.google.com>
Date: Tue, 11 Oct 2022 08:02:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.145-cip17-1-ge85493c8cea0
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 10 runs,
 6 regressions (v5.10.145-cip17-1-ge85493c8cea0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 15:02:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9729

cip/linux-5.10.y-cip smc: 10 runs, 6 regressions (v5.10.145-cip17-1-ge85493=
c8cea0)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =

qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.145-cip17-1-ge85493c8cea0/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.145-cip17-1-ge85493c8cea0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e85493c8cea0c5b53ef511efe088b0749b4d5aa0 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/634578a2a3367b21a7cab640

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/634578a2a3367b21a7=
cab64c
        failing since 99 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-10-11T14:07:23.515112  <8>[   13.235958] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/634578a2a3367b21a7=
cab64d
        failing since 99 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-10-11T14:07:23.496258  <8>[   13.217714] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/63457c44ad69922680cab5ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/63457c44ad69922680cab5ed
        failing since 76 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/634576f27c77d6a1adcab60a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/634576f27c77d6a1adcab60b
        failing since 76 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81, =
first fail: v5.10.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig             | 1          =


  Details:     https://kernelci.org/test/plan/id/6345767a251dfad97ccab621

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qem=
u_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-qem=
u_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/6345767a251dfad97c=
cab623
        failing since 55 days (last pass: v5.10.131-cip13-37-ge3a52725ce96,=
 first fail: v5.10.131-cip13-49-g1145e9c6352e6)

    2022-10-11T13:58:13.848657  <8>[    2.578415] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_x86_64                  | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6345771ab0fae2b1e9cab611

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.145=
-cip17-1-ge85493c8cea0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/6345771ab0fae2b1e9=
cab613
        failing since 55 days (last pass: v5.10.131-cip13-37-ge3a52725ce96,=
 first fail: v5.10.131-cip13-49-g1145e9c6352e6)

    2022-10-11T14:00:46.005565  <8>[    2.585960] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =20

