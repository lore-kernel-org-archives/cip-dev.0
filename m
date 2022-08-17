Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E736C32771
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 01:08:21 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web12.23534.1660698494730830305
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 18:08:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=LkUH5oGR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id
 m10-20020a17090a730a00b001fa986fd8eeso494711pjk.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 18:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=68oW++QykAkUrNqX4APAouXizj46ufWcruJcbjqDNpk=;
        b=LkUH5oGRJkGUOvgCVSbsuWkL9ODQBoUV+UJfXfCMLbQxc3ksa6K5qH/rPbTbwYl1H+
         r/+Z4BPo3///YjbbbWdtdNaneJbLkrOOjfUDcxXf49oq8gZpNK30fwWmwDiIELsERYRE
         /t8xpGJFG9K9foWnvhWvzX9Yb9WmpRCriR7bzx3wTkRw/L+ie41GG+tYcCA5N1cluKWW
         Ssy4tIf4jNhlDwIGrmO6Rf/mtV4DlK+r7Pl2gBn696XcUwhM9F29P+SXWuCDgTa84ps2
         UD+OkcETpMOQrcnjYClZrQQUp+wWlzs7tzz3wHT04/nQwjV37qn83fud/9t9ZXjnWM1Q
         /LYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=68oW++QykAkUrNqX4APAouXizj46ufWcruJcbjqDNpk=;
        b=CjwkIXWTBaQMSGeRYqO2venklUqhR32J1cUk8mfS0WlOU2XQOV+jxU6Tg1oWR+wxc4
         9uJMuDOqNtbb1MrRbxIb4ypG8X2h2pLCuWjFi6S7e/aeKcfsM/G0MMRPXCeeNg/9kXwU
         RoVQ8Pe3q4rr0sKbag6DDaDag2SYJBunUGduO8putRAG0f/rPmpPeAJ5MKpIG2ODqAjW
         VcQwrkiqs2dg9sBXk9nZsfPHxxZfcE70Y3tXy6wgKh7S6XwbjMgBjEbTd+h1D1ua0vOB
         nWHhrKXEwChtqYMGLGuuHsVraf1QJC1y7VK0VxJQUEO5OpVQLm9fjxKd9RgCeyx63jVg
         KzKQ==
X-Gm-Message-State: ACgBeo0PsZg4cncFnNyKhRp1WCNF75gU3e6XfTMI6LGOg0nyAmir8Hci
	vb84PPq/myCVDVwHCjvfqqnmDSUL7t4oKRoB
X-Google-Smtp-Source: 
 AA6agR6YYWZWr+12FxwCqAqmYz9h8o3qlMSRA+MH+tJV0g+nVgAWHHYE+X+fcsqw9jDUm8BHikvzgw==
X-Received: by 2002:a17:90b:1941:b0:1f3:2636:895 with SMTP id
 nk1-20020a17090b194100b001f326360895mr1325704pjb.26.1660698494041;
        Tue, 16 Aug 2022 18:08:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 v14-20020aa799ce000000b0052b6277df9esm9092337pfi.43.2022.08.16.18.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 18:08:13 -0700 (PDT)
Message-ID: <62fc3f7d.a70a0220.94336.f8cb@mx.google.com>
Date: Tue, 16 Aug 2022 18:08:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-49-g1145e9c6352e6
Subject: cip/linux-5.10.y-cip smc: 12 runs,
 5 regressions (v5.10.131-cip13-49-g1145e9c6352e6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 01:08:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9268

cip/linux-5.10.y-cip smc: 12 runs, 5 regressions (v5.10.131-cip13-49-g1145e=
9c6352e6)

Regressions Summary
-------------------

platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig      =
              | 1          =

qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig+arm64=
-chromebook   | 1          =

qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig      =
              | 1          =

qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defconfi=
g             | 1          =

qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defcon..=
.6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.131-cip13-49-g1145e9c6352e6/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.131-cip13-49-g1145e9c6352e6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1145e9c6352e68c31b58d1035f4f1ff07b2f9c89 =



Test Regressions
---------------- =



platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig      =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc2928e4932a690d355659

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-broonie/smc-qemu_arm64-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62fc2928e4932a690d35565a
        failing since 49 days (last pass: v5.10.112-cip6, first fail: v5.10=
.125-cip10) =

 =



platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig+arm64=
-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc346a1a1262c3453556e3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig+arm64-chromebook/gcc-10/lab-brooni=
e/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62fc346a1a1262c3453556e4
        failing since 67 days (last pass: v5.10.112-cip6, first fail: v5.10=
.121-cip9) =

 =



platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig      =
              | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc29ca978e8b9331355654

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm6=
4-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm6=
4-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62fc29ca978e8b9331355655
        failing since 49 days (last pass: v5.10.112-cip6, first fail: v5.10=
.125-cip10) =

 =



platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defconfi=
g             | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc2551fd64a88237355651

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-q=
emu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/x86_64/x86_64_defconfig/gcc-10/lab-collabora/smc-q=
emu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/62fc2551fd64a88237=
355653
        new failure (last pass: v5.10.131-cip13-37-ge3a52725ce96) =

 =



platform              | arch   | lab           | compiler | defconfig      =
              | regressions
----------------------+--------+---------------+----------+----------------=
--------------+------------
qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defcon..=
.6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc2834a247f03d3235564a

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.131=
-cip13-49-g1145e9c6352e6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/62fc2834a247f03d32=
35564c
        new failure (last pass: v5.10.131-cip13-37-ge3a52725ce96)

    2022-08-16T23:27:53.634557  <8>[    4.302739] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =20

