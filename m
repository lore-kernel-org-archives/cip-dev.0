Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3509CC54E51
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 12:06:57 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.9114.1708690011460935771
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 04:06:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=G7cuWtqq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1db6e0996ceso6132495ad.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 04:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708690010; x=1709294810; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oAqvTkz6ivczwHFh+/4jPAye4lcy0MBjo0vUpNH59qY=;
        b=G7cuWtqqA0XNWRkpMjnSDVIl1GcNq9oW1C5ZxXCKP+iVJA3NO/REFa8QMk8AIuZ4Lt
         voZfrPP57QVElUvMwTjx0UftJUOHSwwbuUn3IT1/06vvhsSoGNdCF666/Y1XXklHTqMA
         VX2l+dPqgrv9iqbHgmutHkVjKH8cuz83ttv5bacU6tN+F7647JNKWYpWH8NMx9s1Wv0D
         YK3YtfaxpiZJGxUEFWkXtAO5qIxMgOgZUlTP1qhwhnHxj1H63xvDhKYnfmXgEBOi5JDq
         C5icUA48vhiOs5uAoaTECIWrbrh06nTb1K0WM/jSEDk5lsN6UMr+9RD30smIxiV2bH0d
         QxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690010; x=1709294810;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAqvTkz6ivczwHFh+/4jPAye4lcy0MBjo0vUpNH59qY=;
        b=B/4zgDs4a7d/BumX/bEPa+jamoz+yTdMoPxHa0O9nnWzLeh2tGfsBq0lCHvmCP8BvJ
         2S9SqBbZs5ZcfhxgL474UHw6aR6G1gCWxPgqHLgv5hrgQIHcRaLxO64KczTuG5abRPUb
         x8T0lr6jcEJWGX+AhOmeMRAAywonqbEMuMipZhKban2qbWYG4bxaEHNz9RjSZCkESOSK
         1MLSmNy858OFXfXgKhnk743ieOH6AmBEItYwdut8dPEgujyzUBBRWPeW3uaoRwqaoTaC
         WYZyfbQPhL1c/xvFbKfffR7MIydgcC1vfegmuXPphwZw6yoe/dB5qab+8InDqE4pvgPa
         1Y3g==
X-Gm-Message-State: AOJu0Yx6Obxjt/IH8ifhyRIFgtW6GJ3DDmdwVkv2oap3+gpfDQqJcc+S
	2ZgIEBVrBaHURtlNGfIOYUGsC/3txeBifA/OpJzmo0CLX40W62RKeAddyoHf+7KWmW+7/uEsFBf
	OHSw=
X-Google-Smtp-Source: AGHT+IHlr6MRqNChG2FRvl9TevzXf1+jYz44J9Ibl4qEaWzhM2DhFq/VsIKR4xmZM37Ur8czlVNecg==
X-Received: by 2002:a17:902:6e0f:b0:1dc:7890:72d7 with SMTP id u15-20020a1709026e0f00b001dc789072d7mr23459plk.20.1708690010442;
        Fri, 23 Feb 2024 04:06:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902f20100b001db3099d6fasm11466776plc.119.2024.02.23.04.06.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:06:47 -0800 (PST)
Message-ID: <65d88a57.170a0220.8544.6c85@mx.google.com>
Date: Fri, 23 Feb 2024 04:06:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-424-g38943e302f8c8
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 11 runs,
 2 regressions (v5.10.209-cip44-424-g38943e302f8c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 12:06:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15074

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 11 runs, 2 regres=
sions (v5.10.209-cip44-424-g38943e302f8c8)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-424-g38943e302f8c8/plan/kselfte=
st-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-424-g38943e302f8c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38943e302f8c8bda23c2853f688afa5e35cae90d =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d877c93cb1cffc3e637088

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-gxl-s905x-libretech-=
cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-broonie/kselftest-lib-meson-gxl-s905x-libretech-=
cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65d877c93cb1cffc=
3e637089
        new failure (last pass: v5.10.205-905-gb40421b142370) =

 =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d8786deacd764b01637019

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lib-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/65d8786deacd764b=
0163701a
        failing since 112 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

