Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB22C4332F
	for <webhook@archiver.kernel.org>; Fri,  7 Oct 2022 11:37:44 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web09.3404.1665142659916806606
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:37:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=JBQ1wfiK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id h10so4309831plb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 07 Oct 2022 04:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+ANlbPYYuNHU/N83rTL8Ac6d5xsjIQjnfkYy5uAep14=;
        b=JBQ1wfiK+TpRo1JbhC8jER6jVjWf6QkM9vwz0d/ep0ziiRrnL27Mpqs12dEuG0xCz4
         6858WH5cFgRYCehW97NKilxIuqprVVOHXCp2lWyWCSBw4k85obtIfS60hESHNeQL3w6r
         4Ka54kGkqj9caKoXGVm9vysK8jNlmMTZvXTEXvQB5KveuCgGJLEflZxbmNosUd0M1Wx/
         swEYjU6/fSYz04kVw5SYsK5IWlZMgK4IvRtYwHK6+uYmfAvGcVAFVMMvTXC6s7tkKH32
         Z66EQVEsGAJmt6gbyMp38ByZdvEM7dkwG76jCTsUenOIYBvAwLbE99mOGGJd1u0GWwVs
         KBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ANlbPYYuNHU/N83rTL8Ac6d5xsjIQjnfkYy5uAep14=;
        b=ELYKoIFddv35gvZBXhrqAuKso8/ooH5kUh8qxjHCIMpPSKvEkDBewN2eRa0QfW2/Kz
         dFVG9jSQOsT39O7QprFkaFGYVVD5MjUWMuNcgHmIdV7qEPkVXElVP17LFYhcGDVjK5pv
         LZUP1PASkzZegDclpF+fHn5EVQi3znRW6GHJ5xjVxfdMejZmZ7uY7LUAgQjtzI/PT4bL
         gbDjrRdCJcsNKvERMsomCTmqZKXd/uADw1wXiznqaTauDulh4WkePj6urSOgd6ykFG1C
         Ep1ZjOS45Jed7PiYy0Si01H7O/f6E7l/gqi9FOnEHs4EDdNMFhGrsMwURRV5c8ajjZyA
         F+zA==
X-Gm-Message-State: ACrzQf3FqRIP0+oyH6+2YEYi7WnGitCsqZj+gci8X6bizophovEcQ/AE
	zQc8tVefby4fOISz60Cvyk30D80vK1jcKfjiG7M=
X-Google-Smtp-Source: 
 AMsMyM5OfRM53s4ViR8HYZpOZ7OXuVnHUkqZLZDfLmyxB4zQ7Kh2gRBG6jHvwTtBPLH3TR/G4c/zyg==
X-Received: by 2002:a17:902:6acb:b0:17d:c267:2ad9 with SMTP id
 i11-20020a1709026acb00b0017dc2672ad9mr4403938plt.10.1665142659076;
        Fri, 07 Oct 2022 04:37:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o9-20020a170903210900b0017f7d7e95d3sm1314882ple.167.2022.10.07.04.37.38
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 04:37:38 -0700 (PDT)
Message-ID: <63400f82.170a0220.c2130.246e@mx.google.com>
Date: Fri, 07 Oct 2022 04:37:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.145-cip17-rt7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 6 runs,
 4 regressions (v5.10.145-cip17-rt7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Oct 2022 11:37:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9683

cip-gitlab/ci/pavel/linux-test kselftest-futex: 6 runs, 4 regressions (v5.1=
0.145-cip17-rt7)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
                 | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
                 | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
                 | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-cip17-rt7/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-cip17-rt7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      411cd76b5afe81569858976d0e9819ab48717fcb =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/6340053150622b4f84cab5ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-me=
son-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-me=
son-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6340053150622b=
4f84cab5ee
        failing since 6 days (last pass: v5.10.138-cip15-10-g52cbd8ad1543e,=
 first fail: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/63400ee2f2995fd264cab6da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-me=
son-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-baylibre/kselftest-futex-me=
son-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63400ee2f2995f=
d264cab6db
        new failure (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d) =

 =



platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/634002db8d28333ad7cab5f3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a774a=
1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig/gcc-10/lab-cip/kselftest-futex-r8a774a=
1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/634002db8d2833=
3ad7cab5f4
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =



platform                     | arch  | lab          | compiler | defconfig =
                 | regressions
-----------------------------+-------+--------------+----------+-----------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip      | gcc-10   | defconfig+=
arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6340091cdc1c5e9660cab62f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/kselft=
est-futex-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-cip17-rt7/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/kselft=
est-futex-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220919.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/6340091cdc1c5e=
9660cab630
        new failure (last pass: v5.10.145-cip17-422-g411cd76b5afe8) =

 =20

