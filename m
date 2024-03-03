Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105DFC54E49
	for <webhook@archiver.kernel.org>; Sun,  3 Mar 2024 21:43:35 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
 by mx.groups.io with SMTP id smtpd.web10.83876.1709502208753021849
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Mar 2024 13:43:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=YXf55j39;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.49, mailfrom: bot@kernelci.org)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e49812ba77so1972851a34.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Mar 2024 13:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709502207; x=1710107007; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8NK4Jg6/3XzyWVsSielwGVCQexqJFo1kRhjpbuw8Gv8=;
        b=YXf55j39ECZ0j3VJ//okXFkmmCBGQ/Ct72h1UJfgHY4VLMfmQeD9/opwAuxManD8dP
         chAcfezUcimLTsPMtyh45GW2Tk09whKG+UpeR3/NoynCq0EF3//URxOh7ajKVMKgxmX7
         GR2zBwHC4WtIu7aHmUvkJzNZzXDubUsQKv/Txvr9r8bdSx1KmFETNicdqIrF3m2nCq4D
         lg7U4WZIyIGeeoRatVIssa+/LTM6kmzYH2A9XPcwmMrB9XkYnOdEPNvoIar87X+xF5Il
         F34+Qat+WeLf5P1qAeij8hQMIR8d4EBhq2g23HDXSUo6S/2uVdkB3zrgfSKt6KolN7aL
         byxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709502207; x=1710107007;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NK4Jg6/3XzyWVsSielwGVCQexqJFo1kRhjpbuw8Gv8=;
        b=FHRqVzchOPDt4r3Df2x9iFXqmXZj0HUXbbwepoxcBA9Lg3hRJoEn/WuBdTbF0raX9n
         eqg/bE9D5xDQLt0XJ8IygG9f+CUZggVPTc22FZSliIspuSQAVi+DM3DLE4MPAdrs1Ob+
         T3ciEQf4Os1GB9CDPV2owd/FmvhZwDnFGLV2gZP97fDEmCT0CdTcT87PcBk/ynTs0CCr
         EqP/N1DRNFrfN5JrZHHzHIRn+hmufvXTfja+dRCtQiX1g6UahXLkuleHf9MY6QdlEg4J
         i0N3hQFfsTx+VZ6LnIf8rJH/y/nEDctBHQWPCYqRQWDdZlfdQnn4elqtsNRm9awrq4Nu
         IZhA==
X-Gm-Message-State: AOJu0YwOLpEmJlUfv51tVKFCwpNuS5SyE57F4C1huSd0epEH50AbRscp
	egsB+D0tu1OYtYlUIkm84C4pDSRlilwd7ch8UsZX4IGFCEFVx5S8cS1MgATZiqmHiRNdCjLNLy4
	+gPM=
X-Google-Smtp-Source: AGHT+IH3OvSAejgs/zf2dBkkG8F+M/3ZRWq87IoZNBlQAbaCZRYzIT74k9EzPb6Z2XI1HB1aLAtnXQ==
X-Received: by 2002:a05:6830:1196:b0:6e4:ea39:9f90 with SMTP id u22-20020a056830119600b006e4ea399f90mr282333otq.33.1709502207234;
        Sun, 03 Mar 2024 13:43:27 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001dc0d1fb3b1sm7014707plh.58.2024.03.03.13.43.26
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 13:43:26 -0800 (PST)
Message-ID: <65e4eefe.170a0220.e65e4.b4c3@mx.google.com>
Date: Sun, 03 Mar 2024 13:43:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-547-gb5450675e67c
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 10 runs,
 1 regressions (v6.1.78-cip15-547-gb5450675e67c)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 03 Mar 2024 21:43:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15183

cip-gitlab/ci/pavel/linux-test kselftest-futex: 10 runs, 1 regressions (v6.=
1.78-cip15-547-gb5450675e67c)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-547-gb5450675e67c/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-547-gb5450675e67c
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b5450675e67cda5a44ee81ea4d17ab5db9b7deff =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65e4df84ea56ec565c63708d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
kselftest-futex-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-547-gb5450675e67c/arm/multi_v7_defconfig/gcc-10/lab-broonie/=
kselftest-futex-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/armhf/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/65e4df84ea56ec=
565c63708e
        new failure (last pass: v6.1.78-cip15-404-gdddfc5d4f194) =

 =20

