Return-Path: <SRS0=iQ9n=FQ=lists.cip-project.org=bounce+64572+5954+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7EDC4361B
	for <cip-dev@archiver.kernel.org>; Sat, 12 Dec 2020 23:51:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEAD22D70
	for <cip-dev@archiver.kernel.org>; Sat, 12 Dec 2020 23:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEAD22D70
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5954+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id G9x3YY4521723xcCg6jfjltT; Sat, 12 Dec 2020 15:51:50 -0800
X-Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web08.11768.1607816275670929704
 for <cip-dev@lists.cip-project.org>;
 Sat, 12 Dec 2020 15:37:55 -0800
X-Received: by mail-pj1-f48.google.com with SMTP id f14so4216739pju.4
        for <cip-dev@lists.cip-project.org>; Sat, 12 Dec 2020 15:37:55 -0800 (PST)
X-Gm-Message-State: gzRd3RM9piwwfQiliBYL6BmXx4520388AA=
X-Google-Smtp-Source: ABdhPJysAu43q3kv6/3Rf4lX4Zf95zPTvOmoNB0xsicDIefdjNaH5gQsp2vZCyQMy0GRRsv2cJ8mJQ==
X-Received: by 2002:a17:90b:d93:: with SMTP id bg19mr19143293pjb.46.1607816274778;
        Sat, 12 Dec 2020 15:37:54 -0800 (PST)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b11sm14326178pjl.41.2020.12.12.15.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Dec 2020 15:37:54 -0800 (PST)
Message-ID: <5fd55452.1c69fb81.a82f6.af20@mx.google.com>
Date: Sat, 12 Dec 2020 15:37:54 -0800 (PST)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.248-cip52
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.4.y-cip baseline: 63 runs, 8 regressions (v4.4.248-cip52)
To: cip-dev@lists.cip-project.org, kernel-build-reports@lists.linaro.org,
 kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="8VuKRmTkWBgPGx1dkbwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1607817110;
 bh=vSOQNefs0b7HXvV4YL271jeRuvksdYE7i56lGSt40lM=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=SqJNPfNJdFgHKjZ6YAL0iTkYWB1KZAq2/Hz1tLMEkcXUQWW+XkuIlgEiEr9m9eMaSAJ
 Y2l3DPbAKSntBrLT43zSAuw3FxCCta1tXjKYzgNn0BxmuyF3RGqSxv0sBw8pI27RBiJLQ
 B7S7RBO6ltl2Jmlhc+YwgQIfJd9piylfncA=

--8VuKRmTkWBgPGx1dkbwT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline: 63 runs, 8 regressions (v4.4.248-cip52)

Regressions Summary
-------------------

platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.248-cip52/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.248-cip52
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      3fecc3c2a2819c00d436c98534c751793ccbc2ee =



Test Regressions
---------------- =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54bd83a1f5fc4e4c94cd2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54bd83a1f5fc4e4c94=
cd3
        failing since 17 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54c9e9d5f85cf6ec94cc1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54c9e9d5f85cf6ec94=
cc2
        failing since 17 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54be13c69561196c94cbc

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54be13c69561196c94=
cbd
        failing since 17 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54ca6500c952c2fc94cb9

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54ca6500c952c2fc94=
cba
        failing since 17 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54bd6cef5824088c94d07

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54bd6cef5824088c94=
d08
        failing since 17 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54ca45579e6ad61c94ce1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54ca45579e6ad61c94=
ce2
        failing since 17 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54bdc3a1f5fc4e4c94cdf

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54bdc3a1f5fc4e4c94=
ce0
        failing since 17 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/5fd54cef36f4dce7ddc94cbd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.248-c=
ip52/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-4-g97706c5d9567/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/5fd54cef36f4dce7ddc94=
cbe
        failing since 17 days (last pass: v4.4.243-cip51, first fail: v4.4.=
243-cip51-10-gd7466739b72e9) =

 =20

--8VuKRmTkWBgPGx1dkbwT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5954): https://lists.cip-project.org/g/cip-dev/message=
/5954
Mute This Topic: https://lists.cip-project.org/mt/78918702/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--8VuKRmTkWBgPGx1dkbwT--
