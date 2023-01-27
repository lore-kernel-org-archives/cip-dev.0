Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CC0C61DA4
	for <webhook@archiver.kernel.org>; Fri, 27 Jan 2023 02:26:17 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web11.93705.1674786365426204626
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 26 Jan 2023 18:26:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=KLpUzrEb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9so3632507pll.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 26 Jan 2023 18:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D6AWDcllkbbIwwcfKA//eMdbdDBFJNJullXnjIDveK4=;
        b=KLpUzrEbPSiRNVLO55YyKO8VfgQKVmwQY/mLQQiXoaUD8a30JGQZYzRLSVcoXD61kH
         fj6f/L3X7r3biJ8IWTkFXeHjufyn73JfMIqH1SfpACTv/zT0WQ1xyUh/ujzLgm8SCEqw
         tDu+IRXIruOa9XDnP8Nx1eb7bPfocN0lcu03sxNL85uVOjjbxp2gBX9s8IJDOxJvr2Vk
         L5YxotlK/Ga4H9DAxrtOZViJKVs/s0QwSY/r3YMqbfsUE7FRKAurrHg/IjM2BUlkx6Sr
         qjsPVU9ysWovO0Eb3EHC9MJtLPE3hN0lwVGE8pmrELhpmCKy13IC7AdsS/nWGbFtAINZ
         GdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6AWDcllkbbIwwcfKA//eMdbdDBFJNJullXnjIDveK4=;
        b=pCc+6tpwpD9wH7+hF2nztAT1Ech9p2T8a2ZRpXEb5CjCM0ApEfKAdvr8IYNXuedK7L
         uFmQnIeSfALNrHjDFSTMNFZVrfU/9mTfXw049EXr9Snn/zYLe1A2LXiGxrwrMVW+/n4b
         jYJ0Srz6OVb4/k/18KnNjyFbmvMyQf/DDqZ8Lf1yb/+e5kjf3PhirblkaHCpbIpIPJSc
         N2SaiwM/jxnzO8akd6Xe4kCUpznTqgztokHjQ1rs00lxTLlyDuC0Z1zjOXXR3nc+R0/j
         1pPijo5JJlzWpqcUHJ+9BJ+T/VDNJYpbANsqnG6z9lPqee8jQyo8GASwAatPNTQcVYlM
         8FxA==
X-Gm-Message-State: AFqh2kr/GKdhKt1sYUYf21uD4EZs8RarPkXTuMz8q81Lkyj5Trn0rndH
	ebiwFb658I75bmRpt/0Jk6OhiYp8zlaPOySQzvD1rw==
X-Google-Smtp-Source: AMrXdXvm5jEmwPs5MHtT8iu/lvtNjipznZsK4calELq3q6eUFCzKDk9vBQacIFRcx1cfSYdE5PmhNA==
X-Received: by 2002:a17:902:bf03:b0:194:9847:9cd4 with SMTP id bi3-20020a170902bf0300b0019498479cd4mr35064052plb.60.1674786367489;
        Thu, 26 Jan 2023 18:26:07 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id c2-20020a170903234200b0018958a913a2sm1624809plh.223.2023.01.26.18.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 18:26:06 -0800 (PST)
Message-ID: <63d3363e.170a0220.a974c.2fda@mx.google.com>
Date: Thu, 26 Jan 2023 18:26:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip-rt
X-Kernelci-Kernel: v5.10.162-cip24-rt10
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip-rt ltp-timers: 12 runs,
 13 regressions (v5.10.162-cip24-rt10)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jan 2023 02:26:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10495

cip/linux-5.10.y-cip-rt ltp-timers: 12 runs, 13 regressions (v5.10.162-cip2=
4-rt10)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip-rt/ke=
rnel/v5.10.162-cip24-rt10/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip-rt
  Describe: v5.10.162-cip24-rt10
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      55fa0afa2bb00f24b1721b532102d34eb18be47e

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  d042c168dd037bb0128b86ee4ac4f5c526eddc7b =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/63d323b5ae7012d8b3915ed1

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d323b5ae7=
012d8b3915ed6
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d323b5ae7=
012d8b3915ed6
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/63d3269aa99958bd5f915ee9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d3269aa99=
958bd5f915eee
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d3269aa99=
958bd5f915eee
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/63d32403f5dc002c9f915ef6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d32403f5d=
c002c9f915efb
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d32403f5d=
c002c9f915efb
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/63d32696a99958bd5f915ec5

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d32696a99=
958bd5f915eca
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d32696a99=
958bd5f915eca
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/63d32377f5dc002c9f915eb9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d32377f5d=
c002c9f915ebe
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d32377f5d=
c002c9f915ebe
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/63d328ef2d4cc78209915eb9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d328ef2d4=
cc78209915ebe
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d328ef2d4=
cc78209915ebe
        failing since 78 days (last pass: v5.10.145-cip17-rt7, first fail: =
v5.10.153-cip19-rt8) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/63d3284ecf7ec266d4915ef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip-rt/v5.10.=
162-cip24-rt10/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63d3284ecf7ec266d49=
15ef4
        new failure (last pass: v5.10.158-cip22-rt9) =

 =20

