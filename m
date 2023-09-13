Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C15EE01FE
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 17:42:32 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web10.3537.1694626945200778796
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 10:42:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=09Y2FpsO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1bc0d39b52cso189395ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 10:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694626944; x=1695231744; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6z9X3ScuR11tNnJYeW2l3kgIqQoDBaSGcWsY4fKAzMc=;
        b=09Y2FpsOLJVIrmcm22LmtxX5QRyM8aAFRhVcq/DOBO1Y03YicJ2t6TQ7aYleZAlfVJ
         PpXHX0UodnAxEkFcvghHipuh6IS2UVKoo/gHXlseHIGgu+EvF8eX3xWFTt4XR5qsCeRZ
         yYokEvCyYBhQ2GXymDMtZ8NYtNHsI45Ig7aMOG32q79RlHplWILt8q/JVWrKyNxe/Fyb
         GQCzF0lXKsFhgvhUur6Uoip4a1gZCVt3Uu4VSaQrQAUrCgCvQIW4MBakgEJbnWmlnkNU
         KbXvgJjnimUui87+690AmBmxXmzC0NOF57hsTzDytaMczJhfbVzW3ogtpSaj09Eqktar
         REGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694626944; x=1695231744;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6z9X3ScuR11tNnJYeW2l3kgIqQoDBaSGcWsY4fKAzMc=;
        b=sO1eE0rKxi47Rzbu3MCVYeHxgysgwu5cB2bD1+4iF29IvpvlZRNmLLDOHFsmEjX5bc
         pzl1wuw6FyKRQaNMdD0aFwq5Imb4QibrwrfBAQpAyb3c3LY3h6fwHWzQy8Xwd/dmvGci
         2h666175+oiFIe3jyqSp1OzVaxvLVIq89+IKv8DsSJfq1dzdQB6dbxUtrMtBASVqdLF5
         1LKQ5JGXM/kAcYxwntH/o1Y1Yz9AzhjfIOEcajjKZ9Tb/r2VMfii23KInu0wPKx+nefJ
         ppvbK2bJG1jEt4YE//71OPL9LW/RkLya2kJb/ndmjXW5aNQmlY1VRLaeuDyWLWKUuOzW
         +uwQ==
X-Gm-Message-State: AOJu0Yyg0wYeDXcPtqWHMwQngXzGU2qymcHBdFNAOIIOj+S0k0Mc4Jx0
	pbtywuBDAfPZNAP2s0CyWpi2zOFR0jwISagEWmE=
X-Google-Smtp-Source: AGHT+IExs6kiR6qew9qB27NTGA6eDYvn3xbPiR4EsUAa1B1VueM1pz2KNhUt5mKpyZX+ueoXpRAqng==
X-Received: by 2002:a17:90a:b118:b0:26b:29b4:bfbb with SMTP id z24-20020a17090ab11800b0026b29b4bfbbmr2655398pjq.30.1694626944187;
        Wed, 13 Sep 2023 10:42:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090a300200b0026b70d2a8a2sm1717044pjb.29.2023.09.13.10.42.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:42:23 -0700 (PDT)
Message-ID: <6501f47f.170a0220.b95f7.5299@mx.google.com>
Date: Wed, 13 Sep 2023 10:42:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v6.1.52-cip5-29-g9fee06894d496
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs,
 3 regressions (v6.1.52-cip5-29-g9fee06894d496)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 17:42:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13119

cip-gitlab/ci/pavel/linux-test baseline-nfs: 15 runs, 3 regressions (v6.1.5=
2-cip5-29-g9fee06894d496)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

imx6q-udoo             | arm    | lab-broonie   | gcc-10   | imx_v6_v7_defc=
onfig          | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.52-cip5-29-g9fee06894d496/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.52-cip5-29-g9fee06894d496
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9fee06894d496c0a873d78633ef74e3395d81c89 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501eb3db2b252c08f8a0a91

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501eb3db2b252c08f8a0a9a
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-13T17:02:46.291085  + set +x

    2023-09-13T17:02:46.297584  <8>[   16.544751] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517893_1.5.2.3.1>

    2023-09-13T17:02:46.407022  / #

    2023-09-13T17:02:46.509629  # #export SHELL=3D/bin/sh

    2023-09-13T17:02:46.510316  =


    2023-09-13T17:02:46.611984  / # export SHELL=3D/bin/sh. /lava-11517893/=
environment

    2023-09-13T17:02:46.612955  =


    2023-09-13T17:02:46.714669  / # . /lava-11517893/environment/lava-11517=
893/bin/lava-test-runner /lava-11517893/1

    2023-09-13T17:02:46.716191  =


    2023-09-13T17:02:46.721801  / # /lava-11517893/bin/lava-test-runner /la=
va-11517893/1
 =

    ... (12 line(s) more)  =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501eac8dd664989b08a0a4e

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/x86_64/x86_64_defconfig+x86-chromebook/gcc-=
10/lab-collabora/baseline-nfs-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6501eac8dd664989b08a0a57
        new failure (last pass: v5.10.191-cip38-29-g9e1aa2001db86)

    2023-09-13T17:00:55.884278  <8>[   18.310750] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11517871_1.5.2.3.1>

    2023-09-13T17:00:55.887760  + set +x

    2023-09-13T17:00:55.995599  / # #

    2023-09-13T17:00:56.098072  export SHELL=3D/bin/sh

    2023-09-13T17:00:56.098900  #

    2023-09-13T17:00:56.200440  / # export SHELL=3D/bin/sh. /lava-11517871/=
environment

    2023-09-13T17:00:56.201299  =


    2023-09-13T17:00:56.302864  / # . /lava-11517871/environment/lava-11517=
871/bin/lava-test-runner /lava-11517871/1

    2023-09-13T17:00:56.304245  =


    2023-09-13T17:00:56.309370  / # /lava-11517871/bin/lava-test-runner /la=
va-11517871/1
 =

    ... (12 line(s) more)  =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
imx6q-udoo             | arm    | lab-broonie   | gcc-10   | imx_v6_v7_defc=
onfig          | 1          =


  Details:     https://kernelci.org/test/plan/id/6501f1e90b513389dc8a0a47

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.52-cip5-29-g9fee06894d496/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/=
baseline-nfs-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6501f1e90b513389d=
c8a0a48
        failing since 22 days (last pass: v4.4-st20-3262-g667bb8d8b2cb, fir=
st fail: v6.1.45-cip3-31-gbae6b8e9a2cff) =

 =20

