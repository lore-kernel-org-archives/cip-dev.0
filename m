Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55BAC7EE2F
	for <webhook@archiver.kernel.org>; Fri, 26 May 2023 08:27:42 +0000 (UTC)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
 by mx.groups.io with SMTP id smtpd.web11.3698.1685089655842032021
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 26 May 2023 01:27:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=iLJ/rH1I;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.170, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so444211a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 26 May 2023 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685089655; x=1687681655;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bpTNc0qZqwyl1puyVIQG2WC4Xqz1OLjIK0pDpMjYJ+A=;
        b=iLJ/rH1IeRP4KwCU0YlfaD/15fXwksazxtfbWX0b6JrqSVfeiVeqzKBGM6Ov21Ot9k
         +WxCZ+lvIBv+/hmRP6BuhRUCn3CorW5/ApusdwopSTuIzc7ljJyZpyUicXd7mh+CW9oE
         ifsOnprXKzHkCGHiQeNpLK5WfB5tMdxr/7Uy+DgtGydJLkdc95si1vtg5YNGoU1OwRUN
         0EfBuuAIkBKrqyo0EkKKx6AzR2tUll5rAG4Oou8I4Ndr06hbzyGsTCQ5ejA18C0ROjoG
         7JDx+vmsKiQL+gKhea7UMDba0aSSV5Vc49CU4nAsN1cBjv855kDfdjuehA0rKrSisZom
         +IbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685089655; x=1687681655;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpTNc0qZqwyl1puyVIQG2WC4Xqz1OLjIK0pDpMjYJ+A=;
        b=gYfiTrtCJFVp3ReZpCBuCYWzS7F+DWuRpFdG/69N2yYmS324hQQqxfksnmm6T6tH7/
         4kgT1l/2DP6BrI0FmwtpMHcm9c5YOrTCWYTfREHvXqc7M2beAdsp3W4eLHNKXRbcxdkR
         qvvCMWiILH5/mfF0ljShVwFuRmxgCcbE+hHHoVK7cARvJZTyGi9x9A2zj5CMU+d7IWW0
         mgWceStMw/KDRa7Mg7lWoG/t5NQhsg0BLRMvunuECl3B8UkloM3cLOhUORuI7f/3yjXd
         PmGH9hMZA5Rdpd7Ykhbd4kiA7ibbNhc/QcWCjVfmYBZmtasc4epVn1wuw0FRrhnVxWCC
         jXKQ==
X-Gm-Message-State: AC+VfDx4sC2LpUVqAlVsLiMmXsBkrZUZIytJxqGY2UiA4ljW3ExHA2zQ
	be6oV9aEauOw2vOgwCEls3WiSah/3M5TRZrW3ZUb/Q==
X-Google-Smtp-Source: ACHHUZ6vRPt+2iMvlDotvdO0WndEicOHebYu7nyldatYeYRQ9N2VB7nxyUH4OjyFrbzbFM2hkP8txQ==
X-Received: by 2002:a17:90b:a49:b0:250:a964:9379 with SMTP id gw9-20020a17090b0a4900b00250a9649379mr1643124pjb.9.1685089654656;
        Fri, 26 May 2023 01:27:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090a458400b00246f9725ffcsm2329176pjg.33.2023.05.26.01.27.32
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 01:27:34 -0700 (PDT)
Message-ID: <64706d76.170a0220.7c677.4c99@mx.google.com>
Date: Fri, 26 May 2023 01:27:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-21-g090289427e8b2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 14 runs,
 9 regressions (v5.10.180-cip33-21-g090289427e8b2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 May 2023 08:27:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11656

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 14 runs, 9 regressio=
ns (v5.10.180-cip33-21-g090289427e8b2)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.180-cip33-21-g090289427e8b2/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.180-cip33-21-g090289427e8b2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      090289427e8b2be9dac126c4d1b760b100f2c6b8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  04e8f2f4fd9493f595b34320403cf6b4f1f6789d =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64705bdfca57fb343e2e85e7

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64705bdfca5=
7fb343e2e85ec
        failing since 211 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64705bdfca5=
7fb343e2e85ec
        failing since 211 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64705e12125fbc0a9d2e85e9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64705e12125=
fbc0a9d2e85ec
        failing since 211 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64705e12125=
fbc0a9d2e85ec
        failing since 211 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647060cc0a2d36c8272e865e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647060cc0a2=
d36c8272e8663
        failing since 93 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a=
2, first fail: v5.10.167-cip26-2-g1e87e7748b91) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647060cc0a2=
d36c8272e8663
        failing since 93 days (last pass: v5.10.165-cip25-154-gb7e05ba4f61a=
2, first fail: v5.10.167-cip26-2-g1e87e7748b91) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/647060d60a2d36c8272e8679

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30519.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647060d60a2d36c8272=
e867a
        new failure (last pass: v5.10.179-cip32-384-g291adc46abef0) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64705f4d5d92970f6a2e8607

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.180-cip33-21-g090289427e8b2/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230519.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64705f4d5d9=
2970f6a2e860c
        failing since 211 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64705f4d5d9=
2970f6a2e860c
        failing since 211 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20

