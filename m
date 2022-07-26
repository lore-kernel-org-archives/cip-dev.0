Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368E2C04A68
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 15:24:34 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.8106.1658849064529579481
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:24:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=4tHAjkYQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id 12so13202914pga.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 26 Jul 2022 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=8dOf7HMvvWAyRxWYZBXKLS+dYOABa2Fr/RP+OdxWh60=;
        b=4tHAjkYQNaecKVgwxbDDT/Iyv8lQnBh7snFFNwUSPUmWQn0DQZY8zn3BuxPUKlNN+5
         Sh2cfceTOn0LYJ4DlVbZalAYmzCjPndIlGhf+zbae36d+vuDBquOHU3lYnJ7PcD82+B5
         H7jbYXO14CZxbczb3MxPM37dO1WfCsfbrBJD/q8iNbQYX4NDf3MPSd9Jt+639+axUYPI
         +EA/zZrKjfehmia4ITDMFRzIPnmrJd/nhjHClIQvPxR75gvaTeJ1jw3pf8BXLGyJdAVY
         8AqmxOJ+YrWrq8pNC9hbqfJ1bY58Ern5FiqZGW0thOy6w0NYp7VLmOPP9ENzmspQDfdP
         47gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=8dOf7HMvvWAyRxWYZBXKLS+dYOABa2Fr/RP+OdxWh60=;
        b=mXA8+oXwRYY9xXIFWwLHi+3GA+ggNxl/YHKoXfYU+OdRVVVwrpd5L9C16MEmOwJrv6
         yTdEa/B1BcsgxIec/6n1fXEXRRobSNX1Kcq2FYGrOfJhngQ4phHwguwCvu8+N55h9wwK
         pykoe1YEkHM1qjZI5QAaGQp1UVTA3rYYRd+2l/zwyeDB/3X51uWC/91aOzc9xzkw1HiD
         mhquhgbql6CWSdQVwWAfugUhVT5CCMN/k1zbYHNFhjPpgCbquiFpyUTN/qE6e27Ujbai
         JLfevvn/OL8McpuA69RsZPqzf75aJm3+gPSuekFlVPQ9ubzjEaEX5pMKPnEKUhuAo5KN
         UiMg==
X-Gm-Message-State: AJIora9u4lLcc0qNgniBi0tgTSEtmXmaj0o3JTrRvFeGt4UHwWyywhKs
	sFgHmaHlEwNN5kN+t+IJuaSKC0+ZGP60p2O0
X-Google-Smtp-Source: 
 AGRyM1uni6aLoHAdJdKB3cqVd22FIB+rMq903WINxwBbp6O7DAH9WboMjCwO3avcNraCbLOw0wmQ8A==
X-Received: by 2002:a05:6a00:2446:b0:528:5f22:5b6f with SMTP id
 d6-20020a056a00244600b005285f225b6fmr17933510pfj.73.1658849063700;
        Tue, 26 Jul 2022 08:24:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o16-20020a170902d4d000b0016bdc98730bsm11785758plg.151.2022.07.26.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 08:24:23 -0700 (PDT)
Message-ID: <62e00727.1c69fb81.b4f84.2553@mx.google.com>
Date: Tue, 26 Jul 2022 08:24:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-36-g21d9d56f4de5a
Subject: cip/linux-5.10.y-cip kselftest-lib: 10 runs,
 2 regressions (v5.10.129-cip12-36-g21d9d56f4de5a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 15:24:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8935

cip/linux-5.10.y-cip kselftest-lib: 10 runs, 2 regressions (v5.10.129-cip12=
-36-g21d9d56f4de5a)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
                   | regressions
-----------------------------+-------+--------------+----------+-----------=
-------------------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.129-cip12-36-g21d9d56f4de5a/plan/kselftest-lib/

  Test:     kselftest-lib
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12-36-g21d9d56f4de5a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      21d9d56f4de5acd415b12aecf82f754e9e6065fb =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
                   | regressions
-----------------------------+-------+--------------+----------+-----------=
-------------------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62e0015bb9c09bbd51daf077

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-cip/ks=
elftest-lib-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm/multi_v7_defconfig+kselftest/gcc-10/lab-cip/ks=
elftest-lib-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/armhf/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62e0015bb9c09bbd=
51daf078
        new failure (last pass: v5.10.129-cip12-12-g93db31b19404) =

 =



platform                     | arch  | lab          | compiler | defconfig =
                   | regressions
-----------------------------+-------+--------------+----------+-----------=
-------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-baylibre | gcc-10   | defconfig+=
kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/62dffc3b468d51eb13daf06b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig+kselftest/gcc-10/lab-baylibre/ksel=
ftest-lib-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-36-g21d9d56f4de5a/arm64/defconfig+kselftest/gcc-10/lab-baylibre/ksel=
ftest-lib-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62dffc3b468d51eb=
13daf06c
        failing since 0 day (last pass: v5.10.129-cip12, first fail: v5.10.=
129-cip12-12-g93db31b19404) =

 =20

