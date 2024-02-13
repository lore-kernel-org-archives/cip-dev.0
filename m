Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5953C48BEB
	for <webhook@archiver.kernel.org>; Tue, 13 Feb 2024 19:06:26 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web10.21900.1707851178196635742
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 13 Feb 2024 11:06:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lB0RC+IE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e1040455b5so359238b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 13 Feb 2024 11:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707851177; x=1708455977; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PEAs1XXgwSRFPOnx3R/cpiAk4ysaKF8lyS7Ldql8xDM=;
        b=lB0RC+IE7Q7FcIy8eAHouJbKiyLLJtCIwADKfaKDbHMW6Xoa+AYRuWXMFwHwpktCp6
         jQlOWLMK4dTTiPhy3Y8R0Tx+6KOCEs98oMi3Aaoz9fImrMwtZkiV84G09r6Wzjut/Bla
         va1wKlcTNKhdIG3BlzMMoxBF6/Nqz0Ecik5vDAizuD7XaK6mp6IvwmbggklT8FHGijzV
         IF8IFVsBTlcr6Ktp0wuJbDx0QavSuVc+BcNo/eny/csCIUcN0l0LnnknszEMRiu/T17k
         XfyyFwR0hmGD3lEgOb7FEo524ZpS22oyLx1/K01xsYrrVXW93TJG+OCwW16XeMsRRC4V
         tFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851177; x=1708455977;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEAs1XXgwSRFPOnx3R/cpiAk4ysaKF8lyS7Ldql8xDM=;
        b=JzkeCB9RoB0N/bGpQ7U0/3oxbr1rBI4STr/lTltNe+JXanFTxk4HRZUyjaNhEvyVK1
         63zAFyCDc0iyVdK4QccyJvCRYi6r6fQV4HjtC9QBCqpMTD0zMjeWHoZqaLFeTa1QNy8h
         zOsyPgiRvXNuYPq6Tfi3FNPGdOqtcKOUHt0yMkT5HCYUBllvuxYtDKDcdCjINLtcIEpl
         T98/Z56A/iWH7DGebpMhPRoa2sEIQD6T/y3J9S7sRGXcFK5ZUcR3VuRAGTfJRmSrJM8Q
         xChX39ygv+EqhnPPcFKT87/WwV40kqgQ1BBB0rBSElieWEjxFo0Pk/r8S0SDxotPplqY
         Ek/Q==
X-Gm-Message-State: AOJu0YxVOw7vpFficlf4P9YisNZb1KYogDr51RoaMGyX7CGXXXnRu+bE
	EB4xFBO3f8KsDle59ORuM5eqq5KMKfDzPoQNGgDKAGhrHcj1O7VXAQmJbKeWqHzzs0JbBex+W0n
	ugDQ=
X-Google-Smtp-Source: AGHT+IG2qT577hXhViAsRPW0R7vxDoYqrhk3kWeDf1cVxG1PdsX+hEwDtek7A97N8Ucaq0Yg2pZhmg==
X-Received: by 2002:a05:6a21:2d87:b0:19c:678d:c1c with SMTP id ty7-20020a056a212d8700b0019c678d0c1cmr601703pzb.37.1707851177186;
        Tue, 13 Feb 2024 11:06:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUaNglkunZBuhOcDe+kjrQ4JTdJk7UoNihknp1Dxic3Cgbmmmq/nL9LUVrXiTdVSvI0m7ez3ORM4Ies6l2SJYbduASRKJcPZBNeX5UJ+ahv2q5jqJhPaffmLs6QRb5XiX/DqMWDqEUljkjX0i/U2Nufw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id bx41-20020a056a02052900b005d67862799asm2411895pgb.44.2024.02.13.11.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 11:06:14 -0800 (PST)
Message-ID: <65cbbda6.050a0220.c3075.7ff3@mx.google.com>
Date: Tue, 13 Feb 2024 11:06:14 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-51-gdb99ac443b0da
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-fcntl-locktests: 11 runs,
 3 regressions (v5.10.209-cip44-51-gdb99ac443b0da)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Feb 2024 19:06:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14951

cip/linux-5.10.y-cip ltp-fcntl-locktests: 11 runs, 3 regressions (v5.10.209=
-cip44-51-gdb99ac443b0da)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig      =
            | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-51-gdb99ac443b0da/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-51-gdb99ac443b0da
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      db99ac443b0da75f00a4fc49e0040ac5dfa47e72

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
qemu_smp8_riscv64        | riscv | lab-broonie | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbac93e201a74d57637017

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/riscv/defconfig/gcc-10/lab-broonie/ltp-fcntl-lockt=
ests-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/riscv/defconfig/gcc-10/lab-broonie/ltp-fcntl-lockt=
ests-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65cbac93e2=
01a74d57637018
        new failure (last pass: v5.10.209-cip44-50-ga624abaa85d7) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbafe815399bd903637018

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/lt=
p-fcntl-locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65cbafe815=
399bd903637019
        failing since 132 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig      =
            | 1          =


  Details:     https://kernelci.org/test/plan/id/65cbb13d50c8c2ae56637029

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-51-gdb99ac443b0da/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-locktests=
-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65cbb13d50=
c8c2ae5663702a
        failing since 243 days (last pass: v5.10.182-cip35-1-g7cde3fba93966=
, first fail: v5.10.182-cip35-8-gdba81ae6f2be) =

 =20

