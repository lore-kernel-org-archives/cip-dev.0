Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228D0C7EE23
	for <webhook@archiver.kernel.org>; Sun, 21 May 2023 10:25:34 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web10.5366.1684664725092757359
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 21 May 2023 03:25:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=YSyBmBN5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.173, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53474b0c494so3180560a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 21 May 2023 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684664724; x=1687256724;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AOL+ViyMUa32m+5G3L5IM4orBWhWOfH28iS6DOiPLBE=;
        b=YSyBmBN5R9g25UnACntb34cpUKIugtx64DJSKlfsc0AMAQeniVim+Z/KIYhRaLTJs8
         9RbzHocinydOx7m60AYd9qHzHKBYEeKS8bQ6Xk0m40twiJ+HcRUN9CVO1yAflY18LIFs
         wfywbOWgFhgOpYYZRBq9lHjekVTcuAMJvCj0NtimG643We9VoRjzZSkilapa3+2FBI0+
         GhGe2tmwDUdxohNmqun9ICuefWqXzycH38Bf4CIr3DxpSkXqCiPNsCapqPMXf4MqgWG6
         UAmUSb4FwZdzfZ1BLMEim6I506I1mf8kRz8rqR2oY09GpHCnh0dkip6VvDk8Inb/fbKy
         iy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684664724; x=1687256724;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AOL+ViyMUa32m+5G3L5IM4orBWhWOfH28iS6DOiPLBE=;
        b=BQmnH9TSrlPMtTNt41ElFqJP6dOrH5v+7dwtvsAM9jN52cIHKhz8L31GamFsC/65sP
         zjkC+Q7girpQBoZvicFxXj+Qv2KUNtV0wgke2G7GdF7vj8nJljNh7DK1zYU1eRq/KC9T
         7QtmEEjx2FITfQsQ1DxsTgvhtVz/Wd0JgdYM+opjO5x6Vqojzra5dibg7MYwz1n6l8Yp
         PUwgJJtU9FRnz3elNWyu/6cHk+vJd8OoqWKTEaFxj5nVrFgSE81C/n7e82tex3vaIC5P
         HVGSnZ0wsu6sCFEBJmEHTdUyUrDmU+DWzj81MjopRy4Z5a/TalVUHr9JZVazYg7hgXDN
         ZDeA==
X-Gm-Message-State: AC+VfDx5HG9bJKtZwCUeAUfzlwQXCPjlaRMuOafvyI281X2/TN/RdwcU
	0qYSstKjrubHx5M0RdE2jVAoUhvjysdikOPkNTjCdw==
X-Google-Smtp-Source: ACHHUZ4UxSRlqavLZEiJ900inlV5Hi7ne3nH7rFlmBl2T+IibJh2zlnz4tCxdPcztCbvZE7FPolqcg==
X-Received: by 2002:a17:903:120b:b0:1a6:d15f:3ce1 with SMTP id l11-20020a170903120b00b001a6d15f3ce1mr10444035plh.34.1684664724083;
        Sun, 21 May 2023 03:25:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902f7c700b001a19196af48sm2757407plw.64.2023.05.21.03.25.20
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 03:25:21 -0700 (PDT)
Message-ID: <6469f191.170a0220.73bcd.46c5@mx.google.com>
Date: Sun, 21 May 2023 03:25:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs,
 2 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 21 May 2023 10:25:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11580

cip-gitlab/ci/pavel/linux-test ltp-ipc: 18 runs, 2 regressions (v5.10.180-c=
ip33-11-gfea7994097935)

Regressions Summary
-------------------

platform          | arch  | lab         | compiler | defconfig          | r=
egressions
------------------+-------+-------------+----------+--------------------+--=
----------
beaglebone-black  | arm   | lab-broonie | gcc-10   | multi_v7_defconfig | 1=
          =

qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig          | 1=
          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip33-11-gfea7994097935/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform          | arch  | lab         | compiler | defconfig          | r=
egressions
------------------+-------+-------------+----------+--------------------+--=
----------
beaglebone-black  | arm   | lab-broonie | gcc-10   | multi_v7_defconfig | 1=
          =


  Details:     https://kernelci.org/test/plan/id/6469e3c010d0f075972e8600

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/arm/multi_v7_defconfig/gcc-10/lab-brooni=
e/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6469e3c010d0f075972e86=
01
        new failure (last pass: v5.10.179-cip32-471-g18129e1b68691) =

 =



platform          | arch  | lab         | compiler | defconfig          | r=
egressions
------------------+-------+-------------+----------+--------------------+--=
----------
qemu_smp8_riscv64 | riscv | lab-broonie | gcc-10   | defconfig          | 1=
          =


  Details:     https://kernelci.org/test/plan/id/6469dea849e96769c82e860f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/riscv/defconfig/gcc-10/lab-broonie/ltp-i=
pc-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip33-11-gfea7994097935/riscv/defconfig/gcc-10/lab-broonie/ltp-i=
pc-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6469dea849e96769c82e86=
10
        failing since 2 days (last pass: v5.10.179-cip32-4-g580ea5dd85ae, f=
irst fail: v5.10.179-cip32-471-g18129e1b68691) =

 =20

