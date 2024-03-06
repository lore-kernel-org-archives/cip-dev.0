Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A37C54E41
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 22:16:55 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.9038.1709763409406662417
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Mar 2024 14:16:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=ITyUD/IZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so202621b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Mar 2024 14:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709763408; x=1710368208; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ADIfRS+xxe0gZLyHAHyEby0k0DDvSqVIfqXKOfrJTwU=;
        b=ITyUD/IZ1aeY2FiPpW6edJ/Vp7ZCPzDfsgQjiCrem5ythur25wE6cT/YBTBA7Hrhdb
         AJmTmO12UY1l/s1V1r3M7w+aIb5Wd5IqpYHCqbnwD278lePw7xf+ypPADPX3ixHOPBbs
         WgzipjA+dQx7HfQOeewWuqJSWsvvqbB1WMw9x4ppe5SaZXzf1O5glN42PH0EtjWYaQAr
         62YOJryeMyq7QjemNn2rxa5IS++Qb5ih735iPL5VKviAW8TVpkaBn4WWgNldz19sWYU4
         pqPu7eCUry7Y/UMd6HCzumYCmQEBiVJudoEtxadKFk1hO3cbJyNEmf87x7ecOYErziql
         CGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709763408; x=1710368208;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADIfRS+xxe0gZLyHAHyEby0k0DDvSqVIfqXKOfrJTwU=;
        b=adJ+iMzXB/hnCqFXlZ8Xw+fE+pIOjlLPQ9okU8iLmuK05HbzlTVrYK96R1WlgRBW/a
         SCIrNSFu0cRDW6LZAeeekhqZbPVx1k6ViCKHuzJTmnCMGKK6texhY+Mm3WFjHrlWUHYo
         hNYe12S8A4zUNVkSvArRbw/JBCdS7ALTviv32wcDe9288h+fflMCZiCqyl7y7S+6iJCq
         j3N2kvB4OUBCiXwLAxtfBivho5XdyOiwZxpj/Vrg2cnrwVfW+y8p/NwG1dQsnzq2sUgz
         KbIMYmWIi2bj8UIwAuZe3u7Vz4kKt2sK8JEU0OCrzBCgTnZNNeFlv6ueZibykGgJVBFs
         Cd2w==
X-Gm-Message-State: AOJu0Yw3UzD6II/Q3tQZ0mxhXdBuQffFt3I6wXO/i5fegiv8YpC8AyWR
	PBNfPn+bNDRT6o8rxkVbag3zus1UKor7MkxgFJmU+RZ/eeQYxqkoXwPeIFCS4X9zDygNIiZdjls
	RNbs=
X-Google-Smtp-Source: AGHT+IH9VqJKYQ9VSTiojMO9vTWtdkA7IfW9funn4Yz5CsHRiOQr+qdF+pf8bFfxPLJGi2EsYWO3lw==
X-Received: by 2002:a05:6a20:1604:b0:1a1:6cf3:265b with SMTP id l4-20020a056a20160400b001a16cf3265bmr1764961pzj.18.1709763407718;
        Wed, 06 Mar 2024 14:16:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x18-20020a056a00271200b006e650049472sm1519512pfv.123.2024.03.06.14.16.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:16:47 -0800 (PST)
Message-ID: <65e8eb4f.050a0220.bac77.5c16@mx.google.com>
Date: Wed, 06 Mar 2024 14:16:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.209-cip44-594-gb47da48f3bae7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 89 runs,
 10 regressions (v5.10.209-cip44-594-gb47da48f3bae7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 22:16:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15241

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 89 runs, 10 regres=
sions (v5.10.209-cip44-594-gb47da48f3bae7)

Regressions Summary
-------------------

platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest        | 1          =

juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =

meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest        | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest        | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =

rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest        | 1          =

rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-594-gb47da48f3bae7/plan/baselin=
e-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-594-gb47da48f3bae7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b47da48f3bae7f477104b0c214451338a6a343df =



Test Regressions
---------------- =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e109070dcd56da4c42da

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e8e109070dcd56da4c431a
        failing since 6 days (last pass: v5.10.205-905-gb40421b142370, firs=
t fail: v5.10.209-cip44-56-g55117716ac0fd)

    2024-03-06T21:32:12.992751  <8>[   52.086178] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 674985_1.6.2.4.1>
    2024-03-06T21:32:13.111679  / # #
    2024-03-06T21:32:13.214471  export SHELL=3D/bin/sh
    2024-03-06T21:32:13.215228  #
    2024-03-06T21:32:13.317142  / # export SHELL=3D/bin/sh. /lava-674985/en=
vironment
    2024-03-06T21:32:13.317898  =

    2024-03-06T21:32:13.419981  / # . /lava-674985/environment/lava-674985/=
bin/lava-test-runner /lava-674985/1
    2024-03-06T21:32:13.421342  =

    2024-03-06T21:32:13.440702  / # /lava-674985/bin/lava-test-runner /lava=
-674985/1
    2024-03-06T21:32:13.811226  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
juno-uboot                   | arm64 | lab-broonie   | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e9b6f6cd62579c4c42e1

  Results:     50 PASS, 11 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
broonie/baseline-nfs-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e8e9b6f6cd62579c4c431f
        failing since 125 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2024-03-06T22:09:31.861527  <8>[   40.175618] <LAVA_SIGNAL_ENDRUN 0_dme=
sg 675092_1.6.2.4.1>
    2024-03-06T22:09:31.980607  / # #
    2024-03-06T22:09:32.083551  export SHELL=3D/bin/sh
    2024-03-06T22:09:32.084344  #
    2024-03-06T22:09:32.186238  / # export SHELL=3D/bin/sh. /lava-675092/en=
vironment
    2024-03-06T22:09:32.187013  =

    2024-03-06T22:09:32.288952  / # . /lava-675092/environment/lava-675092/=
bin/lava-test-runner /lava-675092/1
    2024-03-06T22:09:32.290295  =

    2024-03-06T22:09:32.309186  / # /lava-675092/bin/lava-test-runner /lava=
-675092/1
    2024-03-06T22:09:32.437244  + export TESTRUN_ID=3D1_bootrr =

    ... (10 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie   | gcc-10   | defconfig=
+kselftest        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e060f3a95a70734c42db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e8e060f3a95a707=
34c42dc
        new failure (last pass: v5.10.209-cip44-56-g55117716ac0fd) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+arm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e0ab7f22e80e394c42db

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e8e0ab7f22e80e3=
94c42dc
        failing since 208 days (last pass: v5.10.186-cip37-566-g36076316ef0=
49, first fail: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
+kselftest        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e208b5e38f39334c42f6

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e8e208b5e38f393=
34c42f7
        failing since 83 days (last pass: v5.10.201-cip41-197-g2d08925b44e5=
2, first fail: v5.10.201-cip41-473-gc43d7b7bbe83a) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip       | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e5f0ec04afc5dd4c42e0

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
cip/baseline-nfs-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65e8e5f0ec04afc5d=
d4c42e1
        failing since 223 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.186-cip37-526-g7640d76efb649) =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-gru-kevin             | arm64 | lab-collabora | gcc-10   | defconfig=
+arm64-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65e8df7a01a0057ed04c433b

  Results:     84 PASS, 2 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65e8df7a01a0057ed04c4345
        failing since 321 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-03-06T21:26:36.636653  /lava-12965310/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65e8df7a01a0057ed04c4346
        failing since 321 days (last pass: v5.10.168-cip27-638-g0d599cd2b66=
95, first fail: v5.10.177-cip31-122-gfb6ca504156b4)

    2024-03-06T21:26:35.533093  /lava-12965310/1/../bin/lava-test-case

    2024-03-06T21:26:35.571931  <8>[   38.022579] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
+kselftest        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8df3ce659c17a1f4c4373

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-collabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e8df3ce659c17a1f4c437c
        failing since 125 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2024-03-06T21:25:00.072209  / # #

    2024-03-06T21:25:01.328364  export SHELL=3D/bin/sh

    2024-03-06T21:25:01.338791  #

    2024-03-06T21:25:03.077699  / # export SHELL=3D/bin/sh. /lava-12965318/=
environment

    2024-03-06T21:25:03.088457  =


    2024-03-06T21:25:03.088802  / # . /lava-12965318/environment

    2024-03-06T21:25:06.274178  /lava-12965318/bin/lava-test-runner /lava-1=
2965318/1

    2024-03-06T21:25:06.284565  / # /lava-12965318/bin/lava-test-runner /la=
va-12965318/1

    2024-03-06T21:25:06.662067  + export TESTRUN_ID=3D1_bootrr

    2024-03-06T21:25:06.662187  + cd /lava-12965318/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =



platform                     | arch  | lab           | compiler | defconfig=
                  | regressions
-----------------------------+-------+---------------+----------+----------=
------------------+------------
rk3399-rock-pi-4b            | arm64 | lab-collabora | gcc-10   | defconfig=
                  | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e4df6d42f9dd584c42e1

  Results:     5 PASS, 1 FAIL, 1 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-nfs-rk3399-rock-pi-4b.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig/gcc-10/lab-=
collabora/baseline-nfs-rk3399-rock-pi-4b.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
240129.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/65e8e4df6d42f9dd584c42ea
        failing since 125 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02)

    2024-03-06T21:48:48.429813  / # #

    2024-03-06T21:48:49.684946  export SHELL=3D/bin/sh

    2024-03-06T21:48:49.695202  #

    2024-03-06T21:48:49.695299  / # export SHELL=3D/bin/sh

    2024-03-06T21:48:51.430518  . /lava-12965569/environment

    2024-03-06T21:48:54.622048  / # . /lava-12965569/environment/lava-12965=
569/bin/lava-test-runner /lava-12965569/1

    2024-03-06T21:48:54.632932  =


    2024-03-06T21:48:54.633211  / # /lava-12965569/bin/lava-test-runner /la=
va-12965569/1

    2024-03-06T21:48:54.802433  + export TESTRUN_ID=3D1_bootrr

    2024-03-06T21:48:54.802793  + cd /lava-12965569/1/tests/1_bootrr
 =

    ... (11 line(s) more)  =

 =20

