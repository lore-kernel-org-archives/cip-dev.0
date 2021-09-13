Return-Path: <SRS0=Hg7J=OD=lists.cip-project.org=bounce+64572+6729+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DBBC433EF
	for <cip-dev@archiver.kernel.org>; Mon, 13 Sep 2021 00:27:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3490460F35
	for <cip-dev@archiver.kernel.org>; Mon, 13 Sep 2021 00:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3490460F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id q1b5YY4521723xKlQgiBeRrE; Sun, 12 Sep 2021 17:27:38 -0700
X-Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web12.23173.1631492858311346622
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Sep 2021 17:27:38 -0700
X-Received: by mail-pj1-f50.google.com with SMTP id j1so5068751pjv.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Sep 2021 17:27:38 -0700 (PDT)
X-Gm-Message-State: NaPhZGx9WUkP0tnQPLezrJ50x4520388AA=
X-Google-Smtp-Source: ABdhPJyUKOXGo3SqsOuH2aZvcQ0RgF+vIWJaTR++S5pt0iehZZ0rUPlukO8wUc9q9F/uIMIlwhGTXw==
X-Received: by 2002:a17:90b:1957:: with SMTP id nk23mr10014031pjb.180.1631492857555;
        Sun, 12 Sep 2021 17:27:37 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k12sm4834871pjm.52.2021.09.12.17.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 17:27:37 -0700 (PDT)
Message-ID: <613e9af9.1c69fb81.38791.cce9@mx.google.com>
Date: Sun, 12 Sep 2021 17:27:37 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.283-cip62
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip
Subject: [cip-dev] cip/linux-4.4.y-cip baseline: 232 runs, 16 regressions (v4.4.283-cip62) #kernelci
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
Content-Type: multipart/mixed; boundary="fZd2XEd4W9bDrJT3xSMD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631492858;
 bh=+cZBSjtLRxbqz5ztzjXElcNN8VaMjE0VV3UyPADAMhk=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=BARkNrqhGkjN9efP47JSMDOUlHjqXiDuvFsdnHTnHEFPPTSi+7ieqS5mOZrI8RF67yA
 89sOD75DfULiNCCEX0CyrpgCsqGIpdOjzLEFXzjW8aJ1bdXXT28vxLcqo4BCYYPGzc24E
 X2a9DeRoqlyiqI/paBJBdGba4tkJGmdLKa4=

--fZd2XEd4W9bDrJT3xSMD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline: 232 runs, 16 regressions (v4.4.283-cip62)

Regressions Summary
-------------------

platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-broonie   | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-broonie   | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-broonie   | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-broonie   | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.283-cip62/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.283-cip62
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      823da4b312f214a4d0f750f9cb6157dcd47769fb =



Test Regressions
---------------- =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/613e94543069d740dad5966a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e94543069d740dad59=
66b
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/613e967049c475541cd59666

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e967049c475541cd59=
667
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-broonie   | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/613e95f782409ce783d596b2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e95f782409ce783d59=
6b3
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-broonie   | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/613e9954b70c3bdc95d596ff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-virt-gicv2.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-virt-gicv2.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e9954b70c3bdc95d59=
700
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/613e94cd21b49a6edfd59692

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e94cd21b49a6edfd59=
693
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/613e9751ec17021a43d59684

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e9751ec17021a43d59=
685
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/613e96601a9f7390d6d5968a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e96601a9f7390d6d59=
68b
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/613e9a2bd8532e9f3dd5966a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e9a2bd8532e9f3dd59=
66b
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/613e93a07a344c351bd59676

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e93a07a344c351bd59=
677
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/613e96206f8e305043d59671

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e96206f8e305043d59=
672
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-broonie   | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/613e94f294a39d16add5968f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e94f294a39d16add59=
690
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-broonie   | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/613e984f74a7c9def1d5968a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-virt-gicv3.=
txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-broonie/baseline-qemu_arm-virt-gicv3.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e984f74a7c9def1d59=
68b
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/613e9441ca4f137f90d5966b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e9441ca4f137f90d59=
66c
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/613e96d79cf7f9db08d5966b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e96d79cf7f9db08d59=
66c
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/613e954e05d600ec7fd5967a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e954e05d600ec7fd59=
67b
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/613e996708558e109ad596b8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.283-c=
ip62/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/613e996708558e109ad59=
6b9
        failing since 291 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =20

--fZd2XEd4W9bDrJT3xSMD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6729): https://lists.cip-project.org/g/cip-dev/message/=
6729
Mute This Topic: https://lists.cip-project.org/mt/85564417/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--fZd2XEd4W9bDrJT3xSMD--
