Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9070FC7EE2C
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 23:40:48 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.132.1686008439562488883
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 16:40:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Lt9s//W0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-64d24136685so3954378b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 16:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686008438; x=1688600438;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iB9vK2IdhFLllzsl7/9BpZV+Hl8/ilFR+h+X8qf/PVY=;
        b=Lt9s//W0le/3edFzEFGHJawAD9L2K3Pk1HzWc7cxUmBSJjHZPtJxnjzjuX6wz5w1IU
         jKDr3pqUat1gQwIir6DwxWPkd04+wQXJmZuJlbmFvDDgbfaexQnfkugElySXVTYOixMJ
         /5qrNlAk+6v8RgCJHhee+Rq8GoQkOip4s/GFA/HxhsnJNgK9e2eP+s1glMCQNbhUSnmu
         D2aKwSyBcGwPBxLpKbj0cZJgjHjXYA+y2yCc0dAee2vEHTYkXxzmQxichSg6Ig+VgRfK
         PfmQqYzQJEMkGugJ42g3KaqPsK0sDVkh3QMX/bqNFfb9XEuCt4BOlsfLB1CbKNxyUlJ1
         i4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686008438; x=1688600438;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iB9vK2IdhFLllzsl7/9BpZV+Hl8/ilFR+h+X8qf/PVY=;
        b=cOZDNSJjvyzomFKVmuhr2mMTY89zYoC77Mf5VXAIFTYlqBq5BY3o3Ps5hnEeOg3ycz
         xGsucv8fJQBL7jEqVd1M7z9psukDM/8fKn7L4H0mJnRe9/GX0dBaAR3nxjVqTApbBOQb
         9l0BohvMr35h441J5MOhVgr6zVUin3k5RAes31wIy/OX899ffss7y7oMWdEGdxHcJ1c1
         /WikExUAiRAXzdTzXh2aKIfmXdw32e+SG5c5uf6HqPr/C4WysDGZ/IfbM1RSAvXem4JY
         vvHJuIL5xVNu3nkKBh/wA85HFRhhZWQfo6jNmSruNCI+IoDZI4GaofJvrZvSv1rEaaHT
         hQhQ==
X-Gm-Message-State: AC+VfDxvgPW4SuR+eCLIodClhH2jVfi1peUtaagUBHlVB1C0JTiXzLV5
	2i+40SSvT5NXUyDXEuWX89J7JZyoeajB5H677y7XWA==
X-Google-Smtp-Source: ACHHUZ77/c0D93gGYu+j5rBsyh6Ek/bjXDIlTj94gF0CepCWniXPyc4hUSG22fTK0fenE4lKvbscmw==
X-Received: by 2002:a05:6a00:b4b:b0:635:7fb2:2ab4 with SMTP id p11-20020a056a000b4b00b006357fb22ab4mr542812pfo.6.1686008438416;
        Mon, 05 Jun 2023 16:40:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78d41000000b0063efe2f3ecdsm5564020pfe.204.2023.06.05.16.40.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 16:40:37 -0700 (PDT)
Message-ID: <647e7275.a70a0220.79ecb.9f4b@mx.google.com>
Date: Mon, 05 Jun 2023 16:40:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1314-g1ab0ac1d7e2e3
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 12 runs,
 2 regressions (v6.1.26-1314-g1ab0ac1d7e2e3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 23:40:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11831

cip-gitlab/ci/pavel/linux-test kselftest-futex: 12 runs, 2 regressions (v6.=
1.26-1314-g1ab0ac1d7e2e3)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1314-g1ab0ac1d7e2e3/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1314-g1ab0ac1d7e2e3
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1ab0ac1d7e2e3aeca50f8616b469772a5f010acc =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647e6ec2cdbad982c4f5de66

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/647e6ec2cdbad9=
82c4f5de67
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a) =

 =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647e665725df76be87f5de2a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftes=
t-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1314-g1ab0ac1d7e2e3/arm/multi_v7_defconfig/gcc-10/lab-cip/kselftes=
t-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/647e665725df76=
be87f5de2b
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a) =

 =20

