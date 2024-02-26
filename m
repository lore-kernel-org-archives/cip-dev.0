Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96214C5478C
	for <webhook@archiver.kernel.org>; Mon, 26 Feb 2024 03:45:26 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.13532.1708919125066348180
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 25 Feb 2024 19:45:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=cRq4jObi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dc5d0162bcso21533225ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 25 Feb 2024 19:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708919124; x=1709523924; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BA610sdqn02G8qT/pLir4j/PV4lr3DaruYxwjVpWy9U=;
        b=cRq4jObi6IGkagqk1sp1V4X7Vp5tf+LS2IZafAaFMEmb7gmpO2ad1puFybw3Rh4HFD
         nnwcOU3u9jNlGxdb4kpEA7SnfFvr/uhNwtzEYV9/+wDzPFROtRMMJiLsNX+a9LIwZVTe
         GiffczSSPhxyRy4ziZEEJqCcRyixpPbYD6rp5cf9Ofc8zwVTQWU08ms8fQLhfWExgx+D
         kmloPm/LltsYCsAHPcZfqHj2PkJpQReuBIBph8ZkU2YsQmuyDPXebz+0YY5+RtTUAvjo
         L4YUHbMkExP8YkIe7cwAn01Lhh5fpLg6w5uDnY5oO3FLmS2OvGNh4DNCHuf29KeoOGxb
         BsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919124; x=1709523924;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BA610sdqn02G8qT/pLir4j/PV4lr3DaruYxwjVpWy9U=;
        b=o3ps1DYcPu8+E2FGaV5tAfdAe6GTaSvMmg/hQynfd3/oqP9MywHPRSPxGDVhZPspub
         UXzAJt4YPP0eUJov3gt4OVylHKNVBVqgZE5Ij/MZUTe5RYqnvY4lCjCnjRv6v/lixS4v
         JIUDFbt/LfT+/dpmpgEJ4D0tvFZ0wr8ytvTsiv/31x+w+IHjVvXKNpZPv8n318MTRdLj
         Y1wcC+Kgq3QA7CYQlXnIgnQ3mI5vJstouCnvh3ffPV5kD12NPKjm5SEn1OqqCKly93yw
         P7F3hSujvhkEpw2PX4SWH5rTyYPcEGOWeOrrz+ew7XG0poKDSAlZ83TtkGl3bRslFNQq
         QaVw==
X-Gm-Message-State: AOJu0YwQOXI7vERtvcyhKMMn/AVJyG7ucSsjD77XUcVrf0Qp+KorC2f6
	2YECcgS6OSTy1eroWsc7RCfVQzURa844/y+Lf439YsQROEC56xLi5sG00srKZZzDjq9+hjV2CwN
	0
X-Google-Smtp-Source: AGHT+IEzE6lq7HmajhTkBcUPAXaULBjPxVChkQLnObZ4LrLmsYrbSpmQ52U0f+bMtEiEQay+erNLog==
X-Received: by 2002:a17:902:e84e:b0:1db:f965:471e with SMTP id t14-20020a170902e84e00b001dbf965471emr6364799plg.58.1708919124069;
        Sun, 25 Feb 2024 19:45:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090322d100b001db9493104fsm2881908plg.79.2024.02.25.19.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:45:23 -0800 (PST)
Message-ID: <65dc0953.170a0220.24315.7596@mx.google.com>
Date: Sun, 25 Feb 2024 19:45:23 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.78-cip15
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-timers: 14 runs, 5 regressions (v6.1.78-cip15)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Feb 2024 03:45:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15086

cip/linux-6.1.y-cip ltp-timers: 14 runs, 5 regressions (v6.1.78-cip15)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =

qemu_riscv64       | riscv  | lab-broonie   | gcc-10   | defconfig         =
         | 2          =

qemu_smp8_riscv64  | riscv  | lab-broonie   | gcc-10   | defconfig         =
         | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.78-cip15/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.78-cip15
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8e0cf035f64a98ea0d7ed2527a547f39866c37ba =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig+x=
86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65dbf851ae2e7972a7637044

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.78-ci=
p15/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-timers-hp-11=
A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.78-ci=
p15/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/ltp-timers-hp-11=
A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20240129.0/amd64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  c04218579773e3c7017a87d8bb121771e3e0f09c =



  * ltp-timers.login: https://kernelci.org/test/case/id/65dbf851ae2e7972a76=
37045
        failing since 20 days (last pass: v6.1.75-cip14, first fail: v6.1.7=
5-cip14-6-geddeb7f8123c) =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
qemu_riscv64       | riscv  | lab-broonie   | gcc-10   | defconfig         =
         | 2          =


  Details:     https://kernelci.org/test/plan/id/65dbf6c0ed185cb67763704d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.78-ci=
p15/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.78-ci=
p15/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65dbf6c0ed1=
85cb677637052
        new failure (last pass: v6.1.75-cip14-6-geddeb7f8123c) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65dbf6c0ed1=
85cb677637052
        new failure (last pass: v6.1.75-cip14-6-geddeb7f8123c) =

 =



platform           | arch   | lab           | compiler | defconfig         =
         | regressions
-------------------+--------+---------------+----------+-------------------=
---------+------------
qemu_smp8_riscv64  | riscv  | lab-broonie   | gcc-10   | defconfig         =
         | 2          =


  Details:     https://kernelci.org/test/plan/id/65dbf677a9e247058363701b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.78-ci=
p15/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.78-ci=
p15/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65dbf677a9e=
2470583637020
        failing since 62 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65dbf677a9e=
2470583637020
        failing since 62 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =

 =20

