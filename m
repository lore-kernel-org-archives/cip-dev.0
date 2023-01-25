Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C84C54EAA
	for <webhook@archiver.kernel.org>; Wed, 25 Jan 2023 03:54:03 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.37496.1674618833838891529
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 24 Jan 2023 19:53:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=eLDcFhrR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id h5-20020a17090a9c0500b0022bb85eb35dso750686pjp.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 24 Jan 2023 19:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wExYl2AQsxzTbBEuV9/7x2LBfAG85qDhJj1h2JQD5dE=;
        b=eLDcFhrRHfgNzoGDGKNV+rynWXlbOS6isXDh17rqY9Mxi9H4sAsZXIXYJ9Y6Td1nNJ
         fOgy3b6IzSapK42BuekBGiO9sWr8ewMexIZnZjzZ83KIGXR0qPin03eIP2I7j95mbEAv
         qqXiYI1Q+1mKC7h8b0fiRNpwXwHp8EoGG2MOa+sld8yoa8Jt5kzUyRv7Cjx1u077rUCS
         BeHhDJco3eGuoHO9pCoDIJNr0B+R8psbncZH/OFNoetBAH1goXZbQO9k034LKPvAT4XF
         HviWr4U3CCheusloVr1/J2GuoJwWiTjTYYobX2W8q1iFeNQTxBJv4A+t7ght5bHPMyD4
         HBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wExYl2AQsxzTbBEuV9/7x2LBfAG85qDhJj1h2JQD5dE=;
        b=CgCBqQVUagX3gojDKZIg4qMkhnYzQRuiDshe6awYUncaYKxEgHVg/TrbdO+mLCdgY4
         AzNSgQp2a3HwjfZebpBOghCjlP1tPSj8jk/Gro7JKkY9Ftj2cNn3OVtXskguMcudjz6P
         iI8IeoqR7SsYDD5/VdKmjSzkbTRROko6DL2UQg1VmEGSOk0Qwo+nI3MCwYuy2NfsoMoM
         UAyfNZz7GwYxfCKZ5roA1imBAAARxm9FXq0OuIIHSQbGTaoo48j63IzUl1meFxOZ3+eL
         0JpK3kmyWuP2fX5sNTliKFPcLF4yGYq3sy5GtaWu6W0XpZ9mzmy7LgFspETQpBB7NQwK
         k2JA==
X-Gm-Message-State: AFqh2kqy1apdpEvYMJbv78rkWf8w+G7PsCgvF6v2MGIcGueII2V0lNdI
	hSkeH/0iFc6TXgCr/X25hImqaZm9E6upwNR+
X-Google-Smtp-Source: AMrXdXvJe6+915DVP8JJyX/eh/TCQeHABDcsokFQI6lkYjMsgvDbdaE7r8IX0C2NJbDGIZfYIRwKGg==
X-Received: by 2002:a17:902:a50c:b0:189:e924:e279 with SMTP id s12-20020a170902a50c00b00189e924e279mr29767088plq.49.1674618833179;
        Tue, 24 Jan 2023 19:53:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b001960e9dd05esm2444805plf.112.2023.01.24.19.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 19:53:52 -0800 (PST)
Message-ID: <63d0a7d0.170a0220.a73b4.5186@mx.google.com>
Date: Tue, 24 Jan 2023 19:53:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Kernel: v4.4.302-cip71-590-g22fc523bf881
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-cip baseline-nfs: 25 runs,
 4 regressions (v4.4.302-cip71-590-g22fc523bf881)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Jan 2023 03:54:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10476

cip/linux-4.4.y-cip baseline-nfs: 25 runs, 4 regressions (v4.4.302-cip71-59=
0-g22fc523bf881)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =

jetson-tk1                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip71-590-g22fc523bf881/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip71-590-g22fc523bf881
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      22fc523bf88173aa7805c4360b6581696228b140 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d097fd6594474622915ece

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d097fd659447462=
2915ecf
        failing since 56 days (last pass: v4.4.302-cip70-236-g69445bc0d420,=
 first fail: v4.4.302-cip71) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
imx6q-udoo                | arm    | lab-broonie   | gcc-10   | imx_v6_v7_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/63d09d666c334b246c915f5d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-=
nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d09d666c334b246=
c915f5e
        new failure (last pass: v4.4.302-cip70-98-g7f7838c92740f) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
jetson-tk1                | arm    | lab-baylibre  | gcc-10   | multi_v7_de=
fconfig           | 1          =


  Details:     https://kernelci.org/test/plan/id/63d0a4403821b1f5cf915eba

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-=
nfs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-=
nfs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d0a4403821b1f5c=
f915ebb
        new failure (last pass: v4.4.302-cip69-517-g92709d8ae585) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63d096f1f42913975c915ee3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip71-590-g22fc523bf881/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-co=
llabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63d096f1f42913975=
c915ee4
        failing since 54 days (last pass: v4.4.302-cip71, first fail: v4.4.=
302-cip71-1-g61333eee4869) =

 =20

