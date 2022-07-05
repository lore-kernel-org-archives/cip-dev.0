Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2E7C43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 02:34:45 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web08.79937.1656988481802270045
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 19:34:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=wX7Y9Cdi;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id 3so165909pfx.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 04 Jul 2022 19:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=ZeRQ5XGSbIlw6QWLoYZeeYhVfQ1mJtbdKjSLuj2w1Wg=;
        b=wX7Y9CdiMyrr7sKG1NIe1xCrJOThp/8vgAah6BMOaNofIOINUahcxcKsYaB7xH4d5a
         9A/xL/2nIm4CIQMWbhAeX1jCbcJ860HLs4spCt8SaxLGe4b9VZfwHXY4S+tZV9ObfO5E
         I62qW/di/G/HTf62lGpKksTkhSdKNbXKqcoFsev5I4Dd0dIuGoCr5rqmokzCHAdL3kFC
         kadNbYF+cSCrfr2+Ih4EBY2WA/xa4b7SNOSE8Gj50wUon24yym9X56cWFaN+XKMV/vvt
         OutVZJwErZQQG9d6PC1bK8393S+rVYBGavRWZcoX1L07LJdvy1Fc8n+KH6FgU95qhcgx
         9MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=ZeRQ5XGSbIlw6QWLoYZeeYhVfQ1mJtbdKjSLuj2w1Wg=;
        b=SZZBgwECF/1hHzaQKdVkzO7YftTmazAFeO7xH1JEg1Y3zr4hidGMAMich3VGyinGZn
         ybt7TjkOTi2tLHo99oR0SyW1jeQfFyzh3/JmYeR1LaUK0aGvClHdLCcNgsnvmiJ2RZib
         BMZvXP30kvYacGLp4mawfWumA8Z0CBG5LgUGxzrRUtqZYfw0ssCOxdZDaFhnPUVp8fdK
         QhHm1rfCqqOUBHs5aDIXrrEitIKLPJeyvF0hC5EHGnS0zwhBYenVA3Q9KSUKoR2JVkQM
         RxSgF1dYCEUcS3yi8yNPydOz8tIyKnufOal4grsQxJQCkjYb9yeKxmT69a/sMwaEkNPp
         Jhuw==
X-Gm-Message-State: AJIora/QPOLCke+prFSAm2N6annL10fQ/8Yq7CGccJCsVVjn/RGsKGeG
	weeZVmeBkxciR3nd7tHKk+XfLP6eNvmPh8Gd
X-Google-Smtp-Source: 
 AGRyM1uMViGddv79X3WmawVicNwjZmoYlXCVuytm8r3BrPxWxWdbqThd4KWLzX3Ng3eysO6KnOPFTA==
X-Received: by 2002:a63:fb44:0:b0:40d:1b0d:bfb4 with SMTP id
 w4-20020a63fb44000000b0040d1b0dbfb4mr27559612pgj.335.1656988481130;
        Mon, 04 Jul 2022 19:34:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 u8-20020a170903124800b0016bd8f66ca0sm4551642plh.162.2022.07.04.19.34.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 19:34:40 -0700 (PDT)
Message-ID: <62c3a340.1c69fb81.2a3b1.6422@mx.google.com>
Date: Mon, 04 Jul 2022 19:34:40 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.125-cip10-119-g603acbe1aceb
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 30 runs,
 1 regressions (v5.10.125-cip10-119-g603acbe1aceb)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 02:34:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8655

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 30 runs, 1 regress=
ions (v5.10.125-cip10-119-g603acbe1aceb)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.125-cip10-119-g603acbe1aceb/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.125-cip10-119-g603acbe1aceb
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      603acbe1acebe85cab7f594d9952a493be976262 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/62c39c313152fb640fa39bcd

  Results:     84 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.125-cip10-119-g603acbe1aceb/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-collabora/baseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
220624.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/cas=
e/id/62c39c313152fb640fa39bef
        failing since 118 days (last pass: v5.10.100-cip2-319-gcbff87047566=
, first fail: v5.10.100-cip2-425-g0a0d92194f39)

    2022-07-05T02:04:17.669272  <8>[   37.012819] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s0-probed RESULT=3Dpass>
    2022-07-05T02:04:18.135975  <4>[   37.478301] cdn-dp fec00000.dp: Direc=
t firmware load for rockchip/dptx.bin failed with error -2
    2022-07-05T02:04:18.145786  <4>[   37.488915] cdn-dp fec00000.dp: Falli=
ng back to sysfs fallback for: rockchip/dptx.bin
    2022-07-05T02:04:18.714872  /lava-6750181/1/../bin/lava-test-case   =

 =20

