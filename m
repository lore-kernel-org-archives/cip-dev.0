Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31E1C64EC4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 05:46:54 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.2305.1677044805077095885
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 21 Feb 2023 21:46:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0tu6TvEZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id e9so2559916plh.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 21 Feb 2023 21:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=shyP981bzq1c4uvcNWXQBbfRTArTEuBVOzcBjHijJAM=;
        b=0tu6TvEZDF+gMLVR5aeXtIg/w8kHTpBBE7ID571IocCwLRbjxJC4ohpMzwHF81IxGF
         6GLHTGvAMEUwt9l99LnP9uInyNu0dLasZutS4Bsw0sCzNFUaqYrsgaiyrzUqXe8fDzAm
         jEFPUvI3u+E9j5/4/exM8IqVhzG1pHrTghj7T8/ny1FKe614sGMr+APAvqbRZPZ4Txj5
         +wsI/ZQTOQ09GKUXReuo5kp89jYNI9xkSw4y7eLzW7u5oOK0dA9bPiZhVeMPnJ9OKN/4
         eC7po5N/hVF9mcPiyAubuxbekzKI7Um645H+qtKt2QQ7IknY3oSSEVqY3z0kKbHS07Hu
         Zaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shyP981bzq1c4uvcNWXQBbfRTArTEuBVOzcBjHijJAM=;
        b=B5rWSwYm0a7CeILgiFr7fBxuwDiiiihV20PzY1fPrnWOcik9d1nB/BaFCkLUSSQzoT
         AS0NX0Q/23NtpQ5i4VGOdeEFGNRnXkvhcMV8l2y1sZCp4CBkqtUd2wJiNTZ1l8E9fYad
         O1r1P2ERf7+fSaUKnppHod4OpZjuGLsddimBiIxLiuoNw7IobmBihmLPzxU7o0PW5vJk
         vc05ejXOuSlW9Ts/t6HWzp1MyGw9RKRlpY1y7v07I2rDn1KcO2oNZD68zu9rGzMTGP7W
         gQf9MCxL5mtT2xwXvaeLF/kvsavWap2MDjzXY0x0qeicPTuZgJlHCJcUhTKkm+Nf5Hwe
         5gXA==
X-Gm-Message-State: AO0yUKX6o2VU1X0LWwrW241Occvyfn2HxWrv41ICAM56Ty7xOIQ6LCn9
	hQjUs0K5ICg+q2YnMfLjcopuSL2iAWcnxXNX95I=
X-Google-Smtp-Source: AK7set+wZw/fzS52aW9HYNDspGruSVJue+hWh9qzZtEJZjsBHe4nCyYYaIj/EsNW6sta9UhxNv+0Rg==
X-Received: by 2002:a17:903:280f:b0:19a:ee37:40cb with SMTP id kp15-20020a170903280f00b0019aee3740cbmr5865688plb.56.1677044804002;
        Tue, 21 Feb 2023 21:46:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d2-20020a170902654200b00196519d8647sm1765671pln.4.2023.02.21.21.46.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 21:46:43 -0800 (PST)
Message-ID: <63f5ac43.170a0220.47bb0.3981@mx.google.com>
Date: Tue, 21 Feb 2023 21:46:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-2-g1e87e7748b91
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 5 runs,
 8 regressions (v5.10.167-cip26-2-g1e87e7748b91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 05:46:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10771

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 5 runs, 8 regression=
s (v5.10.167-cip26-2-g1e87e7748b91)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.167-cip26-2-g1e87e7748b91/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.167-cip26-2-g1e87e7748b91
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1e87e7748b91cc6ec7f9f32d6d156ee15f651805

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f59e07643c32f5048c8649

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f59e07643=
c32f5048c864e
        failing since 118 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f59e07643=
c32f5048c864e
        failing since 118 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f59b4ec043ee3e148c8641

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f59b4ec04=
3ee3e148c8646
        failing since 118 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f59b4ec04=
3ee3e148c8646
        failing since 118 days (last pass: v5.10.147-cip18-56-g87bd4289362b=
e, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f5a83860133f54d98c863e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-ch=
romebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f5a838601=
33f54d98c8643
        failing since 118 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f5a838601=
33f54d98c8643
        failing since 118 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63f59f5ac61408f3518c8647

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm64/defconfig+arm64-chromebo=
ok/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f59f5ac61=
408f3518c864c
        failing since 118 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63f59f5ac61=
408f3518c864c
        failing since 118 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7=
f, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20

