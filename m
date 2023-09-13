Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26F0EE01FD
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 18:08:32 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.4245.1694628507946122858
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 11:08:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=byxzCNpu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-68fbbb953cfso45577b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 11:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694628507; x=1695233307; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IzMZDRRzZc1hIcmBHnxJ2qnVEIj5uMapEarwBKWhP9A=;
        b=byxzCNpuj9mWmMLlANYStOSiT2G/BEAH1Go8V6dHUz9m8MutwoanjR2StNzBVmgvWg
         VyHooEj6PBlrSfnacmM3u/OdVCAvPDHzfQIH/vGumIS33NrtBNjAiciH2lApfX1P3jFX
         9olB6uo/vQd0tjwswRHT5nNKZbVimFwf2/Qy9pOXd/IUQeuhVFf3fNjYzD0ar9il26rW
         tE9xgnljeUJbbrvAak3m4zRQ4L9fARpKx+s4sGbeHgF3mBE1YdXDapNOavz0qCuYFBuS
         ms/fZsTHI4NzSB3NTMySNKY917B9KtGWDo/ZNevmFHVNNf/rniZmi0Mn+WhdrSUNVp08
         gTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694628507; x=1695233307;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzMZDRRzZc1hIcmBHnxJ2qnVEIj5uMapEarwBKWhP9A=;
        b=aGulkq86iCrAI541Uatm/ilUQwfyQkWleVuZ/vDRrGpGSAWwWj6i/F5quiMsgURkkJ
         YzrV15ZIyC9mTKoZZyfBIXkO1ZgCDXWU7eyjQW89ylgsOUbOiGiVlDyNfM9hZsh2Mcty
         69Uqk2+DaXSUUQW+iHbLeUCQr1Y3JgGV5FG+qlE4fdUWSIz8Sab9dbqPVE2O2v1zxL3+
         LlkDP0AImyOzcOxdQwz2uZHrYami+XsP+9mLosp031J8/4e6ksbgEg/4bDwNFIGEweSa
         hqT6IdWOmZD1CNrlmuzBek5qWv+vhqa24bNy2jSPkJ3oPmMGIWDztEn7epPezJab7QdT
         czcw==
X-Gm-Message-State: AOJu0YzajwfmUSzFoGnGbObJbsh5567jT0PwJUKwuaL6puDindK2vJcU
	yWupAoWRFHT8An9C0gRYhwz85VtyrTGNeyngdQk=
X-Google-Smtp-Source: AGHT+IEAkeYETSbnRwH5VRT7h+jmppaO47MwcXCZzGT/g8rLXeIq8KK3xhqiaUiN9JHGhEWgy7KMjQ==
X-Received: by 2002:a05:6a00:1914:b0:68a:6d1a:b812 with SMTP id y20-20020a056a00191400b0068a6d1ab812mr3657936pfi.9.1694628504608;
        Wed, 13 Sep 2023 11:08:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u11-20020a63b54b000000b00563826c66eesm8918931pgo.61.2023.09.13.11.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 11:08:24 -0700 (PDT)
Message-ID: <6501fa98.630a0220.c9ce8.8fe0@mx.google.com>
Date: Wed, 13 Sep 2023 11:08:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.52-cip5-29-g9fee06894d49
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline-nfs: 20 runs,
 2 regressions (v6.1.52-cip5-29-g9fee06894d49)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 18:08:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13122

cip/linux-6.1.y-cip baseline-nfs: 20 runs, 2 regressions (v6.1.52-cip5-29-g=
9fee06894d49)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defconfig  =
      | 1          =

rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.52-cip5-29-g9fee06894d49/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.52-cip5-29-g9fee06894d49
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9fee06894d496c0a873d78633ef74e3395d81c89 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
imx6q-udoo       | arm   | lab-broonie   | gcc-10   | imx_v6_v7_defconfig  =
      | 1          =


  Details:     https://kernelci.org/test/plan/id/6501f3518ad6a0f2618a0a5f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: imx_v6_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5-29-g9fee06894d49/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-imx6q-udoo.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5-29-g9fee06894d49/arm/imx_v6_v7_defconfig/gcc-10/lab-broonie/baseline-nfs=
-imx6q-udoo.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6501f3518ad6a0f26=
18a0a60
        failing since 55 days (last pass: v6.1.31-65-ge66be31505fa, first f=
ail: v6.1.38-cip1-10-gf4eb42f19246) =

 =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6501f27498049612f48a0b5c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5-29-g9fee06894d49/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-nfs-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.52-ci=
p5-29-g9fee06894d49/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/b=
aseline-nfs-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6501f27498049612f=
48a0b5d
        failing since 5 days (last pass: v6.1.46-cip4-14-g09ffd7fb38ff, fir=
st fail: v6.1.52-cip5) =

 =20

