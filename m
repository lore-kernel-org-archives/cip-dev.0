Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BE5C77B7A
	for <webhook@archiver.kernel.org>; Wed,  7 Jun 2023 15:24:25 +0000 (UTC)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
 by mx.groups.io with SMTP id smtpd.web11.1045.1686151464378734272
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 07 Jun 2023 08:24:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=E44ltmOx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.182, mailfrom: bot@kernelci.org)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-33b1da9a8acso6239045ab.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 07 Jun 2023 08:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686151463; x=1688743463;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4cqOJIQJv+HWQkf3alj0cTEpcNJcSL+OgNfyh5/p/rs=;
        b=E44ltmOxozUL+5gEBoJTKJ/gF8luKtTm6i6Q2DPSu/8ettepizYNNGzQ23q2rKarAc
         CmC2S5tAQYDEYzwgv2F/enx8iWbxwmjYItTTm/ywfkuHTBk25oFBbN2nnNEyx9qJEtGT
         grXzF4VbR7dY1gAM5cBXBF7IMIlnj+MTu1gj6JnSR5dhlu4Sk6isbLIxK7iqZoP9PndX
         q2M0OKK1siO2lbqOGOp5rpG7N7OsZTB1+aOPVyJS1RNGBSozjZYnKQnW8xE1Ie5muTq+
         Na4XRCmTgCUVZ2SSLvQhR28H62fAqIODBDF7w+c4/2S9ZSNMAgKQswLh3J8/Hvn/hS5F
         FCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151463; x=1688743463;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cqOJIQJv+HWQkf3alj0cTEpcNJcSL+OgNfyh5/p/rs=;
        b=YpnEnMKg8/DFZgXbUdaQTfAo7Sesyyt4UZC7ZA/Fhnmeyu6T4yf2DJ4SpAToWstmRA
         EFIqh5Fftf94rN/UTek5k65RkGks3vn+WVHCCInqMCBYMw1EcoFWfO4HgPgSoGwIsxdU
         9R+1RgeCMP+6wIgGFjt+RoKvJYQHQ3LG1eKb7m6w8bgMcnNat4jNXbeDlw499VWkuGLl
         BQ0ZuayTAn74uZ1tUezL+pHrk7Q2pFq/p0L2TkUGAuBq9NXXQZf9pXW8qWGKdYNRKRQR
         XQE9BfHVlSBnWBKCMbpqNKee0BUQ/j8NSbuB1Oqyuy9UmWzc83JP51PJSCg+ToZprnWY
         z+eQ==
X-Gm-Message-State: AC+VfDzcGJjkr/bPdJIILX8CiNn295BKRsTcri+pwYw6GO1JijA+SvKX
	LJkz6yYbzxO2o4pT5H+V4tCDqLDHLg5XqEwFHcXCfQ==
X-Google-Smtp-Source: ACHHUZ7NSnPscIrY+CKLTl2m3Ihu5l2u7k8DUra/2ShitYMOxZ+hSu6CGj2vSrfsvsNfm1lna8BuDA==
X-Received: by 2002:a92:ce41:0:b0:33d:136f:249f with SMTP id a1-20020a92ce41000000b0033d136f249fmr6237036ilr.22.1686151462724;
        Wed, 07 Jun 2023 08:24:22 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c3-20020a656183000000b0053b92b26412sm8353889pgv.14.2023.06.07.08.24.21
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:24:21 -0700 (PDT)
Message-ID: <6480a125.650a0220.6db41.fc85@mx.google.com>
Date: Wed, 07 Jun 2023 08:24:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip74-rt43-218-g246f4be89a77
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs,
 1 regressions (v4.4.302-cip74-rt43-218-g246f4be89a77)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jun 2023 15:24:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11923

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4.302-cip74-r=
t43-218-g246f4be89a77)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip74-rt43-218-g246f4be89a77/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip74-rt43-218-g246f4be89a77
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      246f4be89a7760f90649094cbfabcccfce7dafd1 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64809532c34553124330614c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip74-rt43-218-g246f4be89a77/x86_64/x86_64_defconfig+x86-chromebo=
ok/gcc-10/lab-collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/64809532c34553124330614d
        new failure (last pass: v6.1.26-1320-g1ddf4b637f785) =

 =20

