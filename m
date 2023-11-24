Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D17CBC636D0
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 03:00:23 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web11.128556.1700794814390622866
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 19:00:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=m+zWbuED;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so997017a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 19:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700794813; x=1701399613; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IP9rGaGVPDdJx/8OjR1nP9NMpswfKmRkLZVy89d4O9Y=;
        b=m+zWbuEDLLh4A/nk5XZ9iJzcFbWYMpZ3Mb44rnHBrlhqyXQyr5PqphLxwtwUKQzyUT
         ywaTB1Jp+CvgAS/5kpAr4euuEq0ZUniy8ob5H7YXmSeYG2B98oeKkGlxu+HpAfWJpirZ
         bL4+fGJeXBUU53l7YgVgXgGE05fyIALQYYZFvOnqR1WW3516SPbjdjnt+4zZ7tjlXEun
         jLtTqVm4IXOlXJkO6LhTI8NYkNSu6aF/bWUd0UOU8I8qM7Bg5JnVV+tlPy6BsC0NWcNQ
         4X0FVYOiJtvXgen06DgHr3wIzob80oKBEjtX9o+9OXyFIdsXcrphe7TOdsWrIhv4EDoM
         RGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700794813; x=1701399613;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IP9rGaGVPDdJx/8OjR1nP9NMpswfKmRkLZVy89d4O9Y=;
        b=Hmo96TMZyvHFE1infKyjAmfRRVDB47YAiygJhbnmkDgDNyEDdOYTIHoN4n1HKdPVM/
         2bky2vU50mueCNeDGxV25lVtpeU6vLdKXxSDGcG5aYeXnBlcMESnhjEcUA5a5poPS1ri
         6my8km5AGi/Z/dz0Wz1BuC3R3mzkexbBYqzIPFNQ1EG/t+cZK542uMubCy2D+uDmmCCd
         gO7AjmCovQvPRHQvP5N5g9f8BqSxeXwdPyUyVFICSgyecHD0CetndqnqRsLsR7T9UZ1l
         YBkgsJCqHVe4yfvdSaL+T4cj83xStESp62W49bz3jB51S9gxoVcoodXsgIAbIQaJkuqu
         +aBA==
X-Gm-Message-State: AOJu0YwK5bXKTQppxZfJxe8+dzK2fdyR+mQVpWLBDUmuBoJpAj9eZxts
	S2+uS8/h64m9H5HcLB+wsNnrGxh2SV5wBktg2mg=
X-Google-Smtp-Source: AGHT+IHCtT/Ovok79jUqhWKsXFu4+DWNcRKuFJyoixkxEToV7VYtR0YLqWsyLjEHsNx/T4QotWkz3g==
X-Received: by 2002:a17:902:db0d:b0:1cc:6101:2086 with SMTP id m13-20020a170902db0d00b001cc61012086mr1511786plx.11.1700794813258;
        Thu, 23 Nov 2023 19:00:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m4-20020a170902db0400b001cc2c6cc39asm2059538plx.243.2023.11.23.19.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 19:00:11 -0800 (PST)
Message-ID: <656011bb.170a0220.671dc.5455@mx.google.com>
Date: Thu, 23 Nov 2023 19:00:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-rt17
Subject: cip/linux-5.10.y-cip-rt ltp-pty: 14 runs,
 3 regressions (v5.10.201-cip41-rt17)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 03:00:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13707

cip/linux-5.10.y-cip-rt ltp-pty: 14 runs, 3 regressions (v5.10.201-cip41-rt=
17)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+p=
reempt_rt | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+p=
reempt_rt | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.201-cip41-rt17/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.201-cip41-rt17
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78ed1354cecc021db9a1d8a8b4755fdfcd826e33

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+p=
reempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65600948ffa35bb4bf7e4aa1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-pty-meson-=
gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-broonie/ltp-pty-meson-=
gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65600948ffa35bb4bf7e4a=
a2
        new failure (last pass: v5.10.194-cip39-rt16) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+p=
reempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/65600310d32663d83a7e4b0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+preempt_rt
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-pty-r8a774a1-h=
ihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig+preempt_rt/gcc-10/lab-cip/ltp-pty-r8a774a1-h=
ihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65600310d32663d83a7e4b=
0c
        new failure (last pass: v5.10.184-cip36-rt14) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
          | regressions
-----------------------------+-------+-------------+----------+------------=
----------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig  =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6560050009cfdafe247e4a6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m=
-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
201-cip41-rt17/arm64/defconfig/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m=
-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6560050009cfdafe247e4a=
6f
        new failure (last pass: v5.10.179-cip32-rt13) =

 =20

