Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D880C32793
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 11:38:14 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web10.27452.1660736287836088257
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 04:38:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=WCOYdO+G;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id l64so11768314pge.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 17 Aug 2022 04:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=yknJOQM8FSQmweMdtVNXJ4AFnAXl0JyRXic70oSleYI=;
        b=WCOYdO+GvUVUto7NnrsuvmqzSPjW43ciK03IjlnyG2tUFZZ+nmCG2T7zu9TnRSaSnk
         PJqFMQTg3BT8SXRYJpYS0BZQqHOJwJXImwmAdmiq/tjfLo3FWdBEdwEDFaE9FmhcVnFD
         Ue7UuDwpWB/+ClpgPtHy4f8AFwRO/3oFQkkXiJshySpcbZQA9zwbDrApx2ch9GpD84os
         wE4Pa15uMQ1iptZnDFC9JvyLz4LEMRUoKUmpJzO8j0ZlSrNv/1Zop1ktXv3gVvtXKdEv
         80kbst86AqCwI6G9SJrDflvE2yNwrUN/SklL9sje2IFRVGqDqsMPr4pxhR9vWX4PG8YG
         Vw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=yknJOQM8FSQmweMdtVNXJ4AFnAXl0JyRXic70oSleYI=;
        b=PVUtX2aJOtCwyoJzU1aGDFDZL1RraoidMRNkUbOMo9doRjuxoq4NkV7ovbzOcvNKJy
         qL6zIPZ9kvakA3bVksKAmjJQeCzxvWaOgiWR1/HhsGZSPycR7r2FD53ENP1RXcIlc5fc
         Gsf3GKjHwhEeJL123674mE1g6B/stkWSo0LnclsPed3kodlSBTaMrRBq8BfU44EytsTX
         tc/8U/BsY/sLKAHotNFTo3H1hiK9TJvumHHcGulXqgQ6jwo6Fbxjv6kdUym34OjJxsGO
         9bKJs650YDsCXCFQS4i+bV3BlqSmRwkEg7tp+W40V6RaKvUh63xsHzJsJc96mOFoYd6d
         cmtQ==
X-Gm-Message-State: ACgBeo2NF4NHMHT+QQllcvG+gqb0VZE8GPWNlPvm+esTCpYo5rtVKW6o
	FSqS6tU3ULnHL5bRXaQGo7/wYpUAEVy7MpDB
X-Google-Smtp-Source: 
 AA6agR4x/JX3nIoTMd/22qGHN2rbvrIueVBASYuMTDe/RsfUNjlwE2S/SfhGsArqCgYf/jfv9jQ1Eg==
X-Received: by 2002:a05:6a00:1c49:b0:52e:4e9a:a07a with SMTP id
 s9-20020a056a001c4900b0052e4e9aa07amr25004619pfw.26.1660736287198;
        Wed, 17 Aug 2022 04:38:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u1-20020a1709026e0100b0016d62ba5665sm1224080plk.254.2022.08.17.04.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 04:38:04 -0700 (PDT)
Message-ID: <62fcd31c.170a0220.3bed6.1b6f@mx.google.com>
Date: Wed, 17 Aug 2022 04:38:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-84-g3b53e4dbd9f41
Subject: cip/linux-5.10.y-cip baseline-nfs: 22 runs,
 3 regressions (v5.10.131-cip13-84-g3b53e4dbd9f41)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 11:38:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9275

cip/linux-5.10.y-cip baseline-nfs: 22 runs, 3 regressions (v5.10.131-cip13-=
84-g3b53e4dbd9f41)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
      | regressions
-----------------------------+-------+--------------+----------+-----------=
------+------------
jetson-tk1                   | arm   | lab-baylibre | gcc-10   | tegra_defc=
onfig | 1          =

meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
      | 1          =

meson-gxm-khadas-vim2        | arm64 | lab-baylibre | gcc-10   | defconfig =
      | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-84-g3b53e4dbd9f41/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-84-g3b53e4dbd9f41
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3b53e4dbd9f41171cf639b3ba0b107f6d6f444ac =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
      | regressions
-----------------------------+-------+--------------+----------+-----------=
------+------------
jetson-tk1                   | arm   | lab-baylibre | gcc-10   | tegra_defc=
onfig | 1          =


  Details:     https://kernelci.org/test/plan/id/62fcca0978fb33732f355642

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: tegra_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-n=
fs-jetson-tk1.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm/tegra_defconfig/gcc-10/lab-baylibre/baseline-n=
fs-jetson-tk1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fcca0978fb33732=
f355643
        failing since 67 days (last pass: v5.10.109-cip5, first fail: v5.10=
.121-cip9) =

 =



platform                     | arch  | lab          | compiler | defconfig =
      | regressions
-----------------------------+-------+--------------+----------+-----------=
------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/62fccac72a3995876935567a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-m=
eson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-m=
eson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fccac72a3995876=
935567b
        failing since 21 days (last pass: v5.10.129-cip12, first fail: v5.1=
0.129-cip12-36-g21d9d56f4de5a) =

 =



platform                     | arch  | lab          | compiler | defconfig =
      | regressions
-----------------------------+-------+--------------+----------+-----------=
------+------------
meson-gxm-khadas-vim2        | arm64 | lab-baylibre | gcc-10   | defconfig =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/62fccab3b59c89097b355658

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-m=
eson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-84-g3b53e4dbd9f41/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-m=
eson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220812.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62fccab3b59c89097=
b355659
        failing since 239 days (last pass: v5.10.8-8301-g3d6168cb89f6, firs=
t fail: v5.10.83-cip1-31-gdcbef6602957) =

 =20

