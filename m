Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD4CC4332F
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 04:27:11 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.1952.1668140829494907501
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 10 Nov 2022 20:27:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=HVae86WS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso3696399pjc.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 10 Nov 2022 20:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ifan/AXQSR5hAUnXpfmLZBFLeaefrlx3SNg3J3Tx+5I=;
        b=HVae86WSom0bBIAOFJRvGM4nK3aWUrqTadkJxyKumkfqMxt/gKNJq5Imse5V11A8GB
         xuh+bM0UgTqSO7+/kQckHJCg0ewRJfiNJKvhvaAL4KTQmd66X3vJBotPQM1hLIoQDrlG
         GWePyxmr9OJ/InalrJIb5gDhvnCps6Ah1SQ7VOiJMDWqpckIDgsfK9ogLb/20/9gvgDn
         i6PdmIAPxHX3+S8z9S122+dWE6QvA/lRiWTBmbNc/Jq5XMG3oGEvZ3LkrRVq59StZDL2
         y6kOhOhQCXG9VBSAxhhlOZa+PNhFBGFjykJ/MovktVC2C2kzWLcDT5RuAbE67qR1sl4a
         /jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ifan/AXQSR5hAUnXpfmLZBFLeaefrlx3SNg3J3Tx+5I=;
        b=CDvU4QIPRYli+1aOj4d3GVGb17g2eKQB65pFdPXMOoZhq80NVNOSsgmluJ945O7Ob9
         iTSVIoLvwBZpTO8EIcl3IjJMCtApVr2b8P0tsbEgDwYTN+a96znyQjVPCc9Ir4bFnrDU
         N7Biz60sbKolMZaYXz4Zl3cvItJeliaSsimStGgh3z+nGGZyrCgEVtNiDFfZkbnhCYFd
         WRqZ+HXc2FTVaEhkq+75xjyqTLrPYn3IDITPQ1QyzJVhDhSLcutK/R+9yztpePXfh2qS
         FUSicVq389gCexL6/ShR0/SfisVE1GaMZPIQ6RDEudHzbiwg534btzNCS7IdKsUOraI3
         NX8Q==
X-Gm-Message-State: ACrzQf1wf/BgJrNraqV5SWvK1OeY4XQmLXh2AY5W/W7zNT3fF35TVOeP
	3EEHoOQYR6pp2MAdUdev2eqf+wSVEwPBeDzSm0Q=
X-Google-Smtp-Source: AMsMyM4xEMqeK+qfajbUIyHYz0uskafOgxLTVAxh2JfTi8VqJIkSTHlMJr/fwGhsWvBgTlJBXPcKCQ==
X-Received: by 2002:a17:90a:a618:b0:1fb:825c:af8a with SMTP id c24-20020a17090aa61800b001fb825caf8amr3412271pjq.104.1668140828701;
        Thu, 10 Nov 2022 20:27:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902a50700b00182d25a1e4bsm508023plq.259.2022.11.10.20.27.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:27:08 -0800 (PST)
Message-ID: <636dcf1c.170a0220.934c8.13e5@mx.google.com>
Date: Thu, 10 Nov 2022 20:27:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-122-g149fbc7cd21d
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 112 runs,
 2 regressions (v5.10.153-cip19-122-g149fbc7cd21d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Nov 2022 04:27:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10013

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 112 runs, 2 regression=
s (v5.10.153-cip19-122-g149fbc7cd21d)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
r8a7743-iwg20d-q7 | arm   | lab-cip       | gcc-10   | shmobile_defconfig  =
       | 1          =

rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.153-cip19-122-g149fbc7cd21d/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.153-cip19-122-g149fbc7cd21d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      149fbc7cd21d7e3a412f88c0e29d060f55e237f6 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
r8a7743-iwg20d-q7 | arm   | lab-cip       | gcc-10   | shmobile_defconfig  =
       | 1          =


  Details:     https://kernelci.org/test/plan/id/636dc5aa31315b9190e7db9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm/shmobile_defconfig/gcc-1=
0/lab-cip/baseline-r8a7743-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/636dc5aa31315b9190e7d=
ba0
        failing since 15 days (last pass: v5.10.147-cip18-56-g87bd4289362be=
, first fail: v5.10.147-cip18-12-g7bc9523ecfb7f) =

 =



platform          | arch  | lab           | compiler | defconfig           =
       | regressions
------------------+-------+---------------+----------+---------------------=
-------+------------
rk3399-gru-kevin  | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chro=
mebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636dcbb74805aeef7de7db5c

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/636dcbb74805aeef7de7db7e
        failing since 247 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-11-11T04:12:25.860036  /lava-7943342/1/../bin/lava-test-case
    2022-11-11T04:12:25.871199  <8>[   61.048632] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

