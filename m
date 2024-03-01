Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B680C5478C
	for <webhook@archiver.kernel.org>; Fri,  1 Mar 2024 15:27:55 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.25926.1709306874408286873
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 07:27:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=UpzYmX3z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e571666804so1631586b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 07:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709306873; x=1709911673; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QdXEEEpeq/VHYgCyr+HH6js3WDoYfmr4Tx0qQkNcX7w=;
        b=UpzYmX3zA3b3U9vFee3qaCsZ0itNBVQNNhJV3dpNDjxnKEiAGwFKYDz5n4cC3yVoTY
         j+hQRSn9eY/BR9akdPtX55nK7EbkOirkFfHPnShjSJF/pbQQZTC+6g2v0MdoKEbcqlIM
         BC+EDvw9mVB+Tkr08dbFub8qYICmvlk47sau2hhGOzCC4uJPK0SEWktlBZsieVjDWqOQ
         d+eo++w/vGjOqnAW64pFiPKajsCuVcpBOL01lWKBC+lSAB0ixVXB7HCv+2vuk5mVna9T
         yn8K8ulvVNt5ThAiZXTAX0NvDUtkj6IZI+z1S+mjnUE0TzIh6xee/uEmFl9Ysvo9mAo1
         FdJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709306873; x=1709911673;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdXEEEpeq/VHYgCyr+HH6js3WDoYfmr4Tx0qQkNcX7w=;
        b=tzaNm6BPRUiat+wViZ6zvxFRC9twz/90kO2VfFuu199YT5cMebf3ccoSt54vycLF59
         YCskD/6Vd1LiCUYkTeR2oHu9YqvYMnYNv6YSs6PY5ni6K9nAcMrDeeVN0sysNUrbr1Lg
         OjmJqayLOiNLO7+1RGg9xFxiPKbAlODPwd/66IJpH8cybpWhAqyAlKJ1ikkNYxH79gSY
         uxSM+6LmCix/6uLUhmcoXWxMqckfuMqy3xA2xbMLJr37ynQthEkTfZxZvJXTV6l6JBOC
         l6I6KYs40n1NA6kH2LioQzEwkAMUrkkUWIqBYW8NKRLYmEIqHnxJWOBYzgllQtFqy6JQ
         vNnA==
X-Gm-Message-State: AOJu0YxLhP38ra1Z5DK7MuZR8REWcMRS2jTv1M0P9jqYgbKoG8ONk2bt
	YsZChIrV4y82lhOBgIF6MZ288WGglrna8lLrOnMVCnCp03fWs8smGBtsprhg2MVdzUWCRKeGgi2
	tgJs=
X-Google-Smtp-Source: AGHT+IEV9g5tQH2OhmbCtdlaFzSUfpGQYvmopyZzFTMwOAfaFB1weBdF9dakV7UsCwKVQesn9DVfRQ==
X-Received: by 2002:a05:6a00:14d0:b0:6e5:5c83:c453 with SMTP id w16-20020a056a0014d000b006e55c83c453mr2776222pfu.23.1709306873005;
        Fri, 01 Mar 2024 07:27:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z19-20020a62d113000000b006e501303f1fsm3197009pfg.40.2024.03.01.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:27:52 -0800 (PST)
Message-ID: <65e1f3f8.620a0220.a44cc.ec17@mx.google.com>
Date: Fri, 01 Mar 2024 07:27:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.209-cip44-56-g6ff909810a18d
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip baseline-cip-nfs: 7 runs,
 4 regressions (v5.10.209-cip44-56-g6ff909810a18d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Mar 2024 15:27:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15124

cip/linux-5.10.y-cip baseline-cip-nfs: 7 runs, 4 regressions (v5.10.209-cip=
44-56-g6ff909810a18d)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =

beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =

r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =

r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.209-cip44-56-g6ff909810a18d/plan/baseline-cip-nfs/

  Test:     baseline-cip-nfs
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.209-cip44-56-g6ff909810a18d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6ff909810a18da01523521db983d48116abb28ec =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | multi_v7_defcon=
fig         | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1eb6a00b186663f637013

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/multi_v7_defconfig/gcc-10/lab-broonie/baseline=
-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e1eb6a00b18=
6663f637014
        failing since 112 days (last pass: v5.10.131-cip13-37-ge3a52725ce96=
, first fail: v5.10.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
beaglebone-black         | arm   | lab-broonie | gcc-10   | omap2plus_defco=
nfig        | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1e93a63284cf1d063701d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-cip-nfs-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm/omap2plus_defconfig/gcc-10/lab-broonie/baselin=
e-cip-nfs-beaglebone-black.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm/cip-core-image-kernelci-cip-core-bookworm-qemu-arm-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e1e93a63284=
cf1d063701e
        failing since 112 days (last pass: v5.10.131-cip13-38-ga8671b4cc3c7=
4, first fail: v5.10.200-cip40) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774b1-hihope-rzg2n-ex | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1ec3120209012a163703d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-cip-nfs-r8a774b1-hihope-rzg2n-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-cip-nfs-r8a774b1-hihope-rzg2n-ex.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e1ec3120209=
012a163703e
        failing since 28 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.208-cip43-4-g1c63c70fb18b8) =

 =



platform                 | arch  | lab         | compiler | defconfig      =
            | regressions
-------------------------+-------+-------------+----------+----------------=
------------+------------
r8a774c0-ek874           | arm64 | lab-cip     | gcc-10   | defconfig+arm64=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65e1ec44b39af1d9e063708d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-cip-nfs-r8a774c0-ek874.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.209=
-cip44-56-g6ff909810a18d/arm64/defconfig+arm64-chromebook/gcc-10/lab-cip/ba=
seline-cip-nfs-r8a774c0-ek874.html
  Rootfs:      https://storage.kernelci.org/images/rootfs/cip/20231004/qemu=
-arm64/cip-core-image-kernelci-cip-core-bookworm-qemu-arm64-initrd.img.gz =



  * baseline-cip-nfs.login: https://kernelci.org/test/case/id/65e1ec44b39af=
1d9e063708e
        failing since 28 days (last pass: v5.10.138-cip15, first fail: v5.1=
0.208-cip43-4-g1c63c70fb18b8) =

 =20

