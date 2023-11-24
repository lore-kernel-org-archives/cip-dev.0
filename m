Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6BCC61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 11:21:56 +0000 (UTC)
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
 by mx.groups.io with SMTP id smtpd.web11.133515.1700824910551083072
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 03:21:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=XEBMSiC6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.179, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c186f027cfso1170327a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 03:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700824909; x=1701429709; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iAnbyBrGqypQgKopY3KHErIQ+USStdopZfks1RYrazw=;
        b=XEBMSiC6FIXmsWRYXiHl6P6MLgz8Bz58rlRlBIvY8Yvdw575lQfOC3ujHbRH7NA7Od
         SeO1AVqsOt+BMx84CyCfCxYehhcJeFE/BJJGGILxGF+Py9lQQSGFgBNB1BJZJDFjp4oS
         cf5OMcUFYkpYutEwSI1SjDHDvDx01jDuvrIoh4JyZT3S5hTXjGSrAg1UM1Sg1qwnEimb
         DZH85MUmodECYzqRHYPqE1hrnL8nEbQSIeL5qyH1AUL5D2beQyudEXvD2UKNxfdXoD2O
         j6hrUM3r4fszPemXm26mUxIjnsCETZa5Gdau7AH9j5sWLHt5NrabTnlL8NzYAx5n/DeE
         HMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700824909; x=1701429709;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAnbyBrGqypQgKopY3KHErIQ+USStdopZfks1RYrazw=;
        b=iKzNNBtCrY7k3IrxrfHAF9nz++h8HYKjyCHlO5HUk3ONqaDI6z1XySuMp8QJ8E38q8
         o/c5dva7Hn2C7RX0ukfVRoScRTNTi8777vc23HpWJJdMM8lxOaXINqKMfQcJ4Wtyinpb
         H3zEg5ibCoIwE0z0qMTvIUGRrg6XpPwx4VFm9ssxFwb3mAUMBWXksQzQXOM4cegdZp3/
         I099cb/Mduqp2KjlITTW3vrVGiNsoVWxnR8k7F2c1dd/KWlvSclijSxzkVoAHXAfziV1
         YIZ/OQuoe1W324X8b25ml89qvF11zx54Orlkvd9M7KtZVSKeWyKDvQjzOAWc7amR2T6F
         lpuQ==
X-Gm-Message-State: AOJu0Yznh2JYfgKbbvhft/sq4783StuRmXBetl4M5KYsxDwV3tAQE752
	p17gKHwO4mtpIv7Ec+gHCd9TSbzG67wx3G/C2sE=
X-Google-Smtp-Source: AGHT+IEUCDW5Tsouj247XeB86bopjcAmx+mDPOxgJdrQ6yLevA/WNXkh+UeWqPrA2oONircAwyXbKg==
X-Received: by 2002:a17:90b:1e0a:b0:285:544a:9810 with SMTP id pg10-20020a17090b1e0a00b00285544a9810mr2184988pjb.13.1700824909666;
        Fri, 24 Nov 2023 03:21:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f15-20020a17090ac28f00b002630c9d78aasm2799605pjt.5.2023.11.24.03.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 03:21:47 -0800 (PST)
Message-ID: <6560874b.170a0220.e2e31.63ab@mx.google.com>
Date: Fri, 24 Nov 2023 03:21:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.62-cip9-12-g3a5321f469b07
Subject: cip/linux-6.1.y-cip ltp-ipc: 12 runs,
 1 regressions (v6.1.62-cip9-12-g3a5321f469b07)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 11:21:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13723

cip/linux-6.1.y-cip ltp-ipc: 12 runs, 1 regressions (v6.1.62-cip9-12-g3a532=
1f469b07)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.62-cip9-12-g3a5321f469b07/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.62-cip9-12-g3a5321f469b07
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3a5321f469b07e6124d325d7faaa2f8f1993f67c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/656076e56712785d677e4b70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-broonie/ltp-ipc-beag=
lebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.62-ci=
p9-12-g3a5321f469b07/arm/multi_v7_defconfig/gcc-10/lab-broonie/ltp-ipc-beag=
lebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/656076e56712785d677e4b=
71
        new failure (last pass: v6.1.59-cip8) =

 =20

