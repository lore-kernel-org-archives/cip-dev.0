Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA05EC77B73
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 02:00:56 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web11.11344.1684807255699108445
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 19:00:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=IUOHfoO8;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ae85b71141so35880825ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 19:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684807254; x=1687399254;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rRYWUDDKqzMuDAkxVkrPILhpV2Lyzvkxau9rRJWOXKM=;
        b=IUOHfoO8/wQanUZP5ww82hIdMVujMK47P9x9K0QhS1wDSueWZkdVn5kELgkTtd5n4c
         PExUuJCQEiFi99u7AGH9/oJVVGWIb0L/mRqz5Mxwk8PZtqFla039md6jMPsXTaL4JYhM
         W9pcz4dTpfvJiwZ8KuJGux50KX6lig2FZMTV1YsrKuwnjCoDUljoBAFIpFQcyV4b0IIf
         +pTWyoLmbEjuRrOBtHyzwMf5kWEeiClPpdFKSb2Ilz/VNmPjALvAVUYweyoyJoF46FaY
         C+Z1V0YOr9jgFd16mVpcLO+xiwx+0Ze3qOF6D0hKlJ9RVkNR1UtZo5g/3gquWRvOp8X6
         3xRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684807254; x=1687399254;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRYWUDDKqzMuDAkxVkrPILhpV2Lyzvkxau9rRJWOXKM=;
        b=A5nur74pCq7K1VM0PzV9+DMpHGAw1zN5PyedjP7MuqQuqYX3SNgGqD4HiuupPpDWMF
         /Idtaf9qwycVRamK09ERoERK49SW6S/fr8dvHhgepRA5OKF/pX4dufCWUA0xU2sYHX6/
         n9V1q5SnN3FWQE9XqzTkk1iqPfBU8M9y4tXY5UWh4LiNXNbN4KBCf/3cBCAQSa+skfLQ
         VZBFr/Rob6ufdNlbNZOJGPSvfEhJMK/SwOmgSXiXnXsVK/vQYrdu5V68mn2NInSlxJ0z
         emzALcUWNgXpDekFo4QH5oNDskMMpcjXt9kVDO0Mhy0flvu2U/quvMsdAF87cWAS+vPe
         aaxw==
X-Gm-Message-State: AC+VfDypMuBqkvKWjHyveW7sNVSU461TBVE98ZHyv/48qBQRCNN8lS6y
	VZS68Q1pJg7DpMBk1ovfcmcKaxlo4hxA9r9EGnDJeA==
X-Google-Smtp-Source: ACHHUZ5PVYripiRowzuJcGWZf3uw3Ls/lwEbaWK1kks7MekaZM30FeJYHgBaGVlANe81ryKPof8uDA==
X-Received: by 2002:a17:902:ed42:b0:1ae:2b94:7016 with SMTP id y2-20020a170902ed4200b001ae2b947016mr14323331plb.55.1684807254391;
        Mon, 22 May 2023 19:00:54 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902694c00b001aaeaa27dd5sm3156676plt.252.2023.05.22.19.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:00:53 -0700 (PDT)
Message-ID: <646c1e55.170a0220.25585.5c06@mx.google.com>
Date: Mon, 22 May 2023 19:00:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.180-cip33-11-gfea7994097935
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-pty: 8 runs,
 3 regressions (v5.10.180-cip33-11-gfea7994097935)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 02:00:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11603

cip/linux-5.10.y-cip ltp-pty: 8 runs, 3 regressions (v5.10.180-cip33-11-gfe=
a7994097935)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip33-11-gfea7994097935/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip33-11-gfea7994097935
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fea799409793527f9b9b2d2c53f0dc4e3ac7ac6a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c17bc47a061a69c2e85f4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/646c17bc47a061a69c2e85=
f5
        new failure (last pass: v5.10.180-cip33) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c19df5329b157f62e85f9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/646c19df5329b157f62e85=
fa
        failing since 3 days (last pass: v5.10.179-cip32-4-gd8c029e4780f, f=
irst fail: v5.10.180-cip33) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
                 | 1          =


  Details:     https://kernelci.org/test/plan/id/646c12ce6302d9c7832e864a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/riscv/defconfig/gcc-10/lab-collabora/ltp-pty-qemu_=
smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip33-11-gfea7994097935/riscv/defconfig/gcc-10/lab-collabora/ltp-pty-qemu_=
smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30512.0/riscv64/rootfs.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/646c12ce6302d9c7832e86=
4b
        new failure (last pass: v5.10.180-cip33) =

 =20

