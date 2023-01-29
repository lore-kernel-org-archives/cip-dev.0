Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FB7C54EED
	for <webhook@archiver.kernel.org>; Sun, 29 Jan 2023 22:30:14 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.27833.1675031413128932824
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 29 Jan 2023 14:30:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=sqjRUyLh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso12245278pju.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 29 Jan 2023 14:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nYfRpBx8E87ufZ1spTL7mCSqu5tfD+jvwnQccL6CVbw=;
        b=sqjRUyLhkCYGu31tq6HHjFJCuLVrZC07GRv06X8OKclQTWhHg0/GCVA+A7CCU5rPhc
         T1kKoqzywgGaWD/muCQb3mx2b9dz+C8vjdAsrTd1wVKe6jT4PlXW+hTS3rJ+fORNjpho
         lV/MK0oWjMdJgTAfmlnWM0DOYxXAdPd2m5VivrID/rQOwAFdmv/D6pzkklCE11k28Cd8
         hOnZGaSdBh1D2WSD9oX7BYiZr63aWGGsJxz6/LbHp3sr4qy1UtGdSMUY+MG0udV1hnPr
         KGdUb8xxCfF/+B84mTcghO78Pw2rQuS0Qn3hjPDZjA9i8a7mflBEE/NmfKXjJT3GxV8C
         MITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYfRpBx8E87ufZ1spTL7mCSqu5tfD+jvwnQccL6CVbw=;
        b=aVy8qOJ2LpA5L4BeJflQYVBwL8Ujq5Ankr6xesFxFrBxKuFjZmceULacEuqEaUBpsz
         QtdggnzmNDdMxxhjlqvPJXHLisVI/eqwwQUM7WnZioYEb7eFmPkLUHTwx19aU2aEDB4y
         83rUff4zxtFv21CxZICbuAPysJyv3gUvdebBubWJVTgRRLrKGKyfiXv63xk2G46m2IIP
         j3RGLYthFuN4zjQo1yQt8jSrhBguB1zJjyCl5l3fCXopmNecDLW2N6CdNz7bCVJlKA/S
         1AlDhYV17lu8Wm9LfGZP4bMYdO1RI84+hricOkt8bhIyyx1hUVJnEGX3fiiotrtHBTAj
         gLlg==
X-Gm-Message-State: AO0yUKVb96/fVkhllLBfHLzRRc9+BpSgGutziMRXH/J6f/h7aQZkSyyO
	pT3/J73nadcMMIXpnCjG7GhZIFDwBwp7vlG4jX9LGQ==
X-Google-Smtp-Source: AK7set9k1qwZoTIchEnLH7MBWzoART7OfCdCPitlJUOypnCMpthEJDelF1hR1DvzgLfILtGc4UgMNw==
X-Received: by 2002:a17:90b:4b45:b0:22c:216e:16df with SMTP id mi5-20020a17090b4b4500b0022c216e16dfmr15284041pjb.49.1675031412294;
        Sun, 29 Jan 2023 14:30:12 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y191-20020a638ac8000000b004d182686e08sm5665832pgd.39.2023.01.29.14.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 14:30:11 -0800 (PST)
Message-ID: <63d6f373.630a0220.3b60a.9081@mx.google.com>
Date: Sun, 29 Jan 2023 14:30:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.271-cip90
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline-nfs: 40 runs,
 2 regressions (v4.19.271-cip90)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 29 Jan 2023 22:30:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10499

cip/linux-4.19.y-cip baseline-nfs: 40 runs, 2 regressions (v4.19.271-cip90)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig        =
   | regressions
----------------------+-------+--------------+----------+------------------=
---+------------
beaglebone-black      | arm   | lab-cip      | gcc-10   | omap2plus_defconf=
ig | 1          =

meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.271-cip90/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.271-cip90
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6cd0670e124d09e80f2daaf2ecb13922a603f30d =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig        =
   | regressions
----------------------+-------+--------------+----------+------------------=
---+------------
beaglebone-black      | arm   | lab-cip      | gcc-10   | omap2plus_defconf=
ig | 1          =


  Details:     https://kernelci.org/test/plan/id/63d6ed987f3a4aba4a915ed6

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs-beaglebone-black=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d6ed987f3a4aba4a915ed9
        new failure (last pass: v4.19.270-cip89)

    2023-01-29T22:04:53.558370  + set +x[   48.833444] <LAVA_SIGNAL_ENDRUN =
0_dmesg 835927_1.6.2.4.1>
    2023-01-29T22:04:53.558591  =

    2023-01-29T22:04:53.732650  #
    2023-01-29T22:04:53.834511  / # #export SHELL=3D/bin/sh
    2023-01-29T22:04:53.834970  =

    2023-01-29T22:04:53.936355  / # export SHELL=3D/bin/sh. /lava-835927/en=
vironment
    2023-01-29T22:04:53.936838  =

    2023-01-29T22:04:54.038364  / # . /lava-835927/environment/lava-835927/=
bin/lava-test-runner /lava-835927/1
    2023-01-29T22:04:54.039586  =

    2023-01-29T22:04:54.045530  / # /lava-835927/bin/lava-test-runner /lava=
-835927/1 =

    ... (12 line(s) more)  =

 =



platform              | arch  | lab          | compiler | defconfig        =
   | regressions
----------------------+-------+--------------+----------+------------------=
---+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
   | 1          =


  Details:     https://kernelci.org/test/plan/id/63d6eb7671e8d3feca915eef

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230120.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/63d6eb7671e8d3feca915ef4
        new failure (last pass: v4.19.270-cip89)

    2023-01-29T21:55:44.074474  <8>[   64.023158] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 3240972_1.6.2.4.1>
    2023-01-29T21:55:44.992533  / # #
    2023-01-29T21:55:45.094294  export SHELL=3D/bin/sh
    2023-01-29T21:55:45.094655  #
    2023-01-29T21:55:45.196055  / # export SHELL=3D/bin/sh. /lava-3240972/e=
nvironment
    2023-01-29T21:55:45.196542  =

    2023-01-29T21:55:45.297934  / # . /lava-3240972/environment/lava-324097=
2/bin/lava-test-runner /lava-3240972/1
    2023-01-29T21:55:45.298574  =

    2023-01-29T21:55:45.304830  / # /lava-3240972/bin/lava-test-runner /lav=
a-3240972/1
    2023-01-29T21:55:45.563678  + export TESTRUN_ID=3D1_bootrr =

    ... (12 line(s) more)  =

 =20

