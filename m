Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D688DC4332F
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 00:02:16 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web10.5747.1667520127246891239
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 03 Nov 2022 17:02:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=icILwT+K;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3252634pjc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 03 Nov 2022 17:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h768lpSj2Kk15mEtjGKop5TplIV7sNxuJX9eOxJ0rrI=;
        b=icILwT+K2WjzvI3RSuTQtnf9EVUOKeUmGYIgYO9d10S/zEf3HuTr+a3y8XRrdEKJpJ
         Uu574RlaiY5qYQUgOR3InIM+ExKt2CAsjxYezKmQPaInjZLannO6hel1nlCnBp8qpXYm
         J65wp+nyciejnH/H9D9wYChCEXu92zEb8Ap4p156mdHBqOroblSsQNXvzSgvILOwsEm6
         GKgcRNR1nTy/mq1IBGLHOXIiT5a1uK8Cozs3HiAu9QOIGLCMrhgPRkxRpHln3EQSqO4X
         MPryKL4dqN1tqrUagY7e7JleS1ewBCuCBeqLiZtqdkP4rV+f93YQHLtxW2r6dRzAKVdl
         80cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h768lpSj2Kk15mEtjGKop5TplIV7sNxuJX9eOxJ0rrI=;
        b=RkECvq0bsusJNavhPZHaSxvRji8UYajFkH5F9IFG/1Zi7jLiB4NDdU1toQpRKOoopN
         8CtxZZWfZ2gbgGx9CvsHssRwk9NnauyPrMAlobAY2W4pwH+zVCdPJJ5lhOQ/utOlISvk
         XsE6WIzreehKCjNWdWYyApX/+BOPrPsqd84N4lZSIWUp8iga2lJgpIKhB3aXh0mPa5Hs
         Bs1sH8euaCz7yBsV4gSdf/k74ANAtQmEsTQvRkUg69p+Q/bLnqrKJ9F7cTO4Ufs1lzYy
         3ykOw1+7xNmro72RJjZ4tfaMpxvQbx4RG6b8go8dyulXU7eKOfWJHsDc9LBlHNM4qQ2i
         jQfw==
X-Gm-Message-State: ACrzQf3gvReDtvMA7Nz8MP4K5ZVVW3nnkAC0eUXeNF7JjvX6EYujMGQV
	Ffy0xodyNOEsL6/Q4MDtdbezPK3SwUini949
X-Google-Smtp-Source: AMsMyM4NqYBuIICgoxcrGXKboPqLJ7tuQqo71I48GXSowsIDfSaEljAYCMfDg3cqPNs52RoaRSeZTQ==
X-Received: by 2002:a17:90a:1690:b0:20a:8f70:14bb with SMTP id o16-20020a17090a169000b0020a8f7014bbmr33638828pja.115.1667520126372;
        Thu, 03 Nov 2022 17:02:06 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y19-20020a626413000000b0056b8181861esm1396358pfb.19.2022.11.03.17.02.05
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 17:02:06 -0700 (PDT)
Message-ID: <6364567e.620a0220.3ec51.2d94@mx.google.com>
Date: Thu, 03 Nov 2022 17:02:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.261-cip83-311-g41979a0fec1a
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 7 runs,
 10 regressions (v4.19.261-cip83-311-g41979a0fec1a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 00:02:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9919

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 7 runs, 10 regressio=
ns (v4.19.261-cip83-311-g41979a0fec1a)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.261-cip83-311-g41979a0fec1a/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.261-cip83-311-g41979a0fec1a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      41979a0fec1a3a190949acd703b3379a09fa2c87

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6364433f41d9cab8a2e7db55

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.261-cip83-311-g41979a0fec1a/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.261-cip83-311-g41979a0fec1a/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364433f41d=
9cab8a2e7db5a
        new failure (last pass: v4.19.256-cip80-1-g68250b8eafbe0) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364433f41d=
9cab8a2e7db5a
        new failure (last pass: v4.19.256-cip80-1-g68250b8eafbe0) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6364432355d3e1d220e7db4e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.261-cip83-311-g41979a0fec1a/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.261-cip83-311-g41979a0fec1a/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364432355d=
3e1d220e7db53
        new failure (last pass: v4.19.256-cip80-1-g68250b8eafbe0) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364432355d=
3e1d220e7db53
        new failure (last pass: v4.19.256-cip80-1-g68250b8eafbe0) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636448407327a1f505e7db4f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.261-cip83-311-g41979a0fec1a/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.261-cip83-311-g41979a0fec1a/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63644840732=
7a1f505e7db54
        new failure (last pass: v4.19.256-cip80-1-g68250b8eafbe0) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63644840732=
7a1f505e7db54
        new failure (last pass: v4.19.256-cip80-1-g68250b8eafbe0) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63644726bb5ddfa2dbe7db4e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.261-cip83-311-g41979a0fec1a/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.261-cip83-311-g41979a0fec1a/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63644726bb5=
ddfa2dbe7db59
        new failure (last pass: v4.19.259-cip82-57-ge54228ee5a88d) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63644726bb5=
ddfa2dbe7db59
        new failure (last pass: v4.19.259-cip82-57-ge54228ee5a88d) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6364474dbb5ddfa2dbe7db72

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.261-cip83-311-g41979a0fec1a/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.261-cip83-311-g41979a0fec1a/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364474dbb5=
ddfa2dbe7db77
        new failure (last pass: v4.19.259-cip82-57-ge54228ee5a88d) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6364474dbb5=
ddfa2dbe7db77
        new failure (last pass: v4.19.259-cip82-57-ge54228ee5a88d) =

 =20

