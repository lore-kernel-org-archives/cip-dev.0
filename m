Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA463C00144
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 23:05:08 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web08.725.1659135899555170025
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 29 Jul 2022 16:04:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=SNXndPzy;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id g12so5829805pfb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 29 Jul 2022 16:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=o4fpsV/ZD7ublF9rOtETuE3CqWaY6yYhyWGxSfTYcuw=;
        b=SNXndPzyTVCu/Uf0J7ZdVOCBAiSCPLqKZvsh2VnhdWMDB2kEFq4So4OlyWFvHxJJfA
         nZ5/2ZamIbkJsE3sgdQZ94wcP1QeAIVdPF1O04/jIuDlB5L6FaO85qPQRXHJ10Kmz5W7
         hsIfR9vVH4gSRahD6HOJqh3CgAGLII61VRYqEbUmcs01akpcs2Xno86ULf3FkEyinBt5
         Au7CRxzd1jt5d7xTAP+mVBIwC901J1b06tXFuN0KJkfl3BgjwP5DqRxVZFW53Q4s/8OZ
         f7UrDzzAMySg0KajYiGnriKQYb+KV8+DdmGWoiDXuBTkfqDI2skZEmGirpyclQZEIpK4
         Dhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=o4fpsV/ZD7ublF9rOtETuE3CqWaY6yYhyWGxSfTYcuw=;
        b=R9c9vjzm3pKFqs6JH1yZFwSXX5WIHAuKYuz7va7J9RzPn6pUvMNNXuN8ekWWIxEj9z
         BTWbREryFm6h2F6yfPlNecmbp3rVji3KHlF+o8mU0bQBQrld97amJiFKxa5fIQ0zZUsb
         nT7JNqsj2kkCrNk2pSip/RFZNnzrimdlClbbaDq3uwbfo5SanA5qQU7nonM7wQ/0rT/4
         A1Y4D7MRT8HhiMkl5XqHoBkvARUoq0NpboTl8iNHJvR+i7cc6ua1XgS4W4RIa78zmmit
         qYBCoAaUTEUs9fv1FZJI4X8+N8pMDPf6ohJNgT1VAH+TuHu/t0yfn7N84VbKZOsd6axQ
         3SFQ==
X-Gm-Message-State: AJIora/muAWlG9Vyac3lPWcbSbkXMDfSLhml5GGuorQgExI8gmesNGVK
	18aD9vaQQcNwZn8NXgYjgRv+8MEl3ZatZhmif8w=
X-Google-Smtp-Source: 
 AGRyM1sfdVqmcFfSs26YuGUfTR5jDK8hN55z6OrvwTxvlgLcTpp2s6ZJuSTvxyJZpNJpYcNbw3aGfg==
X-Received: by 2002:a63:1923:0:b0:419:b27c:7acf with SMTP id
 z35-20020a631923000000b00419b27c7acfmr4556807pgl.449.1659135898707;
        Fri, 29 Jul 2022 16:04:58 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 p17-20020a170902e75100b00161ccdc172dsm4155637plf.300.2022.07.29.16.04.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 16:04:57 -0700 (PDT)
Message-ID: <62e46799.170a0220.15c1c.6f47@mx.google.com>
Date: Fri, 29 Jul 2022 16:04:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.252-cip78-113-gb7034e0f773f8
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 5 runs,
 2 regressions (v4.19.252-cip78-113-gb7034e0f773f8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 23:05:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8989

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 5 runs, 2 regressions (v4.1=
9.252-cip78-113-gb7034e0f773f8)

Regressions Summary
-------------------

platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.252-cip78-113-gb7034e0f773f8/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.252-cip78-113-gb7034e0f773f8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b7034e0f773f811f76bd4c5795f4eafe7e1dede9 =



Test Regressions
---------------- =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig         =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/62e453504e51464ebadaf08b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-113-gb7034e0f773f8/arm64/defconfig/gcc-10/lab-=
broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-113-gb7034e0f773f8/arm64/defconfig/gcc-10/lab-=
broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e453504e51464ebadaf08c
        failing since 53 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =



platform              | arch  | lab         | compiler | defconfig         =
         | regressions
----------------------+-------+-------------+----------+-------------------=
---------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie | gcc-10   | defconfig+arm64-ch=
romebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62e454b8ed5011c8efdaf073

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-113-gb7034e0f773f8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.252-cip78-113-gb7034e0f773f8/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/62e454b8ed5011c8efdaf074
        failing since 53 days (last pass: v4.19.239-cip72-68-g407458469172,=
 first fail: v4.19.245-cip74-32-g2d021d7a9e637) =

 =20

