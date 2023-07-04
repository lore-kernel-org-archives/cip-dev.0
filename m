Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D35EB64DD
	for <webhook@archiver.kernel.org>; Tue,  4 Jul 2023 06:56:07 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.53128.1688453759083274341
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 03 Jul 2023 23:55:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=MOOGNdlD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-666e916b880so2418999b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 03 Jul 2023 23:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688453758; x=1691045758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s0LC274vydaoaN/mPN1/Ejzz8UlA/jMje8EbjcwjeZM=;
        b=MOOGNdlDBVII+aUKTmnCisgo0o8ebzTFZyyd5l+LVAp5AR0T7xWbKTtxKCdc58yg4+
         fi6oL66gbLLNX9dbz5bAgpUyCbSA5MskCYdw6xanhkpVT7GPwFW0QbuTy+gKY0ULXZlz
         vRyrMTvI5XRnEu3MGQghyO2kDXeLGCvVjTsftXs+cxnbB8OLHjB3xKBVIRAN0r2wAHCy
         srOMeu2SWw3r/lE0oV33PErIxgjujHT9K+5U+biU2Rit4YbE8A52pPN1sBPOoY2eeX4u
         f7zV8lriZ6OlL7qS4tpot40yBNaUesHLXoprW6JDoBxgTWQh2qopOJSWuCE3YrJU3z1T
         jJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688453758; x=1691045758;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0LC274vydaoaN/mPN1/Ejzz8UlA/jMje8EbjcwjeZM=;
        b=Q+FH+NKH3HOeaWuA5ZF1npPZwtEH16Tap3KsOIbeONYmirdogPyVvuCcbpVITbniER
         bmaiuiNdaWMEp65GeXtds2raDuzbXBF5E22tHH4nw/thg9CEBRirwtxA/Kjb1RQZvfTX
         MJRpls9SeNF0IrHq2ixHBTuoxx9limIIOSnVNm5HA1b/TU7tJjhLcnPthZW4PNB1lVgo
         Y+8FDcwQnAeU8HvWs0rIEI/BQNcLcE/vvk4QonOIqewOEQIhiYzb1D8Lgdi/VqS9mipr
         5620CrzxDGUJ0QUZVXcE9xLpZmh34D2aN8HPr6/tOc6BrpqDBPpU26fgxFsxsK44DB1u
         CvOQ==
X-Gm-Message-State: ABy/qLZ6dDYdiAFSOVRVhGqZ5RlDDTbyPO1XY6N5UeSlYHx16K+RdXr+
	BOyAkVnwnUSRRCWQn5tai/cdkjobBQtLEwZCfEdweQ==
X-Google-Smtp-Source: APBJJlFp7mWS7vPqpNQkOGi2kL5vY3X7ZXSD5CjNhXZNuhjHt4J6jKA8H5LaQHX8HdwmZPTKY0aSAA==
X-Received: by 2002:a05:6a00:1501:b0:668:9bf9:fa70 with SMTP id q1-20020a056a00150100b006689bf9fa70mr11127109pfu.34.1688453757815;
        Mon, 03 Jul 2023 23:55:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 3-20020aa79103000000b00634dde2992bsm8773141pfh.132.2023.07.03.23.55.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 23:55:57 -0700 (PDT)
Message-ID: <64a3c27d.a70a0220.9c423.10cc@mx.google.com>
Date: Mon, 03 Jul 2023 23:55:57 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.184-cip36-10-ga711f789c23e1
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 78 runs,
 7 regressions (v5.10.184-cip36-10-ga711f789c23e1)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Jul 2023 06:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12203

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 78 runs, 7 regress=
ions (v5.10.184-cip36-10-ga711f789c23e1)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =

rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.184-cip36-10-ga711f789c23e1/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.184-cip36-10-ga711f789c23e1
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a711f789c23e157efd79724aec812ad47941364b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3b7d2c8261061fabb2a7c

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oct=
opus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr-n4020-oct=
opus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64a3b7d2c8261061fabb2a81
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:10:08.875856  + <8>[   21.873813] <LAVA_SIGNAL_ENDRUN 0_d=
mesg 11005083_1.5.2.3.1>

    2023-07-04T06:10:08.875942  set +x

    2023-07-04T06:10:08.979963  / # #

    2023-07-04T06:10:09.080535  export SHELL=3D/bin/sh

    2023-07-04T06:10:09.080726  #

    2023-07-04T06:10:09.181221  / # export SHELL=3D/bin/sh. /lava-11005083/=
environment

    2023-07-04T06:10:09.181493  =


    2023-07-04T06:10:09.282055  / # . /lava-11005083/environment/lava-11005=
083/bin/lava-test-runner /lava-11005083/1

    2023-07-04T06:10:09.282396  =


    2023-07-04T06:10:09.287266  / # /lava-11005083/bin/lava-test-runner /la=
va-11005083/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3b9f7b776bbba79bb2aa6

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr=
-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-12b-ca0010nr=
-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64a3b9f7b776bbba79bb2aab
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:19:10.759074  + set +x

    2023-07-04T06:19:10.765699  [   28.061266] <LAVA_SIGNAL_ENDRUN 0_dmesg =
11005234_1.5.2.3.1>

    2023-07-04T06:19:10.870596  / # #

    2023-07-04T06:19:10.972846  export SHELL=3D/bin/sh

    2023-07-04T06:19:10.973677  #

    2023-07-04T06:19:11.075632  / # export SHELL=3D/bin/sh. /lava-11005234/=
environment

    2023-07-04T06:19:11.075875  =


    2023-07-04T06:19:11.176642  / # . /lava-11005234/environment/lava-11005=
234/bin/lava-test-runner /lava-11005234/1

    2023-07-04T06:19:11.177950  =


    2023-07-04T06:19:11.182650  / # /lava-11005234/bin/lava-test-runner /la=
va-11005234/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3b777ca9f815ecebb2a88

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64a3b777ca9f815ecebb2a8d
        failing since 74 days (last pass: v5.10.168-cip27-109-g23841ec76bec=
, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:08:36.544065  + set +x<8>[   20.341038] <LAVA_SIGNAL_ENDR=
UN 0_dmesg 11005129_1.5.2.3.1>

    2023-07-04T06:08:36.544154  =


    2023-07-04T06:08:36.648678  / # #

    2023-07-04T06:08:36.749278  export SHELL=3D/bin/sh

    2023-07-04T06:08:36.749468  #

    2023-07-04T06:08:36.850023  / # export SHELL=3D/bin/sh. /lava-11005129/=
environment

    2023-07-04T06:08:36.850206  =


    2023-07-04T06:08:36.950723  / # . /lava-11005129/environment/lava-11005=
129/bin/lava-test-runner /lava-11005129/1

    2023-07-04T06:08:36.951029  =


    2023-07-04T06:08:36.956071  / # /lava-11005129/bin/lava-test-runner /la=
va-11005129/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-14-G1-sona           | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3b991e71336571cbb2ab1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.t=
xt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/baseline-nfs-hp-x360-14-G1-sona.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/64a3b991e71336571cbb2ab6
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:18:16.114276  + set +x

    2023-07-04T06:18:16.120621  [   21.498710] <LAVA_SIGNAL_ENDRUN 0_dmesg =
11005195_1.5.2.3.1>

    2023-07-04T06:18:16.230352  / # #

    2023-07-04T06:18:16.333247  export SHELL=3D/bin/sh

    2023-07-04T06:18:16.333986  #

    2023-07-04T06:18:16.435378  / # export SHELL=3D/bin/sh. /lava-11005195/=
environment

    2023-07-04T06:18:16.436232  =


    2023-07-04T06:18:16.537667  / # . /lava-11005195/environment/lava-11005=
195/bin/lava-test-runner /lava-11005195/1

    2023-07-04T06:18:16.538757  =


    2023-07-04T06:18:16.544333  / # /lava-11005195/bin/lava-test-runner /la=
va-11005195/1
 =

    ... (12 line(s) more)  =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/64a3bd531719ddbbe8bb2a90

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig/gcc-10/lab-b=
roonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64a3bd531719ddbbe=
8bb2a91
        failing since 12 days (last pass: v5.10.182-cip35-191-gf4efde512959=
, first fail: v5.10.182-cip35-289-g3c0549540706) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
rk3399-gru-kevin             | arm64  | lab-collabora | gcc-10   | defconfi=
g+arm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/64a3b9ee21e1ff5b21bb2b3f

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.184-cip36-10-ga711f789c23e1/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/64a3b9ee21e1ff5b21bb2b45
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:19:20.013546  <8>[   36.890702] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>

    2023-07-04T06:19:21.070150  /lava-11005281/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/64a3b9ee21e1ff5b21bb2b46
        failing since 74 days (last pass: v5.10.168-cip27-638-g0d599cd2b669=
5, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2023-07-04T06:19:18.922395  <8>[   35.798644] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-07-04T06:19:19.981861  /lava-11005281/1/../bin/lava-test-case
   =

 =20

