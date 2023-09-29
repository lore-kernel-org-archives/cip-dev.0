Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32802E743D4
	for <webhook@archiver.kernel.org>; Fri, 29 Sep 2023 00:38:40 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.web11.7963.1695947918929889620
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Sep 2023 17:38:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=gwnaK1ik;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.170, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1bf55a81eeaso102536025ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 28 Sep 2023 17:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695947918; x=1696552718; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fBsxa7CgcxKANHamGgheaWUZN97sby6Lia1xEMug2gU=;
        b=gwnaK1iksAf3sqftMO4524Wz8l1IQagi3Mw0s3fQskOjsDiRCcKR3KEVAtZQ7hJjIG
         UPwiCw4eYi8Mb4nSI+kA2SukbvPTfOMh2Drcy1WlHn2FkTIaZINQC7ZA5hLaiHEizrTx
         U0CZSNOC+9gLYOTLwffPyLgGWsoGlzMmNce96kMbri2k2UwjQMnFk8qDEG8Iw23UdIYX
         SvSgHVcAO2DvYHESHJ3Lah6lZNs5yP3nUDr9XYaW7QY0iUCRNBvMHjZ9g3OuEnlxnMG2
         pGSo1h+9x91KldzE54yZ6syC8eNOtlzj7Ng9jOQYclxkB2cMxTjsIyFHTaJ2sas16SBy
         M6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695947918; x=1696552718;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBsxa7CgcxKANHamGgheaWUZN97sby6Lia1xEMug2gU=;
        b=EYkX+gUGK7f0eXBo5fO3fEfwC/5Ri/rsto1QnsCB2ZC6MjjsLn8nM3wLhBsIj3HtRH
         L110R7l2PaVNbiBiJZWVk7LVEY3ZSoUZ5hhk67uiQNFjbL0odZZTYekrU2Yh2nnhVumH
         VrRuf7I2s6q4kwKdmKKOUkU+3bfagk0lczX/18IiTVWvCq9kII4MopMjzoCmMI1rG/++
         pD4mFEU0Eyuf5wcs4AQrb+COLiAxv2N0qw8zQBuf56PDh845vnjiudOiXyb/735pxyGw
         WCDsNvcKzl0//zIddAUr0QcJk4fF+Jm7CgJGem/qPiJMNR94tuHHGGw09YJLQqFjUjFB
         OXjg==
X-Gm-Message-State: AOJu0YwFNT9SIY45SwLvQcOC/4hshF5h7neSDehJDZIPAfL3gFFh7FjR
	N7GjcxdCWhpS23HFb+6acPD7/wHNU73y8qjqaO003A==
X-Google-Smtp-Source: AGHT+IHZA2Hl+bAsZWLxkpcMZnw/DM1PmbLhTLSeyHBMDA1BcyVtf2F1MudCF6tm2EITNXX9U0VQqQ==
X-Received: by 2002:a17:902:a415:b0:1c5:de06:9e5a with SMTP id p21-20020a170902a41500b001c5de069e5amr2136022plq.21.1695947917849;
        Thu, 28 Sep 2023 17:38:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b001bf52834696sm15604197plx.207.2023.09.28.17.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:38:36 -0700 (PDT)
Message-ID: <65161c8c.170a0220.de031.eb8d@mx.google.com>
Date: Thu, 28 Sep 2023 17:38:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.295-cip103
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip baseline-nfs: 51 runs,
 3 regressions (v4.19.295-cip103)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Sep 2023 00:38:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13248

cip/linux-4.19.y-cip baseline-nfs: 51 runs, 3 regressions (v4.19.295-cip103)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.295-cip103/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.295-cip103
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f0bb9fab6f834f73d3a71af029f5bda19d99b33c =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
at91sam9g20ek    | arm   | lab-broonie   | gcc-10   | multi_v5_defconfig   =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/6516166c082a5791618a0a42

  Results:     42 PASS, 9 FAIL, 1 SKIP
  Full config: multi_v5_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20e=
k.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/arm/multi_v5_defconfig/gcc-10/lab-broonie/baseline-nfs-at91sam9g20e=
k.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armel/initrd.cpio.gz =



  * baseline-nfs.bootrr.deferred-probe-empty: https://kernelci.org/test/cas=
e/id/6516166c082a5791618a0a78
        new failure (last pass: v4.19.287-cip100)

    2023-09-29T00:11:50.226882  + set +x<8><LAVA_SIGNAL_ENDRUN 0_dmesg 1392=
38_1.6.2.4.1>
    2023-09-29T00:11:50.354800  #
    2023-09-29T00:11:50.456801  / # #export SHELL=3D/bin/sh
    2023-09-29T00:11:50.457631  =

    2023-09-29T00:11:50.559662  / # export SHELL=3D/bin/sh. /lava-139238/en=
vironment
    2023-09-29T00:11:50.560508  =

    2023-09-29T00:11:50.662549  / # . /lava-139238/environment/lava-139238/=
bin/lava-test-runner /lava-139238/1
    2023-09-29T00:11:50.663918  =

    2023-09-29T00:11:50.667750  / # /lava-139238/bin/lava-test-runner /lava=
-139238/1
    2023-09-29T00:11:51.027328  + export TESTRUN_ID=3D1_bootrr =

    ... (11 line(s) more)  =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65161433844ac73ca78a0a42

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-=
rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/65161433844ac73ca78a0a4c
        failing since 190 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2023-09-29T00:02:54.185261  /lava-11637433/1/../bin/lava-test-case

    2023-09-29T00:02:54.207560  <8>[   39.979337] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy1-probed RESULT=3Dfail>
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/65161433844ac73ca78a0a4d
        failing since 190 days (last pass: v4.19.276-cip93, first fail: v4.=
19.277-cip94)

    2023-09-29T00:02:53.124986  /lava-11637433/1/../bin/lava-test-case

    2023-09-29T00:02:53.149203  <8>[   38.920836] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

