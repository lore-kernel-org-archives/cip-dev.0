Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C636C77B60
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:31:02 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.37848.1679473855819308289
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:30:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=h+gXlNBK;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id le6so18567635plb.12
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679473855;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TGdmnwZCBrw7V2S9uMCsvNTMblasuCmSOaD3DsvRtcQ=;
        b=h+gXlNBKIz20QaVPCOMeBqP4sCBiaMyHsArd/nvfLWXPxjwwFkYkDqXrEa+RIUhW39
         vQ0BOlcgkT6bIgCNY5YI8NhkQTTSPjRdeHY/7FYz/YaMXkvxfZPkhqQVB/4BhrZExPPB
         V8U3pukxtz/jTFL9MhSRdhBalxjAehWBXACUxFEeTAjN3Pvi1CRKRLKTwawXTSDyQD3i
         /FcDCwnp4PNtPEQCL9hwB26LrC9kGjvvFv+oAQJA9hXO0DuEzIGklKkl3ofeuTqS8CY5
         JZbBERG+zrGB7rhMVFfTwM7KuAiyuZe7TcrnWnQ92+zO0aw5TDg6jhobWjxDIdC+5UlF
         M3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473855;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGdmnwZCBrw7V2S9uMCsvNTMblasuCmSOaD3DsvRtcQ=;
        b=DaBxBEzuQdVjHoYIw7p+wDFb0AoEWQbuKrU/2j9veqxHobAJjjImr3P3degbE2UBdR
         3sEvQUUyMJOV/QOzqFxryBjPCinG2lhitUpe0dwGxD974KPi3mFQjcjZwKyD4eBrJILE
         CqCTB0uoUJWKKPce7U33aWvO3zllJRMu7GLE/C3tk6aeOwIH8a+f5umpIl6Y0+NYIb1A
         YlllXa59zWZ5r3m/C5SdDJiUp3NKr36O6Sq3mZjG7vdqDdAJ55Eo2Im3tPstaq2ejXiD
         FJ6M+lm122wXEBByvNbekNOFss1OUbta+EIZnFLdNd9zjWlXVaYgLaCzqP3iLDZuk6gW
         Hfxw==
X-Gm-Message-State: AO0yUKU9IR1dzhKppP3kkxfPhvqjTUA4VpN+jdgyNXrw1nNUrFOWBnK3
	E5/YQC5Ug/wKW9P3D8O24nuKOsoNgP3WBrBSaS8=
X-Google-Smtp-Source: AK7set9z8fAD+4cjY23xrKsFsJYmblhxJo5UjqlhwUCf0ZbYbzRaffg5gPa7mg5V/NobHvcYmrALoA==
X-Received: by 2002:a17:902:c944:b0:19e:b9f8:1fca with SMTP id i4-20020a170902c94400b0019eb9f81fcamr2292859pla.10.1679473855107;
        Wed, 22 Mar 2023 01:30:55 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q20-20020a170902b11400b0019251e959b1sm10019607plr.262.2023.03.22.01.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:30:54 -0700 (PDT)
Message-ID: <641abcbe.170a0220.15473.2b3c@mx.google.com>
Date: Wed, 22 Mar 2023 01:30:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94
Subject: cip/linux-4.19.y-cip ltp-timers: 9 runs,
 6 regressions (v4.19.277-cip94)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:31:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11052

cip/linux-4.19.y-cip ltp-timers: 9 runs, 6 regressions (v4.19.277-cip94)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.277-cip94/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.277-cip94
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7027f305d14858b8392890a56cfe71edd50df202

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  f3463a347c37b44bafdf4e882cfb932f6888905d =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641ab0cff61519fd7a9c950f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/641ab0cff61519fd7a9=
c9510
        new failure (last pass: v4.19.276-cip93) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/641aadd6b09f210c669c9505

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641aadd6b09=
f210c669c950a
        new failure (last pass: v4.19.276-cip93) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641aadd6b09=
f210c669c950a
        new failure (last pass: v4.19.276-cip93) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/641aaeef67cfb2e4649c9505

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641aaeef67c=
fb2e4649c950a
        failing since 115 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641aaeef67c=
fb2e4649c950a
        failing since 115 days (last pass: v4.19.259-cip82, first fail: v4.=
19.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/641ab272926adf8eb49c9528

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/641ab272926adf8eb49=
c9529
        new failure (last pass: v4.19.276-cip93) =

 =20

