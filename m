Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89C4C38A2D
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 17:29:39 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web08.820.1666718973762076607
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 25 Oct 2022 10:29:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=2pke6mMb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id c2so3344201plz.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 25 Oct 2022 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZGV9X2hzx4yjCx5w6kEc5ibTY/ccKZmQAtkyLeows4=;
        b=2pke6mMb7GHMUMUp8VwuBEfFw1dUUu7AHAbpzRND71rztN5i9GhMdVRfjzm++z14SE
         5Hveg7LshsVNKlMjEzykU3titaV10G9RNKbWpQpZEL67OKmJbj3qI9exk76rASDJM1ze
         UroGU3t+VaB1k5ej6MwmMu1a4BQCzwpzOkv63gH31ekUyVqblr5XpfNWdlC1dhp3cmek
         LRDbPPRYg0QDdsW4YsywApY1vDs8Zg0sr3v6LL124s2N7eBVE3TZY4B+RL9ssrHwEyWN
         xLTfoexCs7vqNaHDde49uPEAnw+cUxlMbKX8vBZLDKxt/R4VdxtBq4sew1m18+0wSLTR
         Pbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ZGV9X2hzx4yjCx5w6kEc5ibTY/ccKZmQAtkyLeows4=;
        b=EanNM9t+aRtUsCbdwk0xlFrFxmFEWRo0n103P5xn5j4tWoalFe1URmIh8q5V7BIIn3
         SEdEzeD6UPMgP9q8O44W2a380EQgHni/FrxvSNWW0I2VL6Xr+ZgmQkNwvU+RiTuZ4eJN
         gF9dBZM4xc8CAG0rkVr2bEUmBf4z0y3L2Fn2zZzBF9rrtwVSg7wKJqOiw3UrbLsDlChI
         2qUiaAikTBMzXBh53bvxAqsdfoo10gAsB6r5URymsK2VzzyXQyaKkAom4xIelXr9wpGQ
         QCAnBVHkaHsQL8fj0bybpKLHthnJhYMBHrFCaVbXs1+KOwn+Ss7HtnDwbThsZEKE3OsL
         0Ruw==
X-Gm-Message-State: ACrzQf1qJIvcO4gNxXI6VPDF1XoBgx0WLHdQIuCU45smceNqH9QXkIDu
	xBJU/rQI8ApLHTMvNGxNWHbkmtaEnMOpVH5O
X-Google-Smtp-Source: AMsMyM56nX1SqurLsJYjyY4ah1q5NuFXnT4se0WWfqxJk5DqGUL+6w2P3nb4OoGu445fSvtAlXJ8Sw==
X-Received: by 2002:a17:902:e882:b0:186:a3ba:8780 with SMTP id w2-20020a170902e88200b00186a3ba8780mr12394407plg.114.1666718972913;
        Tue, 25 Oct 2022 10:29:32 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a0cce00b002071ee97923sm5606441pjt.53.2022.10.25.10.29.32
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 10:29:32 -0700 (PDT)
Message-ID: <63581cfc.170a0220.8ad3f.a030@mx.google.com>
Date: Tue, 25 Oct 2022 10:29:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-518-gc75907dbbb95a
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs,
 3 regressions (v5.10.145-518-gc75907dbbb95a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 17:29:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9839

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs, 3 regression=
s (v5.10.145-518-gc75907dbbb95a)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
         | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-518-gc75907dbbb95a/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-518-gc75907dbbb95a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c75907dbbb95a00b6b5fd298e65585204cf96ea5 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/63580f66a704ad98d75e5b81

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm/multi_v7_defconfig/gcc-10/lab-cip/kselfte=
st-filesystems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm/multi_v7_defconfig/gcc-10/lab-cip/kselfte=
st-filesystems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63580f66=
a704ad98d75e5b82
        new failure (last pass: v5.10.145-cip17-421-g0d804ef4a611) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/63581095082d9b7c115e5b4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig/gcc-10/lab-baylibre/kselftest=
-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig/gcc-10/lab-baylibre/kselftest=
-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63581095=
082d9b7c115e5b50
        failing since 49 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d=
, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/63581540d26ae152a35e5b6d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig/gcc-10/lab-cip/kselftest-file=
systems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-518-gc75907dbbb95a/arm64/defconfig/gcc-10/lab-cip/kselftest-file=
systems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63581540=
d26ae152a35e5b6e
        new failure (last pass: v5.10.145-cip17-rt7) =

 =20

