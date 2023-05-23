Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34DBC7EE29
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 02:11:26 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.11556.1684807884655278672
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 19:11:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=F7N+W6oa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64d2f99c8c3so3001331b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 19:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684807883; x=1687399883;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zr5gHI1zRgGSx19NTQjiHREJXmKIklgthLOZs6qEcJE=;
        b=F7N+W6oa8S63me/gC1e/UbtNHgIfsuakBtyXPClTUUtxroNICqsrWjcYVrhAJSR5eq
         4u/fAfs2gcdGydfoCJpoHW3r/lfA2kzSBFtsjDQA/d/d8KazFqfjDTxvvdi2bfDBkiWG
         faEjE8C4xDrIecfx4vhD3Uh4N7BaecaEziMz3tM5iSjvfqMCN4T3+/E0BM4MqHvkgZR9
         v/3BW51InX9sC2Jgem/GhoGsi+735xfeqAmSIlhywBJ1WHC3lsLZGHc5ArpTDqGczlRW
         pu+TXY/FUJUPGvsNtQaFGIu7HOUNodUa5KbUMXAGU/fxs9Wgn60DCgAXMz/B9BfNNv+D
         TVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684807883; x=1687399883;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zr5gHI1zRgGSx19NTQjiHREJXmKIklgthLOZs6qEcJE=;
        b=l4+sn07zJbucnJcfgyqcyGr/PHJ7yco2lcqtTQdGFW4YE7KWfFg1tg3f9dHMi2Inls
         CULlOuHze6a+vYSDqN7+U28Nn1lDvUrSRXUgqCiOLefinLFDOPFbERfySoz1zUNo0hdT
         zDALnsFzfXSeMTgKhB5sDDQcDOKt2q0tIWKhG6k3yaAjQKiAAbgP9uIRDC/zR4WDQsFz
         XHmyXy3xceDxGVZKh3Vralx8+surQ1wGReEz6Z+CsYZBCYjQQJfTywg2RyRliM28paE4
         j4KWnlGuQ/wiSze7soT3G3xBaywi4JxVGZdTbyHOGGc1tdh8oXTyALtevQ4tgfMB7n1X
         Cl4g==
X-Gm-Message-State: AC+VfDyZOhYRj7hbgP5izOh8BNQfO6K+NcfFbFPGyTX2oSk2laj2tln9
	xsfbf97ABHNhq8Nz5KonEFS39xc257hkVozxJdlVZA==
X-Google-Smtp-Source: ACHHUZ6A5bJO0JIhvLGub9kO+ID1AF0/+InIZ7VORY1cIowy4v0JpSI8AfZXIKDsOLz3dC2GySbrZg==
X-Received: by 2002:a05:6a20:4420:b0:10b:c54f:6d1b with SMTP id ce32-20020a056a20442000b0010bc54f6d1bmr5504527pzb.52.1684807883667;
        Mon, 22 May 2023 19:11:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c26-20020a631c5a000000b0053474697607sm4938251pgm.4.2023.05.22.19.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 19:11:22 -0700 (PDT)
Message-ID: <646c20ca.630a0220.96b3b.885b@mx.google.com>
Date: Mon, 22 May 2023 19:11:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip-rt ltp-timers: 9 runs,
 8 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 02:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11609

cip/linux-4.19.y-cip-rt ltp-timers: 9 runs, 8 regressions (v4.19.280-cip95-=
rt30)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.280-cip95-rt30/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.280-cip95-rt30
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  ce4802999f7ca6421643879ff08bbc1e18e7f8cc =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/646c1272961d1c49e02e8669

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c1272961=
d1c49e02e866e
        failing since 187 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c1272961=
d1c49e02e866e
        failing since 187 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/646c1117dde05fcd6e2e85e9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c1117dde=
05fcd6e2e85ee
        failing since 187 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c1117dde=
05fcd6e2e85ee
        failing since 187 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/646c101413067b246f2e85e8

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c1014130=
67b246f2e85ed
        failing since 187 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c1014130=
67b246f2e85ed
        failing since 187 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/646c15c74c43e1fa982e860f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230512.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c15c74c4=
3e1fa982e8614
        failing since 187 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/646c15c74c4=
3e1fa982e8614
        failing since 187 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =20

