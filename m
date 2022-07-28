Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEB8C48BE4
	for <webhook@archiver.kernel.org>; Thu, 28 Jul 2022 10:40:26 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.31085.1659004820630745544
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:40:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Xymtk4fO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id b133so1588100pfb.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Jul 2022 03:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3in+8ap/79Lf2cj8Z3Zwb4vSiiofRPfyDgolgy/mc4A=;
        b=Xymtk4fO+MyjHJVS/S8nP8626vPXEkD4FBuabH7lInlgBo0UTxRCKkWzu7wa8iA8vl
         KFEVQHJMveGtObzNWQ9wDlK6Jef+v/gDGrXTJP0WoTeIbeCl2sk/o7ZGN5B0ZJivaoe2
         lNVnGeJ46caBoBQ3uYNYk5UA6iQs7FS7WgMHFwi6mOMixTSaGdJczgyrQUKO462K0USo
         aiEV+UpnVoioMAqr01bM837LZzqRBLCZ2aCpe8bTrNc4ZgOFT9/YE68ExacVQ4KTsGoE
         Wcicpbeqe3ZteYWSgPpoL2XOvVfYAW780EDs2jyD12wznUlrAPO6CiS5yTfeQSxAH4Zn
         T/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3in+8ap/79Lf2cj8Z3Zwb4vSiiofRPfyDgolgy/mc4A=;
        b=FQiXVkVlqt6vztqAXKDuglxqnCXCXWPNRDGRLhTSORWZcWuSElG2wdRvUaLch814Nk
         gOVH/fZOj6xLBoK1oLapbmJaVDXnZcnFpjRVYwD9JzrnepBfmHKLsYxCvQ6nms4xJTBz
         I4eu4LCO9j1fValbs/IFWzyxr4ko/ddIPiOsl7fEDm9OTOgM9BGJ/vAEQI7qFhmjf1tq
         b8fiA0l+AhljLl46JeNsorgHo5UJ1pjkU4/dGFZQpxwuWD6zB7jHcKZHViAnwPJkfIaU
         y3GlHq/XLKq4+Jmi6DXYpZQH0+KBjenq2Af5wWv1pzsyluM7E7zA0AshB1ECqopSTNG2
         GE2g==
X-Gm-Message-State: AJIora+wp/cmcNuQH2js00I+OHfE+LbXoy8oJf1xrsIugPypBk+5lUWE
	rET9+4yYjA10dopLu+hPT5OoLfUw+w4qVrb+jXA=
X-Google-Smtp-Source: 
 AGRyM1t8n0x/iqfSkzSAiXOFJKt9ftLuEKaSXUeZ6deVTn++QuJPDFiNos2MFeW+vZQPf5BVmli/RQ==
X-Received: by 2002:a65:6a14:0:b0:41a:b564:4d68 with SMTP id
 m20-20020a656a14000000b0041ab5644d68mr22008068pgu.99.1659004819549;
        Thu, 28 Jul 2022 03:40:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o60-20020a17090a0a4200b001f021cdd73dsm3536911pjo.10.2022.07.28.03.40.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 03:40:19 -0700 (PDT)
Message-ID: <62e26793.170a0220.560ee.5b44@mx.google.com>
Date: Thu, 28 Jul 2022 03:40:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st5-585-gc99f2b257bde
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs,
 5 regressions (v4.4-st5-585-gc99f2b257bde)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Jul 2022 10:40:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8964

cip-gitlab/ci/pavel/linux-test kselftest-futex: 7 runs, 5 regressions (v4.4=
-st5-585-gc99f2b257bde)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4-st5-585-gc99f2b257bde/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4-st5-585-gc99f2b257bde
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c99f2b257bde3cd60a833056aab624ad5fab3812 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b3446bdf6ca513daf06f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62e0b3446bdf6c=
a513daf070
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b1a7ef3df23dfedaf05a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62e0b1a7ef3df2=
3dfedaf05b
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-11A-G6-EE-grunt           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b0d4fd8baa0417daf076

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62e0b0d4fd8baa=
0417daf077
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0b4738fd25dce30daf073

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/l=
ab-collabora/kselftest-futex-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62e0b4738fd25d=
ce30daf074
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/62e1c2f38967d09707daf05c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-broonie/kselftest-fu=
tex-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4-st5-585-gc99f2b257bde/arm64/defconfig/gcc-10/lab-broonie/kselftest-fu=
tex-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/62e1c2f38967d0=
9707daf05d
        failing since 0 day (last pass: v5.10.129-cip12-36-g21d9d56f4de5a, =
first fail: v4.4-st5-586-geb97410e0086c) =

 =20

