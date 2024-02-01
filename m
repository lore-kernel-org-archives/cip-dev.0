Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37655C48297
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 22:20:44 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.9157.1706826038873021122
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 14:20:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=N066G1o3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ddd19552e6so897747b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 14:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706826038; x=1707430838; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nuffdjLEnpHX8yIxm5pFsn44jPv5zorOQgoHzAu58GM=;
        b=N066G1o3dJSlfXy5wW09Cx4G+lsTzTb6dInsJUSSKpp4RxuLx0X+7A16INgvf1oLQj
         8/zVRV8NbajXFG80Ai8sNcarVp7DZdQy0HawUH40MHoYh7PiabJEc6Sx2To4k/hxCFVa
         MOQU9GyHGPCpkdb3duQ1PH12TVzFiroNPBzfGuSBvJcZQxZ2ohWD8AN5dF53UOQuvKBf
         hleoPZDFiZvaBDJiwIm/8fdaLN+1yxc+sVvKB0o3rjIlnu4E2dPrjJwJuTrYy6TIWJDa
         +aKoZjZgppe4qYERCVPX6zoSPXfN+tz1esBHuYTrzF2IQn6xgCgTTFySfT2+pFIBuI08
         CjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826038; x=1707430838;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nuffdjLEnpHX8yIxm5pFsn44jPv5zorOQgoHzAu58GM=;
        b=Q46qbCCG/9oOit+A+yv+LL2YYFRsvPH+qD9jmDWzzhjAtRwTqrPSLSOR5l2I1nDvc7
         HPnCPnT/hKuON9gqPWM5/J5VB1F3dss9IzuHjUjDd1/3f5csJXcAoOcY/0Vo+uYSbNu2
         l4S7kKbIRSIOlEdfDqNl4cPd99XV9pSFotATnmt8J+yWbSbBiGcCZY+xvaJafzwklEEN
         94pv8ooXEMDhHVZQKG1UsjwToJZrhVKGmMGbVrQuMhqOHGf4z8hiYieTic9oIHNBcLcY
         +Mlvt2DpUmOMXti9TIUolR3agzNCPPRMv9ftA57M/4Ex4M2/jkHv1w23FDUsAI4wuxn2
         uUIw==
X-Gm-Message-State: AOJu0YwQsPOi3gqN2xzIiwQqeYPag5+QfsXiVOKAdlfmAg2hh95sAPGf
	+JLoDIU5MB9/3/ECaR0ImUxMbT3R9Z+UoPpUi4cZTLVxyBZ8/fhHUcm4IV+M+j+bpVZIrsJu1sI
	U
X-Google-Smtp-Source: AGHT+IHVBPLWEGW57K0xzb6EQZlHIfYd+Skj+4F9WWgalAknoYjbPQz7HESYnB3dlGnd/YwAallXKw==
X-Received: by 2002:a62:e507:0:b0:6dd:8a07:6969 with SMTP id n7-20020a62e507000000b006dd8a076969mr5985932pff.5.1706826036333;
        Thu, 01 Feb 2024 14:20:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVehvH6ECRRDYEFCSiBcJOkQJPx7wMcupVhu8ZR+nBpsg5Bj5wFB1TzjSxfVwUCU/v1oCSheHGyOawToXARl8/aVBTs2/lWFzb8pNrCaUKc/j0bLo7jjpwn35Hf3Odmow3LzLNeiTInGKs+QfYR3jmbnQ==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id it25-20020a056a00459900b006dbc5569599sm251369pfb.10.2024.02.01.14.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 14:20:34 -0800 (PST)
Message-ID: <65bc1932.050a0220.b50e2.1dcb@mx.google.com>
Date: Thu, 01 Feb 2024 14:20:34 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.208-cip43-4-g1c63c70fb18b8
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 20 runs,
 7 regressions (v5.10.208-cip43-4-g1c63c70fb18b8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 22:20:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14597

cip/linux-5.10.y-cip ltp-timers: 20 runs, 7 regressions (v5.10.208-cip43-4-=
g1c63c70fb18b8)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 2          =

qemu_riscv64                 | riscv | lab-broonie | gcc-10   | defconfig  =
                | 2          =

qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig  =
                | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.208-cip43-4-g1c63c70fb18b8/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.208-cip43-4-g1c63c70fb18b8
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1c63c70fb18b87b5bcfe5d7ddf0096c92a1557ed

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65bc0a3415d52ba11300a046

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/ltp-timers-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie=
/ltp-timers-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bc0a3415d=
52ba11300a04b
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bc0a3415d=
52ba11300a04b
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
qemu_riscv64                 | riscv | lab-broonie | gcc-10   | defconfig  =
                | 2          =


  Details:     https://kernelci.org/test/plan/id/65bc0d04a79e6ab46900a08e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bc0d04a79=
e6ab46900a093
        failing since 56 days (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d=
, first fail: v5.10.201-cip41-28-ga386bc478aa6b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65bc0d04a79=
e6ab46900a093
        failing since 56 days (last pass: v5.10.201-cip41-16-g3c85fba3b6e5d=
, first fail: v5.10.201-cip41-28-ga386bc478aa6b) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
qemu_smp8_riscv64            | riscv | lab-broonie | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0f986f8a9dc78d00a039

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65bc0f986f8a9dc78d0=
0a03a
        new failure (last pass: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc08ef945d2a061b00a0a4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp=
-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65bc08ef945d2a061b0=
0a0a5
        failing since 120 days (last pass: v5.10.184-cip36, first fail: v5.=
10.194-cip39-1-g53e59f50ca3ff) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
                | 1          =


  Details:     https://kernelci.org/test/plan/id/65bc0cc84ef4e314af00a044

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.208=
-cip43-4-g1c63c70fb18b8/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1-=
hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65bc0cc84ef4e314af0=
0a045
        new failure (last pass: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =20

