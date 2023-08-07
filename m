Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBEEC41513
	for <webhook@archiver.kernel.org>; Mon,  7 Aug 2023 16:27:23 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web11.39210.1691425634959166182
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 07 Aug 2023 09:27:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=yhJOIWcj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6873a30d02eso3043123b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 07 Aug 2023 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1691425634; x=1692030434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=84KzqOLYJMELLG3p5km7Cdgk3z/WPfBOwjiAmGhpsUs=;
        b=yhJOIWcjTpcOVJLIsWnhryVtyEQtgKXSBciNat7And+aNcJJ9p7tVdtUD73XwI5/DQ
         0g2Cq+y2taUHpai9Szf7WG1/SlK9ilsnp9BmAmoV4jPiwetasL2bOiafc/4SecxEDq88
         hPtfnmGDenyANbSIe2cmVj5xiOhiG3XJHIFK7GEV6zJ+p2tB8LwknSNUQ30pARpYlI16
         z/YEJGDiM5dkUeyNUvanb5pW6T+moDbaQ56AiOI2c9bMJ6DfTTW6bai9sabQaQK+31jA
         +q1Z64aFp1jei19FwIvglQlhzIWItqvKb2Zt372LsMU0+9zlEZfw9jbgHAxXN5I3bCBe
         rP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691425634; x=1692030434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=84KzqOLYJMELLG3p5km7Cdgk3z/WPfBOwjiAmGhpsUs=;
        b=NFS1sjx/1BWCpnlzWW5VC4uMruO2fot1rB8uJbAc7mu1cfxnDO+Fi0xeFvzC4kQIJD
         66q46ILpH+2nHmH9ylFJohqOIV95MqLAwmE517EJEVgb1yMFxKq/27IJGI2P2XENbIOt
         Dvoc3LbKWJbphjb4RRLZJlGU54oVqVjB4RlS6YfbJI7st2KOS9xaoPWLUugstMoeYNZx
         zDUWkpwiSnzVDj5hnNDvs3fMzqBlNgQlcFGOP1pWmuKpr/+NehkE9N4IotgwpKyw7F8S
         KhMLuFJe8h28SA4F1oSRbOhJ7JgIIz+L25VzslESfq+L2FElStMLsl7F7vDvVlWgcFL7
         kvkg==
X-Gm-Message-State: AOJu0YzrDZpam757ZnJVU19o1crxuMpXnFBWugpCktgj8aXsJDXa620B
	96/b00nYQ/tArB4YFeTJ5ruIWNQcx8ANhXNRCkNS0g==
X-Google-Smtp-Source: AGHT+IEfiyhzGa5+TfTF21TQyxro6NIZ2+lLgxnp7uO64UNMRts8FzA0ITqrMo0Sg/uTdEa5XHcHGw==
X-Received: by 2002:a05:6a21:3291:b0:12f:c61e:7cac with SMTP id yt17-20020a056a21329100b0012fc61e7cacmr9581244pzb.31.1691425634001;
        Mon, 07 Aug 2023 09:27:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 5-20020a631945000000b00563ff7d9c4bsm5081240pgz.73.2023.08.07.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 09:27:13 -0700 (PDT)
Message-ID: <64d11b61.630a0220.25c4a.945c@mx.google.com>
Date: Mon, 07 Aug 2023 09:27:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip72-638-gbfc57fcad0ac
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
Subject: cip/linux-4.4.y-cip baseline: 56 runs,
 3 regressions (v4.4.302-cip72-638-gbfc57fcad0ac)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Aug 2023 16:27:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12560

cip/linux-4.4.y-cip baseline: 56 runs, 3 regressions (v4.4.302-cip72-638-gb=
fc57fcad0ac)

Regressions Summary
-------------------

platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig | =
1          =

rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-638-gbfc57fcad0ac/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-638-gbfc57fcad0ac
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bfc57fcad0ac581f1b39110b5847f3e579e7888a =



Test Regressions
---------------- =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
r8a7743-iwg20d-q7 | arm  | lab-cip       | gcc-10   | shmobile_defconfig | =
1          =


  Details:     https://kernelci.org/test/plan/id/64d114d902fb75c19335b1ea

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: shmobile_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-638-gbfc57fcad0ac/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-638-gbfc57fcad0ac/arm/shmobile_defconfig/gcc-10/lab-cip/baseline-r8a77=
43-iwg20d-q7.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/64d114d902fb75c19335b=
1eb
        failing since 96 days (last pass: v4.4.302-cip72, first fail: v4.4.=
302-cip72-372-ga3bc58e64f55) =

 =



platform          | arch | lab           | compiler | defconfig          | =
regressions
------------------+------+---------------+----------+--------------------+-=
-----------
rk3288-veyron-jaq | arm  | lab-collabora | gcc-10   | multi_v7_defconfig | =
2          =


  Details:     https://kernelci.org/test/plan/id/64d1148ab3acfbfee335b21b

  Results:     37 PASS, 22 FAIL, 2 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-638-gbfc57fcad0ac/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-638-gbfc57fcad0ac/arm/multi_v7_defconfig/gcc-10/lab-collabora/baseline=
-rk3288-veyron-jaq.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.dwhdmi-rockchip-driver-cec-present: https://kernelci.or=
g/test/case/id/64d1148ab3acfbfee335b254
        failing since 193 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-08-07T15:59:12.864730  Usage: seq [-w] [-s SEP] [FIRST [INC]] LA[ =
  24.757563] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3Ddwhdmi-rockchip-driver-au=
dio-present RESULT=3Dfail>

    2023-08-07T15:59:12.864803  ST

    2023-08-07T15:59:12.865030  =


    2023-08-07T15:59:12.869453  Print numbers from FIRST to LAST, in steps =
of INC.

    2023-08-07T15:59:12.871780  FIRST, INC default to 1.

    2023-08-07T15:59:12.872008  =


    2023-08-07T15:59:12.875119  	-w	Pad to last with leading zeros

    2023-08-07T15:59:12.877269  	-s SEP	String separator

    2023-08-07T15:59:12.880707  /lava-11224398/1/../bin/lava-test-case
   =


  * baseline.bootrr.dwhdmi-rockchip-driver-audio-present: https://kernelci.=
org/test/case/id/64d1148ab3acfbfee335b255
        failing since 193 days (last pass: v4.4.302-cip71-1-g61333eee4869, =
first fail: v4.4.302-cip71-590-g22fc523bf881)

    2023-08-07T15:59:12.810778  [   24.706029] <LAVA_SIGNAL_TESTCASE TEST_C=
ASE_ID=3Ddwhdmi-rockchip-probed RESULT=3Dfail>

    2023-08-07T15:59:12.852056  BusyBox v1.31.1 (2023-06-23 08:10:20 UTC) m=
ulti-call binary.

    2023-08-07T15:59:12.852211  =

   =

 =20

