Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A3BC6FD1C
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 09:37:35 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.97256.1679650649529909968
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Mar 2023 02:37:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=hGHfj5Nk;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id l7so1027119pjg.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Mar 2023 02:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679650649;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=siuUGJNymJtZKFlqGbO4Fej1mHwxeY2iaVz+dBxxEe0=;
        b=hGHfj5Nk7Kw/Avw4ex4QP6t4Cl/jI6NvIorvPlxuoFBnZoS+YQ+9XIn+FeAWBBQ+wc
         B5Q78/nhWd94jfLWe7nKUk6ZtIWdBiG26zWEMEGIM99oYaPtPejLrtbgJeFiJlUV5fSN
         RYkdt6g0BVsS0QcWvOmJTB0dQhR0NKLasIoY0MD3VRjHgvrTyaOwTUlY9jFKf0SzXdu4
         JigAHwLUiwWtCzlPCHDhYgrDcAgP/lOYbHoTeSF5h446e/wuXgKYwIb+N5ThDby+r/Iu
         IJktHPsEx+i6Zm3txrO6YFP/UMAlqSFUyeY4osyPouQSsH1+FpnIsbmFRWVzAj1E2ZYj
         S/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679650649;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siuUGJNymJtZKFlqGbO4Fej1mHwxeY2iaVz+dBxxEe0=;
        b=hTsrAUXupOglioNPAJO4PMCclagTt38sbLdWluHkk3OG1oczo/bqljeADYqpOj1Z88
         SoewofpI3Plm9nNmt/yaA8CInzGnzu1B/j2ckx40xTrDQSHX2DOtbn6YgSNr5LRIA4R8
         8Fxb/M9npVJsLp8nxnUNO9Yl2jfRFYhzVXha8JulRIBTc0N2OUBjsxF1ih37nqVeGGJd
         qt7+zvI+pbI8w7pIC38QcJEoht26sVp4fDaOspMkjL5+gbEjETHjryMDUwcN94bYaWIU
         ZxPpcDiMEvuQzoyahNQA7ZPsEdJ6Et3So/CwphpGewu7tyhejOJQiQbt84e+Rd9TEhq+
         eDpA==
X-Gm-Message-State: AAQBX9dLwoXRl7yYdDyVxDZyoqPYiEcuBwT4oh6m3i1eb2PoDsGcYpKa
	x7xVyUk6f5mS3BFPEwMy6uz8OROnUhMhWZ79+cgNIQ==
X-Google-Smtp-Source: AKy350bJs2zV7pfiOVIp/laMU3wMRbJbC6C9BXRiANh5UUBMs2meN9amWC+DcquMWHWzP8u+pavrBg==
X-Received: by 2002:a17:902:c941:b0:1a0:65d3:bae4 with SMTP id i1-20020a170902c94100b001a065d3bae4mr2122733pla.38.1679650648725;
        Fri, 24 Mar 2023 02:37:28 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id bf6-20020a170902b90600b001a1bf30cef1sm10780702plb.46.2023.03.24.02.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 02:37:28 -0700 (PDT)
Message-ID: <641d6f58.170a0220.d566f.402f@mx.google.com>
Date: Fri, 24 Mar 2023 02:37:28 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.279-cip95
Subject: cip/linux-4.19.y-cip baseline-nfs: 38 runs,
 2 regressions (v4.19.279-cip95)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Mar 2023 09:37:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11109

cip/linux-4.19.y-cip baseline-nfs: 38 runs, 2 regressions (v4.19.279-cip95)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.279-cip95/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.279-cip95
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a166e121fe317e5b7a79c09a0ca641ca15cb61cf =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 2          =


  Details:     https://kernelci.org/test/plan/id/641d661af9593ecfb29c951c

  Results:     77 PASS, 5 FAIL, 1 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.279=
-cip95/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.279=
-cip95/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-nfs-r=
k3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230317.0/arm64/initrd.cpio.gz =



  * baseline-nfs.bootrr.rockchip-usb2phy1-probed: https://kernelci.org/test=
/case/id/641d661af9593ecfb29c9526
        failing since 2 days (last pass: v4.19.276-cip93, first fail: v4.19=
.277-cip94)

    2023-03-24T08:57:55.677260  /lava-9759469/1/../bin/lava-test-case
   =


  * baseline-nfs.bootrr.rockchip-usb2phy0-probed: https://kernelci.org/test=
/case/id/641d661af9593ecfb29c9527
        failing since 2 days (last pass: v4.19.276-cip93, first fail: v4.19=
.277-cip94)

    2023-03-24T08:57:53.589415  <8>[   37.548272] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy-driver-present RESULT=3Dpass>

    2023-03-24T08:57:54.619050  /lava-9759469/1/../bin/lava-test-case

    2023-03-24T08:57:54.645230  <8>[   38.604774] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-usb2phy0-probed RESULT=3Dfail>
   =

 =20

