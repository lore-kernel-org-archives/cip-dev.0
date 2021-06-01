Return-Path: <SRS0=mlYk=K3=lists.cip-project.org=bounce+64572+6487+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE7BC47080
	for <cip-dev@archiver.kernel.org>; Tue,  1 Jun 2021 10:19:36 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB956139A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Jun 2021 10:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB956139A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6487+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Q7K0YY4521723xHWiBVUCDLx; Tue, 01 Jun 2021 03:19:35 -0700
X-Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web08.55971.1622542774827331418
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 01 Jun 2021 03:19:34 -0700
X-Received: by mail-pj1-f53.google.com with SMTP id m13-20020a17090b068db02901656cc93a75so1126706pjz.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 01 Jun 2021 03:19:34 -0700 (PDT)
X-Gm-Message-State: qO8mCPYIK3TOdo7WNka5neJux4520388AA=
X-Google-Smtp-Source: ABdhPJwzuaZId229fGuXTWCEiOjKNWjxbOwH6zEYHztBr7cfan3RwDu6h84/jsza2LAfqjQIFMqpRg==
X-Received: by 2002:a17:902:d512:b029:104:ea04:4897 with SMTP id b18-20020a170902d512b0290104ea044897mr9671364plg.66.1622542774035;
        Tue, 01 Jun 2021 03:19:34 -0700 (PDT)
X-Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h124sm658282pfe.186.2021.06.01.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 03:19:33 -0700 (PDT)
Message-ID: <60b609b5.1c69fb81.18efa.17ab@mx.google.com>
Date: Tue, 01 Jun 2021 03:19:33 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.192-cip50
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Report-Type: test
Subject: [cip-dev] cip/linux-4.19.y-cip baseline-nfs: 41 runs, 4 regressions (v4.19.192-cip50) #kernelci
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
Content-Type: multipart/mixed; boundary="v1OKtHWMBNqVvF1TCGEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1622542775;
 bh=XZi7YJn1ADO7jKJ3+43M2WuDrKoMZlXuMX4kevITgqw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=VYVXAIcVepjzCXcKS28pqxgBcmneJk4SmU3tWNypQ1Jo9ZwgnV7+WS1htaxHRlUyQEC
 rErcbDcFBTrxPp4/nZzkh4StanDg8OtP8Lz65dcWF5ObQ38/znwdZeldGLCoYS33QtP4h
 5U5mBoElf+9AU4fl/Z4vzrxWtooyllj5h/o=

--v1OKtHWMBNqVvF1TCGEw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

cip/linux-4.19.y-cip baseline-nfs: 41 runs, 4 regressions (v4.19.192-cip50)

Regressions Summary
-------------------

platform                  | arch  | lab             | compiler | defconfig =
         | regressions
--------------------------+-------+-----------------+----------+-----------=
---------+------------
dove-cubox                | arm   | lab-pengutronix | gcc-8    | multi_v7_d=
efconfig | 1          =

meson-gxm-khadas-vim2     | arm64 | lab-baylibre    | gcc-8    | defconfig =
         | 1          =

meson-gxm-q200            | arm64 | lab-baylibre    | gcc-8    | defconfig =
         | 1          =

sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre    | gcc-8    | multi_v7_d=
efconfig | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.192-cip50/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.192-cip50
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b07208f6cd5664fa3a2e5c7403dfd3a27ef5daac =



Test Regressions
---------------- =



platform                  | arch  | lab             | compiler | defconfig =
         | regressions
--------------------------+-------+-----------------+----------+-----------=
---------+------------
dove-cubox                | arm   | lab-pengutronix | gcc-8    | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60b5fc51acb198ad07b3af98

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/multi_v7_defconfig/gcc-8/lab-pengutronix/baseline-nfs-dove-cubox=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60b5fc51acb198ad0=
7b3af99
        failing since 36 days (last pass: v4.19.186-cip47-1-g4c2cb7ba796b, =
first fail: v4.19.188-cip48) =

 =



platform                  | arch  | lab             | compiler | defconfig =
         | regressions
--------------------------+-------+-----------------+----------+-----------=
---------+------------
meson-gxm-khadas-vim2     | arm64 | lab-baylibre    | gcc-8    | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/60b600506b4cc82890b3afca

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-khadas-vim=
2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-khadas-vim=
2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60b600506b4cc8289=
0b3afcb
        failing since 71 days (last pass: v4.19.177-cip44, first fail: v4.1=
9.182-cip45) =

 =



platform                  | arch  | lab             | compiler | defconfig =
         | regressions
--------------------------+-------+-----------------+----------+-----------=
---------+------------
meson-gxm-q200            | arm64 | lab-baylibre    | gcc-8    | defconfig =
         | 1          =


  Details:     https://kernelci.org/test/plan/id/60b6004ba2c2ac856fb3af99

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-8 (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-q200.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm64/defconfig/gcc-8/lab-baylibre/baseline-nfs-meson-gxm-q200.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60b6004ba2c2ac856=
fb3af9a
        failing since 71 days (last pass: v4.19.169-cip42, first fail: v4.1=
9.182-cip45) =

 =



platform                  | arch  | lab             | compiler | defconfig =
         | regressions
--------------------------+-------+-----------------+----------+-----------=
---------+------------
sun7i-a20-olinuxino-lime2 | arm   | lab-baylibre    | gcc-8    | multi_v7_d=
efconfig | 1          =


  Details:     https://kernelci.org/test/plan/id/60b5fef66530a2fbaab3af9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-8 (arm-linux-gnueabihf-gcc (Debian 8.3.0-2) 8.3.0)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-oli=
nuxino-lime2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.192=
-cip50/arm/multi_v7_defconfig/gcc-8/lab-baylibre/baseline-nfs-sun7i-a20-oli=
nuxino-lime2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/buster/2021=
0520.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/60b5fef66530a2fba=
ab3afa0
        failing since 16 days (last pass: v4.19.182-cip45-40-g0e469137cd784=
, first fail: v4.19.188-cip48-2-g1296cf66cc52) =

 =20

--v1OKtHWMBNqVvF1TCGEw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6487): https://lists.cip-project.org/g/cip-dev/message=
/6487
Mute This Topic: https://lists.cip-project.org/mt/83228829/4520388
Mute #kernelci:https://lists.cip-project.org/g/cip-dev/mutehashtag/kernelc=
i
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--v1OKtHWMBNqVvF1TCGEw--
