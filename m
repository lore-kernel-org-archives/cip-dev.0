Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D0FC32771
	for <webhook@archiver.kernel.org>; Wed, 28 Sep 2022 14:05:39 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web09.8323.1664373936572633633
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 07:05:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=MK12p5EZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id i6so8441401pfb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 28 Sep 2022 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=oiwPqthmg2TRSvP8LtCWJWYw2ILtfmGrz7ycNDsWliw=;
        b=MK12p5EZRcWajTyqCdd87bCbsUDpES8mW9EpwlnJ0X3i2PiLpfitjhXrIOIz3CjbxK
         MZuTfUzECp15Oxa7f0YT/qrb0tkrdOzC9jXeRRSCCJJ08/d2mpkgnFxQLipO6s1Hwk4m
         WHSAzXvuLvQzawKygoCgwWrMgCwciK+vEoRPZAPyGeE63f8Oy61PivXPkQTKqf3Ig7R3
         aoTPnW3utnpjcV+WDviaJDT7oVEvgffTLsiRi9i/CCiZz+E75zPvllBPmE2Cxbe24fjv
         3D13ahxSkpEyUPUE5k615L8loXWFw3PkU6jVzNV1a5hv0F5zFynTFssFzc6byO0/3yu/
         dkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=oiwPqthmg2TRSvP8LtCWJWYw2ILtfmGrz7ycNDsWliw=;
        b=SjlOejTungzzkrl16SNJiD0fc0l0QfbKS0c0aZQlPAY846/MdPiSuXvNARo5cEkeF6
         he+XdzRPgredRviwU5vm1tt47S23fmv0wASr5YcS5Mnqw5HgSo5SvQVJCoIgc5FwZNH0
         4JYxqwBxLoAW9V21OKmHtcFn65x7XR4pWo+0LC+skVEnyXA0x+nu/wUxk2qSfHcy0aU0
         hIgBrs8kQ60RrPLJhsLXPy1jbHfVl23lyJnqsXFnawqRcYx7x6OweHJbIUmbOJ/CvlEb
         qMn5bGBBgsArCinqrkOACPBSxmBTVMiRVujGdRJ11jgwx0BEo4hf0IZR9JbNXcjTGyB1
         gWvg==
X-Gm-Message-State: ACrzQf0avikaCQR5RPQXaliG3LMKFutbC6w/+bG4PSof/LYXr7FxZOOo
	2HJQENB3+43jvdukRL00MNN/6kIArtKYlTq1
X-Google-Smtp-Source: 
 AMsMyM5IIr6zgrjck4a9aRz2EW0gpL3TzFASpW2CN2YX+4MYH3Qhcbm5DoTfUWvV0rnS1eW50PFjUQ==
X-Received: by 2002:a05:6a00:1342:b0:545:4d30:eecb with SMTP id
 k2-20020a056a00134200b005454d30eecbmr34191006pfu.69.1664373933747;
        Wed, 28 Sep 2022 07:05:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 d63-20020a623642000000b00540d03f3792sm4060201pfa.81.2022.09.28.07.05.32
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:05:32 -0700 (PDT)
Message-ID: <633454ac.620a0220.32a7f.707d@mx.google.com>
Date: Wed, 28 Sep 2022 07:05:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.259-cip82-57-ge54228ee5a88d
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 102 runs,
 1 regressions (v4.19.259-cip82-57-ge54228ee5a88d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Sep 2022 14:05:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9565

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 102 runs, 1 regression=
s (v4.19.259-cip82-57-ge54228ee5a88d)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.259-cip82-57-ge54228ee5a88d/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.259-cip82-57-ge54228ee5a88d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e54228ee5a88d934b744fe3e17655b848b356724 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63344cfe48d8bda926ec4ee0

  Results:     83 PASS, 7 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.259-cip82-57-ge54228ee5a88d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.259-cip82-57-ge54228ee5a88d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220919.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/63344cfe48d8bda926ec4f06
        failing since 198 days (last pass: v4.19.229-cip67-111-g5c3c0b39cf3=
b, first fail: v4.19.231-cip68-123-g92e3e7f3d4df)

    2022-09-28T13:32:21.680964  <8>[   36.011369] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-09-28T13:32:22.693085  /lava-7438543/1/../bin/lava-test-case
    2022-09-28T13:32:22.701493  <8>[   37.031940] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

