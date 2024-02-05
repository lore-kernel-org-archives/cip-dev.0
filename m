Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7C9C4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 14:47:07 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.64527.1707144417296210161
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 06:46:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=JH5zhKhI;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d94b222a3aso36550415ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707144416; x=1707749216; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MHXkyvxttQFS9yWWyNfqChxNeZotuTopRlo+13IRvyA=;
        b=JH5zhKhIXiAM33BMd1P4WbxtFYKKT+CCuAU7PLGGYmV75VOdgyLjHhXLd9h/56sVt6
         doa1CKsG5ZGAc8N0T2yl6LPNGN+kd5lhGMqf+RoDMGAGjgxtx7jm6XsALOhQPTF0CdIF
         kXMP+51oYcX2JbcwCaGcBrgekUPnahXpFSEMldZvY6xxxWGtBTKgv3xqrJwyLW3DSlxY
         5vXVFPrHFSnBmn6xUa04q0bZ922lThLSbj592qfesnAVh8fE0pVANx/zH8fFzN6PORrF
         GfJqIUduGwBOVclLNEDZqgUlBj02T7NjoSXtD4cIuVe3S2JL2M0PwzCcpzofZulQjl3e
         sG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707144416; x=1707749216;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHXkyvxttQFS9yWWyNfqChxNeZotuTopRlo+13IRvyA=;
        b=hCvR8pzjnzyjXAnVKd4xGTpVz92BPEInUr0mM1qSp/RQ77Mgyv707f0pYrlSyKWf7O
         Q8ZiU/s8sdLqk4Cc1W4GW83TeOv8IAmL3pvtouXxwTKU4ZAmm78DyjZ6dZN4k6EcwSY6
         uz3qiriI3HtT5Em1Tiv7U8Uygk4E0HDBYkKNB2uvRvpRbLoqUW0ENkL/xLuRFL+3PVo1
         W8vPVFL3oU6mU8z+I9PQcKz6v67RGkJdPAgUoYy7LjIfVe/lVz9N8oHWIlfvER600l8k
         gyqXAbW1GPbNe7zm7zDzxR+iPgNn4K3EOqnRauk/NuwShiPB0RTF5V1t4YPL86DdGGAp
         Pzvw==
X-Gm-Message-State: AOJu0YznyP+JCZM3XdTSZ0jgbkN40pjcvSy94V+aI3gAgFzvki5GoFRv
	iks1It3szJ+VIY56YHgcPXv/wdIUj2VMTCfmALGEKYTnmky9iqsUlkr9Q/4pkc7sBoHXh3Blv7Q
	t
X-Google-Smtp-Source: AGHT+IH+KrGeZSwi8J6EHHTYO5ZdpWo+r+t3D+LVcElnCQ7CJ1ZgirMpSpejvpW956Q1KHTfqOf2Uw==
X-Received: by 2002:a17:902:d547:b0:1d9:af73:57c2 with SMTP id z7-20020a170902d54700b001d9af7357c2mr3879444plf.3.1707144416285;
        Mon, 05 Feb 2024 06:46:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWvszt70IrLmHIjymuuftQqi6eWpv9sYp9s4hFX3XNmUSD2qY2hzZvypDb+q2F/yc/EEnnBTa7j/5jD/mtq1dfAouruNJURo0Roy2K/5u8zXBvU3WnusnIT7PmchGr0Swm1Ka7c3gEQBZUhCbd1RrnsYw==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jg3-20020a17090326c300b001d94871ba92sm6383548plb.239.2024.02.05.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:46:55 -0800 (PST)
Message-ID: <65c0f4df.170a0220.81000.4e45@mx.google.com>
Date: Mon, 05 Feb 2024 06:46:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.75-cip14-6-geddeb7f8123c
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-timers: 15 runs,
 4 regressions (v6.1.75-cip14-6-geddeb7f8123c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 14:47:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14730

cip/linux-6.1.y-cip ltp-timers: 15 runs, 4 regressions (v6.1.75-cip14-6-ged=
deb7f8123c)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 1          =

hp-11A-G6-EE-grunt     | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 1          =

qemu_smp8_riscv64      | riscv  | lab-broonie   | gcc-10   | defconfig     =
             | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.75-cip14-6-geddeb7f8123c/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.75-cip14-6-geddeb7f8123c
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      eddeb7f8123c49b652f55156c9bdfabba5de8021

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0e7c1716129ccb900a074

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14-6-geddeb7f8123c/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/=
ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14-6-geddeb7f8123c/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/=
ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c0e7c1716129ccb90=
0a075
        new failure (last pass: v6.1.75-cip14) =

 =



platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
hp-11A-G6-EE-grunt     | x86_64 | lab-collabora | gcc-10   | x86_64_defconf=
ig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0e91d80ac1c35a700a04e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14-6-geddeb7f8123c/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/=
ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14-6-geddeb7f8123c/x86_64/x86_64_defconfig+x86-board/gcc-10/lab-collabora/=
ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65c0e91d80ac1c35a70=
0a04f
        new failure (last pass: v6.1.75-cip14) =

 =



platform               | arch   | lab           | compiler | defconfig     =
             | regressions
-----------------------+--------+---------------+----------+---------------=
-------------+------------
qemu_smp8_riscv64      | riscv  | lab-broonie   | gcc-10   | defconfig     =
             | 2          =


  Details:     https://kernelci.org/test/plan/id/65c0e285795a43df9100a039

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14-6-geddeb7f8123c/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8=
_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.75-ci=
p14-6-geddeb7f8123c/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_smp8=
_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c0e285795=
a43df9100a03e
        failing since 42 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65c0e285795=
a43df9100a03e
        failing since 42 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =

 =20

