Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15130C6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:01:02 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web10.37525.1679472054008088592
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:00:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=M+goaz6k;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id kq3so6144640plb.13
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679472053;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BQVg1VVOe4yy1yzDwWte3dzNQpL0KfkCAvCbD0ef7xM=;
        b=M+goaz6k6LroX2PVDWsmiKBlQ4JTppRNLQ0REMlXfZ1EizeZpLMx1zvtVu93ap1afw
         c+ss+ruWVbyIzksjxEzEdS76N1Nr7CNbuiU9/BiHrKTRiRxZQ0rO7dcULNfd/hSA77xs
         LEErf4jGSJzmoDN1Fu9jQbYvSXqHd4YKLhf5HGKImRzLA/NB2EW3x1XfcoIFFTrmSh2Y
         4+KajVUP+B/oSr8jbU3fikK81H4N5fE3hZC0NHRy9LzTDAup/1hpC8o9dc/XT6Wk2Z0Y
         wifuB8bLVxuFqYD3s4SFU6yXvIxIJO6jsRAZBhd3v8dEa9M3K1oVIbOVeptO7b4+vQnK
         EizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679472053;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQVg1VVOe4yy1yzDwWte3dzNQpL0KfkCAvCbD0ef7xM=;
        b=bOKjrWr6lET7dJaJuWUj7rAoc1UiGfG3C6UNqt8Tq8aHJEc1prkpl2bQIRe4htDrkC
         IaS4kXL+NxksYNA2+OQuu4LDJSGVNRYEZvUOejLngCrKFTqEIIctQ1Zviky4YGtJ8R1R
         iOmA4kC8+CH6DqM7S0QpA1XeC4CQFP2jPCeKljWsLGmKjkB/Y+d1mH9FyxIy3DzKel3p
         VV3PfC+kBB9H/9LGN+imlbUxxmNVVHR5HkLSpqt+wxsxRzjNMNnS6PbL43RPFx85c64L
         s+I886BOc9lt+g/fIZ2wEOpQDL2sZr2ZCKYPw9jxW4WltKIoRR37XDUKG6VghvfdHg9Q
         Q6wQ==
X-Gm-Message-State: AO0yUKXW/dCnaUhrNkqgQ2m8hyS1GeV6RsvIP7rzzTrQAWw/A6t+8Dr8
	MyJnItuxwZjBWBcbSVhxSV54ceP0r8na+uNQtMo=
X-Google-Smtp-Source: AK7set8WsGIEU6JQjdW63/Bq7M89xPC3/Ci25EDezARTUI2Ey1V8n7yQVxWWuaZ54p3tDGhbmoSs9w==
X-Received: by 2002:a05:6a20:659c:b0:d9:9d04:2c73 with SMTP id p28-20020a056a20659c00b000d99d042c73mr4861537pzh.45.1679472052994;
        Wed, 22 Mar 2023 01:00:52 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n21-20020a62e515000000b0058bc60dd98dsm9437734pff.23.2023.03.22.01.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:00:52 -0700 (PDT)
Message-ID: <641ab5b4.620a0220.12fe5.0dd3@mx.google.com>
Date: Wed, 22 Mar 2023 01:00:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.277-cip94
Subject: cip/linux-4.19.y-cip baseline-nfs: 45 runs,
 2 regressions (v4.19.277-cip94)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:01:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11046

cip/linux-4.19.y-cip baseline-nfs: 45 runs, 2 regressions (v4.19.277-cip94)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.277-cip94/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.277-cip94
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7027f305d14858b8392890a56cfe71edd50df202 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/641aaa5f748daa9bea9c9508

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.277=
-cip94/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/641aaa5f748daa9bea9c9512
        new failure (last pass: v4.19.276-cip93)

    2023-03-22T07:12:13.950563  /lava-9726828/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/641aaa5f748daa9bea9c9513
        new failure (last pass: v4.19.276-cip93)

    2023-03-22T07:12:12.903858  /lava-9726828/1/../bin/lava-test-case

    2023-03-22T07:12:12.924429  <8>[   38.964040] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

