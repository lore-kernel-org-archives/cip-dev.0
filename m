Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A307EB64D7
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 12:43:55 +0000 (UTC)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
 by mx.groups.io with SMTP id smtpd.web10.40981.1687524234641528852
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Jun 2023 05:43:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=12ABqqLj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.181, mailfrom: bot@kernelci.org)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3423dadd601so2271315ab.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Jun 2023 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1687524233; x=1690116233;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+zHx6gQ5oS0/yU01fpUwS20hj78qGnGCrHpMsBUv0c=;
        b=12ABqqLjexpDWAbmOEhfT1tP8j54a8wK2uOHqjPX+qjRntLdtjuk+WybUis0N/Hnfp
         zi2ke4yz/ud1AN3g9TOXy4MjQ2vjVs1YFzwBeiotCqo48ZkVAi68ITN4O+Is9NEKJF/k
         58ZBr2R/3x83k+ttXxnEdt3UdATzIfLjvgXC0PvfMaL5U7mC8cCSWfpcvzn9q5LfLM+c
         XE98uAZ5lDJeX+WKKDkfR6OzwQ7RwqgspD+NVg/PM9ljf1KgNzAjwzBEDQtxo+v9b4jQ
         62O98Kvm6ozIkwLO3FsgEat6NDHwSZB1BowoFlODqzIwR/A5M7X83BTx2DYojeBglVsI
         SNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687524233; x=1690116233;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+zHx6gQ5oS0/yU01fpUwS20hj78qGnGCrHpMsBUv0c=;
        b=az6pP7cl4d6Tqi8BI9v9KwBIgin5NHrtAbxsNoikLEpyVyUh2m2W9hEQKv0HtQodoP
         2LuZJr+kLSEwOn9JYlHv9YBPcmhqD5kJx1a7TJFSM+ZRWPN6Hrc76dxaCTA48jpydLHn
         51lz+ydKIuLyGQ5e4V5ZvLlm0Q2QTUUowlh2f4yOIZw/kS/59T0TqDHk0Xe6YsbebxqP
         thELW5/BvSSZxD8VRcC+j5FyX/lWxcjVspjZaeXmOs37BsBeww9+XdV+AfLzv82N1iVm
         6uC9veBfV4C+qsK4vM/2jM5ViV6XpWrp7xN/ywUvuP862LwymegrpjQdxmz03THsWv9y
         LFTw==
X-Gm-Message-State: AC+VfDxn4OmkyM3lpIZeSQ94kPnRcmNUK9KAP5o9IecUj+eNlqxzOvSV
	ZMXBgb1A6/gbI2bXlX1dQG/pCyhzua1OHgM1vSFg+g==
X-Google-Smtp-Source: ACHHUZ4HjC/5uXpAvFjLtpmcQUXMRGEKMM0RfDpgjWpyHRWcXeqXx23XHp4B6EtRQA2BlJE2cG4QDw==
X-Received: by 2002:a92:c80a:0:b0:33d:a34a:2d42 with SMTP id v10-20020a92c80a000000b0033da34a2d42mr18557863iln.20.1687524233405;
        Fri, 23 Jun 2023 05:43:53 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 34-20020a631662000000b0054ff36967f7sm6405646pgw.54.2023.06.23.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 05:43:52 -0700 (PDT)
Message-ID: <64959388.630a0220.465e0.e0ba@mx.google.com>
Date: Fri, 23 Jun 2023 05:43:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.287-cip100
Subject: cip/linux-4.19.y-cip baseline-nfs: 49 runs,
 3 regressions (v4.19.287-cip100)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 12:43:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12137

cip/linux-4.19.y-cip baseline-nfs: 49 runs, 3 regressions (v4.19.287-cip100)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig+ks=
elftest | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook   | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.287-cip100/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.287-cip100
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      843423b3724d762d5593ab9aaeb68ac695871b44 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
beaglebone-black | arm   | lab-broonie   | gcc-10   | multi_v7_defconfig+ks=
elftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6495898968e058065830612e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+kselftest
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-be=
aglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm/multi_v7_defconfig+kselftest/gcc-10/lab-broonie/baseline-nfs-be=
aglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6495898968e058065=
830612f
        failing since 13 days (last pass: v4.19.283-cip98, first fail: v4.1=
9.284-cip99) =

 =



platform         | arch  | lab           | compiler | defconfig            =
        | regressions
-----------------+-------+---------------+----------+----------------------=
--------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/6495880733649e7e73306143

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.287=
-cip100/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230609.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/6495880733649e7e7330614d
        failing since 93 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-06-23T11:54:31.662534  /lava-10875974/1/../bin/lava-test-case

    2023-06-23T11:54:31.688069  <8>[   39.617048] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/6495880733649e7e7330614e
        failing since 93 days (last pass: v4.19.276-cip93, first fail: v4.1=
9.277-cip94)

    2023-06-23T11:54:30.606423  /lava-10875974/1/../bin/lava-test-case

    2023-06-23T11:54:30.629281  <8>[   38.559486] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

