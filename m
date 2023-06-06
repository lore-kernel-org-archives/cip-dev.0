Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E7BC77B73
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 15:26:40 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.1655.1686065199407360906
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 08:26:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=GrTXWYrA;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6532671ccc7so5279138b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686065198; x=1688657198;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qAOJlpKzNy8R7DVEFwyEy9mjJqcsVJxwWd1ITnu3bsA=;
        b=GrTXWYrAH2hrxMnjmphuP/UUGQI1OR6lefi4P5O36dc/m7VYQaiVarzFioFVgBsBCb
         NdZdyxk04J9DFMUfAMJCBQIoRdXj6V7KEeu1/d0YAPAmY/j6AXW4m9DyWHJndqPD/zBJ
         x7tzqo2BLcpU4v8wniXMY8o8nBTfgtqYbWzB0MSqrimXBa/RO/cFZ5K6YTNtICCD9yUV
         /ft7PIHpAAdls5iY6Uf0GxbObKOMAXMFqCpFjK0H510LvgGTc+L/8QWFMvTdZFNxCHrx
         7fCHH5ZyCFWlA+3MUKiG1GTPkdinGJVeuel6IzKIveFhwNwSa5NBaSetfiu7wZ5LJWUR
         uQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686065198; x=1688657198;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qAOJlpKzNy8R7DVEFwyEy9mjJqcsVJxwWd1ITnu3bsA=;
        b=WyYzfKbmmrXZPGjSfPT1yEf8MZEOVxG7jjvcN8sKoAUTf3hnaZ4EG4cUkEkv1xhM+i
         +kp5rEuWkjyrsPxG5GIfyF9P3urz4LHymgta77vjB04ffQV5RKsgBvw7cWNvw7G6OK7y
         gQ002TEBC1klP9+VD2ywwySHGRLA+X0RxoqPmoVuw7x/E1E6zgCb2JLPq3/7hKvlaQff
         SJWvdtnbzzjgzb6zaUChbAju0IHGCY3S9xGvpmERoBfAhM3kkHH3zug52QDt6MfurPYG
         Am/4PswaVJqPajViF3YFv114AABL0jxacoiu/EnL2y/BXYk3xJL0pDNTFrY1tMWtg7kT
         6uug==
X-Gm-Message-State: AC+VfDzBFT8+2IGlTcso0BWb5YwSHEwcTuL1Ja1uy5eWl8S1M45eMw/t
	rViaKyL71k7/weSUzO/GakdCqCxrmP9mXR/47ksvCw==
X-Google-Smtp-Source: ACHHUZ594uvH7ovCJV0Pm+4k2cycS6NH+MHqWvmOkVXIzJS4lGTBC1RkYKaGLY9W2b2M1fdi3Xq6Yw==
X-Received: by 2002:a05:6a20:9383:b0:116:2b73:41ec with SMTP id x3-20020a056a20938300b001162b7341ecmr25638pzh.24.1686065198359;
        Tue, 06 Jun 2023 08:26:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s20-20020aa78294000000b00571cdbd0771sm6976725pfm.102.2023.06.06.08.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:26:37 -0700 (PDT)
Message-ID: <647f502d.a70a0220.e5a2e.c81b@mx.google.com>
Date: Tue, 06 Jun 2023 08:26:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1308-ge1d2f27f3d7b0
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st baseline-nfs: 29 runs,
 3 regressions (v4.4-st20-1308-ge1d2f27f3d7b0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 15:26:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11898

cip/linux-4.4.y-st baseline-nfs: 29 runs, 3 regressions (v4.4-st20-1308-ge1=
d2f27f3d7b0)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1308-ge1d2f27f3d7b0/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1308-ge1d2f27f3d7b0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      e1d2f27f3d7b00de8c897e307a469e764166b3f0 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f42dcf648645d9af5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
308-ge1d2f27f3d7b0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
308-ge1d2f27f3d7b0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f42dcf648645d9=
af5de26
        failing since 64 days (last pass: v4.4-st20-939-g5ff13a6decb9, firs=
t fail: v4.4-st20-1098-g8d34bf42efd9b) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
beaglebone-black          | arm    | lab-broonie   | gcc-10   | omap2plus_d=
efconfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/647f415ea93c1e2988f5de26

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
308-ge1d2f27f3d7b0/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-=
beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
308-ge1d2f27f3d7b0/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline-nfs-=
beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f415ea93c1e298=
8f5de27
        failing since 34 days (last pass: v4.4-st20-1098-g8d34bf42efd9b, fi=
rst fail: v4.4-st20-1187-g8497d3390dc2) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f42c541d859355cf5de81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
308-ge1d2f27f3d7b0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
308-ge1d2f27f3d7b0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f42c541d859355=
cf5de82
        failing since 34 days (last pass: v4.4-st20-1098-g8d34bf42efd9b, fi=
rst fail: v4.4-st20-1187-g8497d3390dc2) =

 =20

