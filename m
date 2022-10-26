Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64B4FA3740
	for <webhook@archiver.kernel.org>; Wed, 26 Oct 2022 10:08:12 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web09.5877.1666778885613326238
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 26 Oct 2022 03:08:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=eFu0axZ1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id k22so3110060pfd.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 26 Oct 2022 03:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O88dNjbxYpiIF1dWTT5FZ8UhCQxqnyEncn5+16yWJEg=;
        b=eFu0axZ1zUSA/qEuH7bqUvMbbBVWeJLMIb3MTjgqmiZqHH/FAhfMAiQYq5Bhl8i3Vz
         7hs2TcZ3K4mIEycFCpNMkLHmzO+7ScCQein6yOnp9IHWmeUdcNCrwjD3YX0DW/aFm8mu
         0tn/QLAt2trvQ7CC6SYWePpGWk6kqJlyxSk3m0+hNFgbd7ehoqROcM9Yd5aj/2GqMc0f
         Ddq+8Ok1ngDOFEdM7tH0OwXSgF83cABSBZKkQcZUNEF+X4ReIIprEzGCW5lmE/L+smA6
         1YGi7o0MOzaqWhaOsejNlHI5mGEcWi95p1tTyVGlVStJZ9S3mKvoMCiVSFJJwKCLuGF5
         WYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O88dNjbxYpiIF1dWTT5FZ8UhCQxqnyEncn5+16yWJEg=;
        b=YfJ9baQC1xqSxrchY4gckUsdT2Dnt8mQwxp5WTmFFoTeoS51k8BfJm66o2z/VmwLAF
         Zb1sWEcYxIA5zhIDil6W8c2+w8qtBX49pOKqh+a069EIpEpmXEXNNCALMxmuFmE0XVH+
         7rRDDNY5xkBwOSSlBmGqaS09Fq1w4Q3SiWwZcAbA1vhqL38KUIMgNk3TFyA2Acsu9p/n
         a2t5xQGiVz12+iB9akRIoeI4CSb08A2YurWwYBxAXSX31CXHZ8SADFDo+mIkBlGNuPqx
         5tRAG08/xNSsIbSnv7egxNk8xLeAI6uis5IXiXNt/N9EI4ADrRYtT4j7MNsS2XAT2krE
         Hl0w==
X-Gm-Message-State: ACrzQf1LBdYRd4YeeE1pSLK/pyQdDzGoMp9+dp+7F8zi2RzltnPpMN1R
	PB7Kb+GYFoMBhrnB6MzYKFDpE2FSki5LlZU1
X-Google-Smtp-Source: AMsMyM4yqTEMUYnibg1Vg8kLLxecUSypGvpqY07Z60ZZdm7dT/Whn3vp8/mDStwV0OQ+1tfSGDxS9w==
X-Received: by 2002:a63:804a:0:b0:461:25fe:e7c5 with SMTP id j71-20020a63804a000000b0046125fee7c5mr37433626pgd.395.1666778884719;
        Wed, 26 Oct 2022 03:08:04 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902f60300b00186b280a441sm2563875plg.239.2022.10.26.03.08.03
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 03:08:04 -0700 (PDT)
Message-ID: <63590704.170a0220.efbfe.5606@mx.google.com>
Date: Wed, 26 Oct 2022 03:08:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-11-ge6d27ea102c3b
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs,
 1 regressions (v5.10.147-cip18-11-ge6d27ea102c3b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 10:08:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9853

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 11 runs, 1 regression=
s (v5.10.147-cip18-11-ge6d27ea102c3b)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.147-cip18-11-ge6d27ea102c3b/plan/kselftest-filesystem=
s/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.147-cip18-11-ge6d27ea102c3b
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e6d27ea102c3bf928bd8f3a0815361cca9797bfb =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/6358f8fca0196df8725e5b6c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig/gcc-10/lab-baylibre/ksel=
ftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.147-cip18-11-ge6d27ea102c3b/arm64/defconfig/gcc-10/lab-baylibre/ksel=
ftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221007.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/6358f8fc=
a0196df8725e5b6d
        failing since 50 days (last pass: v5.10.131-cip13-84-g5fcbe4a63ab4d=
, first fail: v5.10.138-cip15-10-g52cbd8ad1543e) =

 =20

