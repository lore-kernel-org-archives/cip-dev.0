Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FCBC77B7F
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 09:31:29 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.14795.1683106286994972632
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 May 2023 02:31:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=FEy3eWzh;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-64115e652eeso3407081b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 03 May 2023 02:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1683106286; x=1685698286;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aBk6pWTXuJra0Fc0JHxR+I8hYsvmlR3xKYdaSnqm9qw=;
        b=FEy3eWzhsLchzTX6vawmwsPVtEbUMShX2Y9ePZkDwahcB8OebaUy0r035FQnqayq8T
         nC3iMMTvLvCKi85LITk/j0GeVc0mxK4Sff76eih3UUsa94ilTC1Cupzu5O97fsA3LdJZ
         6HSO8DyXy1PZBplRGDkgczRHCXap/QGjkP6uxU6J1awCfjQGZBtRBSiTNMKHE1sh1YvD
         DhTYMhUp1Gq8DnjFKzCWKuC13HTpHYoiNisRGcsLrpJcyvWbCYXeNh8w2PinBO2nsWe2
         YPQLb41N4n7VJb3XAkPn/9LxIO9AK0n+UhJXDqps6lnFCuCdvz/YC89fz/4voMs9jfY+
         CW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683106286; x=1685698286;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBk6pWTXuJra0Fc0JHxR+I8hYsvmlR3xKYdaSnqm9qw=;
        b=kmdN1mfctzFab/QsKZ2QnNiW6eAtH5vZ6zWq3dZYAUSK9PZxGHMQWP01Lse39XRWDb
         aCrbev+pCyRYe9/PuQEmovGaUqhDoECxUrlBPEkzgJwFzr5+ECK7Jhuj3Nm8H2Ci9inC
         /y+Pij7MF/nFfp8RwjkvA/vaFqywNfHvXovDEptdf0wQamj3OTf3jCulJCGQsLb6Bux2
         I9mQBl0NWDvui8gN9k8miFt+tE0hlYcN2odI4q3EGJsLcCZAswxwwdQ+N4HnPYQ8eeg1
         aeUF7knxi9vyEq+LHnyNPB/sRoBT+BUC/E9ypKe18R+wW7STlGcJlEmLKtwunz1N0wfq
         8obA==
X-Gm-Message-State: AC+VfDxFn1aqFedVg+vZoGlTHwkh22pQxA3PnpFyp0Sxuge2vA4LwBDw
	UNA5V8VuC5+wp9vPYYXuDGt1G5yrbp275iyUERQ=
X-Google-Smtp-Source: ACHHUZ40pkwICsEcUh+KSlh42YYxMgW6f1sTRiVU0lqtMO1qcrqCjIOnuvpLq110Y+p3rlPO2sCw7w==
X-Received: by 2002:a05:6a21:6d8e:b0:ee:3ddf:9737 with SMTP id wl14-20020a056a216d8e00b000ee3ddf9737mr1596440pzb.28.1683106285826;
        Wed, 03 May 2023 02:31:25 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w22-20020a63f516000000b0052873a7cecesm2369671pgh.0.2023.05.03.02.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 02:31:25 -0700 (PDT)
Message-ID: <645229ed.630a0220.ab44b.52ef@mx.google.com>
Date: Wed, 03 May 2023 02:31:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1186-gb629b961cbe6
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 16 runs,
 3 regressions (v4.4-st20-1186-gb629b961cbe6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 09:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11392

cip/linux-4.4.y-st-rc baseline-nfs: 16 runs, 3 regressions (v4.4-st20-1186-=
gb629b961cbe6)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1186-gb629b961cbe6/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1186-gb629b961cbe6
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      b629b961cbe64f7960f450588400468813a5f85c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645222e6c155ef96a72e8625

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230421.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/645222e6c155ef96a=
72e8626
        failing since 5 days (last pass: v4.4-st20-1097-g52d843097a439, fir=
st fail: v4.4-st20-1186-g2516b357b2e3a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645223e4aff00f37eb2e860d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230421.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/645223e4aff00f37e=
b2e860e
        failing since 113 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-799-g1229c813bcd9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/645222d2112df790b42e8626

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-gb629b961cbe6/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230421.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/645222d2112df790b=
42e8627
        failing since 113 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-799-g1229c813bcd9) =

 =20

