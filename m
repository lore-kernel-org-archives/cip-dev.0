Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1716E743DA
	for <webhook@archiver.kernel.org>; Fri, 29 Sep 2023 01:08:40 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web10.8450.1695949718925478597
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Sep 2023 18:08:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ocASCjtr;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c61bde0b4bso79227705ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 28 Sep 2023 18:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695949718; x=1696554518; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7J5Qz67E9Ze3hN5Low2LKWjY5wYOPDjTt1XITlBr3wk=;
        b=ocASCjtrP6GLm55JmaiGB/9tQxYxSQKyyjEIV3LYiLsmteCHvlqp0Hjh5VDt/b1Ig3
         VLGLQs10QAUYCLuMQuE9vSnrKJ1USa/GHP89vffJvjP7s/wqq30Tw09XOnbwhkLErKsb
         qL9I2aiSwOG2SaCg3D2e4JJGfG1Qx4iuhhLiaGTunGohHYqbZRxvvKCPYo0JRgXJCiaO
         4K94fiMog85KIE8pawqwSwddpY2zprHGkuF+dEJ4v/DcM6C9Y3YBU6nlKrvC4BKeJLSZ
         jCKIpjq903YmroTjk/3epx6ABLtZZt97dbkQEb7RBo8rofTaG8/JVta10ZQ7d3QblcDE
         la7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695949718; x=1696554518;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7J5Qz67E9Ze3hN5Low2LKWjY5wYOPDjTt1XITlBr3wk=;
        b=WquUvdhqwXl/OYhNY5fPGan7HrvnvkrA9d/k33NaA4DcvtOlDdb5TBstVbVr97qR0d
         UUCA7gyTSd0uJ1tqm46QiWp2c/g7+uu2BFJAvzwVq4ySsb8OaIT4d/xwhdpu3T8dULxR
         WSwMILsKvSrFhZ43dWjCfacJubw5UjUQxJ39nIWA13av/fnDl+HvdnpwnxXWU7q2XO0r
         ZHcP6t17UV2k7AM+BUPe6+SIoNemfaTHia3xPk+PbmIDJt6NU/7OYl4Mb5skcvLN79ug
         9aqPI/GjBFIglEpswXRQxoSJh6CZNn/2J75flO9R5msJ8aqVIARBLgK6BWp2hHb9tpRP
         hHsw==
X-Gm-Message-State: AOJu0Yw5dYch3lmm+ZtBPbrObuzuKDW8QNlnj/CRrH3Pd2/Hx/A+N0s6
	s+4fkuQb4BlNNgDRablu576WKIum4XC4YNLBLmfmSQ==
X-Google-Smtp-Source: AGHT+IERH/VEBjbGedsmKR7ym0Hf4l6wJW8a8k/93biqE0msVmRr1gJK3RtkJthS/F7E46q7dKWyEA==
X-Received: by 2002:a17:902:c951:b0:1c5:db4e:bb2c with SMTP id i17-20020a170902c95100b001c5db4ebb2cmr2774317pla.64.1695949717964;
        Thu, 28 Sep 2023 18:08:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id y16-20020a170902b49000b001bd62419744sm15574319plr.147.2023.09.28.18.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 18:08:36 -0700 (PDT)
Message-ID: <65162394.170a0220.340fe.ed1c@mx.google.com>
Date: Thu, 28 Sep 2023 18:08:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.295-cip103
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.295-cip103)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Sep 2023 01:08:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13250

cip/linux-4.19.y-cip ltp-mm: 6 runs, 2 regressions (v4.19.295-cip103)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.295-cip103/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.295-cip103
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f0bb9fab6f834f73d3a71af029f5bda19d99b33c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65161ef18dc4a544618a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65161ef18dc4a544618a0a43
        failing since 621 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/651622632ec6fbaa468a0a6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/651622632ec6fbaa468a0a6d
        failing since 621 days (last pass: v4.19.222-cip64, first fail: v4.=
19.225-cip65) =

 =20

