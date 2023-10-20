Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B93AC0032E
	for <webhook@archiver.kernel.org>; Fri, 20 Oct 2023 15:22:39 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web10.57066.1697815357005080050
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 20 Oct 2023 08:22:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=a15ui0xB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.171, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so815690b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 20 Oct 2023 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1697815356; x=1698420156; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6DceSpCm1RKtyPur3KSw//1mymnRPOQlidjZA/EKERo=;
        b=a15ui0xB5kQhNEpBg3Sz9en0Bbz1K6GnGYXLmUrJq9j7bNdfd3xuIdWPdxHJzBjQ6k
         kxkBi5y8EqgziOuCXunL2/zPZRhHUcMhIxQSwfM6uA65wjI004rfzwQW9LK3IWLKbfYA
         Odx2UTz9zQMigLsvNoUo7vXmy4ej9wD7vKEsa+PZ8+fdlgjQwqijiW3YlevBuSN8UNWV
         GO+1/tYiXVJQcNnrOg1T7U3R4c8zGFwBX4MI6BxcF99vLinBifmU5B5PcAwpZ50EI6qD
         tXktk6WQGcw0xgaOK9rjqVlXfestbJq4aIFh0e8oovNQW84T4YS5UQnDQ4wmFWKZku1x
         ZMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815356; x=1698420156;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DceSpCm1RKtyPur3KSw//1mymnRPOQlidjZA/EKERo=;
        b=LdHtM9zIklMp0dsD6Q08I2txolXmchzdjev6FbpBzBmLhur8jByCPsU8Rg+na5JeOU
         yaAngxBm7IcEJkpHor9ToSQU0+eO9wzqH4LsXsksfyDcyqjmgyV3rlRHhXYkAouw0LwG
         kULRVapLX1UTR77dDxC7fMWnKeiRfH3ifGaYcdpc+p7kokauwzza9Wg0PE4VAJGdh3FS
         6Eh8LFrWEni9f6Knx1IVS3o5djMX7lCcpiK06ZzW/vzRRPlJOMWrWg8i3p2zaMPCJJ2T
         KtrQUXIBp5w7CjQQ5ewjfWfOaBhYIhlHF7SxKRGBMe8d2m/rlGtE9BmVZrNXFvnY++Cs
         kuTA==
X-Gm-Message-State: AOJu0YzHjcTb5BRI17hA3G88gwWzTReOWOOfn/PUCP2ZYhw+Indm7owu
	WeQG5PzXoDNDAKRznOcc5VFx1ZA5B+Bp9aTRPyOzSg==
X-Google-Smtp-Source: AGHT+IHsfaM2Q9RHS6jtDONa75B0Zb0DbRAmh4FFUwlak5lvUKLx0pkje/EePj7/5bX9NPxP3QRF+A==
X-Received: by 2002:a05:6a00:158a:b0:6bd:2c0a:e82 with SMTP id u10-20020a056a00158a00b006bd2c0a0e82mr2363901pfk.7.1697815356021;
        Fri, 20 Oct 2023 08:22:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id i3-20020aa787c3000000b006be047268d5sm1717446pfo.174.2023.10.20.08.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 08:22:34 -0700 (PDT)
Message-ID: <65329b3a.a70a0220.3a860.5ea4@mx.google.com>
Date: Fri, 20 Oct 2023 08:22:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.19.295-cip103-rt33
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.19.y-cip-rt
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip-rt ltp-timers: 10 runs,
 9 regressions (v4.19.295-cip103-rt33)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Oct 2023 15:22:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13418

cip/linux-4.19.y-cip-rt ltp-timers: 10 runs, 9 regressions (v4.19.295-cip10=
3-rt33)

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

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip-rt/ke=
rnel/v4.19.295-cip103-rt33/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip-rt
  Describe: v4.19.295-cip103-rt33
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      28d064262557c550e33da563b323e56c214e60fd

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/653291dc653283f70befcf38

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653291dc653=
283f70befcf3d
        failing since 338 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653291dc653=
283f70befcf3d
        failing since 338 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/653290f1c826027a83efcef6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ti=
mers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ti=
mers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653290f1c82=
6027a83efcefb
        failing since 338 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653290f1c82=
6027a83efcefb
        failing since 338 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 1          =


  Details:     https://kernelci.org/test/plan/id/653295fa2216b0c888efcef3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/653295fa2216b0c888e=
fcef4
        new failure (last pass: v4.19.280-cip95-rt30) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | defconfig+x=
86-chromebook     | 2          =


  Details:     https://kernelci.org/test/plan/id/653290f7b4f471be3aefcef6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ti=
mers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-ti=
mers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653290f7b4f=
471be3aefcefb
        failing since 338 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653290f7b4f=
471be3aefcefb
        failing since 338 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...k+preempt_rt | 2          =


  Details:     https://kernelci.org/test/plan/id/653290f807ed619fa9efcf06

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+preempt_rt
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip-rt/v4.19.=
295-cip103-rt33/x86_64/x86_64_defconfig+x86-chromebook+preempt_rt/gcc-10/la=
b-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653290f807e=
d619fa9efcf0b
        failing since 338 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/653290f807e=
d619fa9efcf0b
        failing since 338 days (last pass: v4.19.245-cip74-rt25, first fail=
: v4.19.265-cip85-rt27) =

 =20

