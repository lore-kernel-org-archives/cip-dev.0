Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A398C7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 13:36:01 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.75.1686058554375305617
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 06:35:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=3Ti5nebx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-256d1b5f7c0so4564540a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 06:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686058553; x=1688650553;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1YdvmT5mlnl74X24per+xWyFW9c3j6KpATSz3Gk+X2A=;
        b=3Ti5nebxN0+TtBWCwHrmSWgHooQMgkH1HDW/CKF4z2E/EamYfx5uFsEH4JDkLIAzJU
         S9LMqolj9nyZojWT+rU/VqAPr1XuWz0AP5+qdbKb8vnGa7MHWyxqrHfQMjUtkyGjf4BT
         NSoeV1bnPuKmrjdSfqreI1PCYjqfsPSLpj48Fzw1HTlGDlm8VqXBHBHz1+Xf3D341lVp
         ir0IHWpgQHB4CAPXeLXzh1b3SK5Yz5qNy8V1wVb5B+TJGLv4h7+A/C9pbN6aaD425nbc
         g8wBuo4q6PfgtWmncQ0NQ7GdYbqKqCBdXQtwfYaxLPu/VkqFPjSsppDm0jmlB4KyU9FG
         TceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686058553; x=1688650553;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YdvmT5mlnl74X24per+xWyFW9c3j6KpATSz3Gk+X2A=;
        b=Esp8rbWEmDVsyEXqBOhQd/e8tmyKtUQS1y0sSljHV8iMoQuyJWuqdV5bOl4JQX6fl1
         Kj4OW0ICxW/2QxBUuX9DYPyp9AuLup6snQoScZ5BQegX6Bob18/rhLqI7AdW3fnXN3o5
         L2H5B5SxBTCnThRsSYYhmvrveO5FoxRaIqMj5rmRGfDbojGPUlnUUpiIjq9Xpnu1LM9X
         SNEvdOAW6sZ3WTJydgWRXSzDSO5hm/lYX2rFF+TRKGLUuLYL9ePEs2SzfVchMf5QrMKW
         Bj/ycNpTtOYDHBGvVdYuZHHYk8SyfR/LY5Qx+wcVkW7Lxdk4OUXajn8Jxe/NLcRZGm4N
         I5ZQ==
X-Gm-Message-State: AC+VfDzweHkByrgXml6jl3ai3p5/l0nmh/x5VM+nMJQVqBq/ZifxOaiv
	RzAddH3c3taEwt8d0VlcbfSr6SF6NfTQGSd+ViYeUQ==
X-Google-Smtp-Source: ACHHUZ5VbLAWCUM+2soeQV88i2MGto9LZ67dh9uqfozpw1MWVZx877FfZdKQgwMK7S2wdyYZT9m8oA==
X-Received: by 2002:a17:90a:8545:b0:23f:962e:825d with SMTP id a5-20020a17090a854500b0023f962e825dmr2742764pjw.1.1686058553159;
        Tue, 06 Jun 2023 06:35:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a035600b0025881710840sm10081411pjf.20.2023.06.06.06.35.52
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 06:35:52 -0700 (PDT)
Message-ID: <647f3638.170a0220.3e8f4.3521@mx.google.com>
Date: Tue, 06 Jun 2023 06:35:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1320-g1ddf4b637f785
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 8 runs,
 1 regressions (v6.1.26-1320-g1ddf4b637f785)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 13:36:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11885

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 8 runs, 1 regressions=
 (v6.1.26-1320-g1ddf4b637f785)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1320-g1ddf4b637f785/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1320-g1ddf4b637f785
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1ddf4b637f7858373296265fe09135a077008de6 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647f2e3899dbc7052df5de3c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-filesystems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1320-g1ddf4b637f785/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-filesystems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/647f2e38=
99dbc7052df5de3d
        new failure (last pass: v6.1.26-1321-g3152fb7c8d2d6) =

 =20

