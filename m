Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5251FC6FA8F
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 20:08:01 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.612.1693426079149648001
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 13:07:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=tY/yeJ2v;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c1e128135aso364815ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 13:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1693426078; x=1694030878; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IEInDkmObzv+SfEAE4IIBKpNlgAJs49Qc0P1aJFvZQc=;
        b=tY/yeJ2vwVGGfNSapnumkmQV3cJxqwvh9phsj/dORk0Ra6hJpYqysU/9D2tDKernQz
         qmaYpNZyhDH6nLpOdhwMRPdwWeBXQXiyEbs894e34Q0wkTJS7hkd9sj3ojI8ju/Q0MPe
         3DZ21msmDro2pRRT4DNvWuzVMjf3CqfRQKWWMoFiwnxSfq4S0B0ler+iKxZYkHJ/wwRC
         8EkefNB2aL9+j8e8O+0TK28HoL8ff8EaMOQDxif1jA53uwIguIb3XGKNfPm11h4vj9x3
         Ss+1tDrGLtF9Corcmh50ORzQPTFHwim2W5h/0hmvdTi3EcFyri8LTK0CQY8Z5nOQBbHW
         OW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693426078; x=1694030878;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IEInDkmObzv+SfEAE4IIBKpNlgAJs49Qc0P1aJFvZQc=;
        b=ek7MEd8Mjn1MkefLD1fqy1mTmCDDAFDj0YK/ozwoSyajr9og63EUI/QVdnzR4h4ktg
         Dho7AaCcj1usszbVtNv6g5eTbnG2Lm5sqNmdkZaKlZ/aeGe3pe71tkxA7m/a/wqc4nas
         9yVy+7xPAsNZqt6y5s+XTKNr4BFzv5CPYhiaQ9EiXlBdIk/GJKx3HsYgKERF5fDMS8Mo
         wkIQtNvQS3YvJD3gqv0IJ29dMyemVhqz6vf3CZ69HeS900H0ZDwundpllc/W3xc/iyEn
         p/6oyFuroiB9WNytASAsb98zktGcpGi/6J8J94LRPSVvVJuS+9mufHW3kQLwCcAGEI0c
         +LXA==
X-Gm-Message-State: AOJu0YzSg1KOxFJ9/72eclsYVZZz2ilGt+3yPoaYuhyEYASXunK1KH9t
	Q8guMMxZfkKm9l8q3GjgFNCUI0RupM9TrlbKUbE=
X-Google-Smtp-Source: AGHT+IFqvW45tIkcMF77rNP0mDErAKOjjHG67oPwx93Oi0E2t1Ds/hlBMDecoeib1IL7OXEDXb5+SA==
X-Received: by 2002:a17:902:b687:b0:1bc:2bd:8523 with SMTP id c7-20020a170902b68700b001bc02bd8523mr2473667pls.24.1693426077852;
        Wed, 30 Aug 2023 13:07:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jc2-20020a17090325c200b001c0cb2aa2easm11527151plb.121.2023.08.30.13.07.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 13:07:57 -0700 (PDT)
Message-ID: <64efa19d.170a0220.fd7e3.527a@mx.google.com>
Date: Wed, 30 Aug 2023 13:07:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38-218-g9947ff6f0dba7
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 31 runs,
 4 regressions (v5.10.191-cip38-218-g9947ff6f0dba7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 20:08:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12921

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 31 runs, 4 regress=
ions (v5.10.191-cip38-218-g9947ff6f0dba7)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.191-cip38-218-g9947ff6f0dba7/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.191-cip38-218-g9947ff6f0dba7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      9947ff6f0dba77de14d710cf958ecb42c2f4c10f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef98ba9b77454c48286dcf

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oc=
topus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ef98ba9b77454c48286dd8
        failing since 132 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-30T19:30:57.464485  + set<8>[   22.382953] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11386157_1.5.2.3.1>

    2023-08-30T19:30:57.464571   +x

    2023-08-30T19:30:57.568843  / # #

    2023-08-30T19:30:57.669422  export SHELL=3D/bin/sh

    2023-08-30T19:30:57.669620  #

    2023-08-30T19:30:57.770117  / # export SHELL=3D/bin/sh. /lava-11386157/=
environment

    2023-08-30T19:30:57.770348  =


    2023-08-30T19:30:57.870833  / # . /lava-11386157/environment/lava-11386=
157/bin/lava-test-runner /lava-11386157/1

    2023-08-30T19:30:57.871183  =


    2023-08-30T19:30:57.875808  / # /lava-11386157/bin/lava-test-runner /la=
va-11386157/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef974b27302d06e7286d97

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ef974b27302d06e7286da0
        failing since 132 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-30T19:23:44.410203  + set +x

    2023-08-30T19:23:44.417172  <8>[   20.928411] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11386103_1.5.2.3.1>

    2023-08-30T19:23:44.526891  / # #

    2023-08-30T19:23:44.629296  export SHELL=3D/bin/sh

    2023-08-30T19:23:44.630058  #

    2023-08-30T19:23:44.731565  / # export SHELL=3D/bin/sh. /lava-11386103/=
environment

    2023-08-30T19:23:44.732403  =


    2023-08-30T19:23:44.833966  / # . /lava-11386103/environment/lava-11386=
103/bin/lava-test-runner /lava-11386103/1

    2023-08-30T19:23:44.835077  =


    2023-08-30T19:23:44.840310  / # /lava-11386103/bin/lava-test-runner /la=
va-11386103/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef98b8e22079e8d7286daa

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64ef98b8e22079e8d7286db3
        failing since 132 days (last pass: v5.10.168-cip27-109-g23841ec76be=
c, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-08-30T19:30:48.332128  + set +x

    2023-08-30T19:30:48.338456  <8>[   20.000377] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11386150_1.5.2.3.1>

    2023-08-30T19:30:48.443259  / # #

    2023-08-30T19:30:48.546009  export SHELL=3D/bin/sh

    2023-08-30T19:30:48.546248  #

    2023-08-30T19:30:48.646854  / # export SHELL=3D/bin/sh. /lava-11386150/=
environment

    2023-08-30T19:30:48.647053  =


    2023-08-30T19:30:48.747795  / # . /lava-11386150/environment/lava-11386=
150/bin/lava-test-runner /lava-11386150/1

    2023-08-30T19:30:48.749002  =


    2023-08-30T19:30:48.754410  / # /lava-11386150/bin/lava-test-runner /la=
va-11386150/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef8fcf716171ad0b286d6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-218-g9947ff6f0dba7/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ef8fcf716171ad0=
b286d6d
        failing since 34 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =20

