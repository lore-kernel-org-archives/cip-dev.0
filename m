Return-Path: <SRS0=gDmR=KJ=lists.cip-project.org=bounce+64572+6459+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F60DC433ED
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 15:51:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1BF161444
	for <cip-dev@archiver.kernel.org>; Fri, 14 May 2021 15:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BF161444
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6459+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KxijYY4521723xRghRG2M59t; Fri, 14 May 2021 08:51:18 -0700
X-Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web09.10689.1621007477873246200
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 May 2021 08:51:17 -0700
X-Received: by mail-pj1-f43.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1541761pjx.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 May 2021 08:51:17 -0700 (PDT)
X-Gm-Message-State: BLlkQco3oVIOE0Fmzqq3zsecx4520388AA=
X-Google-Smtp-Source: ABdhPJxjk7ecT71b3z9jWOwCy7Gb/aghRiGbIPkPcLA2enObfPHQiA/vuSBWLFuZOKt2lzbEwd3h5g==
X-Received: by 2002:a17:902:a40e:b029:e9:7253:8198 with SMTP id p14-20020a170902a40eb02900e972538198mr46627391plq.82.1621007477125;
        Fri, 14 May 2021 08:51:17 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z62sm4300193pfb.110.2021.05.14.08.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 08:51:16 -0700 (PDT)
Message-ID: <609e9c74.1c69fb81.eb3cf.eb7b@mx.google.com>
Date: Fri, 14 May 2021 08:51:16 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.188-cip48-2-g1296cf66cc52
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 13 runs, 3 regressions (v4.19.188-cip48-2-g1296cf66cc52) #kernelci
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
Content-Type: multipart/mixed; boundary="sjUR6mzMAE6FbpUdsnVe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1621007478;
 bh=bGJ0Y0sV6wa3Ghz6lHou2O6YTmo6HkY5bxdBf+Q3V0k=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=pzTpKm1/++N+G/c9uhXdz48s87S1bPOvfa6SOCajGzpgf33xt6XTFKNxVUmFxhjZem0
 t5zk7v1HRYtEuhiZkfrR+GAhSiBOlS+sUDl8qSjNALw2tu3B8MBHTbYD1dvLf3u/hdqXl
 X0LvWPw4vKEQ4lVNiHGxWrh1hTuBJMHZRvc=

--sjUR6mzMAE6FbpUdsnVe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 13 runs, 3 regressions (v4.19.188-cip48-=
2-g1296cf66cc52)

Regressions Summary
-------------------

platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
dove-cubox            | arm   | lab-pengutronix | gcc-8    | multi_v7_defco=
nfig | 1          =

meson-gxm-khadas-vim2 | arm64 | lab-baylibre    | gcc-8    | defconfig     =
     | 1          =

meson-gxm-q200        | arm64 | lab-baylibre    | gcc-8    | defconfig     =
     | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.188-cip48-2-g1296cf66cc52/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.188-cip48-2-g1296cf66cc52
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1296cf66cc5254f1ef6bfe19945e0bc2d81b65a7 =



Test Regressions
---------------- =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
dove-cubox            | arm   | lab-pengutronix | gcc-8    | multi_v7_defco=
nfig | 1          =


  Details:     https://kernelci.org/test/plan/id/609e94cde963cf5b6ab3afa2

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baselin=
e-nfs-dove-cubox.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baselin=
e-nfs-dove-cubox.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/609e94cde963cf5b6=
ab3afa3
        failing since 18 days (last pass: v4.19.186-cip47-1-g4c2cb7ba796b, =
first fail: v4.19.188-cip48) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre    | gcc-8    | defconfig     =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/609e9be3b64cddf835b3afa1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meso=
n-gxm-khadas-vim2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meso=
n-gxm-khadas-vim2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/609e9be3b64cddf83=
5b3afa2
        failing since 53 days (last pass: v4.19.177-cip44, first fail: v4.1=
9.182-cip45) =

 =



platform              | arch  | lab             | compiler | defconfig     =
     | regressions
----------------------+-------+-----------------+----------+---------------=
-----+------------
meson-gxm-q200        | arm64 | lab-baylibre    | gcc-8    | defconfig     =
     | 1          =


  Details:     https://kernelci.org/test/plan/id/609e9bc5e980807981b3afa5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meso=
n-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.188=
-cip48-2-g1296cf66cc52/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meso=
n-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0503.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/609e9bc5e98080798=
1b3afa6
        failing since 53 days (last pass: v4.19.169-cip42, first fail: v4.1=
9.182-cip45) =

 =20

--sjUR6mzMAE6FbpUdsnVe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6459): https://lists.cip-project.org/g/cip-dev/message=
/6459
Mute This Topic: https://lists.cip-project.org/mt/82827667/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--sjUR6mzMAE6FbpUdsnVe--
