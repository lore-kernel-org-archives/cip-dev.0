Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE35EB64DA
	for <webhook@archiver.kernel.org>; Wed, 19 Jul 2023 14:52:07 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.15853.1689778323373784248
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 19 Jul 2023 07:52:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=q031X+Qs;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1b89cfb4571so55946425ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 19 Jul 2023 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689778322; x=1692370322;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8VHDLFD0RDBGeJZgkvea/i9v7gcPJhJNpFHYoLVPoR0=;
        b=q031X+QsYIrc/dEK84rJlSU8IkgvIAr25XhvpFq8+LNWlNgiuZbKh4NgHpRENaRdy/
         LfwYUZoUTG5qJw/asbw/pHLDX1ZgWELBIIo7SjRy6NlMJTCfM2/TuHU2WnfoIeuyb+Dj
         qyl276Ce2dpfg/Orp7Fu6ROMojWpCbbvhVXjLgkZBsKVPruV3uBJ42nY94H6S1UdFAXK
         bb0K0RV5OqfB0LFZDzjTLIaJDpA/NIANFQqvYdOYiMlncBeKjx1BL5hev7U91EQ0m+Dl
         TZgjjFP++ZdRE4sbwp3AjjjXp7ZsVB4iRacrGx0p9Rg1FzpA/moV728nCsa2xvnRKDYF
         85Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689778322; x=1692370322;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8VHDLFD0RDBGeJZgkvea/i9v7gcPJhJNpFHYoLVPoR0=;
        b=Pv3UybjhU8XSKdzui/sgVXGcGCqOBwXJ85XTmnNiSlSospcgUAmU3yrp7bnUe7CuaV
         peNcpemcc6Y6S+h6k6blWtOdrX/JJtdYMvsjnW2iOuiGIag8AomJnl1qQVinhesHo/+y
         QDpLr1iqDcBowLPovYWIWm3VW+HBkveZn/54pMAbfNwO5VDsKBar0nTlm874Adbt1U4v
         WTt0eX9EZbmCKu8jkunttekcWaIY8mXbGaaunqpWW83x6xawDT/ArsP9dWBkRANVry6L
         OZgmCGbRaH9/l9O6x4AO4bJyxJnlts6O5dilQXT2SX6Z4+yMoky9D1rto+Nyz/twuxPU
         Ll+A==
X-Gm-Message-State: ABy/qLbK0av9lzXpe7VVj4X5G5PWFWctMSUUyWPnFXdD5C4731iy5CYM
	nVliVBrJq4WFP/1KcLE6QeggbwpwGi7HenHbqLO4xg==
X-Google-Smtp-Source: APBJJlE//s3Z0RquTO6Ens3ovI/d7HLtvJTcK5s8sW1IPxWl4w8EzwD10G6AiuTQL9GmdGwZ4vP1ZQ==
X-Received: by 2002:a17:903:2791:b0:1b9:de67:286f with SMTP id jw17-20020a170903279100b001b9de67286fmr2780765plb.49.1689778322075;
        Wed, 19 Jul 2023 07:52:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b001b392bf9192sm4094792pll.145.2023.07.19.07.52.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:52:01 -0700 (PDT)
Message-ID: <64b7f891.170a0220.cbe56.882f@mx.google.com>
Date: Wed, 19 Jul 2023 07:52:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-2-gfcd111609480
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 6 regressions (v5.10.186-cip37-2-gfcd111609480)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 14:52:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12437

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 6 regressions (v5.10.186=
-cip37-2-gfcd111609480)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-broonie   | gcc-10   | defconfig | 2       =
   =

qemu_riscv64      | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =

qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =

qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-2-gfcd111609480/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-2-gfcd111609480
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      fcd111609480c664a9d1e68c5ec8c352c2312db5

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-broonie   | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64b7e27cc145f523608ace33

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b7e27cc14=
5f523608ace38
        failing since 27 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b7e27cc14=
5f523608ace38
        failing since 27 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b) =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_riscv64      | riscv | lab-collabora | gcc-10   | defconfig | 2       =
   =


  Details:     https://kernelci.org/test/plan/id/64b7e1e7cac1728aad8ace27

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/riscv/defconfig/gcc-10/lab-collabora/ltp-t=
imers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/riscv/defconfig/gcc-10/lab-collabora/ltp-t=
imers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b7e1e7cac=
1728aad8ace2c
        failing since 27 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-19T13:15:12.715537  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64b7e1e7cac=
1728aad8ace2c
        failing since 27 days (last pass: v5.10.182-cip35-8-g2391124f19a70,=
 first fail: v6.1.31-61-g32a95f5a4e3b)

    2023-07-19T13:15:12.715537  =

   =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64b7e59c0d644b83568ace20

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/riscv/defconfig/gcc-10/lab-broonie/ltp-tim=
ers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64b7e59c0d644b83568=
ace21
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd) =

 =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/64b7e4bff9ca6c90308ace1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/riscv/defconfig/gcc-10/lab-collabora/ltp-t=
imers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-2-gfcd111609480/riscv/defconfig/gcc-10/lab-collabora/ltp-t=
imers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/64b7e4bff9ca6c90308=
ace20
        new failure (last pass: v6.1.38-cip1-10-g02aa22be941dd) =

 =20

