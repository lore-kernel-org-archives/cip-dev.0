Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF07C25B6F
	for <webhook@archiver.kernel.org>; Fri, 27 Oct 2023 13:08:36 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.6469.1698412111456049660
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 27 Oct 2023 06:08:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=NRIugfQD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6be840283ceso2014794b3a.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 27 Oct 2023 06:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1698412110; x=1699016910; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ppALNiJF5xe6BQI9u7rturqQYsFRLgVndPKQfSpcilo=;
        b=NRIugfQDkTPBSHcUrrzITLBDulgHw/Qc8vCJ4ZJ2f1Qpul9qVFnNinBTAJ+9YMCAed
         qjl7NmsD6O7oQWtCllL+n4ju9Jd9WJq6nULD8DyV/mN5ZZI9+dxxPON9lbrwqUjhSRte
         XTQNXp/ZQ9ESL4gKs8dsT379ZveQm2VbXmBGphLR7RTycn2yq1yxkPG9wuGqXAYPrx0J
         f1rPq1ISjeH6HXl/QainmCrqzGhYSiE+mttuopSl0oPE/CUyo5rXOuZ0/DRIC3q/1uHs
         HPvbLxCx/F4QeK77rFfPW01OnFlZMMwwPxP+TwuQQT1NLIqaXoeRLtezqlF506Lu9/4F
         MwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698412110; x=1699016910;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppALNiJF5xe6BQI9u7rturqQYsFRLgVndPKQfSpcilo=;
        b=Vk8ZluKFQ+TPsokrBbAWRmukbpca3PcXzBZzATXgICyk/nUT0oKpVUs+NLMDDQYnLN
         eS0uE8CLXQF9KTJ5UuwPAldPhxLyert6i3RBcmUzmsGmP/7C7i1MGL2UXC0hiIaTXV7Z
         OA3NUDksQgO2171gRal7ya5aZSqkmVfyIT6pbwkiWzUNZ1LKbF48KisDiKWSGI55B+IC
         6D8gwYAsrMCfwsvTps9BrAMNXzhf5o3MUigG09u1cTGnjaNCy4d7WPI0iqJE7crwJRUX
         wmJ3sQzvigiA2E5XCz7kR51Pzg1Q19X8Z9mJXXkIoKLmoZM2V8NHXJXhs1+PbqbIdGxh
         Nk1Q==
X-Gm-Message-State: AOJu0YzAaEBUj/2aqbRo+qzum1507VWLlqiaZzIILrcxWNsrTy0zywUV
	vX5lIPAjsTIHZxq+JucrbH6yGRc2dlwe97JwxTQ=
X-Google-Smtp-Source: AGHT+IH0oIYCU42F+aecZsUCvq6D2w/jnZRFOiXSLCnkVVsodHF+iv2qAqhPu2Cz7pVfjkI13gYvwQ==
X-Received: by 2002:a05:6a20:3d92:b0:15d:e8ce:145 with SMTP id s18-20020a056a203d9200b0015de8ce0145mr2910334pzi.21.1698412110035;
        Fri, 27 Oct 2023 06:08:30 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z17-20020a637e11000000b0058c1383fa8bsm1103698pgc.0.2023.10.27.06.08.28
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:08:29 -0700 (PDT)
Message-ID: <653bb64d.630a0220.8289b.2f1a@mx.google.com>
Date: Fri, 27 Oct 2023 06:08:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.58-cip7-132-gb38ea1474c159
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 47 runs,
 5 regressions (v6.1.58-cip7-132-gb38ea1474c159)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Oct 2023 13:08:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13476

cip-gitlab/ci/pavel/linux-test baseline-nfs: 47 runs, 5 regressions (v6.1.5=
8-cip7-132-gb38ea1474c159)

Regressions Summary
-------------------

platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
at91sam9g20ek      | arm   | lab-broonie | gcc-10   | multi_v5_defconfig  |=
 1          =

bcm2835-rpi-b-rev2 | arm   | lab-broonie | gcc-10   | bcm2835_defconfig   |=
 1          =

imx6dl-udoo        | arm   | lab-broonie | gcc-10   | imx_v6_v7_defconfig |=
 1          =

imx6q-udoo         | arm   | lab-broonie | gcc-10   | imx_v6_v7_defconfig |=
 1          =

imx8mp-evk         | arm64 | lab-broonie | gcc-10   | defconfig           |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.58-cip7-132-gb38ea1474c159/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.58-cip7-132-gb38ea1474c159
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b38ea1474c1591eafe6d4659c33713917887c7a2 =



Test Regressions
---------------- =



platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
at91sam9g20ek      | arm   | lab-broonie | gcc-10   | multi_v5_defconfig  |=
 1          =


  Details:     https://kernelci.org/test/plan/id/653baab933a61d29aeefcefd

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/multi_v5_defconfig/gcc-10/lab-broonie/=
baseline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/653baab933a61d29aeefcf36
        new failure (last pass: v5.10.194-915-g33f52aa14b957)

    2023-10-27T12:18:26.028624  + set +x
    2023-10-27T12:18:26.028912  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 203448_1.6.2=
.4.1>
    2023-10-27T12:18:26.161028  #
    2023-10-27T12:18:26.263128  / # #export SHELL=3D/bin/sh
    2023-10-27T12:18:26.263602  =

    2023-10-27T12:18:26.364952  / # export SHELL=3D/bin/sh. /lava-203448/en=
vironment
    2023-10-27T12:18:26.365441  =

    2023-10-27T12:18:26.466864  / # . /lava-203448/environment/lava-203448/=
bin/lava-test-runner /lava-203448/1
    2023-10-27T12:18:26.467663  =

    2023-10-27T12:18:26.471479  / # /lava-203448/bin/lava-test-runner /lava=
-203448/1 =

    ... (12 line(s) more)  =

 =



platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
bcm2835-rpi-b-rev2 | arm   | lab-broonie | gcc-10   | bcm2835_defconfig   |=
 1          =


  Details:     https://kernelci.org/test/plan/id/653ba6980f33ff5941efcefd

  Results:     50 PASS, 2 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/bcm2835_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-bcm2835-rpi-b-rev2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/bcm2835_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-bcm2835-rpi-b-rev2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/653ba6980f33ff5941efcf32
        new failure (last pass: v5.10.177-cip31-33-gd59f246891e73)

    2023-10-27T12:00:47.188816  + set +x
    2023-10-27T12:00:47.193060  <8>[   58.955335] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 203305_1.6.2.4.1>
    2023-10-27T12:00:47.310790  #
    2023-10-27T12:00:47.413108  / # #export SHELL=3D/bin/sh
    2023-10-27T12:00:47.413573  =

    2023-10-27T12:00:47.515080  / # export SHELL=3D/bin/sh. /lava-203305/en=
vironment
    2023-10-27T12:00:47.515573  =

    2023-10-27T12:00:47.617066  / # . /lava-203305/environment/lava-203305/=
bin/lava-test-runner /lava-203305/1
    2023-10-27T12:00:47.617755  =

    2023-10-27T12:00:47.624064  / # /lava-203305/bin/lava-test-runner /lava=
-203305/1 =

    ... (14 line(s) more)  =

 =



platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
imx6dl-udoo        | arm   | lab-broonie | gcc-10   | imx_v6_v7_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/653ba6abb3645b2eadefcefd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6dl-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6dl-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653ba6abb3645b2ea=
defcefe
        new failure (last pass: v4.4-st20-3596-g73e7f2b880d98) =

 =



platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
imx6q-udoo         | arm   | lab-broonie | gcc-10   | imx_v6_v7_defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/653ba696affa00ee6defceff

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie=
/baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/653ba696affa00ee6=
defcf00
        new failure (last pass: v4.4-st20-3596-g73e7f2b880d98) =

 =



platform           | arch  | lab         | compiler | defconfig           |=
 regressions
-------------------+-------+-------------+----------+---------------------+=
------------
imx8mp-evk         | arm64 | lab-broonie | gcc-10   | defconfig           |=
 1          =


  Details:     https://kernelci.org/test/plan/id/653ba8364fa69190e5efcf0e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-imx8mp-evk.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.58-cip7-132-gb38ea1474c159/arm64/defconfig/gcc-10/lab-broonie/baselin=
e-nfs-imx8mp-evk.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/653ba8364fa69190e5efcf17
        new failure (last pass: v5.10.194-557-g2932db67f070a)

    2023-10-27T12:07:50.880959  + set<8>[   49.502809] <LAVA_SIGNAL_ENDRUN =
0_dmesg 203352_1.6.2.4.1>
    2023-10-27T12:07:50.881225   +x
    2023-10-27T12:07:51.000319  / # #
    2023-10-27T12:07:52.163399  export SHELL=3D/bin/sh
    2023-10-27T12:07:52.169470  #
    2023-10-27T12:07:53.664876  / # export SHELL=3D/bin/sh. /lava-203352/en=
vironment
    2023-10-27T12:07:53.671057  =

    2023-10-27T12:07:56.388125  / # . /lava-203352/environment/lava-203352/=
bin/lava-test-runner /lava-203352/1
    2023-10-27T12:07:56.394419  =

    2023-10-27T12:07:56.400152  / # /lava-203352/bin/lava-test-runner /lava=
-203352/1 =

    ... (17 line(s) more)  =

 =20

