Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54609C4332F
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 20:44:36 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.29882.1671655469642628616
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 21 Dec 2022 12:44:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=W17wlIgb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so3591994pje.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 21 Dec 2022 12:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c15QlxOb5nuPJT2mzUijPvF0eewLOHPyBOQ8UUE7tuo=;
        b=W17wlIgbADmbcBzQ799K2s/PvS7z5SIV4JXd2LeaqeAI1y5vlItJiBzRJx/tgwLt29
         SaB6wMGPOOODl7LCbiAqdcdVtPPZT87uwze88G3AndlrMpLLuE4qg/X38MW4irVgvFhR
         PEtFEcFjZKfB1+SJ8O7148IZgP7fT3o/H6oHef7bb76R3oUbodxTN6gRcA6YnOyrLsEu
         j9CcLJZ61DXrYdpKywRU7x1bNwKU+qM2TkKd28h7iHkCqpZcHyPwTe4Eprnp3y30InXu
         +SXO5gjEW9loHyUWZP4c9oeRGbO6yQhYo7Z7nc5LWG1iJNCy5zOKfqmbthcvoz2CwYNz
         REHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c15QlxOb5nuPJT2mzUijPvF0eewLOHPyBOQ8UUE7tuo=;
        b=v7E+XAr5dPoUusEDvi+n6n8NTg8NSoLK6fYsbKPImH/jZteLAj/Q2XgAeLbA8/ZPO5
         A3T6QjkM8DIsFtNwKX8AD9k4wiIW/qGAZSSGWqO17tWBFb+hJvPArVYkyEqGkF3SZjFD
         QVbeiO6xz7H4qlTbTQFeNNb65DMMEXj9JUNSzI6RiPpTyPbI+Tc5082mR33y2SlNlhxr
         eQEL+r7rvOqJp//4GiP1+Z5zvcq/45dKLLQACbwcBCA7/tQEKDWd+Wg03mWDbBcO59pe
         meq+9WkYRO6/5mR09zNCl8GgfCD/WzVd/Wver8Sw/IqgNjAsg3fABJszX4m77y8rDgAb
         Ui8g==
X-Gm-Message-State: AFqh2kqwP7G5jD/1Yuqz5bFv/n5/njNxqTPUJqsmBgglVNbCco3DDKkj
	AaXRurvYrP5KNSfKqyiGh1U6uu7Npk/E7H2KMyM=
X-Google-Smtp-Source: AMrXdXu8uRAJxdq8vCARAFmbnZ7ELMaD5TFl0I9h7CGWpY2H3R9qz+0/npLTLVnkJMyspo6oB/u7ZA==
X-Received: by 2002:a17:902:7087:b0:189:aab9:cd80 with SMTP id z7-20020a170902708700b00189aab9cd80mr3329274plk.64.1671655468716;
        Wed, 21 Dec 2022 12:44:28 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902c65200b00190eb20377bsm11877524pls.189.2022.12.21.12.44.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 12:44:28 -0800 (PST)
Message-ID: <63a3702c.170a0220.8a626.616c@mx.google.com>
Date: Wed, 21 Dec 2022 12:44:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.158-cip22-142-g79bb6f9db05d
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 14 runs,
 6 regressions (v5.10.158-cip22-142-g79bb6f9db05d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Dec 2022 20:44:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10261

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 14 runs, 6 regressio=
ns (v5.10.158-cip22-142-g79bb6f9db05d)

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

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.158-cip22-142-g79bb6f9db05d/plan/ltp-time=
rs/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.158-cip22-142-g79bb6f9db05d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      79bb6f9db05dca63bd1dd09dc84a45072dbc2ee9

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  9547e6a3a3dce0fce39215b54f4fe314de54a5a8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63a362462185de08934eee30

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221216.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a36246218=
5de08934eee35
        failing since 56 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a36246218=
5de08934eee35
        failing since 56 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C436FA-Flip-hatch    | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63a361bec002c15dab4eee6d

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221216.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a361bec00=
2c15dab4eee72
        failing since 56 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a361bec00=
2c15dab4eee72
        failing since 56 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63a364b88a903dd8784eee5b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.158-cip22-142-g79bb6f9db05d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221216.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a364b88a9=
03dd8784eee60
        failing since 56 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63a364b88a9=
03dd8784eee60
        failing since 56 days (last pass: v5.10.147-cip18-12-g7bc9523ecfb7f=
, first fail: v5.10.147-cip18-451-g87ba4bc77ca06) =

 =20

