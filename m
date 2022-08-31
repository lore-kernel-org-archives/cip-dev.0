Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA6DECAAD5
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 13:22:31 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web12.25471.1661952147342446650
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:22:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=8Ig7NGtJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id t5so14160017pjs.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 31 Aug 2022 06:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=Hsdf4oe7vrtwjHaq3eN0XLrxfD3rEhPH7RXu/SN/MQg=;
        b=8Ig7NGtJ0TxcQiEuyoPm9BZI6gWRkgIgOOgo4leA+WmPlK0siIXVdGrUzo5SJwFkDW
         2BJXDsmO39obeeFYiXYSIXq9TCrjVl2jtXu3NojX4ZIbd5rtmLIfKDpkFSEx1+4F3OjV
         /oYyla15eTX4VouNcPK1v9iKe2xrK2x7DbRBZzpz2n/xcgYJdH85sDHz9Yf1iw4omRvc
         D6PE6i425fjMhWkl63S02iDN4xAlausBUlaYZOcqjNtJ6smFl+K/kM37DvoNeweGhpP+
         Jb1/eHvSkx7E400mJPSf3PEBjmL1Zekgct7835NmRigOcw9B0AMpTc6cBZb19sO2zyvh
         Zm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Hsdf4oe7vrtwjHaq3eN0XLrxfD3rEhPH7RXu/SN/MQg=;
        b=yQ+gQCTGXHUZmZn6DCrYFz1KoPzpOkOaJbcKJmrJR1WSuH7ed6oUdBnf+rC256zxUT
         v8LLusN5sau2lvcvkCGLXQ0GPn9N0jG/fuSKy+OccYiwaOx6lmjme5nUerzImV+s5BBa
         xmOQh7BLzqpiFXGGv5MZevEQhExnunCM/hkP78czbwEY5TxFTv4XJ/WcR6hmsJujHmax
         nD+HTL+eIYysUNOCPkoPoSeSaw130BqeALBDWK3egyrgSf+6qiF2Hnenf6faaY3aacXP
         4NiJtCNYGbIRxhJWG88Ob229VgDZdbh1bTkVs/3w6FNt1gGEW0YHFP4VyBfJ+vghIP2n
         JqOw==
X-Gm-Message-State: ACgBeo0lSECF9OJe8cDuP/Nnlql3oW8OmO5NuECQbc95HIWLyv4qhk1b
	s6f1fKIRWzA2aVV52dW7Nf95gMTuMvVLZVurmoE=
X-Google-Smtp-Source: 
 AA6agR57cY+zqIGP0kAjhPeBw5xbjhxAt8GmcEdEII45gBXWZmDjG1Fb9vdTHQYFto8R1IdWCq8JvA==
X-Received: by 2002:a17:90a:2e0c:b0:1fd:ad5a:21d1 with SMTP id
 q12-20020a17090a2e0c00b001fdad5a21d1mr3385393pjd.132.1661952146720;
        Wed, 31 Aug 2022 06:22:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 w2-20020a170902e88200b0016dc2366722sm187493plg.77.2022.08.31.06.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 06:22:26 -0700 (PDT)
Message-ID: <630f6092.170a0220.dfa1d.0675@mx.google.com>
Date: Wed, 31 Aug 2022 06:22:26 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.138-cip15
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 9 runs,
 2 regressions (v5.10.138-cip15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 13:22:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9340

cip/linux-5.10.y-cip kselftest-filesystems: 9 runs, 2 regressions (v5.10.13=
8-cip15)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.138-cip15/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.138-cip15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f2d94917db95e02bef61288aba5b06e0dfef3a73 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
beaglebone-black             | arm   | lab-cip      | gcc-10   | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/630f51f29335374f9f355677

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftest-filesystems-beaglebo=
ne-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftest-filesystems-beaglebo=
ne-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/630f51f2=
9335374f9f355678
        new failure (last pass: v5.10.136-cip14) =

 =



platform                     | arch  | lab          | compiler | defconfig =
         | regressions
-----------------------------+-------+--------------+----------+-----------=
---------+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/630f5271412cbc06ed355657

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-meson-g12b=
-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.138=
-cip15/arm64/defconfig/gcc-10/lab-baylibre/kselftest-filesystems-meson-g12b=
-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220826.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/630f5271=
412cbc06ed355658
        failing since 14 days (last pass: v5.10.131-cip13-49-g1145e9c6352e6=
, first fail: v5.10.131-cip13-84-g3b53e4dbd9f41) =

 =20

