Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D79BEB64DB
	for <webhook@archiver.kernel.org>; Thu, 22 Jun 2023 11:45:16 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.9107.1687434314346530123
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 22 Jun 2023 04:45:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=4foeE38t;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1b5251e5774so35372845ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 22 Jun 2023 04:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687434313; x=1690026313;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O5rz5I/KSIPppv261Ta6l9ladb73Ht+pSLBwFkMy/CA=;
        b=4foeE38tpnfdkRWZFioNL6l1Uq9Up4jUBAj+1Rsa1xZjFzIlPYhUF6578KlrkxXY2S
         CttnDoPy+4ZhmE5BMVMm03lzTXAGDU9tJj39vx7yZQarx7222jTOFbLUg3UfzmMnjLZG
         lEi59jYfUa/cZUkA4cIteAu0+0piKdKFCXhY+MwkOKoc9g3JDka5jfWNQEekTAoLtq9l
         NQ8obf8L/eDBB+T9sXf9G3UPKooTyiux3aytGvYvawL7Is8FdOOfV5JOuIcLB8YII9df
         7O/W2mD4U0kLFbvLO/6mEpl98sQHLDnaB08C1Ej9lFxS0a+GTqCdE4KKn/XBIeGFp5Ng
         5Y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687434313; x=1690026313;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5rz5I/KSIPppv261Ta6l9ladb73Ht+pSLBwFkMy/CA=;
        b=QRtfOLZW9EfLxcGXTKGoO17diAt2sqF8WILKe2gSbBa8I/zqUGZSx22N7WUsN/9trl
         JkLxvIfQwdB6IswXPX480OkMK8ezcbn60kJ/r47OxoVzc59v36DFlCseN1quDEr4tczs
         uC1J0ymAikbYFnlqXdHC7jkNPFcs+PTU3vHW3SQ5Lwxw696FT/1Vi9kN9SUbYhHZ3Hjv
         GtJhj8MOsjAh66m3Qs5dQ/qScLjl/9ldEDUd9xEUwkqUecHugUd+sGoN4kKvN2u6IuNc
         hv5tKnbeV5JL2YKG4ZYPXSfoqctvT0IqbbzkAwS0PIjTDNH+LYK5YgDqTIzF5r8jIqH+
         zbLQ==
X-Gm-Message-State: AC+VfDwzDglWHkHuDQulm1PIAbMC0hu3wbnEikgBtajrMsO52Uiy9ds+
	htoCyy+388qkkuqD9ZZxseeezT8FVItobKWh/OoltA==
X-Google-Smtp-Source: ACHHUZ77MhKdq2Tpr2Z0nsYItzB9sZ87UtVri8jitt4yyFSwQphKQTkFiO/tPkqj9vBeR9keh4K24w==
X-Received: by 2002:a17:903:124f:b0:1ac:3605:97ec with SMTP id u15-20020a170903124f00b001ac360597ecmr8738032plh.62.1687434313366;
        Thu, 22 Jun 2023 04:45:13 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001b53be3d942sm5179334plh.232.2023.06.22.04.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:45:12 -0700 (PDT)
Message-ID: <64943448.170a0220.37a98.bc07@mx.google.com>
Date: Thu, 22 Jun 2023 04:45:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.184-cip36-rt14
Subject: cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 12 runs,
 2 regressions (v5.10.184-cip36-rt14)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jun 2023 11:45:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12124

cip/linux-5.10.y-cip-rt ltp-fcntl-locktests: 12 runs, 2 regressions (v5.10.=
184-cip36-rt14)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =

qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.184-cip36-rt14/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.184-cip36-rt14
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1b650b4c826dc15118c34e6c891e42858f3367e0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64942962f97d36f68330613b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-fcntl-lock=
tests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-fcntl-lock=
tests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/64942962f9=
7d36f68330613c
        failing since 33 days (last pass: v5.10.175-cip29-rt12, first fail:=
 v5.10.179-cip32-rt13) =

 =



platform                     | arch  | lab           | compiler | defconfig=
            | regressions
-----------------------------+-------+---------------+----------+----------=
------------+------------
qemu_smp8_riscv64            | riscv | lab-collabora | gcc-10   | defconfig=
+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/649421e7b09af8bd78306145

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-fcntl-lo=
cktests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
184-cip36-rt14/riscv/defconfig+preempt_rt/gcc-10/lab-collabora/ltp-fcntl-lo=
cktests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30609.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/649421e7b0=
9af8bd78306146
        new failure (last pass: v5.10.179-cip32-rt13) =

 =20

