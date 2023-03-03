Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0666C7EE30
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 20:57:56 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.186.1677877074468641193
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 03 Mar 2023 12:57:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=5c+3dhIl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id l1so3881290pjt.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 03 Mar 2023 12:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1677877074;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qjVUOkBnEzrrkXqIIYpADJ3C28oYiY08HKsHgHbGzpM=;
        b=5c+3dhIlPciX+swxdb8JLlC5BwvDgihQdGFKrhmgQeA62nVOxt4Gkjo6DM9VyMLA1P
         pTsxyZYM/smwvJE8+BMajbPx2o7CsLN+mB/PrKbdVbibDvFXZdO6L/lun8TqPjAQzAoX
         KeY1fWiS8saqUKTAZvno3qh5a69QjkOSBW+nGfq9qWrIGcxYk65gVsZX7/a55eVwwVsd
         JLt3wHIjzMtTnBPVEXOC2GP3JLDRljjENcwG3j8LwmR09jRHOja8p5Fz7ZzpwNMBzDA6
         AxpCnD455KEVdK+iGzEHheXyYEJyTY0a/rOQ8L09IvKQmSIk76DXAS6KlZCr9WhC8haV
         pbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677877074;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjVUOkBnEzrrkXqIIYpADJ3C28oYiY08HKsHgHbGzpM=;
        b=KyDALRIr405+lxJepD8yXK7QBZw8xn4uZVHuejDN57tFdG9NmuUEYYVZ3O0OCMXQGa
         1Po5rb/5oLr7lW7Xjkukr9jRTUngQ36mBOLNkJboMxC8UUUKLe/dZcCZOnaqxokC1io6
         D5g/0OvC+mOvd2JM4/r9O8YxSY5sCPlBe8YP/pnQKUfuFMt+iuPdyVJhvZHbUp4j/ABE
         RSjIwauD6ivsqvt9l0FAHXm7Ih4jN2GTHMIdMc1AlPc6yL9Rbwc86fupu9qyN+kDq0l8
         mjGRnPhkjviRKm04YVX9kh/um7/wjN6b5aYfNNBJ9YFifan9rbweZF58Mh+XIi1afCmV
         bloQ==
X-Gm-Message-State: AO0yUKVLdFYIkXDSBUFGwEMuFexFuziE5DmjXRl+ktj4hL9q79xhpYfd
	+Aj8R36GJvy8IMPfIc3OZ40x917iyAOd1HGD77oLk1Lt
X-Google-Smtp-Source: AK7set8oCOvmOqcEAbg1DZr600SYA/a7UbflOMxFZQvuu4TjEKbXNqYHhy1lxBuf5E+ioSG08GUVug==
X-Received: by 2002:a17:902:b612:b0:19e:6b56:7d8c with SMTP id b18-20020a170902b61200b0019e6b567d8cmr2519937pls.9.1677877073624;
        Fri, 03 Mar 2023 12:57:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b0019a97a4324dsm1972710plg.5.2023.03.03.12.57.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:57:53 -0800 (PST)
Message-ID: <64025f51.170a0220.7823.4932@mx.google.com>
Date: Fri, 03 Mar 2023 12:57:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-109-g23841ec76bec
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 7 runs,
 9 regressions (v5.10.168-cip27-109-g23841ec76bec)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 20:57:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10927

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 7 runs, 9 regression=
s (v5.10.168-cip27-109-g23841ec76bec)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

qemu_riscv64              | riscv  | lab-collabora | gcc-10   | defconfig  =
                  | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-109-g23841ec76bec/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-109-g23841ec76bec
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      23841ec76bec7ddf00658918b23753dc2ca930ce

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a5d15b796362fd2731fa0290d48c096d370a040d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64025028fb2e1d16da8c86b4

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230224.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64025028fb2=
e1d16da8c86b9
        failing since 128 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64025028fb2=
e1d16da8c86b9
        failing since 128 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64024f9a14cc55338b8c8681

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230224.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64024f9a14c=
c55338b8c8686
        failing since 128 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64024f9a14c=
c55338b8c8686
        failing since 128 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
qemu_riscv64              | riscv  | lab-collabora | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/64025143f920e4397d8c8647

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30224.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64025143f92=
0e4397d8c864c
        new failure (last pass: v5.10.167-cip26-192-ga2cd4acb16b2) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64025143f92=
0e4397d8c864c
        new failure (last pass: v5.10.167-cip26-192-ga2cd4acb16b2) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/640252c1580a73771e8c864d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230224.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/640252c1580a73771e8=
c864e
        new failure (last pass: v5.10.168-cip27-86-g19cf8cd2dd993) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64025d7616735a96ee8c8652

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230224.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64025d76167=
35a96ee8c865d
        failing since 9 days (last pass: v5.10.167-cip26-2-g1e87e7748b91, f=
irst fail: v5.10.167-cip26-192-ga2cd4acb16b2) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64025d76167=
35a96ee8c865d
        failing since 9 days (last pass: v5.10.167-cip26-2-g1e87e7748b91, f=
irst fail: v5.10.167-cip26-192-ga2cd4acb16b2) =

 =20

