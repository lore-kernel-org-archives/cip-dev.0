Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3622AC43334
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 01:40:50 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.1669.1658799647875897513
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:40:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=twK5PAup;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id w185so11990765pfb.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 18:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Uu3jIvxBrwvkUcIX59bb70lm58F5RW9YvRgTtGHSkUQ=;
        b=twK5PAuph59Kyx0Q6jwy0TqNMEBC9LgROg1WG5Wij3tyoZBMC4sK/HDkuFbG7XCKNC
         AbtPEufne0H2Mi/oUagwA9rb3nQ2k2tcYno6bIV6ncyywXy2l+pzCBte7ZgEYa14UBa9
         xk4OiNVKD3QRhCfTDvA1BZ01FTcKr0cUlK9x3aUdzQEhqdBnzulI+73rQALGxCDWHwU3
         I72BkLdOCOJPhDo1SyVp1LRuPv7mYEQui0m+hN/G7kNixwSivFSXjogC1E1Tk0qTYAlk
         gn5ISE89Y9FvrEA4HUma/XSuK8RH9ugRlR0QG/sCuXA4RHrENBbIAwxb8WJ0UfOXU4Tp
         do6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Uu3jIvxBrwvkUcIX59bb70lm58F5RW9YvRgTtGHSkUQ=;
        b=ZPPPA4iGWRyQZFb/c59bPM6qutXArAFXrZATkZXW5L8h/JotCMbjqRLO89XPWUrmOR
         Po+qCPer1jcDWtZYZbmIkJ5XSy9KMGuEod1hu0PkGwplexno3BVBPbYhG1LN8KJotQ/R
         iDkyZs2Vi+GTUx5tp2EyrPdU9BICM0LGBjUGrvM7cnG7JWzv2YO3s8k2hRnKSItsz+ai
         bkhcHhUSE5xgEkdiQLrAfUpi4ClW/bj89Q37Of14FUGI9FFYuNdsWqrRPceKVKyHqzte
         bDaWU6QFDTmnVFhkSzj5jFgOU9n+sH0FUaGskfiuy9pCgU7lx9cBOF5Bza8l58u5asxr
         x8Cg==
X-Gm-Message-State: AJIora8hrCqM9y9NuDqWReIIOh9QFV8sw1LCrDFenf/rmP7e1fHna5yg
	YXAHfKakzrbyY8SwKUd76Lp7aiEAb+XR5CGk
X-Google-Smtp-Source: 
 AGRyM1slLoSmBs2d7x/Yt33vp4P/W9H3X7izC5uUORfAY9yHB7UFCX/ipSJrRffypgJ76hEZGUli8Q==
X-Received: by 2002:a63:db0c:0:b0:41a:6c14:a81f with SMTP id
 e12-20020a63db0c000000b0041a6c14a81fmr13348238pgg.33.1658799646948;
        Mon, 25 Jul 2022 18:40:46 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 j1-20020a170902da8100b0016d9877d3bfsm536087plx.32.2022.07.25.18.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 18:40:46 -0700 (PDT)
Message-ID: <62df461e.1c69fb81.7751f.152a@mx.google.com>
Date: Mon, 25 Jul 2022 18:40:46 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip69-517-g92709d8ae585
Subject: cip/linux-4.4.y-cip baseline: 102 runs,
 6 regressions (v4.4.302-cip69-517-g92709d8ae585)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 01:40:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8918

cip/linux-4.4.y-cip baseline: 102 runs, 6 regressions (v4.4.302-cip69-517-g=
92709d8ae585)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip69-517-g92709d8ae585/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip69-517-g92709d8ae585
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      92709d8ae585b3c97e359b1323f02c37349ee40d =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62df3a103ff2ed5542daf075

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm=
64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm=
64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62df3a103ff2ed5542daf=
076
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62df42aa0d3c31b496daf09a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62df42aa0d3c31b496daf=
09b
        failing since 68 days (last pass: v4.4.302-cip69, first fail: v4.4.=
302-cip69-296-g52de9431d314) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62df3a0152ae3c4809daf0c4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_a=
rm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_a=
rm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62df3a0152ae3c4809daf=
0c5
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62df3a0f3ff2ed5542daf06c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm=
64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm=
64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62df3a0f3ff2ed5542daf=
06d
        new failure (last pass: v4.4.296-cip67) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62df42a80d3c31b496daf094

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62df42a80d3c31b496daf=
095
        failing since 68 days (last pass: v4.4.302-cip69, first fail: v4.4.=
302-cip69-296-g52de9431d314) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62df39fb8872029232daf06a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_a=
rm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip69-517-g92709d8ae585/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_a=
rm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62df39fb8872029232daf=
06b
        new failure (last pass: v4.4.296-cip67) =

 =20

