Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A63C7EE23
	for <webhook@archiver.kernel.org>; Tue, 30 May 2023 15:36:08 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.532.1685460961732798861
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 30 May 2023 08:36:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=pRj9KNIj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b041ccea75so16364625ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 30 May 2023 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685460961; x=1688052961;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HLzFnHywvASR5Xki+bi6wemEZ7Nn6R7IZLhtJMJpy/g=;
        b=pRj9KNIj3M+tk6EKiQ0K0KjWy0YRbWI7CoHb+jefeLoe6dD+G5EFABkSlowJDUyom3
         HCuoKHOftFHvjuM/iL1rJYnz6KnTbnqYwNABLZMC601aHGppTcuANBV7UlpRRl2jqpmB
         0VJR7K2Eg+8x8T9bUxT0uh/lIbQgpWhJvUsKeu7P89pat2DOZoXMeWTvxOTJMOiVoB80
         ndGZaiQhh2a1PZYaDMFT9IPIf618Nc0+oM+/vDYSZpQow/0JrAdRjm3I5BO9YkBfQ1SQ
         6GKN8xA06FnxaoECd2i33x5NBTtOAR0kRVKkC7RiYrbZRXyp2jA2VkOPqKoOT9qE0Vd8
         FhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685460961; x=1688052961;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLzFnHywvASR5Xki+bi6wemEZ7Nn6R7IZLhtJMJpy/g=;
        b=C64GMfEvDyHdTfLpPLw6YcDNnGT6KOxDe68d13wxCi+FVgEQd7qqkCSDyDd9VKxjou
         ME6k7cV6aIFl7qT76RBIn/n8Piw5OJDo2eIboJA5F+jKamfLH82r3lj52eCuwA47ftm0
         xJ8/KpE12ZPjqHwcmuI/FsDSXsd9JwnOf/pPwM8fdk4V3g4G/3O9zyN7DtvezNRDZhBY
         MdQ0bOKjl3aQR/gNazIsNbVBZuHo7DStnkRQipC/7k+tg8WDlUZGSvMsb81e0HHHYDs2
         4w4OfPZ/tw49e4kj7c+TyUbxQBAyxqHLQ888S3Daalt7oLNpJ6+ad6yRJ+NbhDXTTyJi
         hXnQ==
X-Gm-Message-State: AC+VfDy4UAC3G/EymSupAjzKQywt94DcL2ndagtkscPcV2oYAMusxHvl
	5fLuEYCyJYlX8+QmUrQE4s3UFu+auMlpWrMhowL4mA==
X-Google-Smtp-Source: ACHHUZ7CbxxbY/S52austQdzEbyL1dOoYv/TRv/sks51gtj4yWdzhUSO72SSMPyJAsdSFyFdTDHkIg==
X-Received: by 2002:a17:902:f682:b0:1af:a058:cc2d with SMTP id l2-20020a170902f68200b001afa058cc2dmr2961049plg.57.1685460960667;
        Tue, 30 May 2023 08:36:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b001b05e96d86bsm1746932plr.162.2023.05.30.08.35.59
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:36:00 -0700 (PDT)
Message-ID: <647617e0.170a0220.b65e7.3202@mx.google.com>
Date: Tue, 30 May 2023 08:36:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.283-cip98-135-g4ed206c5dc11
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 8 runs,
 8 regressions (v4.19.283-cip98-135-g4ed206c5dc11)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 May 2023 15:36:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11704

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 8 runs, 8 regression=
s (v4.19.283-cip98-135-g4ed206c5dc11)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =

r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =

rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.283-cip98-135-g4ed206c5dc11/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.283-cip98-135-g4ed206c5dc11
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4ed206c5dc11f3047430e9e28f6b0ba48980512a

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64760b7c8a4ac1faf12e8643

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64760b7c8a4=
ac1faf12e8648
        failing since 207 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64760b7c8a4=
ac1faf12e8648
        failing since 207 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-11A-G6-EE-grunt       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64760b8ede9961163a2e85f7

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64760b8ede9=
961163a2e85fc
        failing since 207 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64760b8ede9=
961163a2e85fc
        failing since 207 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
r8a774a1-hihope-rzg2m-ex | arm64  | lab-cip       | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6476152122acf9a9fa2e85e6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6476152122a=
cf9a9fa2e85f1
        failing since 34 days (last pass: v4.19.280-cip96-59-g4b02e7efb967d=
, first fail: v4.19.280-cip96-89-g355dfa824cb4) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6476152122a=
cf9a9fa2e85f1
        failing since 34 days (last pass: v4.19.280-cip96-59-g4b02e7efb967d=
, first fail: v4.19.280-cip96-89-g355dfa824cb4) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
rk3399-gru-kevin         | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64760fd498513427442e88b6

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.283-cip98-135-g4ed206c5dc11/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64760fd4985=
13427442e88bb
        failing since 87 days (last pass: v4.19.273-cip92-14-ga8d1f73f2a28,=
 first fail: v4.19.273-cip92-24-g2070ce514972) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64760fd4985=
13427442e88bb
        failing since 87 days (last pass: v4.19.273-cip92-14-ga8d1f73f2a28,=
 first fail: v4.19.273-cip92-24-g2070ce514972) =

 =20

