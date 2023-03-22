Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C923C77B61
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:33:02 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.37606.1679473979260348465
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:32:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Xde8FqSJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id o2so11191781plg.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679473978;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bZARfYks7JtAUNkSH8pLOdqc0Gbdg217AFckjcaJn94=;
        b=Xde8FqSJkUy6NRgFJKePxf8DMCtETi65oMrFOiLLbSkg9hpZKp9Mz5GiLyYCVlx7m1
         /c/krNhFdEVFf0FLYFgLybk9eZ5kgqduEZShqeYrlsEkyRtEU5DqzlF0f+2jk8K9zlZC
         cFGNaHDmMsoFDMyV64dF/QTt7BhctjuH7tIa6Q62wuoy7M4jQ+ZM6tqiUH2F+WV+HfqS
         5dYtzjjJC7IIZEmQVncTC4C4UwaECDbfxjEejzGLhI59md4ws4IuuURdM57YpeJWLIQV
         fE6ElrUxl7qZd4wu60ZeEN7Y5XOSe07apN4wVu+kNgVix1FUwBjPkyEf/JPBCRqvFS9B
         oTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473978;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZARfYks7JtAUNkSH8pLOdqc0Gbdg217AFckjcaJn94=;
        b=C0aAPV2Z9Cz/LMQF0llRMs5vQJDTYlJWcGzIv+GiT+c2q+P5mQDH4VAQDLLMrJA6N4
         bWW2h0PkJ9LocaaaM8nnWOPmzvCx1Xk3BsJRR3bDF5IbtGhKtp9VVp5JUNAqO9hvLpkz
         6c7obkMty/NDyi3rAVZ2wdQmWnU7311ScWpO9QCVEq5ZN7t0A08SmUn2Sj7dO0xsFvzP
         T5WzsLXU5tElL7LXl2ZcexzL9gOoadZ1Ta5+5XWdLsjXOKgLfjjRC9HeXOWRhrfdji3E
         zmCDYgHrxIPQZPJ+N8QR2BZKrutMA+fz2j/nivPWAvq3zamz+x9bEcxa4DPhXiuX7+As
         QfjQ==
X-Gm-Message-State: AO0yUKXYgmKfZzFGugRlZa3FiF6ZsVHn1nc03EbYbp3FRGpW51RAEldw
	uat9jKgoaPScDqX3t5SgIeIWR0IuCZbCKU03d+A=
X-Google-Smtp-Source: AK7set94e4E0xKYmbFUr4t4r6O1qHaEUG09B4qYfi8oa1bfBMtcX6aHCUCnV13gBOlKT6XtCpdj48w==
X-Received: by 2002:a17:90b:3906:b0:23f:9925:6f8b with SMTP id ob6-20020a17090b390600b0023f99256f8bmr2946763pjb.17.1679473978553;
        Wed, 22 Mar 2023 01:32:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d11-20020a17090a2a4b00b0023377b98c7csm9100993pjg.38.2023.03.22.01.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:32:58 -0700 (PDT)
Message-ID: <641abd3a.170a0220.e030e.f974@mx.google.com>
Date: Wed, 22 Mar 2023 01:32:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 12 runs,
 3 regressions (v5.10.175-cip29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:33:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11056

cip/linux-5.10.y-cip ltp-fcntl-locktests: 12 runs, 3 regressions (v5.10.175=
-cip29)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.175-cip29/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.175-cip29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bb7267e6d2a6f131bb46ba14f0d3c418379e8bd4

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C433TA-AJ0005-rammus    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aa96388a3a12cd49c950e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-fcnt=
l-locktests-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-fcnt=
l-locktests-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/641aa96388=
a3a12cd49c950f
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641ab10a57b56228f19c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ltp-fcntl-lockte=
sts-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ltp-fcntl-lockte=
sts-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/641ab10a57=
b56228f19c9506
        failing since 8 days (last pass: v5.10.168-cip27, first fail: v5.10=
.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641ab7769f55dc54ee9c9505

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-r=
zg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests-r8a774a1-hihope-r=
zg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/641ab7769f=
55dc54ee9c9506
        new failure (last pass: v5.10.173-cip28) =

 =20

