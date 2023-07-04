Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE5FC001DD
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 07:26:07 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.53475.1688455563255174286
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 04 Jul 2023 00:26:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=x2GU91Ca;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6687096c6ddso2651077b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 04 Jul 2023 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688455562; x=1691047562;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mDCkh6mq5/YMuIxSdA2Sbi+ZQbQbi4Yio+/zu6YprxM=;
        b=x2GU91CaHeh4JivgIodVWSOWP65Ayv2gCZujR64/L17RfQu35FFxM77jChQS+q4Wag
         L/Z0bLYeBENON4bf+LTJiFDgzyjBnvrWklWK0qZIY4L4j3qQ6hIMMjhMcuA2GB8uM6lV
         inNTPzIgSam8Avtv4o8fRvswVWY1vOw3L6xk1uJ6stWGMfRm9xV5PSD6d45jzdzjMnEz
         9EnzTrWK0Z+0X2DfauSwmzUE0iDzVfk1iOCBS0v+K1dSnTX3AQigoYNvJY/QUvv8KIT1
         ZjfyQHk5bxQUgSscQvK7x/tOZJtJ9KcpGkncBkrTQWMLSxn+w3HfLDxCfChLUhR3PvBE
         7lBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455562; x=1691047562;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDCkh6mq5/YMuIxSdA2Sbi+ZQbQbi4Yio+/zu6YprxM=;
        b=AVDUtR13mpX8R+vyJvCfeCawF42B9mipAhMydbYuKQTJJr8RNtqrgnbzip0h9DAQdv
         Ei7P/xzZ3D1755zt2n2MEuHnSeXZKwc4x2kyaziXloUdktEXEk2DQ4SdhwMoG3nW3p+x
         cGPwFhK0u29IgX87XxeLS1oSuazGU/mwuFxCGHV08krvwB/2qOB18LdZ7LKarPb19/gP
         W3oguZkntyCxgEaE6dHlvt/fleqMMzF+pXfPgOmCs4sCCqQgbfU4uNbuYb6eqTHWW/12
         /BMVLMq3koqcakReoZnItptDuLoY12qGY9UAyBTD8vtwbbZ30AL4b/DqrwEYjA3ffvNX
         NdhQ==
X-Gm-Message-State: ABy/qLavTdRFYXdXhKCIicglBpplwo5jp0OXYJ8VgJgfc4M9OxliNuDl
	9t09R10L+VrMdH5YqTUegxIB2ei+l4MkZTeVMn0guQ==
X-Google-Smtp-Source: APBJJlE1hOFVkBzH5/NMTxkrrc5iatA/hsezXURwa3i7ALuUZAxSymdN+e+8OUUIvfCLXXWv59iiWQ==
X-Received: by 2002:a05:6a20:7f9d:b0:12e:8070:b291 with SMTP id d29-20020a056a207f9d00b0012e8070b291mr5829699pzj.47.1688455562224;
        Tue, 04 Jul 2023 00:26:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h21-20020aa786d5000000b00678cb336f3csm12937089pfo.142.2023.07.04.00.25.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Message-ID: <64a3c985.a70a0220.5e62c.a810@mx.google.com>
Date: Tue, 04 Jul 2023 00:25:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-10-ga711f789c23e1
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 14 runs,
 8 regressions (v5.10.184-cip36-10-ga711f789c23e1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 07:26:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12211

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 14 runs, 8 regressio=
ns (v5.10.184-cip36-10-ga711f789c23e1)

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

qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
                 | 2          =

qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.184-cip36-10-ga711f789c23e1/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.184-cip36-10-ga711f789c23e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a711f789c23e157efd79724aec812ad47941364b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C436FA-Flip-hatch   | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64a3bd7995862c9b59bb2a8d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a3bd79958=
62c9b59bb2a92
        failing since 250 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a3bd79958=
62c9b59bb2a92
        failing since 250 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64a3bdafd143f9406abb2a86

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a3bdafd14=
3f9406abb2a8b
        failing since 250 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a3bdafd14=
3f9406abb2a8b
        failing since 250 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/64a3bd41e94e01b00fbb2a81

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a3bd41e94=
e01b00fbb2a86
        failing since 20 days (last pass: v5.10.180-cip34-236-g6d219c607dc6=
8, first fail: v5.10.182-cip35-8-gc3d08808cfa7) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a3bd41e94=
e01b00fbb2a86
        failing since 20 days (last pass: v5.10.180-cip34-236-g6d219c607dc6=
8, first fail: v5.10.182-cip35-8-gc3d08808cfa7) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_riscv64             | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 2          =


  Details:     https://kernelci.org/test/plan/id/64a3ba1e3c72e68073bb2a75

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a3ba1e3c7=
2e68073bb2a7a
        failing since 20 days (last pass: v5.10.180-cip34-236-g6d219c607dc6=
8, first fail: v5.10.182-cip35-8-gc3d08808cfa7)

    2023-07-04T06:19:59.014359  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64a3ba1e3c7=
2e68073bb2a7a
        failing since 20 days (last pass: v5.10.180-cip34-236-g6d219c607dc6=
8, first fail: v5.10.182-cip35-8-gc3d08808cfa7)

    2023-07-04T06:19:59.014359  =

   =

 =20

