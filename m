Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC67AEB64D9
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:22:45 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web11.11595.1686748960274855707
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:22:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=a2WokpPv;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-655fce0f354so5191308b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686748959; x=1689340959;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8sdA0AwjVtAw3SSjOGiLVNMZ2clAvRgCH9bh/RYwuu0=;
        b=a2WokpPvO5gn39ow+WuX6dxVdSNbWeHfyzaSA8d9HUhzM/ffd4d9zCeE3auEX7936C
         THJh+WE4Qa0nnYPqpHyOQ8RFNCNWVg34mbP9MPgD6QURG5QrG5xkDe91qdqzc/A2NVSO
         Animzlr7rPrq73RJUdNHOqMiRwYqD8UuUl171vH1FvlPlpHXeKwJLuHdGQ3FnC9PKx75
         jvs9wrvCuoT69w00TizlFDlM+WYj8MgIfxdWOm+LhgWZgpmY1kZ40+eNBozQ2q1eAHU9
         n6SoNqCDzwHgAV+z5O+NyoRYBOytmIKUrhDu2B3xpYPkzvh0C+7hcEY5nGVq8G0LCzBJ
         iljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748959; x=1689340959;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sdA0AwjVtAw3SSjOGiLVNMZ2clAvRgCH9bh/RYwuu0=;
        b=YMRatmHNid4xPMFeBy8fs/4OAjuopxcqfXnf2j7KoyNPr47+rQqtgTN3ou6wsegK12
         YsGPBTKxlReeBwIrLfb+8+MaNZB6yuoic5r5LUuDr911j8oF3DJCTNxEQUprQumzupj+
         QwfL7h8eewYKz5gCDV3cge/zWSE5SCsDxbYrQalFpV20N4QdxiUDCnbW3K5jN4wmPPsm
         aAEV9d4ezP2pteMneZDgRwmWp++F3EEBXeedPasAwzRSh2pIrYsMAp203rSwmVLKZpRi
         Q/d42RfdakX1p2O0iXmOawcD+mSo/w973FVWj/Iv0Zepcoys0jV2j14Ia+QVgrE82Yfo
         heMA==
X-Gm-Message-State: AC+VfDyRZ03ylzkk9celZzQdg3pvdJqVwLoOrRR+Fhj46VbcocRideL9
	z0c4XL21Ea/Izhxk/TGHcRKrmK25op7YRePcUSxlEg==
X-Google-Smtp-Source: ACHHUZ6Tie4G3v/GkJ31Gf3lj8vtxsreUhd5uZZkYhUAwrDlLBKzNgkHn69gGc2DKiYaJQ937mWjdg==
X-Received: by 2002:a05:6a20:2447:b0:117:6b17:106f with SMTP id t7-20020a056a20244700b001176b17106fmr1677170pzc.11.1686748959193;
        Wed, 14 Jun 2023 06:22:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id e15-20020aa7824f000000b0066355064acbsm10328263pfn.104.2023.06.14.06.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:22:38 -0700 (PDT)
Message-ID: <6489bf1e.a70a0220.2fe62.46f1@mx.google.com>
Date: Wed, 14 Jun 2023 06:22:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-1-g7cde3fba93966
Subject: cip/linux-5.10.y-cip ltp-ipc: 10 runs,
 1 regressions (v5.10.182-cip35-1-g7cde3fba93966)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:22:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12026

cip/linux-5.10.y-cip ltp-ipc: 10 runs, 1 regressions (v5.10.182-cip35-1-g7c=
de3fba93966)

Regressions Summary
-------------------

platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35-1-g7cde3fba93966/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35-1-g7cde3fba93966
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7cde3fba93966b9614ca285f91928a57a79f7f3f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform          | arch  | lab           | compiler | defconfig | regressi=
ons
------------------+-------+---------------+----------+-----------+---------=
---
qemu_smp8_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 1       =
   =


  Details:     https://kernelci.org/test/plan/id/6489ae6701d2a9d2d830613e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_s=
mp8_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35-1-g7cde3fba93966/riscv/defconfig/gcc-10/lab-collabora/ltp-ipc-qemu_s=
mp8_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30609.0/riscv64/rootfs.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/6489ae6701d2a9d2d83061=
3f
        new failure (last pass: v5.10.182-cip35) =

 =20

