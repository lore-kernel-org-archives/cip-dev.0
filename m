Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A56C77B7D
	for <webhook@archiver.kernel.org>; Thu, 18 May 2023 12:16:36 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.15409.1684412194547415001
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 May 2023 05:16:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=jb/7k6gz;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64d18d772bdso717529b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 May 2023 05:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684412193; x=1687004193;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SkX1BiOMgPw1bRrctBFB8QRQijsD70CHoliABxKQs+U=;
        b=jb/7k6gzZtsCJqGRiOI7EHNvIbm+dKnTlPnnxRayuTEiel+2zTIcsAIZi3YpBfCj3d
         RCN/zL8ayF0EfkrkHh0/UuhlWfIxDQLN/1PAmsHzJpa2iwIf3bwGsGcHGK1EZnMs9dVP
         I3zL6FcxUDteVyEQs/+f16DHgL2q7BumVsUeqROq02a0NznBjLqD0eYrwVlkHrWiGC8m
         5K5MgBPo34li6OMNweq6G8G1MbvDjOv9nqnmsw8+Z6d7TBnshfDTCAzTlot1hj0y1Wd9
         9xXrblHjoVmymDkScRU/9YqEV2Ao26Yb9knmHHFID6gLNUPtQ1G2jIC3PPzeGJSLmE4G
         tmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684412193; x=1687004193;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkX1BiOMgPw1bRrctBFB8QRQijsD70CHoliABxKQs+U=;
        b=EBOGtYK8JRZyw5OPfZdlUU5sUd6ZyweL7k15fZiLNv+wdQ1uFBzuYsgYbCXBlLL9Yr
         To47rZ9QBl8tdnrQWUjSSliBRiKkSnTZXE+ClD1of6H/OXUlILWvN+RO6TgBxkGlm1iH
         j4HNk3wzqwb0v2IH9KXmWIV8/2uiufHdwGX4weLDHXgLAUgk0ZTqWJqhosHnlCLqZHS3
         4fixM/xup68fauNS23zM4ZrKHJnMIhYoi41GHCtW4kGw1LAwAY76fMrvhlKOyEhKTqbv
         /gxPFz1MS0QuFJWIXII6ew6ORTOxi4bcChqPXT2yWWCjXS+5hszrfwZsA/eqerOC+JwD
         RB8g==
X-Gm-Message-State: AC+VfDzVddC9/ZZ6/iqShM9csMINqOIQ7vllsLYHC8JEEWmmML5PqLn3
	M32z7i68vYNESOjSQ9UmksuroY1NdDQt+/79K5YUKA==
X-Google-Smtp-Source: ACHHUZ4L/IdS0gcwkMUA6wED77kIy9GWNMlPDfCGlMfz+h5AbGA6XqmiuaqeJSWdnDeRBEIuSzGODA==
X-Received: by 2002:a05:6a00:139b:b0:643:59cd:6cad with SMTP id t27-20020a056a00139b00b0064359cd6cadmr4887734pfg.24.1684412193501;
        Thu, 18 May 2023 05:16:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j5-20020aa783c5000000b0064ceb16a1a8sm1236282pfn.33.2023.05.18.05.16.31
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 05:16:31 -0700 (PDT)
Message-ID: <6466171f.a70a0220.2445c.1dcc@mx.google.com>
Date: Thu, 18 May 2023 05:16:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.179-cip32-471-g18129e1b68691
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs,
 8 regressions (v5.10.179-cip32-471-g18129e1b68691)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 May 2023 12:16:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11522

cip-gitlab/ci/pavel/linux-test ltp-timers: 16 runs, 8 regressions (v5.10.17=
9-cip32-471-g18129e1b68691)

Regressions Summary
-------------------

platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-broonie   | gcc-10   | defconfig    =
              | 2          =

qemu_riscv64             | riscv | lab-collabora | gcc-10   | defconfig    =
              | 2          =

qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =

rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.179-cip32-471-g18129e1b68691/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.179-cip32-471-g18129e1b68691
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      18129e1b6869127ae39e5978bb2fe70ecd53f174

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-broonie   | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/64660c64399d72618a2e85e9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-broonie/ltp-=
timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64660c64399=
d72618a2e85ee
        failing since 56 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64660c64399=
d72618a2e85ee
        failing since 56 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_riscv64             | riscv | lab-collabora | gcc-10   | defconfig    =
              | 2          =


  Details:     https://kernelci.org/test/plan/id/6466079d2587d99a472e85e6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-collabora/lt=
p-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-collabora/lt=
p-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466079d258=
7d99a472e85eb
        failing since 56 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12)

    2023-05-18T11:10:06.692467  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6466079d258=
7d99a472e85eb
        failing since 56 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12)

    2023-05-18T11:10:06.692467  =

   =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
qemu_smp8_riscv64        | riscv | lab-collabora | gcc-10   | defconfig    =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/64660b4da428f6a3542e85e9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-collabora/lt=
p-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/riscv/defconfig/gcc-10/lab-collabora/lt=
p-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64660b4da428f6a3542=
e85ea
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip       | gcc-10   | defconfig+arm=
64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646608e7f6d75df80d2e85ed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/646608e7f6d75df80d2=
e85ee
        new failure (last pass: v5.10.179-cip32-4-g580ea5dd85ae) =

 =



platform                 | arch  | lab           | compiler | defconfig    =
              | regressions
-------------------------+-------+---------------+----------+--------------=
--------------+------------
rk3399-gru-kevin         | arm64 | lab-collabora | gcc-10   | defconfig+arm=
64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64660ca8a0003781682e85ec

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.179-cip32-471-g18129e1b68691/arm64/defconfig+arm64-chromebook/gcc-10=
/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64660ca8a00=
03781682e85f1
        failing since 190 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64660ca8a00=
03781682e85f1
        failing since 190 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3=
b, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

