Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7416C77B76
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:23:10 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web10.6710.1681471386416282602
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 04:23:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=C8WOwuTt;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id f2so9497973pjs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 04:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681471385; x=1684063385;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qndmHJs3ZjA75FJrRS/e/ELUs1Sylda8UcOybDL4YYg=;
        b=C8WOwuTt0+aGa0lua4wNNQSZH+xNMv9AJzSSv2EarPmD3IVPk3BtfaWcmkKKY3ARWW
         xyDXmeEITh20qr+ZLwsLIcrL6nxoMy5p23br/NLpW5leLsetrMeYReW84YqQ8eFJZXuF
         StfwURXkOkDgoExiHVMoeSZEzeig1yTgSDue60dvcfd7fwJjIKkbUms6QA8isSoQQcJL
         nOKAsJ3bO2cWkZUpeE/zUIP9Qk1Skm+AxOqBL5MtGVt+Mi0CNgJ/h62GaYkRFsu/JYfp
         OinCOHaV7ZI4skGlwTfWfk+LrXCSTioQ+lJzqSupFQSG8XWDcgcfZitqFLcx007EsJKx
         RCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471385; x=1684063385;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qndmHJs3ZjA75FJrRS/e/ELUs1Sylda8UcOybDL4YYg=;
        b=MHsziB9L+oLf7dt/4pqrHv3FcVa9qL+NVXo7IpXImgBHkZgk1XDDcsx5anRacymKO0
         hSdvBXotTw7wOa40RtUWXocPMx7vMagj/d1ANIHfzHItCTAva1fivBaJp2b14R6zZqvx
         USXKs6DOsCmJ7MWG6B9zXGD99Ou/tgW2G+jehGaH9XIEFNMdlgpdGSsg6D/8FChwyVCk
         R17Hw14rDlgo6F8nuFvg3k2iGd+K0BkwZ/BS3KEhEaHsSurroOAF61od9T/sgGG4Fci3
         IAtmNBszsUdDSFy8+1zw0vkQs4wgKaENQEAm0wwV/95id1n9q5i6rWFMrng0qbDkKD2Y
         9+Dw==
X-Gm-Message-State: AAQBX9d12IkLNav4nY3vp1YxgRYKBQLnEUHvUPvzvbSFw/BTrm+hgeur
	EvGzxtx1CzD4Bz7VJWO8J5jKbwE+vP03OPFtBCpwddAV
X-Google-Smtp-Source: AKy350ZeT333bkiqplYV881JNSC1PfMdQEh5VhQG8F85h7S8h8RFEIBazFab5hj0PfkxiGBwLu7l7A==
X-Received: by 2002:a17:90a:4144:b0:240:973d:b436 with SMTP id m4-20020a17090a414400b00240973db436mr4686247pjg.49.1681471385722;
        Fri, 14 Apr 2023 04:23:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090b069500b0023a9564763bsm4542853pjz.29.2023.04.14.04.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:23:05 -0700 (PDT)
Message-ID: <64393799.170a0220.91ccc.a3dc@mx.google.com>
Date: Fri, 14 Apr 2023 04:23:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.177-cip31
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-ipc: 17 runs, 2 regressions (v5.10.177-cip31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:23:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11214

cip/linux-5.10.y-cip ltp-ipc: 17 runs, 2 regressions (v5.10.177-cip31)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

qemu_riscv64                 | riscv | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.177-cip31/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.177-cip31
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      deb75c99ed78d677587a345854b8a00fb2cac68c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cb9b37a6a47ea5f9e442b4473c6eb06877bd18ac =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64392f2cceae2ebc422e8622

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ltp-ipc-meson-gx=
l-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/ltp-ipc-meson-gx=
l-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230407.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/64392f2cceae2ebc422e86=
23
        failing since 20 days (last pass: v5.10.173-cip28, first fail: v5.1=
0.176-cip30) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
qemu_riscv64                 | riscv | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/643932874d571b92502e85f0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/riscv/defconfig/gcc-10/lab-broonie/ltp-ipc-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30407.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/643932874d571b92502e85=
f1
        new failure (last pass: v5.10.176-cip30) =

 =20

