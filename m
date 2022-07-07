Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9450C433EF
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 02:37:21 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web12.1155.1657161434376833090
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Jul 2022 19:37:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Eh/QXC5n;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.169,
 mailfrom: bot@kernelci.org)
Received: by mail-pg1-f169.google.com with SMTP id bf13so2906240pgb.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Jul 2022 19:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=KtwypEylrXmrL0B8QGkW12wD3pWDEerEbpegoZEdrTo=;
        b=Eh/QXC5nEbKhCcprAwuveUPkfCl/RuOabQQi3Y56GPLbR4X79I35Yg8YxzUMZHP9Db
         AnOR2mnEcRVE1nGE7gS5aSRW0i/u0a+lBlxK+3wsIQn/chq6tmzYiOFpJ5MNSQ47oxQd
         T/5TYfeX+n63ELbs9k9PTi21W6mXJMgS73OjdE+RFzbsMuHoR+w6FYg++8Qiu3WbM5dH
         JZ43zVwWi43dKUEvMxyHTG9t5Z5vbrX31bP4NgOtCcyU3W4UeYaj1AHvVX/xlB9ydR1u
         UEWkHnObFGbDHIb5EzDQg8AmybmcDCwiWMsgDu0w1VQNEjP4a2rDuiFV0tQ3cyS36b8/
         r2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=KtwypEylrXmrL0B8QGkW12wD3pWDEerEbpegoZEdrTo=;
        b=nVXKOPDbSlgehtEL/lnVM0nZVKAqO2TsefJBJrq5liliZ+0RECtL9IsxqZM9PUPr7Y
         HyDzpRs0pGm1qIL8Z7QcygCCCwhEfRt9AsHtVZP9S6YIIds/+mo+fSRnuEoLiNc6TH9N
         mGZY+bdkc5rA6lKj3tlSq8WwyslFPNXYqtNGH/0RCBcGMAEG9OIeyQRFAx+QyRN4cRd+
         B1+S2pqIRLSNA9mObSehQSYRaIBXLJ8BfGsGiOGtgkxsRRFio/h+xRWwqdWvopTSuH9s
         tMEkq/zefBVFbQ2jKjSUeFaK68vo0Vxd7i5pu2D5Erb7N3J+1wLx8V6uX7YYKjZO4Ldy
         aSDw==
X-Gm-Message-State: AJIora+mOjLepFURYMIr4RMNxTYfXBDfrupBKOBMQpYI4vGI5rFf2z9r
	73tbK8OVLtqZGvgicrctfZuRKj0YLa6t14tX
X-Google-Smtp-Source: 
 AGRyM1s3+r53+C0UfqpWi9VFUw2syo3seqyTGNV2Bz+A6Ze29uG2lNsWK/E9plkokEWIEhIcsJfFow==
X-Received: by 2002:a17:90a:b701:b0:1e8:6d19:bcb with SMTP id
 l1-20020a17090ab70100b001e86d190bcbmr2146370pjr.218.1657161433284;
        Wed, 06 Jul 2022 19:37:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 o12-20020a170902d4cc00b0016a3f9e4865sm26757983plg.148.2022.07.06.19.37.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 19:37:12 -0700 (PDT)
Message-ID: <62c646d8.1c69fb81.6e36d.64a7@mx.google.com>
Date: Wed, 06 Jul 2022 19:37:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.9.196-8580-gf266375ffc61
X-Kernelci-Branch: ci/iwamatsu/linux-4.4.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.4.y-cip-rc baseline: 87 runs,
 8 regressions (v4.9.196-8580-gf266375ffc61)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Jul 2022 02:37:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8704

cip-gitlab/ci/iwamatsu/linux-4.4.y-cip-rc baseline: 87 runs, 8 regressions =
(v4.9.196-8580-gf266375ffc61)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.4.y-cip-rc/kernel/v4.9.196-8580-gf266375ffc61/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.4.y-cip-rc
  Describe: v4.9.196-8580-gf266375ffc61
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f266375ffc610dd9f3a80109cd6070c2e886487a =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c641b0445744776aa39bf0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-baylibre/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c641b0445744776aa39=
bf1
        failing since 0 day (last pass: v4.4.302-1082-g00b9de85d40e, first =
fail: v4.4.302-1085-gb83ed90eb98d) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62c6432c4c1206a06ca39bd3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c6432c4c1206a06ca39=
bd4
        failing since 1 day (last pass: v4.4.302-1082-g00b9de85d40e, first =
fail: v4.4.302-1083-g94e3113365c2) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c641be445744776aa39c10

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-broonie/baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c641be445744776aa39=
c11
        failing since 0 day (last pass: v4.4.302-1082-g00b9de85d40e, first =
fail: v4.4.302-1085-gb83ed90eb98d) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62c64440686e3b2f3ca39c0e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c64440686e3b2f3ca39=
c0f
        failing since 1 day (last pass: v4.4.302-1082-g00b9de85d40e, first =
fail: v4.4.302-1083-g94e3113365c2) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c641b2ff5d27a1b8a39be9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-baylibre/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c641b2ff5d27a1b8a39=
bea
        failing since 0 day (last pass: v4.4.302-1082-g00b9de85d40e, first =
fail: v4.4.302-1085-gb83ed90eb98d) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-baylibre | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62c6432ecc8a9ed6e7a39bd6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig/gcc-10/lab-baylibre=
/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c6432ecc8a9ed6e7a39=
bd7
        failing since 1 day (last pass: v4.4.302-1082-g00b9de85d40e, first =
fail: v4.4.302-1083-g94e3113365c2) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig+arm64-c=
hromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c641bfd62ca580a9a39bcd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig+arm64-chromebook/gc=
c-10/lab-broonie/baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c641bfd62ca580a9a39=
bce
        failing since 0 day (last pass: v4.4.302-1082-g00b9de85d40e, first =
fail: v4.4.302-1085-gb83ed90eb98d) =

 =



platform              | arch  | lab          | compiler | defconfig        =
          | regressions
----------------------+-------+--------------+----------+------------------=
----------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie  | gcc-10   | defconfig        =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/62c64466ae120cac4ba39bdb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.4.y-cip-rc/v4.9.196-8580-gf266375ffc61/arm64/defconfig/gcc-10/lab-broonie/=
baseline-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220624.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/62c64466ae120cac4ba39=
bdc
        failing since 1 day (last pass: v4.4.302-1082-g00b9de85d40e, first =
fail: v4.4.302-1083-g94e3113365c2) =

 =20

