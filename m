Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C547C00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 20:30:39 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web12.545.1659472238316788530
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 02 Aug 2022 13:30:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=Yig84xCv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174,
 mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id iw1so14482697plb.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 02 Aug 2022 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=OFTTrbsm/lGZofZCC3SniyxhDKHUR4ZGJVQah34ZO7A=;
        b=Yig84xCveUCOLp2beaIy/dgFMcn7Q2e+uJ80EH82yxDWRgDvd6LLk1QgzkxSEh1P1p
         Uh/Kixa8opKXSMlcEioS+9MezGgucxwBqR+i/mrSCsimo4MWh+SWEvdFKrWvIutaDjID
         /ML9uHSt870wPO7aQi6jI+sWs8wPqTdZtYYrG379VsdXNKGsAsLCN7KyLPUgPSZVi4jr
         jwThRedKR3o1l4pGkiwuCY//Avy9xiU3SmEm8OuFbcB2TO1v7kGJXMJzcDWFrpPIwFYO
         hD0Uj0UArPkZZXZDlHZSYrfDlVXeSgg+rUAW/PqJfjOAVvjFEVTbiNpBHtKdNrmhN0Qm
         T53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=OFTTrbsm/lGZofZCC3SniyxhDKHUR4ZGJVQah34ZO7A=;
        b=Swlrl2UjO/5kscfPLJNsTDGqTBT9Q0yaUnuIgNvlUfH7DNbmWKNsHP/tsbrzJIrp/l
         zRjZurAmA2VdzghwtfTSp7qhd3jdNhOUw8p1XKnGVkvt1Mhk6jDsjoRqz5FLa8vVTKj9
         cGbCiqXY3ypLpbjCTf5UeNLcDzn1+P/xXQ0jQeTBO9t6Su6YVfy2txuj3gjn7iVww88X
         COXSx/knSEStM+E2Gvze0LBysdwEcmnV6D3mzVhjshc/FeJxCMgGSIH56rsXdBr16Bpl
         fJCDn/BgbCKIEndRu19FADn4waRcz5ErmNDroR7oB3xcJoDywaK+w09y1xCCmcBda8ka
         V1Eg==
X-Gm-Message-State: ACgBeo3/c6Jp81b9K9uYq7Y7MJNj9ydbJ2x1zTakCWnwjVa8RDGpVmbV
	9Zg7bDSHJfvRdimnyylaLWW8WEul1aGGTNMz+N8=
X-Google-Smtp-Source: 
 AA6agR6P2UZtja15hoxqYzDL+WDCn+UlLLkjSEAgv74KylOfivQ87b/sB2GQJgpXcAriTmPiYdLKMQ==
X-Received: by 2002:a17:902:820d:b0:16e:c853:ddd1 with SMTP id
 x13-20020a170902820d00b0016ec853ddd1mr18805387pln.31.1659472236718;
        Tue, 02 Aug 2022 13:30:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 n2-20020a170902968200b0016c50179b1esm112137plp.152.2022.08.02.13.30.36
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 13:30:36 -0700 (PDT)
Message-ID: <62e9896c.170a0220.7916f.0447@mx.google.com>
Date: Tue, 02 Aug 2022 13:30:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 14 runs,
 3 regressions (v5.10.131-cip13)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 20:30:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9029

cip-gitlab/ci/pavel/linux-test baseline-nfs: 14 runs, 3 regressions (v5.10.=
131-cip13)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 3          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.131-cip13/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.131-cip13
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e217bcd84090afd29c7a9ab120fb3c8ff8844478 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 3          =


  Details:     https://kernelci.org/test/plan/id/62e97de3203c33deafdaf0dd

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.131-cip13/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/base=
line-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.cros-ec-sensors-gyro0-probed: https://kernelci.org/=
test/case/id/62e97de4203c33deafdaf120
        failing since 84 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-08-02T19:41:04.916667  <8>[   93.188208] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel1-probed RESULT=3Dfail>
    2022-08-02T19:41:05.951876  /lava-6951001/1/../bin/lava-test-case
    2022-08-02T19:41:05.983316  <8>[   94.255469] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-gyro0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel1-probed: https://kernelci.org=
/test/case/id/62e97de4203c33deafdaf121
        failing since 84 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-08-02T19:41:04.885961  /lava-6951001/1/../bin/lava-test-case   =


  * baseline-nfs.bootrr.cros-ec-sensors-accel0-probed: https://kernelci.org=
/test/case/id/62e97de4203c33deafdaf122
        failing since 84 days (last pass: v4.19.233-516-ge5e741fbfc87, firs=
t fail: v5.10.109-cip5-384-g722204542e8a)

    2022-08-02T19:41:02.777507  <8>[   91.049143] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-driver-present RESULT=3Dpass>
    2022-08-02T19:41:03.811008  /lava-6951001/1/../bin/lava-test-case
    2022-08-02T19:41:03.844478  <8>[   92.116469] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Dcros-ec-sensors-accel0-probed RESULT=3Dfail>   =

 =20

