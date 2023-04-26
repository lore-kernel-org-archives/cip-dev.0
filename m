Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21338C77B78
	for <webhook@archiver.kernel.org>; Wed, 26 Apr 2023 14:24:19 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web10.9346.1682519050567170816
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Apr 2023 07:24:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=ly6fkqoO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-63b35789313so5193688b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Apr 2023 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682519049; x=1685111049;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t5A35oRujJpDwu1cLnIGzAje5vbt0keQO7OmWqjkIsk=;
        b=ly6fkqoO2qSZ1E86nDb/x5Yp02Yy5StTV9cWapScE62U/KOb7IIkHlkfEkQfyL5YL+
         sEMxRQ2jajxHm8jzTzFzKXfnrUUV67FBMKUY+lWCa/DbPzmeeFgZ56X2dtorwjct7ZZp
         6hYpEF5+mO5YeuHEdkTsZ4dPA+0Rz0fsZa/1exJamTHNLtrrQucV5P2faPP5Pl9F7uD1
         RUW/jbxid3oPCUu3Kjyx5CAwJu1FDYjP0K8J+orCVepdLomNPPe2m6+sKguOrYIxgBos
         TBWMl/hk6ou+sM71W2YrGQr9Hmz3eFqUZ//fj+37ssqvo08deX2d9inm+yuw73VUFxHx
         Z9CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519049; x=1685111049;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t5A35oRujJpDwu1cLnIGzAje5vbt0keQO7OmWqjkIsk=;
        b=PdE25VHtmfI/fac0t4sImBryVfLyBgvs5UrE2i2Ynq85sCJFEN1tQr9KGlE8h0JlR2
         CQvRT+EMl0vMU2PiGP6bY5+ITWD/c7fBtgZWvgEt8d1UvB2si/F8LUgJGMfInsDY7v+I
         WPfntWWUeav4IxgIr+NQ8JOLFTUyFkrbZXYsF2U7ICmntZd90fLD2WiitPmp4VXMfU5A
         U7wbV0UBjJnG4RG3EgKPXO32VHQIUsISlb2B6WkJBNvmKOntwFsHQANoa3Eq4V/Uu5Rn
         0ni72VTsq06WsrkLvHH6h0EZUppW8E8YtkF1GVaV6n6a2Yd7E7nJbZqWyV00s4B/JD//
         9CTw==
X-Gm-Message-State: AAQBX9dBOJ/2gT5NfsG3dhM+NrwIClX57zc4bKBooR4inPg5AlmXLLnm
	/0RaSAVFEj7OcuO3gM3Xo0dUEJiIhGLaq8YwRPzZfg==
X-Google-Smtp-Source: AKy350aZWMPMjX8hCENa3C1CRXjGdF9Da+fy1GTyzOAnCewibWE9qkeIbVc42orlnOOIEco51oGuSA==
X-Received: by 2002:a05:6a00:134a:b0:637:253a:531c with SMTP id k10-20020a056a00134a00b00637253a531cmr30500462pfu.27.1682519049465;
        Wed, 26 Apr 2023 07:24:09 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o21-20020a056a0015d500b0063b87f47062sm8079685pfu.127.2023.04.26.07.24.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 07:24:08 -0700 (PDT)
Message-ID: <64493408.050a0220.ca3e5.f9a1@mx.google.com>
Date: Wed, 26 Apr 2023 07:24:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip96-89-g355dfa824cb4
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 8 runs,
 9 regressions (v4.19.280-cip96-89-g355dfa824cb4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Apr 2023 14:24:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11358

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 8 runs, 9 regression=
s (v4.19.280-cip96-89-g355dfa824cb4)

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

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =

r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.280-cip96-89-g355dfa824cb4/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.280-cip96-89-g355dfa824cb4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      355dfa824cb4c11c1525b77bd5e76e4c0733b7c9

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6449268e99f5c156b62e85e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6449268e99f5c156b62=
e85e8
        new failure (last pass: v4.19.280-cip96-59-g4b02e7efb967d) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/644924f1acb27b0da52e85eb

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/644924f1acb=
27b0da52e85f0
        failing since 173 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/644924f1acb=
27b0da52e85f0
        failing since 173 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6449270c46ba0b51b92e85ec

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6449270c46b=
a0b51b92e85f1
        failing since 173 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6449270c46b=
a0b51b92e85f1
        failing since 173 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig  =
                  | 2          =


  Details:     https://kernelci.org/test/plan/id/6449275d09134c529e2e8634

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig/gcc-10/lab-ci=
p/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6449275d091=
34c529e2e863f
        failing since 21 days (last pass: v4.19.276-cip93-5-g2eb2a953ab59, =
first fail: v4.19.279-cip95-86-g16c082d0be46) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6449275d091=
34c529e2e863f
        failing since 21 days (last pass: v4.19.276-cip93-5-g2eb2a953ab59, =
first fail: v4.19.279-cip95-86-g16c082d0be46) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex  | arm64  | lab-cip       | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64492b31503efa64422e8629

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.280-cip96-89-g355dfa824cb4/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-cip/ltp-timers-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64492b31503=
efa64422e8634
        new failure (last pass: v4.19.280-cip96-59-g4b02e7efb967d) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/64492b31503=
efa64422e8634
        new failure (last pass: v4.19.280-cip96-59-g4b02e7efb967d) =

 =20

