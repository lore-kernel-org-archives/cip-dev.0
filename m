Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B758DEB64DC
	for <webhook@archiver.kernel.org>; Sat, 22 Jul 2023 15:24:28 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.7589.1690039465270377916
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 22 Jul 2023 08:24:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=DJg0nIZh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6686a05bc66so1965169b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 22 Jul 2023 08:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1690039464; x=1690644264;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VZPBNYCCRctAB+75m2Q5sz3UfTt2NZvo2r2uy176fe0=;
        b=DJg0nIZhyR2mrRS8Cbdyc4axQku6W0W0s9ZMOgITgdIGMDQtBVVRUTGFw5L3x9d09g
         5Sa2axVGTRjU7ZpbIvNTbhGd02tRBanJKoJSjBEcHUUAqbJllqiSwnOH6L7PlxY217mw
         Yno76udu3qCRqJj3sZ9yMxgpPzFtIZ7Y9lg3cdc9ANVLmm2roJN8ne8+OgZlj/IJYWhe
         3q4gxgoCajq4l4K5j1DW3h68CB3iI6psSHFeXtV4Rf6zgwSmznBpm3N0UUpnK+kIlJ+f
         TuSrTy4juR/TxEzJzWH/zdYV6sFsnUzVhG5IGJxtE4CR+9ltGIp191N+suvcK+/K+FBp
         ZEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690039464; x=1690644264;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZPBNYCCRctAB+75m2Q5sz3UfTt2NZvo2r2uy176fe0=;
        b=fmt6TV46NPc1O1iWHUY3nkOkgzfH11AgYyTLkbOY9MtK+Z8cmFg+4a7qOnXqaNBzvR
         ku3cuevtvh0lfJZdGYsdkGDAgWLol63i7h0KNJYQE26l4yC58pttZRXE0YGY0Xb7nH0t
         9dMzMTX3mtdQAl/doTuSOKXnHXoAFVE2UmF7O87TYmIxpYlh9DnRtIjsQ2TycyFFRTZh
         G9E6bNEwtzWaXT+qzNJXoRDztdXwXQE40GGxFpRYZiP0oP0j3fk1oXiMw+SgJjDEyEBx
         2NH2jKvrit/zgl2TI8oG459VF6HfceU+5l5beKC3Hcjuw3/yS+hehE4N2beBij0lut7Q
         /IRw==
X-Gm-Message-State: ABy/qLYRo+IFEDdroCk30qx3RCZUIOMBufJoDrFsr8T8Xa+YoxkeO/Kh
	TYIW67+RQb3XMaa5cg5WJ3CjHx8K/mqylrAHgjI=
X-Google-Smtp-Source: APBJJlF2x4QpIiRiJSDbMTPec7PnCjgC9uLjb9t43t3/quJAAeG21+IIrp5/EotfJvV/3Xl6+eOrCQ==
X-Received: by 2002:a05:6a20:8e1f:b0:12d:23ea:9ccc with SMTP id y31-20020a056a208e1f00b0012d23ea9cccmr5625531pzj.39.1690039464189;
        Sat, 22 Jul 2023 08:24:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p9-20020a639509000000b005633941a547sm5131341pgd.27.2023.07.22.08.24.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 08:24:23 -0700 (PDT)
Message-ID: <64bbf4a7.630a0220.a4e10.8c8b@mx.google.com>
Date: Sat, 22 Jul 2023 08:24:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.186-cip37-12-g2710acbceb75
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test baseline-nfs: 8 runs,
 2 regressions (v5.10.186-cip37-12-g2710acbceb75)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Jul 2023 15:24:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12497

cip-gitlab/ci/pavel/linux-test baseline-nfs: 8 runs, 2 regressions (v5.10.1=
86-cip37-12-g2710acbceb75)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.186-cip37-12-g2710acbceb75/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.186-cip37-12-g2710acbceb75
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2710acbceb751c864f5fbbd3521374e60d9802fe =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bbe388f0e4df7ce68ace1d

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64bbe388f0e4df7ce68ace22
        failing since 38 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-22T14:11:03.372908  + <8>[   22.137366] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11125259_1.5.2.3.1>

    2023-07-22T14:11:03.373256  set +x

    2023-07-22T14:11:03.480661  / # #

    2023-07-22T14:11:03.581520  export SHELL=3D/bin/sh

    2023-07-22T14:11:03.582514  #

    2023-07-22T14:11:03.683994  / # export SHELL=3D/bin/sh. /lava-11125259/=
environment

    2023-07-22T14:11:03.684770  =


    2023-07-22T14:11:03.786335  / # . /lava-11125259/environment/lava-11125=
259/bin/lava-test-runner /lava-11125259/1

    2023-07-22T14:11:03.787132  =


    2023-07-22T14:11:03.791558  / # /lava-11125259/bin/lava-test-runner /la=
va-11125259/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64bbe38ba549302cdd8ace97

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.186-cip37-12-g2710acbceb75/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64bbe38ba549302cdd8ace9c
        failing since 38 days (last pass: v4.19.283-cip98-1248-gcaf6e8ee921=
e9, first fail: v5.10.182-cip35-8-g2391124f19a70)

    2023-07-22T14:11:09.747240  + set +x[   18.994219] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11125275_1.5.2.3.1>

    2023-07-22T14:11:09.747325  =


    2023-07-22T14:11:09.851548  / # #

    2023-07-22T14:11:09.952087  export SHELL=3D/bin/sh

    2023-07-22T14:11:09.952228  #

    2023-07-22T14:11:10.052787  / # export SHELL=3D/bin/sh. /lava-11125275/=
environment

    2023-07-22T14:11:10.052956  =


    2023-07-22T14:11:10.153494  / # . /lava-11125275/environment/lava-11125=
275/bin/lava-test-runner /lava-11125275/1

    2023-07-22T14:11:10.153736  =


    2023-07-22T14:11:10.158567  / # /lava-11125275/bin/lava-test-runner /la=
va-11125275/1
 =

    ... (12 line(s) more)  =

 =20

