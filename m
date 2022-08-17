Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70D6C25B0E
	for <webhook@archiver.kernel.org>; Wed, 17 Aug 2022 01:13:01 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web08.23720.1660698772127072065
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 18:12:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=3eYiBQ8Z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id m2so10738804pls.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 16 Aug 2022 18:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=LRrxK7PR4KWhbWclx3P8bDDbJcPR0FQNYqeQX6xciXc=;
        b=3eYiBQ8Zp0QTADxPli+5dTO/8PK5KJLgvA41QYeQxqP5EiEzS6a4s+UskzPBF3LDEr
         EavBNEDm8Sis6OA7OmdyH9iEpODu1F3k9KWNEheuBsVB4slwfeJHZkhFG0TuTtBc0/ca
         s7pM8TuAacEqSnqcsu7C/z+fcZdpixluRrmpwX3RV76/LFPycq9p9Hgn3mtVBfLKJM5s
         u6hTzM1jZdRokH+0VakmyQ+KNzAk1JAJC9Z1u9H4uSXn/r0rFaJKEMiwjyAJ/5bH8/p8
         e7JtqQ4cdb2bvfS/egEPBny+MNJPJfXTPyk2MZqX/jr9BZq4Wg8OOjNYzHSDGcnFklX2
         aeOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=LRrxK7PR4KWhbWclx3P8bDDbJcPR0FQNYqeQX6xciXc=;
        b=sYBbYKgbrpIImAUd4QzLPgcHaJDOCF1NVb+PparTr9JlYpbwQmkKhUSckOKCPZ/eCo
         sspL7FDWm8RbFU3lRFl0Kybm+poFg379IYNhyVB3RP12JKL++23+s1Q6GCdwLy/LMYB4
         GB6dsqJcfb/QCq1ruhc1aSCsVlsuLoed2rS4fHFYPeb+5xgU0PR4rsRHI+OLktzsuPzx
         M5MVq+YXt1dYJkm5/jbf5qKToGMy3htobREkYZ8N0tvD4iN4OjmtENB/Lnu/+FPNE8Yf
         cias95vB8y3PctvSrBKpkoBZQBIlJUge9yd857Co57EzoWzeNFcXwfIBc3BeXXdB5hK+
         ruNQ==
X-Gm-Message-State: ACgBeo3VXherbLt40pREIrqj0Sdspt2kXQY0xeJpzr2a7qSELuyQfEwy
	YKI6g/JesM4n/7zE2ei/lH/gVdBSWFyWeFsM
X-Google-Smtp-Source: 
 AA6agR5zWh/09zkbn8rDxmjBJ6kZmrIAmSD0jmfWs/ndWeAbwkMmAxy8xef8qdv1140qsAPb0epYng==
X-Received: by 2002:a17:90a:f8d3:b0:1fa:b220:1973 with SMTP id
 l19-20020a17090af8d300b001fab2201973mr1245304pjd.109.1660698771315;
        Tue, 16 Aug 2022 18:12:51 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 h8-20020a17090a2ec800b001f2fa09786asm186079pjs.19.2022.08.16.18.12.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 18:12:50 -0700 (PDT)
Message-ID: <62fc4092.170a0220.3fb94.0750@mx.google.com>
Date: Tue, 16 Aug 2022 18:12:50 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-84-g5fcbe4a63ab4d
Subject: cip-gitlab/ci/pavel/linux-test smc: 9 runs,
 4 regressions (v5.10.131-cip13-84-g5fcbe4a63ab4d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Aug 2022 01:13:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9269

cip-gitlab/ci/pavel/linux-test smc: 9 runs, 4 regressions (v5.10.131-cip13-=
84-g5fcbe4a63ab4d)

Regressions Summary
-------------------

platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig+arm64=
-chromebook | 1          =

qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig      =
            | 1          =

qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook | 1          =

qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defconfi=
g           | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13-84-g5fcbe4a63ab4d/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13-84-g5fcbe4a63ab4d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      5fcbe4a63ab4d3a1c958bd377c1c3c31e82f8909 =



Test Regressions
---------------- =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc2ddadd8030bd3435565d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62fc2ddadd8030bd3435565e
        failing since 98 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-broonie   | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc346b8a5c1973b535566d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm64/defconfig/gcc-10/lab-broonie/smc-q=
emu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62fc346b8a5c1973b535566e
        failing since 98 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
qemu_arm64-virt-gicv3 | arm64  | lab-collabora | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc2ea8cb40bbef373556bd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62fc2ea8cb40bbef373556be
        failing since 98 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a) =

 =



platform              | arch   | lab           | compiler | defconfig      =
            | regressions
----------------------+--------+---------------+----------+----------------=
------------+------------
qemu_x86_64           | x86_64 | lab-collabora | gcc-10   | x86_64_defconfi=
g           | 1          =


  Details:     https://kernelci.org/test/plan/id/62fc2f452eaefe7fc7355642

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13-84-g5fcbe4a63ab4d/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220805.0/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/62fc2f452eaefe7fc7=
355644
        new failure (last pass: v5.10.131-cip13-49-g1145e9c6352e6)

    2022-08-16T23:57:28.894982  <8>[    2.380278] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>   =

 =20

