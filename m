Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DA4C001B1
	for <webhook@archiver.kernel.org>; Thu, 15 Jun 2023 10:38:10 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.14938.1686825483650390439
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 15 Jun 2023 03:38:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=5Uyhv7Ir;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b3d44e3d1cso34317725ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 15 Jun 2023 03:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686825482; x=1689417482;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tvpKTmIrGj+2BAWJ8UM4bKgFi/nfGc67dWP/IhqZSWA=;
        b=5Uyhv7IreLxqbZzdWaMR7LdRS0LdqhefiHw1Zgzccr+ws2uUWgFtfvWhMJ4VpOtoKm
         ylwH5p+ZXcUPp3fz1vY4oH8QeVvYyecnat00/AHpkHqZhSYsBUknn9Lap58pCW77GDZI
         zm1vHUpg0ei1a/z2DusrsSMcXyoC+tpFvy6hXEt0xNXp3tQDXhnFG2uo40h5maw2+Jly
         q2oNBUxxy1C+6A/XQLgkIwPpo+lCynvUwFELtJl6j6MRlt6AnVY0GZfFw///9KphaFMT
         cQK4EjfH+/LqOalUVqlHOHLpjtSt3apX1o8ikP/CaTYSW3cYbSZxNx7M/0bvy6MRsnjQ
         BcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686825482; x=1689417482;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvpKTmIrGj+2BAWJ8UM4bKgFi/nfGc67dWP/IhqZSWA=;
        b=e/hdZ9NJDjdLVa7jKkTLYKWcF8Z22pEjqW5uSSV+IF+jiziDSe9WVhl7dX07ORazfL
         WYTKyW/7zLCRddcQ536tLNYJPhPYeMcm5+fw6lj9ciEcZlo8x49llLLrvOCpUt6r2pHO
         jHJmxaf8FLKO54y5WhmWm1SIsFez9jrCjcVxix1SoDFGbuElCc4zGPhJp/ASyQPSvdON
         0CNK6nsJqVCl0o6ukKTJx5IlmFmYMF2/L5uIqpm+s7IVYwVRXFpcOy9aoo4L4lZnvVRL
         JmRl6DOUwkdIx1BxlgN8UQB5+u3QhjUyDVswQUBK2n/uoY9Fg9HphbrRo8HFoOS7imCC
         xsJA==
X-Gm-Message-State: AC+VfDzpNocAgVm+X12hyQcdTba6+XoQx4vsVoVM1RvzhsIc6KmVQaVm
	gynOwThr+c004GeseJ5dKo8/IZU7jNp+jzQ2dxcmmg==
X-Google-Smtp-Source: ACHHUZ6rNqaErsJrZC7e3N7F4YdpAaM6uZA3Qoroe/r2lD//cyOkqIsesAaJc7Ysj6VeqCvaV5MQDA==
X-Received: by 2002:a17:902:8212:b0:1b0:3df1:c293 with SMTP id x18-20020a170902821200b001b03df1c293mr13643649pln.45.1686825482603;
        Thu, 15 Jun 2023 03:38:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b001ab01598f40sm2051720plk.173.2023.06.15.03.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 03:38:00 -0700 (PDT)
Message-ID: <648aea08.170a0220.7b529.484a@mx.google.com>
Date: Thu, 15 Jun 2023 03:38:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-8-gdba81ae6f2be
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 2 runs,
 2 regressions (v5.10.182-cip35-8-gdba81ae6f2be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jun 2023 10:38:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12051

cip/linux-5.10.y-cip kselftest-seccomp: 2 runs, 2 regressions (v5.10.182-ci=
p35-8-gdba81ae6f2be)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-8-gdba81ae6f2be/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-8-gdba81ae6f2be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dba81ae6f2be7f7d87f3a29a8566758d2e0017ae =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/648adac6b400b4ca93306168

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselfte=
st-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+kselftest/gcc-10/lab-broonie/kselfte=
st-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/648adac6b400=
b4ca93306169
        failing since 5 days (last pass: v5.10.180-cip34-26-g462b2292d23e6,=
 first fail: v5.10.182-cip35) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/648adfce21e5473f4830615d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-s=
eccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-8-gdba81ae6f2be/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest-s=
eccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/648adfce21e5=
473f4830615e
        new failure (last pass: v5.10.182-cip35-1-g7cde3fba93966) =

 =20

