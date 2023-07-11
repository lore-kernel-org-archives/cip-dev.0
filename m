Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F6BEB64DD
	for <webhook@archiver.kernel.org>; Tue, 11 Jul 2023 16:07:27 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.56.1689091638997467036
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 11 Jul 2023 09:07:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vbpNhwri;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-263253063f9so4300247a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 11 Jul 2023 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689091638; x=1691683638;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HWJ1O/0cqXc3qAzpr0baRJD1dckBPqTiuE2UOkq0Nh4=;
        b=vbpNhwripvfTaHXbsw7kMGtaQGUaa38YBTV2U8+NWsf3rMRlqEjKCAmC7BT9O+48l4
         Ud2PokEcmk0D1eWWdEkKj4t2fKK7coF0uPGC1Lywr0vy84gBkSGXsEfGiKEpPeFyrxBi
         JzSb7KUTeS34ZuZYk67XNPApH+TZiG1iYxtCThbYGpzl4AWC60DobFt+CN+8Ftu5ZrFA
         DFXwxrgKUMHaV+wto+oGNpCMSl6BRHsMUJ9LYreXuI9lZp88astftcZck7Fi1ozObGfR
         l0i6xndRLPfqddrDDjO3cabmaCREBfracQqJcVYuj3uNdK/ONCnJeDbUDyDI3RQKbsMB
         yfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689091638; x=1691683638;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWJ1O/0cqXc3qAzpr0baRJD1dckBPqTiuE2UOkq0Nh4=;
        b=Lzpd5qqlR+sImQnkjLz1q8MrzvOvNipipKS83nyrcY0YYXn+8KL8fbdMUSHgqHwfLt
         67BzkpAWbFc+lGMHILsumieSLSB68c9KeseoAm4yNd0gl2KN0ZQaflDMErfhfSe58cb2
         8fVI21aWIOVRxS0g60RpWjnqOiqdq7ZX9Ij6MDLQmc+I0xOw3GAh+QMYi7wf/BzZg9kT
         wAPEwzRsIDoEOlLSEqALyhfVgZlm95vjxOdYlYXMs0xK5Tgxr3IVYN5XS7MZGRxlRIy/
         hG5MDsaiaQ2FfwvDtXv/mCZTzX7BRKqlaYY9MhoMO0kDmihJuuj0h5/KUXa3GgPc44ej
         Kg/w==
X-Gm-Message-State: ABy/qLZfJSwZKV0y1Hwh09u98GnBmItTkj8geEOiIbKHG51xeBcoXVtd
	9Ha1b5xijPKIvtVwh2Ldqg0hqh0ceb2ws0HzGb3MdQ==
X-Google-Smtp-Source: APBJJlEOUD+lpdaYFLd41wFZILfyDDsU4vvExLfefjfLh3f2NP/dYCLnYriwrjmKOqzVDSk00oQhEw==
X-Received: by 2002:a17:90b:4a12:b0:262:ece1:5fd9 with SMTP id kk18-20020a17090b4a1200b00262ece15fd9mr16292164pjb.10.1689091637958;
        Tue, 11 Jul 2023 09:07:17 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090acc0600b00263b4b1255esm8266018pju.51.2023.07.11.09.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 09:07:17 -0700 (PDT)
Message-ID: <64ad7e35.170a0220.8971b.f2da@mx.google.com>
Date: Tue, 11 Jul 2023 09:07:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-13-g8fae18103387
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip ltp-timers: 8 runs,
 4 regressions (v5.10.184-cip36-13-g8fae18103387)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Jul 2023 16:07:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12321

cip/linux-5.10.y-cip ltp-timers: 8 runs, 4 regressions (v5.10.184-cip36-13-=
g8fae18103387)

Regressions Summary
-------------------

platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2          =

qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.184-cip36-13-g8fae18103387/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.184-cip36-13-g8fae18103387
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8fae18103387e09e360941d7df884a2fc6010f66

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie   | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64ad79838403409cecbb2a96

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu_=
riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ad7983840=
3409cecbb2a9b
        failing since 5 days (last pass: v5.10.184-cip36, first fail: v5.10=
.184-cip36-8-gb192df20e8c9) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ad7983840=
3409cecbb2a9b
        failing since 5 days (last pass: v5.10.184-cip36, first fail: v5.10=
.184-cip36-8-gb192df20e8c9) =

 =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/64ad74fced170c69ccbb2a80

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qem=
u_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.184=
-cip36-13-g8fae18103387/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qem=
u_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ad74fced1=
70c69ccbb2a8e
        failing since 5 days (last pass: v5.10.184-cip36, first fail: v5.10=
.184-cip36-8-gb192df20e8c9) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64ad74fced1=
70c69ccbb2a8e
        failing since 5 days (last pass: v5.10.184-cip36, first fail: v5.10=
.184-cip36-8-gb192df20e8c9) =

 =20

