Return-Path: <SRS0=WhpQ=OZ=lists.cip-project.org=bounce+64572+6782+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A710EC433F5
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 04:32:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D4336136F
	for <cip-dev@archiver.kernel.org>; Tue,  5 Oct 2021 04:32:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D4336136F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id A9aZYY4521723xEbwIQo5JMK; Mon, 04 Oct 2021 21:32:51 -0700
X-Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web08.21122.1633408371185448097
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Oct 2021 21:32:51 -0700
X-Received: by mail-pj1-f45.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so1023851pjw.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 04 Oct 2021 21:32:51 -0700 (PDT)
X-Gm-Message-State: r4Q5G4O25eVWqllJqYWgG07Qx4520388AA=
X-Google-Smtp-Source: ABdhPJxCEegja2Y5KsfDEPS9Aw1scKAFnp8U3PbvX9xEDZmFqgsBCUe16xY4waElQ/X1vqGxAXdYkw==
X-Received: by 2002:a17:902:eac5:b0:13e:292f:266a with SMTP id p5-20020a170902eac500b0013e292f266amr3303868pld.10.1633408370438;
        Mon, 04 Oct 2021 21:32:50 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p9sm16598343pgn.36.2021.10.04.21.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 21:32:50 -0700 (PDT)
Message-ID: <615bd572.1c69fb81.7a509.44e9@mx.google.com>
Date: Mon, 04 Oct 2021 21:32:50 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Kernel: v4.4.285-cip63-rt36
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-cip-rt
Subject: [cip-dev] cip/linux-4.4.y-cip-rt baseline: 108 runs, 8 regressions (v4.4.285-cip63-rt36) #kernelci
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
Content-Type: multipart/mixed; boundary="yizXYGvCp0IdNIodrEGU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1633408371;
 bh=4E5xHB0rR0xRCosoIcorgGEjvYrWKQh3ZG0/abjwEvw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Ct7/zHStDurp2W1P4gu0DDVl2gEHeVUaIXXeDDx6fQTRk8+cZMHrJKeQTxid0VR2YxG
 bCDzOzwt1wCQlTAZbVOllr9uxz6olmZFJRwN5+DPMUQSd15pOWhLlYrHR/wMv6ZrAO3dv
 MSNRr3hAsEdWQ+LZUOer4G0xcpDl5Rs7+Wk=

--yizXYGvCp0IdNIodrEGU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip-rt baseline: 108 runs, 8 regressions (v4.4.285-cip63-rt=
36)

Regressions Summary
-------------------

platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.285-cip63-rt36/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.285-cip63-rt36
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      ed9fad48752d076117300317879659c2e041d4b4 =



Test Regressions
---------------- =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/615bc4d922a31df5a299a2fd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/615bc4d922a31df5a299a=
2fe
        failing since 316 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/615bc911025b6b4f7299a36b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/615bc911025b6b4f7299a=
36c
        failing since 316 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/615bc7771283daea0899a2db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/615bc7771283daea0899a=
2dc
        failing since 316 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/615bcd27d3e7faac3199a3da

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/615bcd27d3e7faac3199a=
3db
        failing since 316 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/615bc4d88971e6bd5899a2df

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/615bc4d88971e6bd5899a=
2e0
        failing since 316 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/615bc94dbeea8ad29799a2ec

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/615bc94dbeea8ad29799a=
2ed
        failing since 316 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defconfig  =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/615bc6ff3e7e39dfa199a303

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/615bc6ff3e7e39dfa199a=
304
        failing since 316 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab          | compiler | defconfig           =
         | regressions
--------------------+------+--------------+----------+---------------------=
---------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip      | gcc-8    | multi_v7_defc...CONF=
IG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/615bcd9ff91852fbfd99a359

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.28=
5-cip63-rt36/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/615bcd9ff91852fbfd99a=
35a
        failing since 316 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =20

--yizXYGvCp0IdNIodrEGU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6782): https://lists.cip-project.org/g/cip-dev/message/=
6782
Mute This Topic: https://lists.cip-project.org/mt/86086469/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelci
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--yizXYGvCp0IdNIodrEGU--
