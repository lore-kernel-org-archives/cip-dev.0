Return-Path: <SRS0=6f8t=M2=lists.cip-project.org=bounce+64572+6653+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1D3C4338F
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 17:34:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AC460F9C
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 17:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97AC460F9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OKoOYY4521723xLzUlAjxbBE; Tue, 03 Aug 2021 10:34:10 -0700
X-Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web12.1910.1628012049826946541
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 03 Aug 2021 10:34:09 -0700
X-Received: by mail-pj1-f47.google.com with SMTP id nh14so18838423pjb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 03 Aug 2021 10:34:09 -0700 (PDT)
X-Gm-Message-State: U7jN1JnmgM43bgQcidi55Q4Hx4520388AA=
X-Google-Smtp-Source: ABdhPJwPPRbVBvyEu5tgvV4tqDkUVTJtgYbYFLeoZ2n6aWsyX62vdIB9tMv6LuM2B+DjshipLfX8kQ==
X-Received: by 2002:a63:5b24:: with SMTP id p36mr109612pgb.91.1628012049009;
        Tue, 03 Aug 2021 10:34:09 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y67sm11839567pfg.218.2021.08.03.10.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 10:34:08 -0700 (PDT)
Message-ID: <61097e10.1c69fb81.ca66.132b@mx.google.com>
Date: Tue, 03 Aug 2021 10:34:08 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Branch: linux-4.4.y-cip-rt
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4.277-cip60-rt35
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.4.y-cip-rt baseline: 151 runs, 10 regressions (v4.4.277-cip60-rt35) #kernelci
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
Content-Type: multipart/mixed; boundary="sUWhgxY04MgGz911HiSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628012050;
 bh=1CxsRx/C7DdYwO2NnEVxBao2BcpqPo8MyvVULNazz2Y=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=nrqXuti1LLrf4JUZdeFvGzlrdS1aILGn/w3Ee/FI5sMs61ybN1pQWd79vV41WNF9jIg
 IeqAIF39vML8cvKwV9WYTly9mgkt+0KjldZou1Bwee1TjzimPt8WaT6ow6L3jdHxmVDkJ
 UgC8kqP39INtihjGYBd9D3SZyOLeYGRAg5o=

--sUWhgxY04MgGz911HiSW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.4.y-cip-rt baseline: 151 runs, 10 regressions (v4.4.277-cip60-r=
t35)

Regressions Summary
-------------------

platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =

qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =

qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip-rt/ker=
nel/v4.4.277-cip60-rt35/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-4.4.y-cip-rt
  Describe: v4.4.277-cip60-rt35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      11d4c8f3cf9d373ef6dc3e7a8cb914ca1a41dc0c =



Test Regressions
---------------- =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/610971016cece053e8b136d6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/610971016cece053e8b13=
6d7
        failing since 254 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/610977e3a435ed892fb13669

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/610977e3a435ed892fb13=
66a
        failing since 254 days (last pass: v4.4.235-cip49-rt31, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/6109710e5ace51a7beb13669

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6109710e5ace51a7beb13=
66a
        failing since 254 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/610977e04a2dcf9614b13662

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/610977e04a2dcf9614b13=
663
        failing since 254 days (last pass: v4.4.235-cip49-rt31, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv2 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/61097639cc509ea7a9b13687

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-v=
irt-gicv2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-v=
irt-gicv2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61097639cc509ea7a9b13=
688
        failing since 254 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/610970767938a87c2db1366e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-qemu_arm-vi=
rt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/610970767938a87c2db13=
66f
        failing since 254 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-baylibre  | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/610977bcd85f27c8deb1366e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-baylibre/basel=
ine-qemu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/610977bcd85f27c8deb13=
66f
        failing since 254 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/610970836686a56843b136b0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-cip/baseline-qemu_arm-virt-gi=
cv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/610970836686a56843b13=
6b1
        failing since 254 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-cip       | gcc-8    | multi_v7_defc...CON=
FIG_SMP=3Dn | 1          =


  Details:     https://kernelci.org/test/plan/id/610977c6e0a2df90e2b13671

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig+CONFIG_SMP=3Dn
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig+CONFIG_SMP=3Dn/gcc-8/lab-cip/baseline-q=
emu_arm-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/610977c6e0a2df90e2b13=
672
        failing since 254 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =



platform            | arch | lab           | compiler | defconfig          =
          | regressions
--------------------+------+---------------+----------+--------------------=
----------+------------
qemu_arm-virt-gicv3 | arm  | lab-collabora | gcc-8    | multi_v7_defconfig =
          | 1          =


  Details:     https://kernelci.org/test/plan/id/61097594f468268848b13691

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-v=
irt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip-rt/v4.4.27=
7-cip60-rt35/arm/multi_v7_defconfig/gcc-8/lab-collabora/baseline-qemu_arm-v=
irt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/kci-2020=
.05-6-g8983f3b738df/armel/baseline/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/61097594f468268848b13=
692
        failing since 254 days (last pass: v4.4.231-cip47-rt30, first fail:=
 v4.4.244-cip51-rt32) =

 =20

--sUWhgxY04MgGz911HiSW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6653): https://lists.cip-project.org/g/cip-dev/message=
/6653
Mute This Topic: https://lists.cip-project.org/mt/84644247/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--sUWhgxY04MgGz911HiSW--
