Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514C4C61DB3
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 20:34:52 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web10.35333.1700685285452558843
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Nov 2023 12:34:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=OYZlv1u0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.181, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b843fea0dfso144068b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Nov 2023 12:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700685284; x=1701290084; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fr0rfms7tXicjm/v6zPXZ20qPmu3fmuNiMNhVPcFt+Y=;
        b=OYZlv1u0HPu7reu2oL4nnNB5XAN3obeJKJH4+Qi6WPDEOa1SSAyfG9muOLa1VI1bnG
         ViOn8N5wdEGvCEVzuJMUGtwwyLMQLAqlXwusBBum1gWd9cFoo5yQVLPaD0L3m1DSnCkR
         7/sy0rPxvHUa0nIyLOqLhAgp7zFfzFaKGk7SZtJb2Lq/Xq6PeEhI3j1160A2p8Ohb1GB
         QplFRuS6pW6x8HC5ouQgA6VNDMiC13rrmlkg1qiL3AET3iYEacdM/ASW6MMfhhMmgJQs
         dQK/IcTV7EbentFRJeZglOfvUUBJJGumzbrEPLoNdEuEP/B1Q2UxyUElLCqVOtflWvTZ
         QQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685284; x=1701290084;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fr0rfms7tXicjm/v6zPXZ20qPmu3fmuNiMNhVPcFt+Y=;
        b=w2hO/Ho9cuxaTx+kW/1cwDqBcGCaoO2v0CevYkt8ye+btDx7pkBGQvjiZcdpN/u24m
         bqYo605jKgvakMtBwB+q2Nk0AYpEPdoUh5aV73kOWW0bjZpQdvwk3r3V2vQCalJyj47G
         VqQYRgJ/x6hc6DlYVlQnhEy4blL4D7CfPQJaXry/ehX+39yoUehjdGpWqqpvhrp73AGI
         7bkRshYaE3xhScYMTcl7Jj0cPLECH1n6wA0IDNsoyayv9QFp2mjnkB3vNjTigLYLqUjA
         VaACBxCPJFQhHrI5ufudxcQxc1w77+y7x4A6UkVIgWpbR+onvLgH3OEjClPy5nmPsL2v
         Dkvw==
X-Gm-Message-State: AOJu0Yy0Pi7OglHMCG+IIr/5SKsbFKiTbRWqZHz36/lLJqknoC73k/X1
	IgE5D2FqaJ2zLrHCOfpwUue9dVkqgMsadZITT6I=
X-Google-Smtp-Source: AGHT+IFg5UiqyvrQkBIMWMBTGDnCr7vwA+d6u/z1FE0a0bi248fURbTQo7SqGtmEZp4OwUbmyZhAyg==
X-Received: by 2002:a05:6808:16a8:b0:3b2:dd36:dec0 with SMTP id bb40-20020a05680816a800b003b2dd36dec0mr5009008oib.4.1700685284190;
        Wed, 22 Nov 2023 12:34:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 37-20020a630f65000000b005c200b11b77sm96070pgp.86.2023.11.22.12.34.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:34:42 -0800 (PST)
Message-ID: <655e65e2.630a0220.567f6.08c8@mx.google.com>
Date: Wed, 22 Nov 2023 12:34:42 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.200-cip40-188-g33d0b44cd71d
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 13 runs,
 5 regressions (v5.10.200-cip40-188-g33d0b44cd71d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Nov 2023 20:34:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13647

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 13 runs, 5 regressio=
ns (v5.10.200-cip40-188-g33d0b44cd71d)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =

qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 2          =

qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
               | 1          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.200-cip40-188-g33d0b44cd71d/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.200-cip40-188-g33d0b44cd71d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      33d0b44cd71d9f81944784e605bc1def7fa0b71e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/655e5ac2db1e2e5ec17e4a6e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/x86_64/x86_64_defconfig+x86-=
board/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/x86_64/x86_64_defconfig+x86-=
board/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/655e5ac2db1e2e5ec17=
e4a6f
        new failure (last pass: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/655e57e73449642f4a7e4a6e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/riscv/defconfig/gcc-10/lab-b=
roonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/655e57e7344=
9642f4a7e4a73
        failing since 88 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/655e57e7344=
9642f4a7e4a73
        failing since 88 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
qemu_smp8_riscv64        | riscv  | lab-collabora | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/655e54673012b1c28c7e4a8e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/riscv/defconfig/gcc-10/lab-c=
ollabora/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/655e54673012b1c28c7=
e4a8f
        new failure (last pass: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig   =
               | 1          =


  Details:     https://kernelci.org/test/plan/id/655e51fbcc1032fb6b7e4b0b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.200-cip40-188-g33d0b44cd71d/arm64/defconfig/gcc-10/lab-c=
ip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/655e51fbcc1032fb6b7=
e4b0c
        failing since 20 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

