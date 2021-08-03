Return-Path: <SRS0=1r3+=M2=lists.cip-project.org=bounce+64572+6649+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85ABC4338F
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 05:23:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB63A60F8F
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 05:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB63A60F8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ytdzYY4521723xPkcrgMH4qI; Mon, 02 Aug 2021 22:23:11 -0700
X-Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web09.1312.1627968190984614186
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 02 Aug 2021 22:23:11 -0700
X-Received: by mail-pl1-f176.google.com with SMTP id i10so22321201pla.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 02 Aug 2021 22:23:10 -0700 (PDT)
X-Gm-Message-State: El1dvMKkseBlDZnfmQUQlQkPx4520388AA=
X-Google-Smtp-Source: ABdhPJykTjwdI9FTKwkVS2/p8TEwhHmjdMD8u/sjWgRmYrGjo2hcBLMS6PZ+TxU9lwQRpwPiv/l5Zw==
X-Received: by 2002:a17:902:c9c3:b029:12c:8f2d:4235 with SMTP id q3-20020a170902c9c3b029012c8f2d4235mr17346288pld.9.1627968190229;
        Mon, 02 Aug 2021 22:23:10 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 26sm15885682pgx.72.2021.08.02.22.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 22:23:09 -0700 (PDT)
Message-ID: <6108d2bd.1c69fb81.514a.ead3@mx.google.com>
Date: Mon, 02 Aug 2021 22:23:09 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.277-cip60
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.4.y-cip baseline: 142 runs, 14 regressions (v4.4.277-cip60) #kernelci
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
Content-Type: multipart/mixed; boundary="7Ijf6OCFgDJLIPbsBMlQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627968191;
 bh=V1Z9FPROrJgxNxxMrbqRN8tqArg9040LFwP7+JGrB0o=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=d0QB0kLsnHloJqe+pC/m5Vua6brjHKrj4KzCR9UB+wXlh8Bn+vgPo55ZfFp0ERGij+a
 0GH8XbBH6/YJkNgfcshjg7IGemEOl1GrhAfKmAl3POxpM4hFhREh/azw6uFhpTWjEoQjO
 s5Y7fY99PLQQ7ODMcTHVB82jR4/O1OAGw9w=

--7Ijf6OCFgDJLIPbsBMlQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip baseline: 142 runs, 14 regressions (v4.4.277-cip60)

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

qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.277-cip60/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.277-cip60
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6012d2c32efa70a548d6e59b763c39bb0d38f2e0 =



Test Regressions
---------------- =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6108beed68b4d93720b13688

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108beed68b4d93720b13=
689
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6108c11ea314bc4a83b13663

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv2=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108c11ea314bc4a83b13=
664
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-broonie   | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6108d1bbfe14da96a1b13661

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108d1bbfe14da96a1b13=
662
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6108bff54d19fc37d4b13689

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108bff54d19fc37d4b13=
68a
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6108c28158d2e148b3b13661

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108c28158d2e148b3b13=
662
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6108ca399a20430fc0b1368a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108ca399a20430fc0b13=
68b
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6108cd9ba9ffdeb873b13673

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108cd9ba9ffdeb873b13=
674
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6108beb00add7769e8b1367b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/baseline-qemu=
_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108beb00add7769e8b13=
67c
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6108c0a5c045fbd09fb1366f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-virt-gicv3=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108c0a5c045fbd09fb13=
670
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-broonie   | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6108d0cbf222304fabb13661

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-broonie/baseline-qemu_=
arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108d0cbf222304fabb13=
662
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6108bfbda519e66230b13661

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-qemu_arm-=
virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108bfbda519e66230b13=
662
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6108c1d9ca3b42c6f4b1367a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108c1d9ca3b42c6f4b13=
67b
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/6108c9bc4d0f60b800b136b2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-collabora/baseline-qem=
u_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108c9bc4d0f60b800b13=
6b3
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6108cd7105f2ec39a1b13674

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.277-c=
ip60/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-virt-gicv=
3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6108cd7105f2ec39a1b13=
675
        failing since 250 days (last pass: v4.4.243-cip51, first fail: v4.4=
.243-cip51-10-gd7466739b72e9) =

 =20

--7Ijf6OCFgDJLIPbsBMlQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6649): https://lists.cip-project.org/g/cip-dev/message=
/6649
Mute This Topic: https://lists.cip-project.org/mt/84632771/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7Ijf6OCFgDJLIPbsBMlQ--
