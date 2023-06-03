Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1240C7EE24
	for <webhook@archiver.kernel.org>; Sat,  3 Jun 2023 17:43:26 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.2046.1685814200130362593
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Jun 2023 10:43:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=JnvUYlOq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-650c89c7e4fso3190278b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Jun 2023 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685814199; x=1688406199;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gK7iAKw2usqj4mEd3C62+M5c4T6t8yDokd9DqZgZNkI=;
        b=JnvUYlOqhIwgzPEP88qVLysecH1cZ/grwVMXbBniwwDc+5h+a/BTQDoINxaJsZEYca
         4ygiJ3oRgDGTgV1hRA6bxLmHsXXmkxoF0dNdp/5tXc+Vo7Ic1rWUhqW2On/8VhUWBeen
         m80yNS2Sf6DA6bvVmgvmG2tIotHUP21ulKfJB5Z20L+VYSMvsRiTZRrQPX/03TTClB7K
         065xOb8S/dlo+KtPTK4TceHHR4eNXMUoQs4l5Ixx0yplJdCxfzPihoogZOEg6RQzrIuM
         zit6uATXE4wVoygcoEMYDZ2jiBY33k6Val8zDetT/+IlnzbiRQrjUSVkK2/Rz0aMGh8O
         5DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685814199; x=1688406199;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gK7iAKw2usqj4mEd3C62+M5c4T6t8yDokd9DqZgZNkI=;
        b=RmKja3J13kDl6I9RWS4xqSp9M5sHoq20pHiX4hbZVKYpuAEn/5p7+VTf3N6khl1d3l
         j+eJeYbJ2MPAb7Sbh3JoCWa+WB+LRUk12zz+qM8NNOhvcISKYILwBkcf1F/31lmMAgcn
         cM9X1+cU71uosI8ENfjnhJpOq7sE304JIJzWzyxWFArIg+sCzYU7UWpLWkugqKtAG8h/
         UyyhdJjutQ/LplqQpcr4FaDSNOjHXfHE89DZyvw+J00PDG67O49H+NflkgKjFZI0Pt6S
         qQlJv5SYTfT0PbU1aICX8mGBY94Da+Pzhu2DN9xLx3jqQQl8Wj03a4HJ8uEk7bOU5ZL9
         Hfkg==
X-Gm-Message-State: AC+VfDwJuKNKXEKU1r/bE6jENwClRx/lchDeh2+QpS20Vbyz/AC1JAs2
	E9bJ7UdZl+9wDCBuKUzF7beBNqaxW2I4W0Gk+tc1jQ==
X-Google-Smtp-Source: ACHHUZ70Mub7aEIYPF4jzmPXgg6a1YZQdnFHNMeScgPe01WxopuWL0JjIDm13HmViNqzkN/rQDV0Pg==
X-Received: by 2002:a05:6a20:72a5:b0:10f:9bea:5a61 with SMTP id o37-20020a056a2072a500b0010f9bea5a61mr2945956pzk.2.1685814199078;
        Sat, 03 Jun 2023 10:43:19 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a63d94a000000b005308b255502sm3075918pgj.68.2023.06.03.10.43.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 10:43:18 -0700 (PDT)
Message-ID: <647b7bb6.630a0220.7a0b2.5b0e@mx.google.com>
Date: Sat, 03 Jun 2023 10:43:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1281-g84d5372e0f31
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 12 runs,
 7 regressions (v6.1.26-1281-g84d5372e0f31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 03 Jun 2023 17:43:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11758

cip-gitlab/ci/pavel/linux-test ltp-timers: 12 runs, 7 regressions (v6.1.26-=
1281-g84d5372e0f31)

Regressions Summary
-------------------

platform         | arch   | lab           | compiler | defconfig           =
       | regressions
-----------------+--------+---------------+----------+---------------------=
-------+------------
qemu_riscv64     | riscv  | lab-broonie   | gcc-10   | defconfig           =
       | 2          =

qemu_riscv64     | riscv  | lab-collabora | gcc-10   | defconfig           =
       | 2          =

qemu_x86_64      | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig    =
       | 2          =

rk3399-gru-kevin | arm64  | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1281-g84d5372e0f31/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1281-g84d5372e0f31
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      84d5372e0f314fb85258229768641315d1a95773

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform         | arch   | lab           | compiler | defconfig           =
       | regressions
-----------------+--------+---------------+----------+---------------------=
-------+------------
qemu_riscv64     | riscv  | lab-broonie   | gcc-10   | defconfig           =
       | 2          =


  Details:     https://kernelci.org/test/plan/id/647b77833053bec44cf5de2a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-q=
emu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-q=
emu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647b7783305=
3bec44cf5de2f
        failing since 73 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647b7783305=
3bec44cf5de2f
        failing since 73 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12) =

 =



platform         | arch   | lab           | compiler | defconfig           =
       | regressions
-----------------+--------+---------------+----------+---------------------=
-------+------------
qemu_riscv64     | riscv  | lab-collabora | gcc-10   | defconfig           =
       | 2          =


  Details:     https://kernelci.org/test/plan/id/647b6997276cc54087f5ded6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/riscv/defconfig/gcc-10/lab-collabora/ltp-timers=
-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/riscv/defconfig/gcc-10/lab-collabora/ltp-timers=
-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647b6997276=
cc54087f5dedb
        failing since 73 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647b6997276=
cc54087f5dedb
        failing since 73 days (last pass: v5.10.167-cip26-2-g28bb49f7179b, =
first fail: v5.10.175-cip29-rt12) =

 =



platform         | arch   | lab           | compiler | defconfig           =
       | regressions
-----------------+--------+---------------+----------+---------------------=
-------+------------
qemu_x86_64      | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig    =
       | 2          =


  Details:     https://kernelci.org/test/plan/id/647b6a72420c07564bf5de52

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig/gcc-10/lab-collabora/lt=
p-timers-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/x86_64/x86_64_defconfig/gcc-10/lab-collabora/lt=
p-timers-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647b6a72420=
c07564bf5de57
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-06-03T16:29:23.229091  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647b6a72420=
c07564bf5de57
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935)

    2023-06-03T16:29:23.229091  =

   =

 =



platform         | arch   | lab           | compiler | defconfig           =
       | regressions
-----------------+--------+---------------+----------+---------------------=
-------+------------
rk3399-gru-kevin | arm64  | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647b748b8e59064bcbf5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm64/defconfig+arm64-chromebook/gcc-10/lab-col=
labora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1281-g84d5372e0f31/arm64/defconfig+arm64-chromebook/gcc-10/lab-col=
labora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/647b748b8e59064bcbf=
5de26
        new failure (last pass: v4.19.280-cip95-rt30) =

 =20

