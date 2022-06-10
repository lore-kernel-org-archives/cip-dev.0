Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D42DC43334
	for <webhook@archiver.kernel.org>; Fri, 10 Jun 2022 13:06:59 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web08.26846.1654866413892384028
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 06:06:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=tZF3Tx8H;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id u18so22756399plb.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 10 Jun 2022 06:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=mdvtdJDnFyR3QHCj7MLz0bK+DQotEjuAcHtPJq0gcFo=;
        b=tZF3Tx8HAMO3GjTqpYyvyCPcUoZFF5lf239c6wZZ7OgldFd0mWOaCG9q8t7R+bD4kU
         hRurLalgDY50k+qJIj6OpckAx0Q6Zaqj4fvFu7sKZmNToKJrPLQVBCOtiQF2w/htL9s2
         Rf5WyHVBZ+YvEcXDdv8RRI4cNGwOSYtR/o6BEJrRj52JXMgAxV7c4LqBS3YiOTmBPKJ4
         orQTF48JLaDk8uEuGdTmUH6ZAsKWRLuDehCU14gzq16PwiPzrB74L3ue/+R9SM9eZfAe
         RbpoC6Ic4dV62oX4FTexkz4SzfzEUOMa/Vj4pXQRyZ8qSbTcuzY4StHr8tfEKeAXwT6z
         jY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=mdvtdJDnFyR3QHCj7MLz0bK+DQotEjuAcHtPJq0gcFo=;
        b=54MGEZQ2yEGD6JIkNHZ+ZHJkmMKkhUrsr9kkFf6BTUnRTc0sQsiYntwcahHG8rsnfA
         2O1XJp+bW5u1ua6Yu9fHqVHjhlNxR4Io5Q1oxirskCP3Fr3PK2oku5ych0ZWA/TACEFg
         mz5iPXgAZNKOmLjLR4LrhB2pr4VjPNzTs3v/wPlUo7CFafu0SDgJaYgjKBrY1N3cyQsq
         g5/ZkG9XhbV/ywQdUrbJB8vr+QVh2seDt2C/ESkes4xba4AoUE0RV7MN29msUdcxN7Es
         XPZFgIjxDzqMasQl8foCCiZ4KDVLm4RuEVs7Qyu8QZCrEfhAzH4fRp41l048gikZKkA7
         236A==
X-Gm-Message-State: AOAM533btlrHLho8j/08HL/h6Lq44WavBiX784S80wMNw+eFoEI1gXFS
	vVA9EI7OdKLlOH2oR8+2IYK6GHjkTGmiczrpCAw=
X-Google-Smtp-Source: 
 ABdhPJzOkvvToZJr2la5O/BHO8UCsYrPUQ6tRKC5I+pFmzXf0LgVUgpfjkIHwS3mn7+8cnDNsC2cUw==
X-Received: by 2002:a17:90a:a605:b0:1ea:6b4f:915e with SMTP id
 c5-20020a17090aa60500b001ea6b4f915emr6557717pjq.60.1654866412845;
        Fri, 10 Jun 2022 06:06:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 s10-20020a17090a440a00b001e3290cc2c1sm1654379pjg.34.2022.06.10.06.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 06:06:52 -0700 (PDT)
Message-ID: <62a341ec.1c69fb81.effc8.2222@mx.google.com>
Date: Fri, 10 Jun 2022 06:06:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.121-cip9
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-mm: 2 runs, 1 regressions (v5.10.121-cip9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jun 2022 13:06:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8544

cip/linux-5.10.y-cip ltp-mm: 2 runs, 1 regressions (v5.10.121-cip9)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.121-cip9/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.121-cip9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bd24696dd7ad23517733728da675a00cd3073916

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  aa0d8ff94a7df8b63b81f185b261bc9f24bf36fc =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62a339b23d5ceec30ea39bf9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.121=
-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hihop=
e-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.121=
-cip9/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hihop=
e-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220603.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/62a339b23d5ceec30ea39bfa
        failing since 149 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

