Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB521CCA48C
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 10:54:04 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.4926.1658400839568611420
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=GnTYLUrs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id r24so1462042plg.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 21 Jul 2022 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=pPxL5aUFi6CEf3ESslyBOqGintMfkNlYqsUuLXuRSpU=;
        b=GnTYLUrsqePzFK0AuVg9TuH67z8qnadlXblO+LNXFc6YNtGqm+oh7Hbm4+YvLLj+0S
         +iQylpzXLt57RgN0S1ihfVP6M8aA7FIh/uOFOT9RZk3Rk+D2xh6YsbOR8vp1V9BTqTjv
         E3oazE8YPdlP3w7XS8si+Xs/rLzIj9P8iOHSmtaevt4aOnoLlRwDFRpb32I4iu66NIXZ
         3HwCCU4rCXRvzhK/rRZ2rPqNHxmof6enmeVJlpVFla1mCzEYPgdcEjnrBcMX/nZEVEqM
         pPabvSxUdU+atF1F9GGvJZGNSMbcgxpfrCDV+v3tIoIkVmp/gspiN9l+idjof5yaf1CQ
         7YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=pPxL5aUFi6CEf3ESslyBOqGintMfkNlYqsUuLXuRSpU=;
        b=n0LAqdOcjXLun7LI0hRDip41k1T+VVduuK0ZIeLVW6ObcWFZJEJ5Htt3vF5CeN5iBD
         qXyVWJz7byScbzdd8syr4EsdZ3/HulbIf3+2JhSgkNLlkcIORXT2ex5SP1RhG4p0m8FE
         pQHb7dxoQEbHvZE90guWKcpzGhzmtqstqsCuY8PNXd/jjGA9+zN7uJ5WOiJuaNYE97fg
         ml7M5kcXV7OVi2JtPYCtnslKXH2RYvnqEvWlV4qpRrs/N+bYfzD65POxT5WSEJoWLX5c
         9zufHnOhh9TM3Ga5ZzBGXgivkBiG5lMdBiPez96IdGJi4nu/Vh2fsYysVj/BFS4sRODH
         0hQw==
X-Gm-Message-State: AJIora9DzydMekP04GmFSxXME0ev5o1E7rCKKhrt+RtsMMAv4aoBsgRd
	FXdeIQM7TdFnYKoLzuglLAyaCacxodH7K2Z7FZI=
X-Google-Smtp-Source: 
 AGRyM1vvQF1ZlpfP/HQtSsIXK9ZRLQCzHKUh6a1knFzXLRrveFzlQMo1XYjDya3pru+iAYAPDfzm3Q==
X-Received: by 2002:a17:90a:bb94:b0:1f2:19f0:b01e with SMTP id
 v20-20020a17090abb9400b001f219f0b01emr10087870pjr.46.1658400838765;
        Thu, 21 Jul 2022 03:53:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n1-20020a170902d2c100b0016a565f3f34sm1386839plc.168.2022.07.21.03.53.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 03:53:58 -0700 (PDT)
Message-ID: <62d93046.1c69fb81.7a082.2243@mx.google.com>
Date: Thu, 21 Jul 2022 03:53:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-ge4e007863cc76
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 11 runs,
 3 regressions (v5.10.129-cip12-12-ge4e007863cc76)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 10:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8877

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 11 runs, 3 regressions =
(v5.10.129-cip12-12-ge4e007863cc76)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig =
        | 1          =

beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
        | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.129-cip12-12-ge4e007863cc76/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.129-cip12-12-ge4e007863cc76
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e4e007863cc767efd75ca69c0b98e5daab0c20ff

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  bda92ad659a52d38ac810099f69adff626b064c6 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | multi_v7_defconfig =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62d926bb0c6be4fbcedaf0bc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm/multi_v7_defconfig/gcc-1=
0/lab-cip/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62d926bb0c6be4fbcedaf0=
bd
        new failure (last pass: v5.10.129-cip12-59-ge5b19636ca9c4) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
beaglebone-black         | arm   | lab-cip | gcc-10   | omap2plus_defconfig=
        | 1          =


  Details:     https://kernelci.org/test/plan/id/62d91cf9e580dc2d10daf056

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm/omap2plus_defconfig/gcc-=
10/lab-cip/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm/omap2plus_defconfig/gcc-=
10/lab-cip/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62d91cf9e580dc2d10daf0=
57
        new failure (last pass: v5.10.126-cip11-116-gef362fbbff528) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62d91e4ca75c989310daf068

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.129-cip12-12-ge4e007863cc76/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220716.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/62d91e4ca75c989310daf0=
69
        failing since 14 days (last pass: v5.10.126-cip11-1-gc5218dc69ff1, =
first fail: v5.10.126-cip11-116-gef362fbbff528) =

 =20

