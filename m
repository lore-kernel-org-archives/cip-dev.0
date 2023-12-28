Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0F9C46CD2
	for <webhook@archiver.kernel.org>; Thu, 28 Dec 2023 00:37:35 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.114523.1703723851111310609
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 27 Dec 2023 16:37:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=kX/cZcLq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d427518d52so25942175ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 27 Dec 2023 16:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703723850; x=1704328650; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GXNu+9T7AAIdtnusRb4WSr3aUmFpM9prt+5/P0JUfmE=;
        b=kX/cZcLqTC9VGoRfwFBLDoLctjxMiutSXIcpPQ4QaWKtc7AGa2uw2h+wZzWgLb1y+i
         CMcBk+jVHFv2vkGhh6YcH702Q05mwEv1YNampinosLV9xh5wJ6eEcz+3sk92xcpt+joW
         JsgzNS5WnC4I6azEPb+UGBzxC+mdXyzHDtY6i/XxgMGLne8k+i9gYNLyR1VT1Jw7lnbJ
         sdON5JBNm2DOXA4JD8u2HwFEqYPBP8SnY/6Z3M0nT5TI1vMERmpyUrtszxtzb+Gs977v
         NLCEjoFlA0ZfomZ+ST/n7S2G3vfo20qdL87PnBLyhCCqZT1iOhKZiwd91B7nywVvMz4u
         P8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703723850; x=1704328650;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXNu+9T7AAIdtnusRb4WSr3aUmFpM9prt+5/P0JUfmE=;
        b=UAjOe4J+RfYfl6Pxzp2FwwF2B7yAO7tYVstUmh03lOsmr5lzyUhfMEUPkh0T1ddmio
         BDDrTv/lvQ+276kJrCHqKuA2KcjSg2EPX9prLqJpav5S4cd8wLfvCpOeVss0lafuYGgE
         Qf2ZHE4F56thvI2/ynE+h0OFHBZo1HDywlPHvARMeWLP/l+xwq3wmaalf+1MjPyEDYzg
         K5PuiHosG69M16zaQfvuhk7UdLhl4o9PgBuRcfee9ouGhrqJZGq6aGxK5nXFKtTu3GeQ
         ssEeIOz5G7grIp6m/MtCam6flOGa0uFeq8IO4uFE5s/f/VpBI4UvqKF0SZm0vDOXhXR9
         rBRQ==
X-Gm-Message-State: AOJu0YwZNVfWbbGrxh+fPnvlDHx0iumZfrLcGysE4IpnEeENZiRNx+NT
	SgBN0mxFJcYy5MY5w/7fM6UTUNQao8yCUlH5JUAyLKIz608=
X-Google-Smtp-Source: AGHT+IGsDblLUNzIMlbp9cEM22rsdrNs+K5qDBFJ4awdfGpyC2Mss1c+aEJVGSxbDooXdGp6ZhhkQw==
X-Received: by 2002:a17:902:bb10:b0:1d4:341c:db32 with SMTP id im16-20020a170902bb1000b001d4341cdb32mr7413945plb.11.1703723849624;
        Wed, 27 Dec 2023 16:37:29 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902e54100b001cf51972586sm12585886plf.292.2023.12.27.16.37.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 16:37:29 -0800 (PST)
Message-ID: <658cc349.170a0220.64fce.ddee@mx.google.com>
Date: Wed, 27 Dec 2023 16:37:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66-cip11-rt6-10-g38253b8903b4
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 17 runs,
 3 regressions (v6.1.66-cip11-rt6-10-g38253b8903b4)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Dec 2023 00:37:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14211

cip-gitlab/ci/pavel/linux-test ltp-ipc: 17 runs, 3 regressions (v6.1.66-cip=
11-rt6-10-g38253b8903b4)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =

beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.66-cip11-rt6-10-g38253b8903b4/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.66-cip11-rt6-10-g38253b8903b4
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38253b8903b46da162814048c6f555bba4399ca8

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/658cb2b02f6c1cdac2e1349e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-broon=
ie/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/658cb2b02f6c1cdac2e134=
9f
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-cip     | gcc-10   | multi_v7_defconfig  | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/658cb89190a33ea6bce13475

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-cip/l=
tp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/multi_v7_defconfig/gcc-10/lab-cip/l=
tp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/658cb89190a33ea6bce134=
76
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =



platform         | arch | lab         | compiler | defconfig           | re=
gressions
-----------------+------+-------------+----------+---------------------+---=
---------
beaglebone-black | arm  | lab-broonie | gcc-10   | omap2plus_defconfig | 1 =
         =


  Details:     https://kernelci.org/test/plan/id/658cb705926ee232a8e1347b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/ltp-ipc-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.66-cip11-rt6-10-g38253b8903b4/arm/omap2plus_defconfig/gcc-10/lab-broo=
nie/ltp-ipc-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/armhf/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/658cb705926ee232a8e134=
7c
        new failure (last pass: v5.10.201-cip41-77-g545d45774209f) =

 =20

