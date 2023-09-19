Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1921CD5BC6
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 14:01:06 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web10.9213.1695132065700758193
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 19 Sep 2023 07:01:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=BO0M4WL0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1c451541f23so20159615ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 19 Sep 2023 07:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695132065; x=1695736865; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AQLS1LEhNrAv/YWFR6jb7g6weS+rKEDkedhIxD8NLEs=;
        b=BO0M4WL0tAxQ69wTGDerkxX1vzyQx76bsOFYn6nHROtpYmraHE0XITQ2fslPshHz9i
         2tAVyihp/xWwhzAxheOn2T/cFzZ81qdC1Pmo2SFuKQrT44CGjpk7vCG3u/2WCDB21NgD
         hU8yD7HuQOcf3upaTHoqL4ZzpvEXaQsBgwo1TBuw7NJHaoXn7ak5YDaAj6qR7jcSYTSe
         6qIiekG/d+sSPbHQgkoa7oyCDZqFommunX7CvQV5kKF3tZrY4K/HtGNS0JXzzqTIn7UM
         l9Ig02witYLLknHyprBoy2mDdCEoCDCdYLRLIGPt4C9tjW6lQOg15u1KTjHwPN9C5BBq
         5fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695132065; x=1695736865;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQLS1LEhNrAv/YWFR6jb7g6weS+rKEDkedhIxD8NLEs=;
        b=AaBmVzOqfWoeit47RM4bh1jGL8Te5HVSMTghaDJb5Ehr1wO8Z2DNDlYe11HhT9H16D
         qQL59+4lOzkOBucvdTZdUMX3cAOfzSwa5RY1qI+Vre8oAnI/DYyTYJE8FATF0J65L6qa
         52wBrAMEhDSJtrKR30dG0GhUXG0Dk9Kj8NDPnZ474x/7ewLu2lOe62LSRRFLPdW5inrP
         80Fb/aaQgSX24VJ1GfWWH4zv9aJIFY5qcCHmcxbLJfMftBk7YKK2Y8EiK8MnLceRwXFU
         x30t6AgZN4yQHT3yU9FlYP8xLULRJrT4EjaGf2iHlv38C8WkKRKm065JwomC4BDMY9nI
         tiKA==
X-Gm-Message-State: AOJu0Ywp0moMS24w82XSnv/Hg+ywSAeI3txjHZX1HtI3pJXJNCAeuGPd
	ebE2Y6J1kP2R9HfyaBEPqgspmmPnlj1PEmQ4CBjpXg==
X-Google-Smtp-Source: AGHT+IETR7T5h3uZwzUD/eIVAZz19HRY/TrdwObVFGDQYl4nST+HnzYermsdkSt9z6YXkf3CywGUYA==
X-Received: by 2002:a17:902:da92:b0:1c5:b1cc:fe0e with SMTP id j18-20020a170902da9200b001c5b1ccfe0emr706475plx.53.1695132064235;
        Tue, 19 Sep 2023 07:01:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id a4-20020a1709027d8400b001c0a4146961sm10108846plm.19.2023.09.19.07.01.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 07:01:03 -0700 (PDT)
Message-ID: <6509a99f.170a0220.ea652.2ebb@mx.google.com>
Date: Tue, 19 Sep 2023 07:01:03 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.191-cip38-661-g112a3073ff26
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 163 runs,
 26 regressions (v5.10.191-cip38-661-g112a3073ff26)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 14:01:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13151

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline: 163 runs, 26 regressio=
ns (v5.10.191-cip38-661-g112a3073ff26)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =

fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =

meson-g12b-a311d-khadas-vim3 | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =

r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =

rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =

sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =

sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.191-cip38-661-g112a3073ff26/plan/baseline/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.191-cip38-661-g112a3073ff26
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      112a3073ff2650cf1c0684ba93fb4a7284304812 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
bcm2836-rpi-2-b              | arm    | lab-collabora | gcc-10   | bcm2835_=
defconfig            | 1          =


  Details:     https://kernelci.org/test/plan/id/6509998872f83b913f8a0a8a

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: bcm2835_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm/bcm2835_defconfig/gcc-10=
/lab-collabora/baseline-bcm2836-rpi-2-b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm/bcm2835_defconfig/gcc-10=
/lab-collabora/baseline-bcm2836-rpi-2-b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509998872f83b913f8a0a93
        failing since 54 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-19T12:56:25.417704  / # #

    2023-09-19T12:56:25.519850  export SHELL=3D/bin/sh

    2023-09-19T12:56:25.520560  #

    2023-09-19T12:56:25.622012  / # export SHELL=3D/bin/sh. /lava-11570940/=
environment

    2023-09-19T12:56:25.622727  =


    2023-09-19T12:56:25.724306  / # . /lava-11570940/environment/lava-11570=
940/bin/lava-test-runner /lava-11570940/1

    2023-09-19T12:56:25.725403  =


    2023-09-19T12:56:25.742028  / # /lava-11570940/bin/lava-test-runner /la=
va-11570940/1

    2023-09-19T12:56:25.805848  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T12:56:25.850056  + cd /lava-11570940/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
fsl-ls1028a-rdb              | arm64  | lab-nxp       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099f9acc07af2fe18a0a6b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-nxp/baseline-fsl-ls1028a-rdb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-nxp/baseline-fsl-ls1028a-rdb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65099f9acc07af2fe18a0=
a6c
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65099955bb5a3538058a0a50

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n4020-octopus=
.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65099955bb5a3538058a0a59
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T12:51:21.276757  + set +x

    2023-09-19T12:51:21.283056  <8>[   10.775806] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11570981_1.4.2.3.1>

    2023-09-19T12:51:21.387530  / # #

    2023-09-19T12:51:21.488145  export SHELL=3D/bin/sh

    2023-09-19T12:51:21.488305  #

    2023-09-19T12:51:21.588828  / # export SHELL=3D/bin/sh. /lava-11570981/=
environment

    2023-09-19T12:51:21.588977  =


    2023-09-19T12:51:21.689583  / # . /lava-11570981/environment/lava-11570=
981/bin/lava-test-runner /lava-11570981/1

    2023-09-19T12:51:21.689919  =


    2023-09-19T12:51:21.694290  / # /lava-11570981/bin/lava-test-runner /la=
va-11570981/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65099b71580ada589a8a0a6d

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-12b-ca0010nr-n40=
20-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65099b71580ada589a8a0a76
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T13:00:11.594300  + set +x

    2023-09-19T13:00:11.601271  <8>[   15.733484] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571030_1.4.2.3.1>

    2023-09-19T13:00:11.709791  / # #

    2023-09-19T13:00:11.812455  export SHELL=3D/bin/sh

    2023-09-19T13:00:11.813289  #

    2023-09-19T13:00:11.914895  / # export SHELL=3D/bin/sh. /lava-11571030/=
environment

    2023-09-19T13:00:11.915689  =


    2023-09-19T13:00:12.017317  / # . /lava-11571030/environment/lava-11571=
030/bin/lava-test-runner /lava-11571030/1

    2023-09-19T13:00:12.018703  =


    2023-09-19T13:00:12.023157  / # /lava-11571030/bin/lava-test-runner /la=
va-11571030/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65099946ae0cc636728a0a62

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65099946ae0cc636728a0a6b
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T12:51:29.356813  + set<8>[   12.320293] <LAVA_SIGNAL_ENDRUN =
0_dmesg 11570956_1.4.2.3.1>

    2023-09-19T12:51:29.357273   +x

    2023-09-19T12:51:29.463867  /#

    2023-09-19T12:51:29.566397   # #export SHELL=3D/bin/sh

    2023-09-19T12:51:29.566633  =


    2023-09-19T12:51:29.667145  / # export SHELL=3D/bin/sh. /lava-11570956/=
environment

    2023-09-19T12:51:29.667301  =


    2023-09-19T12:51:29.767829  / # . /lava-11570956/environment/lava-11570=
956/bin/lava-test-runner /lava-11570956/1

    2023-09-19T12:51:29.768064  =


    2023-09-19T12:51:29.772863  / # /lava-11570956/bin/lava-test-runner /la=
va-11570956/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65099b6ba64be6256a8a0a65

  Results:     6 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65099b6ba64be6256a8a0a6e
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T13:00:10.131887  <8>[   14.141567] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 11571018_1.4.2.3.1>

    2023-09-19T13:00:10.135242  + set +x

    2023-09-19T13:00:10.239828  #

    2023-09-19T13:00:10.342564  / # #export SHELL=3D/bin/sh

    2023-09-19T13:00:10.343486  =


    2023-09-19T13:00:10.445295  / # export SHELL=3D/bin/sh. /lava-11571018/=
environment

    2023-09-19T13:00:10.446074  =


    2023-09-19T13:00:10.547872  / # . /lava-11571018/environment/lava-11571=
018/bin/lava-test-runner /lava-11571018/1

    2023-09-19T13:00:10.549071  =


    2023-09-19T13:00:10.554751  / # /lava-11571018/bin/lava-test-runner /la=
va-11571018/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
juno-uboot                   | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a37146afb6aa5b8a0a83

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a37146afb6aa5b8a0ac2
        failing since 54 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-19T13:34:24.046050  / # #
    2023-09-19T13:34:24.147931  export SHELL=3D/bin/sh
    2023-09-19T13:34:24.148433  #
    2023-09-19T13:34:24.250381  / # export SHELL=3D/bin/sh. /lava-117755/en=
vironment
    2023-09-19T13:34:24.251253  =

    2023-09-19T13:34:24.353255  / # . /lava-117755/environment/lava-117755/=
bin/lava-test-runner /lava-117755/1
    2023-09-19T13:34:24.354521  =

    2023-09-19T13:34:24.368722  / # /lava-117755/bin/lava-test-runner /lava=
-117755/1
    2023-09-19T13:34:24.428774  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-19T13:34:24.429345  + cd /lava-117755/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-kbox-a-230-ls        | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099f83cc07af2fe18a0a4e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-kontron/baseline-kontron-kbox-a-230-ls.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-kontron/baseline-kontron-kbox-a-230-ls.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65099f83cc07af2fe18a0=
a4f
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
kontron-sl28-var3-ads2       | arm64  | lab-kontron   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099f86cc07af2fe18a0a53

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-kontron/baseline-kontron-sl28-var3-ads2.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-kontron/baseline-kontron-sl28-var3-ads2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65099f86cc07af2fe18a0=
a54
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-g12b-a311d-khadas-vim3 | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099ed990789c78588a0a9f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65099ed990789c78588a0=
aa0
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a565b790de4e218a0a5b

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a566b790de4e218a0a62
        failing since 53 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-19T13:42:44.705109  + set +x
    2023-09-19T13:42:44.708225  <8>[   84.061002] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 1010340_1.5.2.4.1>
    2023-09-19T13:42:44.817564  / # #
    2023-09-19T13:42:46.282242  export SHELL=3D/bin/sh
    2023-09-19T13:42:46.303191  #
    2023-09-19T13:42:46.303648  / # export SHELL=3D/bin/sh
    2023-09-19T13:42:48.261562  / # . /lava-1010340/environment
    2023-09-19T13:42:51.863621  /lava-1010340/bin/lava-test-runner /lava-10=
10340/1
    2023-09-19T13:42:51.885084  . /lava-1010340/environment
    2023-09-19T13:42:51.885498  / # /lava-1010340/bin/lava-test-runner /lav=
a-1010340/1 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a97517635c7af28a0a55

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509a97517635c7af28a0=
a56
        new failure (last pass: v5.10.186-cip37-566-g36076316ef049) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099f57dff95a3cdc8a0a47

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65099f57dff95a3cdc8a0a4e
        failing since 54 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-19T13:16:37.580721  / # #
    2023-09-19T13:16:39.041969  export SHELL=3D/bin/sh
    2023-09-19T13:16:39.062503  #
    2023-09-19T13:16:39.062708  / # export SHELL=3D/bin/sh
    2023-09-19T13:16:41.017672  / # . /lava-1010373/environment
    2023-09-19T13:16:44.615232  /lava-1010373/bin/lava-test-runner /lava-10=
10373/1
    2023-09-19T13:16:44.635951  . /lava-1010373/environment
    2023-09-19T13:16:44.636053  / # /lava-1010373/bin/lava-test-runner /lav=
a-1010373/1
    2023-09-19T13:16:44.756119  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-19T13:16:44.756354  + cd /lava-1010373/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g+arm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a16ef266aa22258a0a4a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-cip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509a16ef266aa22258a0=
a4b
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a774c0-ek874               | arm64  | lab-cip       | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a3ed7f2d2acf278a0a4f

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-c=
ip/baseline-r8a774c0-ek874.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a3ed7f2d2acf278a0a56
        failing since 54 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-19T13:35:58.075407  / # #
    2023-09-19T13:35:59.534714  export SHELL=3D/bin/sh
    2023-09-19T13:35:59.555206  #
    2023-09-19T13:35:59.555369  / # export SHELL=3D/bin/sh
    2023-09-19T13:36:01.509419  / # . /lava-1010407/environment
    2023-09-19T13:36:05.103772  /lava-1010407/bin/lava-test-runner /lava-10=
10407/1
    2023-09-19T13:36:05.124549  . /lava-1010407/environment
    2023-09-19T13:36:05.124659  / # /lava-1010407/bin/lava-test-runner /lav=
a-1010407/1
    2023-09-19T13:36:05.203542  + export 'TESTRUN_ID=3D1_bootrr'
    2023-09-19T13:36:05.203870  + cd /lava-1010407/1/tests/1_bootrr =

    ... (25 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a1f95de572be348a0a48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/6509a1f95de572be348a0=
a49
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
r8a77960-ulcb                | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a2ed19d653aeff8a0b2c

  Results:     4 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a77960-ulcb.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-r8a77960-ulcb.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a2ed19d653aeff8a0b35
        failing since 54 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-19T13:36:21.632461  / # #

    2023-09-19T13:36:21.734823  export SHELL=3D/bin/sh

    2023-09-19T13:36:21.735616  #

    2023-09-19T13:36:21.837021  / # export SHELL=3D/bin/sh. /lava-11571242/=
environment

    2023-09-19T13:36:21.837768  =


    2023-09-19T13:36:21.939201  / # . /lava-11571242/environment/lava-11571=
242/bin/lava-test-runner /lava-11571242/1

    2023-09-19T13:36:21.940312  =


    2023-09-19T13:36:21.955274  / # /lava-11571242/bin/lava-test-runner /la=
va-11571242/1

    2023-09-19T13:36:22.005776  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T13:36:22.006237  + cd /lav<8>[   16.375270] <LAVA_SIGNAL_STA=
RTRUN 1_bootrr 11571242_1.5.2.4.5>
 =

    ... (28 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/65099ca165d7175d1b8a0aab

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65099ca165d7175d1b8a0ab5
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T13:05:21.974185  <8>[   32.451541] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-09-19T13:05:22.998747  /lava-11571054/1/../bin/lava-test-case

    2023-09-19T13:05:23.009668  <8>[   33.488437] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65099ca165d7175d1b8a0ab6
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T13:05:21.961830  /lava-11571054/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm...ok+kselftest | 2          =


  Details:     https://kernelci.org/test/plan/id/65099ed139d8cc1a5f8a0a5e

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-collabora/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test/cas=
e/id/65099ed139d8cc1a5f8a0a68
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T13:14:49.532933  <8>[   40.893023] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-09-19T13:14:50.572318  /lava-11571092/1/../bin/lava-test-case

    2023-09-19T13:14:50.588329  <8>[   41.950092] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test/cas=
e/id/65099ed139d8cc1a5f8a0a69
        failing since 151 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-09-19T13:14:49.515255  /lava-11571092/1/../bin/lava-test-case
   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099ed322654425018a0aed

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-collabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/65099ed322654425018a0af6
        failing since 23 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-09-19T13:14:29.770669  / # #

    2023-09-19T13:14:31.031846  export SHELL=3D/bin/sh

    2023-09-19T13:14:31.042810  #

    2023-09-19T13:14:31.043282  / # export SHELL=3D/bin/sh

    2023-09-19T13:14:32.787552  / # . /lava-11571083/environment

    2023-09-19T13:14:35.993293  /lava-11571083/bin/lava-test-runner /lava-1=
1571083/1

    2023-09-19T13:14:36.004742  . /lava-11571083/environment

    2023-09-19T13:14:36.008631  / # /lava-11571083/bin/lava-test-runner /la=
va-11571083/1

    2023-09-19T13:14:36.087579  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T13:14:36.088076  + cd /lava-11571083/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-rock-pi-4b            | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a2fc7454e1a4588a0a48

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a2fc7454e1a4588a0a51
        failing since 23 days (last pass: v5.10.186-cip37-770-gddd36cfc4c4c=
8, first fail: v5.10.186-cip37-982-g80a0585c0aa62)

    2023-09-19T13:32:43.224336  / # #

    2023-09-19T13:32:44.484791  export SHELL=3D/bin/sh

    2023-09-19T13:32:44.495648  #

    2023-09-19T13:32:44.496069  / # export SHELL=3D/bin/sh

    2023-09-19T13:32:46.239440  / # . /lava-11571230/environment

    2023-09-19T13:32:49.443055  /lava-11571230/bin/lava-test-runner /lava-1=
1571230/1

    2023-09-19T13:32:49.454496  . /lava-11571230/environment

    2023-09-19T13:32:49.461011  / # /lava-11571230/bin/lava-test-runner /la=
va-11571230/1

    2023-09-19T13:32:49.509940  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T13:32:49.510389  + cd /lava-11571230/1/tests/1_bootrr
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-a64-pine64-plus       | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099f7dcc07af2fe18a0a42

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-sun50i-a64-pine64-plus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-sun50i-a64-pine64-plus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65099f7dcc07af2fe18a0=
a43
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h5-lib...ch-all-h3-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g+kselftest          | 1          =


  Details:     https://kernelci.org/test/plan/id/65099f7ecc07af2fe18a0a48

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-sun50i-h5-libretech-all-h3-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig+kselftest/gc=
c-10/lab-broonie/baseline-sun50i-h5-libretech-all-h3-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.login: https://kernelci.org/test/case/id/65099f7ecc07af2fe18a0=
a49
        new failure (last pass: v5.10.186-cip37-982-g80a0585c0aa62) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
sun50i-h6-pine-h64           | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6509a2eb19d653aeff8a0b15

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.191-cip38-661-g112a3073ff26/arm64/defconfig/gcc-10/lab-c=
ollabora/baseline-sun50i-h6-pine-h64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/6509a2eb19d653aeff8a0b1e
        failing since 54 days (last pass: v5.10.184-cip36-10-ga711f789c23e1=
, first fail: v5.10.186-cip37-526-g7640d76efb649)

    2023-09-19T13:36:34.092975  / # #

    2023-09-19T13:36:34.194879  export SHELL=3D/bin/sh

    2023-09-19T13:36:34.195137  #

    2023-09-19T13:36:34.295731  / # export SHELL=3D/bin/sh. /lava-11571234/=
environment

    2023-09-19T13:36:34.295887  =


    2023-09-19T13:36:34.396386  / # . /lava-11571234/environment/lava-11571=
234/bin/lava-test-runner /lava-11571234/1

    2023-09-19T13:36:34.396577  =


    2023-09-19T13:36:34.407078  / # /lava-11571234/bin/lava-test-runner /la=
va-11571234/1

    2023-09-19T13:36:34.468567  + export 'TESTRUN_ID=3D1_bootrr'

    2023-09-19T13:36:34.468695  + cd /lava-1157123<8>[   18.348796] <LAVA_S=
IGNAL_STARTRUN 1_bootrr 11571234_1.5.2.4.5>
 =

    ... (10 line(s) more)  =

 =20

