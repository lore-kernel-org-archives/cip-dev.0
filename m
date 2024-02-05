Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D31C4828D
	for <webhook@archiver.kernel.org>; Mon,  5 Feb 2024 13:14:07 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
 by mx.groups.io with SMTP id smtpd.web10.62536.1707138838836927569
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Feb 2024 05:13:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=Tca8CIIk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.177, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so4031067a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Feb 2024 05:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707138838; x=1707743638; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YMEz9auAO0xkbXCqVq3nQ228L015inFE6AqsTaMmeq4=;
        b=Tca8CIIkQvPf4EC+zx9JvFK7dkpDSIUFYID808xEnXBdj4VSTak9WcvDzztKIxHeJU
         fCqAaUl6P3CBkLM3HNRg+r3OCPG9TfjFr2Bw/vq7lRXE26xHQQ9JSDedwdItgbZ4Mcio
         B4gUEX7QrveI6Gp1Q8D2XqSb6fBAeRbjU5xiVNs35Z9n07IEAfWubEQ9XtaGjCeFA7uU
         YkJllqC5FM8qKNyGge9tiddlbhjWoP//FsXFjcKAGwPawDvkMei8/HNUzAizIC6YGZb+
         0Jub6WJcxcRyrK+QMyPooJCO6DysJFsWpOLYm/XhHGUb13BdK7rQFSP3z2V3ZXP3Xs6V
         uNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138838; x=1707743638;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMEz9auAO0xkbXCqVq3nQ228L015inFE6AqsTaMmeq4=;
        b=ioQZUQXpuagYwoQO4KbcOfAyqVjptGp1yg7dJqh6paOC/gamQMKlZg6fSHE1lE+73G
         yq90P5GXldnDJj4AXzhrFirCyZ20DKp2R+YQAHUa4GsZRUkQRp4GbXmmFw2GWolRsMKY
         8jQJpQOoc+WqJrr6tZAfy7wHnBdCBCkuzvdXHbOCx3a5rgbecPBU58xGLpGTUbsLmKrd
         K/qJBAxXSZ9rlVb+PcTwkvhBPeQXhCotT0SFUDOeFWE2pKZQWMmfs0zz7cJqgYgPWI/3
         6kBY64nOBNYqR/2723IO97GC+ElJpkHyX4OHCAn/ujrYn0zQQCYjjt02zFQivnbv+YdR
         LMWw==
X-Gm-Message-State: AOJu0Yw4RFOBNKViudd6PrPZtmF2/paZyAz9gPhaJooXcVNV9eTY04gF
	oI4uscYE3MXvVmF2LkgXWNsTRhTti6TJuIH793TgoCoH24ah4CbJW9lnSXP6hiWvH0gyWWA85VO
	4
X-Google-Smtp-Source: AGHT+IEIp5ATV6YKWaDXJ2WzoXTvC8huYOpNbTi7PdmmZKjWri4Hy17HfDuRswb+cclMNh3rnm6Q2w==
X-Received: by 2002:a05:6a20:a296:b0:19c:5711:fd93 with SMTP id a22-20020a056a20a29600b0019c5711fd93mr11488337pzl.16.1707138837489;
        Mon, 05 Feb 2024 05:13:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id h3-20020aa786c3000000b006ddd112c7c9sm6870554pfo.145.2024.02.05.05.13.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:13:56 -0800 (PST)
Message-ID: <65c0df14.a70a0220.a496f.511c@mx.google.com>
Date: Mon, 05 Feb 2024 05:13:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-6-ga817aa655908
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 58 runs,
 12 regressions (v6.1.75-cip14-6-ga817aa655908)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Feb 2024 13:14:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14721

cip-gitlab/ci/pavel/linux-test baseline-nfs: 58 runs, 12 regressions (v6.1.=
75-cip14-6-ga817aa655908)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =

beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =

beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =

sc7180-trogdor-kingoftown-r1 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =

sc7180-trogdo...zor-limozeen | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-6-ga817aa655908/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-6-ga817aa655908
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a817aa655908e54b6999ed3d0663c3f370d059ec =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
acer-chromebox-cxi4-puff     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d690b24484908500a044

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-acer-chromebox-cxi4-puff.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-acer-chromebox-cxi4-puff.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c0d690b24484908=
500a045
        new failure (last pass: v6.1.75-cip14-132-g6e54756fbd6c2) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
asus-CM1400CXA-dalboz        | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d5a082af2ddef000a098

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-CM1400CXA-dalboz.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-asus-CM1400CXA-dalboz.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0d5a082af2ddef000a0a1
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:33:20.192254  <8>[   18.905106] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12703479_1.5.2.3.1>

    2024-02-05T12:33:20.303040  / # #

    2024-02-05T12:33:20.405762  export SHELL=3D/bin/sh

    2024-02-05T12:33:20.406566  #

    2024-02-05T12:33:20.508040  / # export SHELL=3D/bin/sh. /lava-12703479/=
environment

    2024-02-05T12:33:20.508867  =


    2024-02-05T12:33:20.610326  / # . /lava-12703479/environment/lava-12703=
479/bin/lava-test-runner /lava-12703479/1

    2024-02-05T12:33:20.611658  =


    2024-02-05T12:33:20.616358  / # /lava-12703479/bin/lava-test-runner /la=
va-12703479/1

    2024-02-05T12:33:20.743420  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
at91sam9g20ek                | arm    | lab-broonie   | gcc-10   | multi_v5=
_defconfig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d6eeb24484908500a06b

  Results:     48 PASS, 6 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm/multi_v5_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-at91sam9g20ek.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm/multi_v5_defconfig/gcc-10/lab-broonie/ba=
seline-nfs-at91sam9g20ek.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0d6eeb24484908500a0a4
        failing since 39 days (last pass: v5.10.201-cip41-63-gfdfe1fbf93bc6=
, first fail: v6.1.66-cip11-rt6-10-g38253b8903b4)

    2024-02-05T12:38:35.747744  <8><LAVA_SIGNAL_ENDRUN 0_dmesg 544934_1.6.2=
.4.1>
    2024-02-05T12:38:35.881118  #
    2024-02-05T12:38:35.984401  / # #export SHELL=3D/bin/sh
    2024-02-05T12:38:35.985186  =

    2024-02-05T12:38:36.087248  / # export SHELL=3D/bin/sh. /lava-544934/en=
vironment
    2024-02-05T12:38:36.088032  =

    2024-02-05T12:38:36.190010  / # . /lava-544934/environment/lava-544934/=
bin/lava-test-runner /lava-544934/1
    2024-02-05T12:38:36.190782  =

    2024-02-05T12:38:36.194808  / # /lava-544934/bin/lava-test-runner /lava=
-544934/1
    2024-02-05T12:38:36.622213  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-broonie   | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d43926815db4a300a039

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm/omap2plus_defconfig/gcc-10/lab-broonie/b=
aseline-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0d43926815db4a300a073
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:26:52.576371  <8>[   56.525869] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 544871_1.6.2.4.1>
    2024-02-05T12:26:52.700327  #
    2024-02-05T12:26:52.802448  / # #export SHELL=3D/bin/sh
    2024-02-05T12:26:52.802805  =

    2024-02-05T12:26:52.904002  / # export SHELL=3D/bin/sh. /lava-544871/en=
vironment
    2024-02-05T12:26:52.904372  =

    2024-02-05T12:26:53.005602  / # . /lava-544871/environment/lava-544871/=
bin/lava-test-runner /lava-544871/1
    2024-02-05T12:26:53.006243  =

    2024-02-05T12:26:53.010255  / # /lava-544871/bin/lava-test-runner /lava=
-544871/1
    2024-02-05T12:26:53.302233  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
beaglebone-black             | arm    | lab-cip       | gcc-10   | omap2plu=
s_defconfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d5e169bca57a1100a044

  Results:     52 PASS, 3 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm/omap2plus_defconfig/gcc-10/lab-cip/basel=
ine-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm/omap2plus_defconfig/gcc-10/lab-cip/basel=
ine-nfs-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0d5e269bca57a1100a07e
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:34:17.971461  + set +x
    2024-02-05T12:34:17.974740  <8>[   44.821886] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1088508_1.6.2.4.1>
    2024-02-05T12:34:18.160004  / # #
    2024-02-05T12:34:18.262124  export SHELL=3D/bin/sh
    2024-02-05T12:34:18.262812  #
    2024-02-05T12:34:18.364179  / # export SHELL=3D/bin/sh. /lava-1088508/e=
nvironment
    2024-02-05T12:34:18.364868  =

    2024-02-05T12:34:18.466171  / # . /lava-1088508/environment/lava-108850=
8/bin/lava-test-runner /lava-1088508/1
    2024-02-05T12:34:18.467337  =

    2024-02-05T12:34:18.474125  / # /lava-1088508/bin/lava-test-runner /lav=
a-1088508/1 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d586335deb05a900a088

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0d586335deb05a900a091
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:35:29.839333  + set<8>[   18.966785] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12703471_1.5.2.3.1>

    2024-02-05T12:35:29.839423   +x

    2024-02-05T12:35:29.945450  / # #

    2024-02-05T12:35:30.046160  export SHELL=3D/bin/sh

    2024-02-05T12:35:30.046346  #

    2024-02-05T12:35:30.146938  / # export SHELL=3D/bin/sh. /lava-12703471/=
environment

    2024-02-05T12:35:30.147180  =


    2024-02-05T12:35:30.247932  / # . /lava-12703471/environment/lava-12703=
471/bin/lava-test-runner /lava-12703471/1

    2024-02-05T12:35:30.249424  =


    2024-02-05T12:35:30.254078  / # /lava-12703471/bin/lava-test-runner /la=
va-12703471/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d5853203898f1d00a04d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0d5853203898f1d00a056
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:35:23.688001  + set +x

    2024-02-05T12:35:23.694422  <8>[   17.614133] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12703469_1.5.2.3.1>

    2024-02-05T12:35:23.798432  / # #

    2024-02-05T12:35:23.899373  export SHELL=3D/bin/sh

    2024-02-05T12:35:23.900074  #

    2024-02-05T12:35:24.001381  / # export SHELL=3D/bin/sh. /lava-12703469/=
environment

    2024-02-05T12:35:24.002151  =


    2024-02-05T12:35:24.103620  / # . /lava-12703469/environment/lava-12703=
469/bin/lava-test-runner /lava-12703469/1

    2024-02-05T12:35:24.103969  =


    2024-02-05T12:35:24.109119  / # /lava-12703469/bin/lava-test-runner /la=
va-12703469/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
hp-x360-14a-cb0001xx-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d59b3203898f1d00a069

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-hp-x360-14a-cb0001xx-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0d59b3203898f1d00a072
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:33:08.317153  + set<8>[   17.617856] <LAVA_SIGNAL_ENDRUN =
0_dmesg 12703443_1.5.2.3.1>

    2024-02-05T12:33:08.317236   +x

    2024-02-05T12:33:08.421412  / # #

    2024-02-05T12:33:08.521953  export SHELL=3D/bin/sh

    2024-02-05T12:33:08.522110  #

    2024-02-05T12:33:08.622594  / # export SHELL=3D/bin/sh. /lava-12703443/=
environment

    2024-02-05T12:33:08.622776  =


    2024-02-05T12:33:08.723365  / # . /lava-12703443/environment/lava-12703=
443/bin/lava-test-runner /lava-12703443/1

    2024-02-05T12:33:08.723627  =


    2024-02-05T12:33:08.728770  / # /lava-12703443/bin/lava-test-runner /la=
va-12703443/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
lenovo-TPad-C13-Yoga-zork    | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efconfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d57f82af2ddef000a03a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/x86_64/x86_64_defconfig+x86-board/gcc-10/lab=
-collabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0d57f82af2ddef000a043
        failing since 17 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-30-g79e2886a5da69)

    2024-02-05T12:33:26.186005  <8>[   18.024375] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12703473_1.5.2.3.1>

    2024-02-05T12:33:26.291035  / # #

    2024-02-05T12:33:26.391690  export SHELL=3D/bin/sh

    2024-02-05T12:33:26.391892  #

    2024-02-05T12:33:26.492436  / # export SHELL=3D/bin/sh. /lava-12703473/=
environment

    2024-02-05T12:33:26.492620  =


    2024-02-05T12:33:26.593140  / # . /lava-12703473/environment/lava-12703=
473/bin/lava-test-runner /lava-12703473/1

    2024-02-05T12:33:26.593424  =


    2024-02-05T12:33:26.598584  / # /lava-12703473/bin/lava-test-runner /la=
va-12703473/1

    2024-02-05T12:33:26.640373  + export TESTRUN_ID=3D1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d951ad0c220fd400a064

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-=
r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig/gcc-10/lab-cip/baseline-nfs-=
r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65c0d951ad0c220fd=
400a065
        failing since 5 days (last pass: v4.19.299-cip105-1134-gc868d5e4ada=
a, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sc7180-trogdor-kingoftown-r1 | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d70dde1746125200a04d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig+arm64-chromebook/gcc-10/lab-=
collabora/baseline-nfs-sc7180-trogdor-kingoftown-r1.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig+arm64-chromebook/gcc-10/lab-=
collabora/baseline-nfs-sc7180-trogdor-kingoftown-r1.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0d70dde1746125200a056
        failing since 1 day (last pass: v6.1.72-cip13-32-gf60d2e8cb51c, fir=
st fail: v6.1.75-cip14-132-g6e54756fbd6c2)

    2024-02-05T12:39:33.216092  + set +x

    2024-02-05T12:39:33.222739  <8>[   29.064758] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 12703542_1.6.2.3.1>

    2024-02-05T12:39:33.329651  / # #

    2024-02-05T12:39:33.430243  export SHELL=3D/bin/sh

    2024-02-05T12:39:33.430406  #

    2024-02-05T12:39:33.530966  / # export SHELL=3D/bin/sh. /lava-12703542/=
environment

    2024-02-05T12:39:33.531129  =


    2024-02-05T12:39:33.631693  / # . /lava-12703542/environment/lava-12703=
542/bin/lava-test-runner /lava-12703542/1

    2024-02-05T12:39:33.631929  =


    2024-02-05T12:39:33.638819  / # /lava-12703542/bin/lava-test-runner /la=
va-12703542/1
 =

    ... (14 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                  | regressions
-----------------------------+--------+---------------+----------+---------=
-------------------+------------
sc7180-trogdo...zor-limozeen | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65c0d76859db0de29d00a039

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig+arm64-chromebook/gcc-10/lab-=
collabora/baseline-nfs-sc7180-trogdor-lazor-limozeen.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-6-ga817aa655908/arm64/defconfig+arm64-chromebook/gcc-10/lab-=
collabora/baseline-nfs-sc7180-trogdor-lazor-limozeen.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65c0d76859db0de29d00a042
        failing since 1 day (last pass: v6.1.72-cip13-32-gf60d2e8cb51c, fir=
st fail: v6.1.75-cip14-132-g6e54756fbd6c2)

    2024-02-05T12:41:05.035289  + <8>[   30.793063] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 12703570_1.6.2.3.1>

    2024-02-05T12:41:05.038561  set +x

    2024-02-05T12:41:05.148028  / # #

    2024-02-05T12:41:05.250298  export SHELL=3D/bin/sh

    2024-02-05T12:41:05.251188  #

    2024-02-05T12:41:05.352758  / # export SHELL=3D/bin/sh. /lava-12703570/=
environment

    2024-02-05T12:41:05.353490  =


    2024-02-05T12:41:05.454858  / # . /lava-12703570/environment/lava-12703=
570/bin/lava-test-runner /lava-12703570/1

    2024-02-05T12:41:05.456001  =


    2024-02-05T12:41:05.462109  / # /lava-12703570/bin/lava-test-runner /la=
va-12703570/1
 =

    ... (14 line(s) more)  =

 =20

