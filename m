Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6B9C61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:59:47 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.134886.1700830783785092551
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:59:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=kfIMg2nH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1cf89df1eecso13523615ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700830783; x=1701435583; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+fVr5RfzoOeCv2L16w1JoATUaUFIo9EHdCPL+xAScu4=;
        b=kfIMg2nHn/u82djtJhwdNjIls7jQ/n1l8JKLALS2+CBD8ALOmuhPy8WaS8gU7Qw60E
         Ebd/48sjXWEPhhsGxxV3uB75z9DNj14wdhleHtiDXA49AuDJsBj/skpJXTa7XpMhJoTR
         dYWrDlkD5TFDUhogxv8gyEPOxobqEr3xa7BWRXZZiHRvCl1waIK6EmBKUfWWx8Z4ihx5
         jNH6TCSAflv3gD+PEGuTXB/B4yNeCbnMwj5GCAcMVdmcgzn9wO4eYmgSUsiJYz6aryhm
         jJ9R4jZj8f++mzXkOdeWJC21UkNwSzERxEapnupfMoS1uWkkxywkKUr8eobw06NGUEHc
         0www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700830783; x=1701435583;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fVr5RfzoOeCv2L16w1JoATUaUFIo9EHdCPL+xAScu4=;
        b=O46Y2IxTF0KoMDilMRlqznwhDhedZE0D7JdUqM4VhdS5j/jBTJ8K9byIr389ML9O6T
         Q4b0sbtRVTyh/p1tvq20u1JMg3sVWTUJWiiuD3AWjmRHluBqeMKDS3VH7/kZ8BXEzsU+
         yo/dKTKEboSWH8T7jvabDNcriMfoK/lPyJznoOxzU/glmQPNmfYA3ntpdFe9SpiCDM8Q
         qUbqzYh10A0IUjAY2dJDEznToCCzWRvMnuOJ1ti4kfEOIUollNw865CNJwLWWqEay1aP
         d+ALoGxv06Gq2d3NROEqHmPAyFBRnfSKXsQkNxqUi0x1f4e7TUhOWbWkIm14kkKIhwUw
         oiuA==
X-Gm-Message-State: AOJu0Yw8jSt7Kl8WLJue2ZK+ksAoEqMwhGHp6eGpA5bkeM7dNnGtcMXN
	M3YmF4UML3cayygZxMHl7preTgS7MP23XK7vac4=
X-Google-Smtp-Source: AGHT+IFqnxPUUdQ1QQpK8uhNjWw4GpqfzaejXnv9wAPTsqcrCz8nqY7MutIoesUWD5nwn9BEIaRA0w==
X-Received: by 2002:a17:903:2349:b0:1cf:9790:f23c with SMTP id c9-20020a170903234900b001cf9790f23cmr2911791plh.55.1700830782541;
        Fri, 24 Nov 2023 04:59:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902680600b001ce67fab3a2sm3173076plk.261.2023.11.24.04.59.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:59:40 -0800 (PST)
Message-ID: <65609e3c.170a0220.1f9e8.76ce@mx.google.com>
Date: Fri, 24 Nov 2023 04:59:40 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs,
 3 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:59:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13744

cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs, 3 regressions (v6.1.62-=
cip9-12-g3a5321f469b07)

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


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.62-cip9-12-g3a5321f469b07/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c

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


  Details:     https://kernelci.org/test/plan/id/6560931c20b7a058a97e4af1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/x86_64/x86_64_defconfig+x86-board/gcc-10/la=
b-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6560931c20b7a058a97=
e4af2
        new failure (last pass: v5.10.201-rt98-828-g27523c64bc5dd) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
qemu_riscv64             | riscv  | lab-broonie   | gcc-10   | defconfig   =
               | 2          =


  Details:     https://kernelci.org/test/plan/id/656091031e74eccb0d7e4ad2

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.62-cip9-12-g3a5321f469b07/riscv/defconfig/gcc-10/lab-broonie/ltp-time=
rs-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/656091031e7=
4eccb0d7e4ad7
        failing since 0 day (last pass: v6.1.62-cip9-13-g34c303883a305, fir=
st fail: v5.10.201-rt98-828-g27523c64bc5dd) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/656091031e7=
4eccb0d7e4ad7
        failing since 0 day (last pass: v6.1.62-cip9-13-g34c303883a305, fir=
st fail: v5.10.201-rt98-828-g27523c64bc5dd) =

 =20

