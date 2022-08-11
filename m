Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F5C25B0C
	for <webhook@archiver.kernel.org>; Thu, 11 Aug 2022 15:10:50 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web08.7624.1660230637053090014
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:10:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=FvceII6q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52,
 mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id t22so17958338pjy.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 11 Aug 2022 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc;
        bh=FECB4AcJg4CciNK5e4gntiaekn7H7/P78gFTyhrxM5U=;
        b=FvceII6qPwQFKAf44LlZ6b+eaSrUd4Jsx1NAINLxbjHjAF+v9Z9o+7HDOUaA20vQxY
         372lR11lv0hhR5aPd2sGFXmkavqT3v9Leywn4MdMIPmyrR+GY+h2W+qEiZ5jlIxgu6hZ
         rbiil5LwZRarcZphi5/b3rH/nf/m/A3g+3i5PO6ZMVpHyZ/k7OAzswE+NaPnhQ1u0Qr2
         B69LlnXxZKOr6gOQtORZgMCywBsJJCiPOGbuRfI3sGiPxRp86yLmvZ80s18XmL2oL2Wf
         Ixn+B5FH25xWj48uwZ+RHUtCJNH0+8F8X8bWJx/wx+ix0scuV2DqEja8FAdu9hQrrW2v
         apGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=FECB4AcJg4CciNK5e4gntiaekn7H7/P78gFTyhrxM5U=;
        b=g+kg148HPnsn1BqJFnfgu1GBarmHcnXDgcmBaxONyqGgUp/yXhjJ2XuGFfNyGu8huc
         7AktdiFPEZNHrjd5gbtfHNFI27eY3VV37vihEU+AijjuN1K90H6fQbwGHZWN7VjdrRBT
         YXBJg1ARYRXB3/dUeWpUS+NXyBi9zYPs7ylg1ab8X0k6GNicAdIS5YSRv8XZlVHojjXm
         27wUq/VQpqKw4xJWmyiwDIxXGO6+I5ZLoSS7HXQjE2/vG9urbvhOfmDdrjAwKHGo/r3H
         +qQmHVc/O1RoZx75d56iq2/I44uJG1eU2dz3qOpIKndohF6/h5Aa+DQZs7eFtOKTCo2C
         nRMw==
X-Gm-Message-State: ACgBeo3gHM26NWLrCLE4ZJWs1+QiZAfkzfnFyFfWStxdFnEixdSsyRLN
	LnW70terQZDNe+vdn8hMq2tfTl2yn39A62Bamro=
X-Google-Smtp-Source: 
 AA6agR68ETdSvlLNnMsBp+JC4iIyTYgpRiGC0ztobNMNIy1EnarG/1IVaLvYBtPxgJS2rhFjWF55lQ==
X-Received: by 2002:a17:902:c94c:b0:16e:ce7d:1fe with SMTP id
 i12-20020a170902c94c00b0016ece7d01femr33148862pla.168.1660230636092;
        Thu, 11 Aug 2022 08:10:36 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b0052d51acf115sm4134548pfg.157.2022.08.11.08.10.35
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 08:10:35 -0700 (PDT)
Message-ID: <62f51beb.a70a0220.b16c4.7288@mx.google.com>
Date: Thu, 11 Aug 2022 08:10:35 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-493-ge129308279043
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 38 runs,
 2 regressions (v5.10.131-cip13-493-ge129308279043)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Aug 2022 15:10:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9160

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 38 runs, 2 regress=
ions (v5.10.131-cip13-493-ge129308279043)

Regressions Summary
-------------------

platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig       =
           | 1          =

rk3399-gru-kevin      | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-493-ge129308279043/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-493-ge129308279043
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e12930827904334316a5d7407de3f9a7126f9892 =



Test Regressions
---------------- =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre  | gcc-10   | defconfig       =
           | 1          =


  Details:     https://kernelci.org/test/plan/id/62f51013a90d733f90daf065

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-meson-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig/gcc-10/lab-=
baylibre/baseline-nfs-meson-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220805.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/62f51013a90d733f9=
0daf066
        failing since 7 days (last pass: v5.10.100-cip2-484-gede5006fb276, =
first fail: v5.10.131-cip13-431-g420b8f43ddc46) =

 =



platform              | arch  | lab           | compiler | defconfig       =
           | regressions
----------------------+-------+---------------+----------+-----------------=
-----------+------------
rk3399-gru-kevin      | arm64 | lab-collabora | gcc-10   | defconfig+arm64-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62f50f0b090f13eb46daf05d

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-493-ge129308279043/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220805.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62f50f0c090f13eb46daf07f
        failing since 155 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-08-11T14:15:16.363070  <4>[   37.253736] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-08-11T14:15:16.373373  <4>[   37.264388] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-08-11T14:15:16.377033  /lava-7015281/1/../bin/lava-test-case
    2022-08-11T14:15:16.409807  <8>[   37.301093] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

