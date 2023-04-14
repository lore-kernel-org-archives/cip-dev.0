Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3786C77B72
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:13:40 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web11.6703.1681470815064161048
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 04:13:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=GJB/Y9/V;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.171, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f171.google.com with SMTP id p17so6802741pla.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 04:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681470814; x=1684062814;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x05WzVfZVskOcdZa2jJGkn29jSjO46cf/i327lE7gbs=;
        b=GJB/Y9/VnOyHIoKu4FAjOEj4UxLcYoBPC+bHoGBEbUjAuFOpvqBvh7u2e4qtks8rm8
         p0p3GDVd2xetWhQhJFNevjUSbjq2Cp7yjyHcQuAEhsLLPX46RVnYB987iBfG2bGTa01X
         UTM3V4Diwl4HQ09DGWKQTgoP+6LRe4sGWM4ftZOX8+QfF8PQlAABnF/c+eWVl3vkCr+i
         RG+fHVjwSeexYa9/jge/0vioeWcOPRCMWeUE1VZAeGLUJkfkt4FWbjlfigz/fgZsm16L
         uXdrUgMePXC1jIHVJbBdzfRt84+I9UUk9l3jOi8cZNuw2bfobhOiZq36F3HOodOUxn+w
         jUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681470814; x=1684062814;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x05WzVfZVskOcdZa2jJGkn29jSjO46cf/i327lE7gbs=;
        b=ZRTx7RPUY9bmaSjIB2XhDZy3vVVLtHk7a21MOVh54jQC3w5mjSCjJazazuSak6tE1h
         jP/LjFsN8Si/buuQRwF8g8jMGyHEjLCqtpO4bh9TeEeBEdX617lLOEpuBrLKrZQdwZTF
         gbfOFUEvRjEi/z8f0d4ZxqPEf0BQcFUzcOV/KKAqoPxgKdxtRm9SGwOS/h6RSbKWQ0Ds
         JJcFM6EjmWJ/N3S7SxvJXOU1cKcaJqFimpWVylarlsP4V1B/cw/abrCLPz09QBDc+oIq
         MN4TWw8DTWjgjcq8pvJxi56pXzoD04R6fbMYFjO51P3aEay90V3e6eSSqBksK8vQNSzt
         bhZA==
X-Gm-Message-State: AAQBX9dyVnqEnSNG1ZrkoNHWNYwl5nH511HbVs2df1zFXg3R0o+REAUH
	rLkCwgFfYj+rmFmMxlPxfS2L4uKt2l+Q/3FfXHYsg3Jx
X-Google-Smtp-Source: AKy350ZtFiJiQ+MgJV4q+UJrvrN5uFR9WUeTVjnKpBLGZGjrJjDPCxDm70FdTmHJ0a77UzUpLKMJgA==
X-Received: by 2002:a17:902:da8f:b0:1a6:7510:3341 with SMTP id j15-20020a170902da8f00b001a675103341mr2839118plx.69.1681470814267;
        Fri, 14 Apr 2023 04:13:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c21300b001a1d553de0fsm2876455pll.271.2023.04.14.04.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:13:33 -0700 (PDT)
Message-ID: <6439355d.170a0220.7ef7a.6df4@mx.google.com>
Date: Fri, 14 Apr 2023 04:13:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.280-cip96
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip smc: 6 runs, 2 regressions (v4.19.280-cip96)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:13:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11212

cip/linux-4.19.y-cip smc: 6 runs, 2 regressions (v4.19.280-cip96)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.280-cip96/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.280-cip96
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f5788ca10e5121ce62a8a58a84c723b7d99607f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6439301aa6f87a6f782e85ef

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.280=
-cip96/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6439301aa6f87a6f78=
2e85fb
        failing since 279 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-04-14T10:50:59.743284  <8>[   12.121277] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6439301aa6f87a6f78=
2e85fc
        failing since 279 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-04-14T10:50:59.733507  <8>[   12.111742] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

