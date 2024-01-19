Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E2BC47DD6
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 02:02:24 +0000 (UTC)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
 by mx.groups.io with SMTP id smtpd.web11.12207.1705629742754529325
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 Jan 2024 18:02:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=wDyP5Z33;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.170, mailfrom: bot@kernelci.org)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36082f3cb05so1301745ab.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 Jan 2024 18:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705629741; x=1706234541; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ECy7BD7nYgzewLhDNm7T+bwo29+kiWmyBFgnWR7Itqo=;
        b=wDyP5Z33vyU4YfWz33DS4AP8SxDR4PlxtKPw3CMGn46zHDXI/sDlMA83L/BzAxslbh
         p8hG5XO0ttXvhZEZccwsdK3p7rbE8eoYgfrsbzglcez0ZCzlf+JhpIFE9tRqcHBbjP7k
         i14Ffg2MM+CLPVlA3t1D7VeHgIpmu0/FDOhsgs5pUR478axy8MM9+25vAgOFzEw7AjmF
         B3Tn1kT1jAQFLh7+9KZKx9p1c1Vh32LEk+o1/+wrAcZfCjm19oL/twOcy0uXGUj8bmpX
         qA7qBTWdO0z+vTfGLddLJz/LbBtDFk50QfLT91jZkJTeXXbTVlqKXO+NWYJitwGKDaAy
         vV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705629741; x=1706234541;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECy7BD7nYgzewLhDNm7T+bwo29+kiWmyBFgnWR7Itqo=;
        b=HxXmQ+dSpoBKX2X82UdUc2FpGSBaUH71KON+XDMrQ98aeF0AEC2TBRkiXU6A78fgwV
         bZ8LAQklbxyBiSi84V0aISnYimQGiSSOsQfE9+6h8hNJRa7Ngx0xOPBaXE//Zx0waQc6
         7rdhzhXbeYzU8cNlh+lTwnNzU+t/VJ9XrNwkUqtlu0nlQMQsRWSrkb/ahAcAXxjPw17T
         WdVBcW0kz6kBFGCt+vkPHe/I0aG4WJWqX7GBxqs8Fg0dpMgw83bzPHdsu4r6q3uoR9uN
         6Ungnho0s/PtScGDd061gyH1LKzdK4zbMoPu/RBiQnJCGSmXse3sIIC09FMTHsWknT5T
         v8NA==
X-Gm-Message-State: AOJu0Yz0bYN66djB30sEyMGI3qCiEFn/k9ifTva2NNFdPuIgOw/BFEhc
	lBQTS1wQKLZ3cYG2KPR0JfF93RlwofgM4/xEcfgJKwwQ4bbWJ3qkDLW5BY71nTcn3vtzI9Z3lGn
	UB7U=
X-Google-Smtp-Source: AGHT+IHOoXtEvjYWEh2WDXb2xUFZKYpAEZt7ELvTi5J5nC148+J9Ne8yGFxNV+PxTNsqXklZJyti3Q==
X-Received: by 2002:a92:ce42:0:b0:361:9249:5aed with SMTP id a2-20020a92ce42000000b0036192495aedmr1872612ilr.52.1705629741493;
        Thu, 18 Jan 2024 18:02:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k14-20020a636f0e000000b0058901200bbbsm2277542pgc.40.2024.01.18.18.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 18:02:20 -0800 (PST)
Message-ID: <65a9d82c.630a0220.f4f12.b91c@mx.google.com>
Date: Thu, 18 Jan 2024 18:02:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.72-cip13-30-g79e2886a5da69
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-timers: 8 runs,
 3 regressions (v6.1.72-cip13-30-g79e2886a5da69)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 02:02:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14421

cip/linux-6.1.y-cip ltp-timers: 8 runs, 3 regressions (v6.1.72-cip13-30-g79=
e2886a5da69)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig           =
       | 2          =

rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.72-cip13-30-g79e2886a5da69/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.72-cip13-30-g79e2886a5da69
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      79e2886a5da69a8a86ec82215b5e9e0748943546

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
qemu_smp8_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig           =
       | 2          =


  Details:     https://kernelci.org/test/plan/id/65a9c6becbb2534d2852a3f1

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_sm=
p8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_sm=
p8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65a9c6becbb=
2534d2852a3f4
        failing since 24 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/65a9c6becbb=
2534d2852a3f4
        failing since 24 days (last pass: v6.1.66-cip11-1-g2d3d776d703d7, f=
irst fail: v6.1.67-cip12) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9d1fbfd562b420252a475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/65a9d1fbfd562b42025=
2a476
        new failure (last pass: v6.1.67-cip12) =

 =20

