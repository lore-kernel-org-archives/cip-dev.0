Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B06EB64DA
	for <webhook@archiver.kernel.org>; Fri, 21 Jul 2023 03:05:58 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web11.2896.1689908749712502596
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 20:05:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Mq85cHbb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-563643b20baso1003118a12.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 20:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689908749; x=1690513549;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RLcoKDKDQ5LE2tWVvc8+FOiq17am9xkDt43bbySibR4=;
        b=Mq85cHbb1PxBNtJx5LsCDOV+GyDE0XIj/1gDTJRVWiBjEMlIJohAOpBv47pfCHyHPX
         eF/kLk42kGPadUyx/3Kl/gKptRyCHdJ/ghpHHL7bV6Th/pNTDqwQkhiwWcDmeBzTYGaQ
         hB5fbi7JI2ifxo3Q64RiBVdcBkmEpGqPYC3ge1tvARengARt4oV2jwf8V9AsdKKMAUMX
         rZFmqAdlvEAttocOCbsaSabLxV0c61k7x5MBY96iy+VBIBvD1asK9FTtFSWfOVdSU6AN
         FanRYXErBn1ec0EbC9rGhWp7b6LoM9dtTDVAUk2f493OvGvPF1au2dc+vd03mXn3wrdX
         MGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689908749; x=1690513549;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLcoKDKDQ5LE2tWVvc8+FOiq17am9xkDt43bbySibR4=;
        b=P3VVQaGni+e0fEuy/PCRQs/g+tsBIMxzkNHqMD3lfWmrt7btop265RQPpWxo9uO8IV
         EWadfYhK3vo+x2ijbi0lnz55bWw61YMJsNrMvE0FwKE0DVToOqCRdcS+ALf3XkG4UJoQ
         8iTj2GFhGuxLyQ7wiVwap+UlRAFNes8Z6aTBnFibVf+KSMOkei7ROBqJd9JI5IX6Rx8V
         3HV0FbijPQKMDqEM2qPe4PQfhenZ/KwcOFfpSrLsB+JT0bIYiqThtArJs7kuH0Lu6GDP
         QmXJsVokI9vRvgHHQ265xdCw0JLwrrCc+ASS49wX5gnDslCD/v3vXo32t5Fsprd3NavW
         +QZw==
X-Gm-Message-State: ABy/qLaB37pFlTXwYymHhbHRroV9XdXFchUe/Gmu3Fp/TGRSusaf0HY7
	Q0Ff7MPyGty7sukyBomHhewwHLVbStGH9bRRmoEG1w==
X-Google-Smtp-Source: APBJJlHQ16FQ9kU/+CO73uD6R5XOSBvC/YQ3cl/KpqRqdsS95QyfUC5DoqTo/KI8SPwiWSWm3zhsRg==
X-Received: by 2002:a05:6a20:728c:b0:131:52ce:5148 with SMTP id o12-20020a056a20728c00b0013152ce5148mr948485pzk.39.1689908748809;
        Thu, 20 Jul 2023 20:05:48 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fm10-20020a056a002f8a00b006783ee5df8asm1839072pfb.189.2023.07.20.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 20:05:47 -0700 (PDT)
Message-ID: <64b9f60b.050a0220.a1932.3ae6@mx.google.com>
Date: Thu, 20 Jul 2023 20:05:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.186-cip37-11-g2b3c22dc0633
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-nfs: 2 runs,
 2 regressions (v5.10.186-cip37-11-g2b3c22dc0633)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jul 2023 03:05:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12491

cip/linux-5.10.y-cip baseline-nfs: 2 runs, 2 regressions (v5.10.186-cip37-1=
1-g2b3c22dc0633)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-11-g2b3c22dc0633/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-11-g2b3c22dc0633
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2b3c22dc06337fb4c486cdf00b4182c35f61bb58 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64b9e18921e41fb01a8ace27

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/arm/omap2plus_defconfig/gcc-10/lab-broonie/baseline=
-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b9e18921e41fb01a8ace5d
        failing since 187 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-21T01:37:45.042890  + set +x
    2023-07-21T01:37:45.046388  [   46.375091] <LAVA_SIGNAL_ENDRUN 0_dmesg =
4303_1.6.2.4.1>
    2023-07-21T01:37:45.164880  #
    2023-07-21T01:37:45.268246  / # #export SHELL=3D/bin/sh
    2023-07-21T01:37:45.269211  =

    2023-07-21T01:37:45.371350  / # export SHELL=3D/bin/sh. /lava-4303/envi=
ronment
    2023-07-21T01:37:45.372321  =

    2023-07-21T01:37:45.474585  / # . /lava-4303/environment/lava-4303/bin/=
lava-test-runner /lava-4303/1
    2023-07-21T01:37:45.475938  =

    2023-07-21T01:37:45.480294  / # /lava-4303/bin/lava-test-runner /lava-4=
303/1 =

    ... (12 line(s) more)  =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/64b9e1be4a1e9895368ace1c

  Results:     51 PASS, 4 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-11-g2b3c22dc0633/arm/omap2plus_defconfig/gcc-10/lab-cip/baseline-nfs=
-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64b9e1be4a1e9895368ace1f
        failing since 187 days (last pass: v5.10.158-cip22-7-g92462fd9830b,=
 first fail: v5.10.162-cip24)

    2023-07-21T01:38:41.817672  <8>[   43.158110] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 988099_1.6.2.4.1>
    2023-07-21T01:38:42.052436  #
    2023-07-21T01:38:42.155430  / # #export SHELL=3D/bin/sh
    2023-07-21T01:38:42.156148  =

    2023-07-21T01:38:42.257959  / # export SHELL=3D/bin/sh. /lava-988099/en=
vironment
    2023-07-21T01:38:42.258669  =

    2023-07-21T01:38:42.360466  / # . /lava-988099/environment/lava-988099/=
bin/lava-test-runner /lava-988099/1
    2023-07-21T01:38:42.361650  =

    2023-07-21T01:38:42.367601  / # /lava-988099/bin/lava-test-runner /lava=
-988099/1
    2023-07-21T01:38:42.743357  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =20

