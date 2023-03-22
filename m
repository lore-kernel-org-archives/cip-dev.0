Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5CCC6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 13:30:43 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web11.42569.1679491833890643131
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 06:30:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=sJ18utFr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso23461508pjb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 06:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679491833;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zvw7hjvIcrMg54cThbfzi01McpAvW6jnEHeF3J3wyY=;
        b=sJ18utFrRMdYjudxoAlwr5w+IuqNeEKJmwgNH1HoglJNrUshYt8Hko3rhLXaJ3Zl5g
         Omlmdu40f3zuX3OX2cspVbMa70C4IDeWUgt0mbaNggi52obduwa8sVICQ5xNXEeBragO
         PDMKDPsCPoc6BEccKDau9so+5eEHGPcOwV6IGgVMJsb3ynV7BO4CNfLh66KjvcQLeg4w
         4DuU87LSmr2Vs52XXUJgmNLv3oSRCABZMUIvYzc+JF0/tj4q7TUEkiZatdnAkL/wToig
         T2myNMb201kXvL6hw7HPNVnnSMGT2npbBIN2929dF1+aSFqgjaktziTVLs2L4cj21DjI
         a6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679491833;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Zvw7hjvIcrMg54cThbfzi01McpAvW6jnEHeF3J3wyY=;
        b=QemiObKSdGvV1raRGvIEnrqeIRWXfUrhy8ojVoxgXwNIam2AYvpS2WVHMZtHpXFR8T
         hiSGugpgjwlLWYkSDz9Pr+OwtT64/iG1HRbflW8paxwxIhEKw31SP5y2GgQVijoAkJ2s
         b71DBFDu1Z3svPkzfV5EQDd2rvEjK1P8Edei71rMIpATjjlQdx6P/BxKv9N4MnOq18A/
         qXqIJJB/51ENtewacY0OobryiGfc6A6sP2p5FCYmDOCPfqh+qiTWziCHXts2d5DiNhFX
         TI5ItFuzl/lHEMjUG6j9iOtthOVCs9ntbfgTG7FcR90CsXXQuzl4aAfbRxctW3BOSnsq
         qZ8w==
X-Gm-Message-State: AO0yUKUtxlrXYaZaUmhNf96/HQU2loVUs9WjPtA7q9mg8pSgP40xA8FA
	ILoGXzO60ZqhksyHGA2FAfLpuxdoLIctXg1E9icucw==
X-Google-Smtp-Source: AK7set/Oj+tLX8U/hST68wl7B1f0C1YUfNUX47nvVTGkaQU4uLbcwIbNPJrd8DgfOSwWicfwdgeWEA==
X-Received: by 2002:a05:6a20:a61b:b0:d4:979a:e31c with SMTP id bb27-20020a056a20a61b00b000d4979ae31cmr4888265pzb.62.1679491833104;
        Wed, 22 Mar 2023 06:30:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s29-20020a63525d000000b0050fb618800dsm2434248pgl.67.2023.03.22.06.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 06:30:32 -0700 (PDT)
Message-ID: <641b02f8.630a0220.b1bb0.484f@mx.google.com>
Date: Wed, 22 Mar 2023 06:30:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94-rt29
Subject: cip/linux-4.19.y-cip-rt ltp-timers: 10 runs,
 8 regressions (v4.19.277-cip94-rt29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 13:30:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11081

cip/linux-4.19.y-cip-rt ltp-timers: 10 runs, 8 regressions (v4.19.277-cip94=
-rt29)

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
rnel/v4.19.277-cip94-rt29/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.277-cip94-rt29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      26d9f86d942d1c22bb7542618e47ea5c0e6b4026

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
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/641af68a08d6212bb99c951c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641af68a08d=
6212bb99c9521
        failing since 126 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641af68a08d=
6212bb99c9521
        failing since 126 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/641af82f51a948cb539c950c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641af82f51a=
948cb539c9511
        failing since 126 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641af82f51a=
948cb539c9511
        failing since 126 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/641b02a8c603663f229c9521

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-tim=
ers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641b02a8c60=
3663f229c9526
        failing since 126 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641b02a8c60=
3663f229c9526
        failing since 126 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/641b008c9ac4421f8f9c9546

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
277-cip94-rt29/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/lab=
-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230317.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641b008c9ac=
4421f8f9c954b
        failing since 126 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/641b008c9ac=
4421f8f9c954b
        failing since 126 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =20

