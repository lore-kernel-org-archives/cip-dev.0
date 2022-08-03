Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D51C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 15:55:04 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web08.10608.1659542094452808867
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:54:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=5Ospaqe3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id q19so7487954pfg.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 08:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=3kdWdD0V5ocSsbU5UtJcCvtDof+UFx0YnnojZ9dc/mA=;
        b=5Ospaqe3k5CkwZa3ho1kv81b+EcS9/K9lpViZXFF6M5/qKrXjjr5qXQW7puZh8l6FG
         j2rUYfvDiNy0oGd54kCvZBgpqfYH8XMIJR2pVmILjGAOT3+GSDTO6WqcoAZl4VHGOix/
         HhOUkf0YW+LLdf4ryhqUlievxUZPj8HqjTKkAVOVdJZ2aA6+ngSMgQd3OIxWUSxvxPpg
         3WPIWz+THU9h+SMsOtcaYiE0bFC/8xgwhb+Uixk+z8EHOAw2BX8OuyUZexOUVU39/ol5
         74iyZZjUzDk+tOsHmjoqba3YCq07wOqJHV07XL8rv+WTAtzpSeZk8ZcUAwsqm9FVs508
         OJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=3kdWdD0V5ocSsbU5UtJcCvtDof+UFx0YnnojZ9dc/mA=;
        b=QyGPtXXSrQ8Vh8V1RJwl9gOaLZ3/4WrQu8FuZnO2TlKPf5NMtpNDa/Ps7S+HlQhwST
         yc3zjJcjpY5RhC8mN5qLMJDXDg38PV1HJlMhKhEmPBlDpcBzYxXO6Iy7j23mxxnOadx2
         GY5JlP/xtTivl9Vdaq33HJ/CmsmbLcnhrDUCFIfTYOVFdIwOtUKEjxF0D1/RWEWNbRnn
         +l6XCGo7MSwnFwc1/PJ9CwV9geCNM7v0eFHe7yXLBRhPhFLvZJ3hVuYigSjWiALm7Bwc
         L55m5/GlsDzU6dZsSAa8wwL87kSajVitd6y+n+W3qGw/IKo2p55Yw7diUdNWxFOJ3D+/
         x5OQ==
X-Gm-Message-State: ACgBeo3cWktxd80e1jGMXjMMT/hIcHV1fuNzzExRYeTKaiYF788fRCtL
	B90YX3eEItke+E4+731xSzSZTgPp8efaDewdCLk=
X-Google-Smtp-Source: 
 AA6agR6OHFUZCL1pMajh69K969CMUmuVtaQqceKCjpMhRy9DA7/ZimVSM2qpFE+FUwNiZHFbcmmJWw==
X-Received: by 2002:a63:5064:0:b0:41b:b1db:cb61 with SMTP id
 q36-20020a635064000000b0041bb1dbcb61mr18675164pgl.67.1659542093765;
        Wed, 03 Aug 2022 08:54:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 e16-20020a170902ef5000b0016ccbc9db0fsm2096375plx.5.2022.08.03.08.54.53
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:54:53 -0700 (PDT)
Message-ID: <62ea9a4d.170a0220.5962f.3ac1@mx.google.com>
Date: Wed, 03 Aug 2022 08:54:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-431-g420b8f43ddc46
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 36 runs,
 2 regressions (v5.10.131-cip13-431-g420b8f43ddc46)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 15:55:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9064

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 36 runs, 2 regress=
ions (v5.10.131-cip13-431-g420b8f43ddc46)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-431-g420b8f43ddc46/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-431-g420b8f43ddc46
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      420b8f43ddc46ea18870caf6aa2052c5602729a5 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea8decffed7a00f0daf07c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm/multi_v5_defconfig/gcc-=
10/lab-broonie/baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/armel/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62ea8decffed7a00f=
0daf07d
        new failure (last pass: v5.10.129-cip12-12-ge4e007863cc76) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62ea90483631898d7fdaf05b

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-431-g420b8f43ddc46/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220718.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62ea90483631898d7fdaf07d
        failing since 147 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-08-03T15:11:50.655242  <8>[   95.452461] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-08-03T15:11:51.685134  /lava-6961675/1/../bin/lava-test-case   =

 =20

