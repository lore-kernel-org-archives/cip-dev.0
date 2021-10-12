Return-Path: <SRS0=MARJ=PA=lists.cip-project.org=bounce+64572+6810+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8605FC433F5
	for <cip-dev@archiver.kernel.org>; Tue, 12 Oct 2021 19:12:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D02160EDF
	for <cip-dev@archiver.kernel.org>; Tue, 12 Oct 2021 19:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1D02160EDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JAjhYY4521723xHj4UkhtIwg; Tue, 12 Oct 2021 12:12:29 -0700
X-Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web09.18693.1634065949260634417
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 12 Oct 2021 12:12:29 -0700
X-Received: by mail-pj1-f53.google.com with SMTP id pi19-20020a17090b1e5300b0019fdd3557d3so398723pjb.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 12 Oct 2021 12:12:29 -0700 (PDT)
X-Gm-Message-State: TlhcsgaHIEE4MbBoIsjYgkj2x4520388AA=
X-Google-Smtp-Source: ABdhPJw+pKPXOLA7RFaZYDUn5Jg3aCYPqQiMOPHNe+5KU4Uz7WZESiwM1mqYJmq8gLmiypjjKwYIGg==
X-Received: by 2002:a17:90b:4b03:: with SMTP id lx3mr8049340pjb.162.1634065948598;
        Tue, 12 Oct 2021 12:12:28 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e6sm11735469pfm.212.2021.10.12.12.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 12:12:28 -0700 (PDT)
Message-ID: <6165de1c.1c69fb81.49742.0e42@mx.google.com>
Date: Tue, 12 Oct 2021 12:12:28 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.209-cip59
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 19 runs, 3 regressions (v4.19.209-cip59) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="eDvnH8nA7aqCEq9V1Jkw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634065949;
 bh=gM8OgCs8mWMiWo1+O/lwltUsFXs2wx1+7Ud2D/Rsb7Q=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=V5Sj81wU58S8RuL5fPXCPrH+zBJjmfexLTvlUUkJAD0Dt8jGEJtmFshPo1tfxNYzdyx
 ODQyrCguAzl0+FQvuCynBfQamDDP9ZcwbcsJzMN91b2ug5dIvkDp1050OwCbVvjCa4QEn
 IrA25iZ43Jm42NQxlLcSdWvqnYwXwTcbcQY=

--eDvnH8nA7aqCEq9V1Jkw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 19 runs, 3 regressions (v4.19.209-cip59)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
3          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.209-cip59/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.209-cip59
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      11e803e05e061dc32e92deb7bd73c20dfbc48ae5 =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-8    | multi_v7_defconfig | =
3          =


  Details:     https://kernelci.org/test/plan/id/6165d17a783350c75508faa8

  Results:     63 PASS, 6 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-nfs-rk3288-veyro=
n-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.209=
-cip59/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-nfs-rk3288-veyro=
n-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
1008.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-iodomain-grf-probed: https://kernelci.org/=
test/case/id/6165d17a783350c75508fac0
        failing since 95 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-10-12T18:18:03.634015  /lava-4703619/1/../bin/lava-test-case
    2021-10-12T18:18:03.671965  <8>[   35.056441] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-iodomain-grf-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwmmc_rockchip-sdio0-probed: https://kernelci.org/t=
est/case/id/6165d17a783350c75508fad9
        failing since 95 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-10-12T18:18:00.242466  /lava-4703619/1/../bin/lava-test-case
    2021-10-12T18:18:00.272722  <8>[   31.657528] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdio0-probed RESULT=3Dfail>   =


  * baseline-nfs.bootrr.dwmmc_rockchip-sdmmc-probed: https://kernelci.org/t=
est/case/id/6165d17a783350c75508fada
        failing since 95 days (last pass: v4.19.194-cip51, first fail: v4.1=
9.196-cip53)

    2021-10-12T18:17:59.177136  /lava-4703619/1/../bin/lava-test-case
    2021-10-12T18:17:59.207933  <8>[   30.592722] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Ddwmmc_rockchip-sdmmc-probed RESULT=3Dfail>   =

 =20

--eDvnH8nA7aqCEq9V1Jkw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6810): https://lists.cip-project.org/g/cip-dev/message/=
6810
Mute This Topic: https://lists.cip-project.org/mt/86270795/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--eDvnH8nA7aqCEq9V1Jkw--
