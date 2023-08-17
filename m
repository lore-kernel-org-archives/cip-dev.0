Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8754EC41513
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 02:47:56 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web11.178625.1692240469514118700
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Aug 2023 19:47:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=hQ+E7Z6v;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.46, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6bd0425ad4fso5937649a34.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Aug 2023 19:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692240468; x=1692845268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P7/UMU72EyBW9SJ1bcz6yNzC0xGGzMckrysdzbonlmk=;
        b=hQ+E7Z6vNPHVygFicD6D+/FTOy808iAAOx9age+5HAu2yTOYeb1FwJ4ukxPsEXyzxY
         /GurrMW3aVgNiZUEX4+/lj/IdP2AAh3577H/Sbx6wcCcOmPFAU8m6ypMk1T1jxwoTXye
         yTlqGIsI/sKZBjTBc+hlq1extuMKwSmP6xJ6CqIzXP62NciJ1WCS8sbZLQyDOg0prMFN
         BqHoqqBzQ3mrNw3LJuaV89184vVxNDwrsB3h2js5nBidN0aH7K+6ozU0lmwAfPn6CEdU
         O+mwMsFyd/iZZsgyZ6XLqQWZ1S++VzsalP+iBEiHEtqeqwDBQCSU5n2xNyJzWQSTEeZ0
         DyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692240468; x=1692845268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7/UMU72EyBW9SJ1bcz6yNzC0xGGzMckrysdzbonlmk=;
        b=DI6IpKIJDN4qbYqYp8tWuE3e1XvvSy2OqdhGDsJrTddvceO79hns29W4OiMjaFqHa5
         3vfzJPmLUf3Q9UBdh88DBdMl6xnfq7ib44ydPAW7rjgTc7bPkLOQHf0A/9U29elbDGa5
         vIbjRSlSzFbUskhgoA5RPZH3JZjgBkeUV493g9jeWKXyYcvimXZikTIEvH2asTZrt9df
         6n09L3xpKH9vmGSNATp7Glx/b2y+9pMB/Ps1qQAh/cfhTbES1KSJcxqi4A9yvo+cv3Wc
         KzhP72SAFc4A566uPNOAl/7Gj15Ah7TU8ejHauRdYnEfa+4JQn6tgoo0SsRGgRAHUggb
         YZvQ==
X-Gm-Message-State: AOJu0Yx5ngxgKqKOvd0NSvkGLKw4lXMMDadbcqq9Dli9lX5NsOMpcbC3
	CRYwb06lW10wnvJJmntXFPCco+sG2qjwcapuMc19Uw==
X-Google-Smtp-Source: AGHT+IGv8w6h2E5oC9jwKn5UQP5wikzOeUbdi53zTBjw8pBmVlSn2UQNYc3TETFuzciOPY4LVSvqNA==
X-Received: by 2002:a9d:66cb:0:b0:6b9:9cfa:ffad with SMTP id t11-20020a9d66cb000000b006b99cfaffadmr3601007otm.28.1692240468268;
        Wed, 16 Aug 2023 19:47:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a191700b0026b41363887sm474430pjg.27.2023.08.16.19.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 19:47:47 -0700 (PDT)
Message-ID: <64dd8a53.170a0220.7d3ca.13ba@mx.google.com>
Date: Wed, 16 Aug 2023 19:47:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip78-rt45
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip-rt
Subject: cip/linux-4.4.y-cip-rt baseline: 143 runs,
 7 regressions (v4.4.302-cip78-rt45)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Aug 2023 02:47:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12746

cip/linux-4.4.y-cip-rt baseline: 143 runs, 7 regressions (v4.4.302-cip78-rt=
45)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
imx6q-sabrelite       | arm   | lab-collabora | gcc-10   | multi_v7_defc...=
g+preempt_rt | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =

qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =

qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =

rk3288-veyron-jaq     | arm   | lab-collabora | gcc-10   | multi_v7_defconf=
ig           | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.302-cip78-rt45/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.302-cip78-rt45
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3cf7ed0b67379f8a7553970ac5ae1fc052d22719 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
imx6q-sabrelite       | arm   | lab-collabora | gcc-10   | multi_v7_defc...=
g+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd7c97b8093ec43635b1dc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+preempt_rt
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm/multi_v7_defconfig+preempt_rt/gcc-10/lab-collabora/baselin=
e-imx6q-sabrelite.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd7c97b8093ec43635b=
1dd
        new failure (last pass: v4.4.302-cip76-rt44) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd7d2a76a07a381935b1fb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd7d2a76a07a381935b=
1fc
        failing since 258 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv2 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd7cbb24fcdec3cd35b1e2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd7cbb24fcdec3cd35b=
1e3
        failing since 258 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-broonie   | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd7e1a2ac41c54b935b1dd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm64/defconfig/gcc-10/lab-broonie/baseline-qemu_arm64-virt-gi=
cv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd7e1a2ac41c54b935b=
1de
        failing since 258 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
qemu_arm64-virt-gicv3 | arm64 | lab-collabora | gcc-10   | defconfig       =
             | 1          =


  Details:     https://kernelci.org/test/plan/id/64dd7cbbc4d470af4535b1e2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm64/defconfig/gcc-10/lab-collabora/baseline-qemu_arm64-virt-=
gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64dd7cbbc4d470af4535b=
1e3
        failing since 258 days (last pass: v4.4.296-cip67-rt37, first fail:=
 v4.4.302-cip71-rt41) =

 =



platform              | arch  | lab           | compiler | defconfig       =
             | regressions
----------------------+-------+---------------+----------+-----------------=
-------------+------------
rk3288-veyron-jaq     | arm   | lab-collabora | gcc-10   | multi_v7_defconf=
ig           | 2          =


  Details:     https://kernelci.org/test/plan/id/64dd7f3906146c54ee35b1ea

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-ve=
yron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.30=
2-cip78-rt45/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline-rk3288-ve=
yron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64dd7f3906146c54ee35b213
        failing since 190 days (last pass: v4.4.302-cip71-rt41, first fail:=
 v4.4.302-cip72-rt42)

    2023-08-17T02:01:33.652095  [   24.633615] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-driver-audio-present RESULT=3Dfail>

    2023-08-17T02:01:33.666104  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-08-17T02:01:33.666166  =

   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64dd7f3906146c54ee35b214
        failing since 190 days (last pass: v4.4.302-cip71-rt41, first fail:=
 v4.4.302-cip72-rt42)

    2023-08-17T02:01:33.570931  [   24.553458] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-08-17T02:01:33.612178  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-08-17T02:01:33.612338  =


    2023-08-17T02:01:33.616247  Usage: seq [-w] [-s SEP] [FIRST [INC]] LAST

    2023-08-17T02:01:33.616477  =


    2023-08-17T02:01:33.621018  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-08-17T02:01:33.623348  FIRST, INC default to 1.

    2023-08-17T02:01:33.623405  =


    2023-08-17T02:01:33.626574  	-w	Pad to last with leading zeros

    2023-08-17T02:01:33.628851  	-s SEP	String separator
 =

    ... (1 line(s) more)  =

 =20

