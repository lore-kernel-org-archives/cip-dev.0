Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC2C10F13
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 10:52:52 +0000 (UTC)
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
 by mx.groups.io with SMTP id smtpd.web10.5800.1702291970755457238
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 11 Dec 2023 02:52:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MxI0XkCU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.41, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5908a63a83fso2019623eaf.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 11 Dec 2023 02:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702291969; x=1702896769; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NSAaIQ8AP4hwqJtX3he0BQX/jmb+Yy24Fad6JzkyZrU=;
        b=MxI0XkCU7vb0ch5huuVc7dpJNJvZQe9YMe/f0XeDDwyqmcru41UC50D3jg78M4uipT
         xXBFeBFYOtmX5qQdsAAPXe/9rATaMRLdpomspFmFwCTThzIJQDAM1XzFn0xWUFd+SvS0
         hJ0oyuQa7rO5uYcZHP2eUI3bhX+fvziM65baxzLgBnjl9HUuBUCS5VowWuyNbPilX+v1
         F8bS6NmY0cfM1Ga9l/SGsjpAMQ2JyqmxFOzxXt+WcYfn+SGKDS8siUNl3bRs8aNND/Pn
         AXjV+bKIReQDAhokqFGbgrtUwaTEgZf5I2ksWl81/vwGg0ufSSZcFsiPCj1uWbyAfbmd
         ydcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291969; x=1702896769;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NSAaIQ8AP4hwqJtX3he0BQX/jmb+Yy24Fad6JzkyZrU=;
        b=H2DSH4p+vK9VRrsF+n9nsS3pBQaKR6xRli3+BH/VGeeWVZHTc5SvzlENeTUJrtz240
         p2di4RR66MjuiQklBXpGEAu19s4nb7bDra+8Wjozg8Kid+qPamkExf4BjsVzoLe6UXfK
         bJt6wqS7yhl7frNcfhhYnJzpeOUyw5bTovWooTR08igbxcNmB7BGO4Uc6xfF325JFDBP
         egnEL0RgjmdgDt6JQWHki+toNCyc9fT3yWLz5PVq/HLN5NnXgIV2sX6+23cZsp7rcq2L
         pKjgH/mmKLOTNT+MMTVBT8k7bETkzgbU15REP00/33ahqSJyFMr+utBkoFPiuZhULp/L
         6aOQ==
X-Gm-Message-State: AOJu0YyR3pYkat1hWWhvzCnLX9yUpqtOpd7M+Uwtyt4Mb5+r0LfRDksG
	bOh6xEjqKMyRm8PHAa3mwcEAxaumoC6JNNHgJKlnsw==
X-Google-Smtp-Source: AGHT+IFiZkLVXYBeXVZvMVjEFvdgCP+A1gR+IB5ZvoT6it1NZwYVKfncQV/v+aaSkwUtWaIPRGSP2g==
X-Received: by 2002:a05:6359:594:b0:16d:fc9b:f6b7 with SMTP id ee20-20020a056359059400b0016dfc9bf6b7mr4018355rwb.5.1702291969473;
        Mon, 11 Dec 2023 02:52:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fm21-20020a056a002f9500b006cea0fd9afdsm6174569pfb.92.2023.12.11.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:52:45 -0800 (PST)
Message-ID: <6576e9fd.050a0220.62160.0329@mx.google.com>
Date: Mon, 11 Dec 2023 02:52:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-gfdfe1fbf93bc6
Subject: cip/linux-5.10.y-cip ltp-mm: 5 runs,
 1 regressions (v5.10.201-cip41-63-gfdfe1fbf93bc6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 10:52:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14015

cip/linux-5.10.y-cip ltp-mm: 5 runs, 1 regressions (v5.10.201-cip41-63-gfdf=
e1fbf93bc6)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-63-gfdfe1fbf93bc6/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-63-gfdfe1fbf93bc6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      fdfe1fbf93bc6fe6ed2708f11c2613bef556fdeb

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6576dd56f85e8a4ee5e13488

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-63-gfdfe1fbf93bc6/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/6576dd56f85e8a4ee5e13489
        failing since 698 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

