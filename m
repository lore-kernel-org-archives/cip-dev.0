Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D3BC67871
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 03:30:19 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.108906.1673667018673895232
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 13 Jan 2023 19:30:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=RyfU2M6n;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id k12so3200143plk.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 13 Jan 2023 19:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gv5HgEHr14ViGvspvOCpBoJLDRf2Y6uWYDJz41WdrX8=;
        b=RyfU2M6nGG+GzGeBlKOr/wZIq5lXOcd2WqdB58n3bMPu2jvScskWt5LGWUVpBlkl/q
         jKbAHv0/XC8Rgmhh9lkyjSXMzAMacI5nXgtDRO7B7SxTWawGjlP98cjF2mwNmaYw+IwD
         cRAfUKwp1GTt7dM0TC7aCwC1lrqch7lYfVNIWcW8PVSdKnU4Rd99C8cYq3zPsLvlhu9J
         2Vbyjx714up+1EPukf+BFK6snpaYQCEYekb/HjubGuGKNlydDvsNwYeaOGl0FKxAB5di
         ByKuXoacAeFGLLHtBtU+uMWYF+wgCWL1WxZ8izeb/QaZKh6k0bIy1YWxEYx6heBnq383
         qUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gv5HgEHr14ViGvspvOCpBoJLDRf2Y6uWYDJz41WdrX8=;
        b=09ZfEe1wAMWRQLigyRocAKAQuFiKnkHhHlOQpS5+oc5x5Uxaw4LFoYzuA8aaYm07O5
         0B6CbEq7jtu/gXuozxHLVcT7f4+UKwLqjuV0Lassth8S+9tCdgJD/8ZRKADiq6rbLR7S
         2ZgqslOhlxKWyXVHct6d+S9eD6uUP2sXkRL9cysSvHE7kT8HzNght+8NrqHtt4NYpJsb
         gCqbyiVmQ1EYIXYWZseNdlRF5PUzNJZ81lQ+Qqaqx5tNSD/W6I7dpuEeDhzecVUv9Gt3
         lNEjqbKAmc8Bq6I91eZNCjqresekJWn72oOiqLDq7WL+1VA7hh477/V61F+F+0LH2HzK
         DrzA==
X-Gm-Message-State: AFqh2kq9DkBDK5PjV20BrXZRcH4vmo0yX4pjXMO6JK2VpoxU0qI2qF3a
	ObqrWFj40FMiSfB8v+QARJ6pzDUI0en+khFGIB0=
X-Google-Smtp-Source: AMrXdXvRS7oTt3gF0ZfsuMMfZAa+HVJ4Z4TqrPYkrnvSFyzJWgW5cwvEmX82NqOOD7JkmIAjDRfhpA==
X-Received: by 2002:a17:90a:630a:b0:225:c317:137c with SMTP id e10-20020a17090a630a00b00225c317137cmr77279091pjj.36.1673667017760;
        Fri, 13 Jan 2023 19:30:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y7-20020a17090a474700b00219463262desm12893859pjg.39.2023.01.13.19.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:30:17 -0800 (PST)
Message-ID: <63c221c9.170a0220.990c6.4491@mx.google.com>
Date: Fri, 13 Jan 2023 19:30:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 7 runs,
 2 regressions (v5.10.162-cip24)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 03:30:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10355

cip/linux-5.10.y-cip kselftest-seccomp: 7 runs, 2 regressions (v5.10.162-ci=
p24)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.162-cip24/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.162-cip24
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7ef5f1fda52a95426084959dac09acdb3c81327b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63c20c7977bf4b79021d39ca

  Results:     87 PASS, 3 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/63c20c7977bf4b79021d39cc
        failing since 65 days (last pass: v5.10.153-cip19, first fail: v5.1=
0.153-cip19-3-gc76f4e7e5c71)

    2023-01-14T01:59:01.480887     =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/63c21346defac2bfa81d39d2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson=
-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson=
-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230109.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63c21346defa=
c2bfa81d39d3
        failing since 35 days (last pass: v5.10.155-cip21, first fail: v5.1=
0.158-cip22) =

 =20

