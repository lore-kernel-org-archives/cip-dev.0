Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A74C76196
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 12:22:14 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.68482.1680524525767611547
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 03 Apr 2023 05:22:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1BwlOHFa;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so32341153pjt.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 03 Apr 2023 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1680524525;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pmaMobazH+E8EhBU6dHbucEDIYntm93HFYPqpqLVaxI=;
        b=1BwlOHFavnqIqittTZDOxFbGkJZpchikSYyONP4SOnH0aZ2aOrdLuVUpVFVvYL+zFL
         kTtxWbPPYJxMuLKuUW99MG/bYXFrqhrvNGLFYNg765S6728bhjvG1Uc8Rn01xNUrBMqU
         8xJxy/mzBSdmW94FXe4h+65zIe1UGR8wPnfnUmdrvishi512GNdcqZEYxLREOi/mFALj
         itZ/q0M4SZ6XT0x77xPmh+nm7O4PoRwuf8r8ojLW4/dWiwu/jIGH/OqrDU/e7BlU7Zv3
         laLgSI8QEe1RQt74x5QryQWokQPl5GLbHPiBlpXhub9aAVXNmtSiWxhKIiuwUu0dDVb+
         wYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680524525;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmaMobazH+E8EhBU6dHbucEDIYntm93HFYPqpqLVaxI=;
        b=2A/2C23qcLI9XuA7MYqZsLkvZ9sALowEdLKiJzn7RcgT7b8Ni54f250wYFrq0+HYe5
         Pppc3mbhvvKUDMHeipf2DnoIfKBghuPB6hUcpdIHyHHKxGGDUrvxMQhJqwE2mNu2U2lH
         EYzDmMDXmQFWXrzFBp5Tz1qk84NVYj/0hGyZORGd6cKzlEtrKGAMu/PyV2eQrBdEr+cW
         dYQKu2b4omzinIeTO63yjBnQtw7kXQzJrCdJLK0OzY91ImtpXgA0s1xoTgjwviDJk8xz
         jSyjsoyG2+rMTNfZxCUPA9lqPxh2VEshEPlJbxBXATDKYNuOUfOZmdrRXwep5rCGWHa1
         iwyQ==
X-Gm-Message-State: AO0yUKUEWXU3g7aNrr6LSu+qDXsouqickQWZe9aOGQ5k/3GGf3ipM3Ue
	eQIUxgZDqScQzNLIM1Lr4LCDEzhtzfXPW3vS1dU=
X-Google-Smtp-Source: AK7set/BKSNOpTxrRZWbe4LVHLeV3h4vgcXSnBcqzUA97rFho2X4OCkFTrY8QRsOVQGz7xjXxEGnFw==
X-Received: by 2002:a05:6a20:4e1a:b0:d6:b44e:f644 with SMTP id gk26-20020a056a204e1a00b000d6b44ef644mr29801550pzb.59.1680524525017;
        Mon, 03 Apr 2023 05:22:05 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r11-20020a63514b000000b0050bd71ed66fsm5805983pgl.92.2023.04.03.05.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 05:22:04 -0700 (PDT)
Message-ID: <642ac4ec.630a0220.1aab5.a652@mx.google.com>
Date: Mon, 03 Apr 2023 05:22:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1098-g8d34bf42efd9b
Subject: cip/linux-4.4.y-st baseline-nfs: 19 runs,
 1 regressions (v4.4-st20-1098-g8d34bf42efd9b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 12:22:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11152

cip/linux-4.4.y-st baseline-nfs: 19 runs, 1 regressions (v4.4-st20-1098-g8d=
34bf42efd9b)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st/kernel/=
v4.4-st20-1098-g8d34bf42efd9b/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st
  Describe: v4.4-st20-1098-g8d34bf42efd9b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8d34bf42efd9bbd9f2b159d4e40217ea530ba3ff =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/642abd1234dfb1b5d062f76c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
098-g8d34bf42efd9b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st/v4.4-st20-1=
098-g8d34bf42efd9b/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collab=
ora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230324.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/642abd1234dfb1b5d=
062f76d
        new failure (last pass: v4.4-st20-939-g5ff13a6decb9) =

 =20

