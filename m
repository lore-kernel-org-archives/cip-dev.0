Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3791BC05027
	for <webhook@archiver.kernel.org>; Sun, 29 Jan 2023 23:00:24 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.28537.1675033216916605244
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 29 Jan 2023 15:00:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=v9zdsEGT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id z1so2330075plg.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 29 Jan 2023 15:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YkOi1ABo9ACSiMy6lzuDZHXsvTkHxLuzOnig2k0q7yM=;
        b=v9zdsEGTKC2WfyGIfuLR790NXyuqCkoZ1YKTNYBSpysez5ISdNxjT+ZMUVuwZZH1pF
         53piK4cHDCSkoPpKxXDkooh0/QVpk/c+bANhsfUq1KcuRX5l4pFaKh6y2h+3BlVLkZ0z
         TlfZyayR/KOiJr+q2dJrXPXUwSiQg2RmH6hXEkEJt/IvWRCvzt3gfaNMJU7jifMh0/sx
         HFiywkRQclK2o5cp1SlW3P1wdFQ0NwVUHRuqdHQlNvdjeuacnXZEGn63TpCaLx/Cd7i2
         sP3WMPkJZb1Mkxp2UgSCOeY2ruG4GtSySKzLLj/wBLyHDiLGTzsLth6I6QRQoo83QqDy
         yMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YkOi1ABo9ACSiMy6lzuDZHXsvTkHxLuzOnig2k0q7yM=;
        b=Nc2tnThe2tu8RZ7TDrKcezzHN9EkFGi/8XnKF7dbFnLEakFP67WVfNMsPKARW56H+Z
         AUv3l8r8bewJQLUr5pADSJaHL0mRWyPhpIR87TUcIwy0i5tvDYBu733o4PKn7395Fp/B
         yhE3u7ZbpoCaaHWa47jUR6Qe8ZVwDzaiAZs8wyl3bvm2jYPNswubvVZ5bgJwqZanQgjy
         7Xkir757MaOGdwEvQCdrfOamhet2gtFL6xOrAFXXIkqrioIpK1j3bfvSyqxKJcPm3xFh
         6PIi7slrlSPeH+IWufhr8kPBOwHOuqB3t7V0r3xuRwoP1ns56mPzINy7U++Jp1FcFagq
         67Yg==
X-Gm-Message-State: AO0yUKXAE2e3IV4jPyd0IKjS7Z3nVPaykOthzsGJ/6lDmTYc7d1ysyeR
	pyliBrDHo6y1q60NMxmooIXLcTxjHtTwO4SRRoVWAw==
X-Google-Smtp-Source: AK7set8RmrbOGIybRdGOhgJQ5EGXe0UY1aDJWC9MSCrSfDyzdh1Bkjcl4fTeYWmL+OBzHU/gURyREQ==
X-Received: by 2002:a17:90a:7348:b0:22c:93a6:abdb with SMTP id j8-20020a17090a734800b0022c93a6abdbmr3198477pjs.7.1675033215723;
        Sun, 29 Jan 2023 15:00:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a17090a384b00b00226369149cesm8315770pjf.21.2023.01.29.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 15:00:15 -0800 (PST)
Message-ID: <63d6fa7f.170a0220.5cd29.cdf0@mx.google.com>
Date: Sun, 29 Jan 2023 15:00:15 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.271-cip90
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-timers: 10 runs,
 6 regressions (v4.19.271-cip90)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 29 Jan 2023 23:00:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10502

cip/linux-4.19.y-cip ltp-timers: 10 runs, 6 regressions (v4.19.271-cip90)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.271-cip90/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.271-cip90
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6cd0670e124d09e80f2daaf2ecb13922a603f30d

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
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63d6ef0b385a085ded915eb9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d6ef0b385=
a085ded915ebe
        failing since 64 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d6ef0b385=
a085ded915ebe
        failing since 64 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63d6ede8d7dd3314e8915f2f

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/ltp-time=
rs-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d6ede8d7d=
d3314e8915f34
        failing since 64 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d6ede8d7d=
d3314e8915f34
        failing since 64 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63d6eea33edab3bb48915f0a

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/ltp-timers-rk3=
399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230120.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d6eea33ed=
ab3bb48915f0f
        failing since 64 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63d6eea33ed=
ab3bb48915f0f
        failing since 64 days (last pass: v4.19.259-cip82, first fail: v4.1=
9.266-cip86) =

 =20

