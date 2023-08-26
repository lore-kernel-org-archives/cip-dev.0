Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E30DC83F11
	for <webhook@archiver.kernel.org>; Sat, 26 Aug 2023 17:26:27 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.web10.12787.1693070777557053198
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Aug 2023 10:26:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=OhAJtypO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.180, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-68bedc0c268so1744360b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Aug 2023 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693070776; x=1693675576;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HgQH+PM5xW3u4eDwBtt0AL60rnC6MxxIl1Pj/l3theQ=;
        b=OhAJtypO2dGHf5RJ1rXQ4Ejnyrw2ja+TUBi2If6x2XiFWwWZa01iXc1Jx7km4qz1C+
         3KpfqybDbzyqmUts6XuUhYbQgfxnxYVWHc7vl8ewT1YSuTWruxnwjjcy1yPBcG32iKLX
         tMskDZLjugyFYbmE9VHGibzWBlT49gh6pV4PLdGJ1AEzp67HNd4HNfH2+ih7Ls7yL9qI
         kmlZ/VWV0HOl5XmnxX235xoyHZ6MxsI4918JTZTUqn+nI4FD1BazxDKDrUZrvAOrbk1S
         tpVJauWiVcy5AFReNz4atP12C930svBu+W0bOa4u0qJt1RCgLVpQVtWm5cTpX54x/mU7
         mk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693070776; x=1693675576;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgQH+PM5xW3u4eDwBtt0AL60rnC6MxxIl1Pj/l3theQ=;
        b=lYHS45rCQoe6ogQsYFzgmi2bHnMVltjwWaFTEYuTTgVoIlpD5QImQHgEszIe6ma2ia
         4jgUSpGIYipwoV/tnjSArv7QjAm4ZzhUsNwNgcb9Fw/gOMwsJo2ut/Y4epPRhLEYN4Wm
         sMbJy2jBKN589RqfBZ7WXGEqSW6/GXkh9RO8PWcUm6K8XnZgCATzBIcZPSfeVZE1Ii5M
         tMLgBHHoRzUNJzblQJxb04AvHQJwjut1TbxgkEo+ljJafjZq+uGOovSzM4UDYrCwqhYZ
         SxM5TnGTJPIGcDjtQAFCVo1/8ia0jfN3Nsrh8uvBv/LcdnTpuZhWTN8rkWcKWfj4elIA
         fXpg==
X-Gm-Message-State: AOJu0Ywxg0BNVxY8GNtU9Wc2YCLPazStwgnVcfYbsJQSg4urXifKiWI5
	ksQnSPM0hZkManYEHug2ygn95Gvw6aZvBdJgZdU=
X-Google-Smtp-Source: AGHT+IHaElaT/50HwJ/X3Z1dzqVAOOQKWZhzUR9bCyfvR1sGGL/ruJILWO8b83ReWe8Rpw23l1bkHQ==
X-Received: by 2002:a05:6a20:8e29:b0:133:7276:324b with SMTP id y41-20020a056a208e2900b001337276324bmr27134464pzj.23.1693070776498;
        Sat, 26 Aug 2023 10:26:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d21-20020aa78695000000b0068a6972ca0esm3530952pfo.106.2023.08.26.10.26.15
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 10:26:16 -0700 (PDT)
Message-ID: <64ea35b8.a70a0220.4fbfb.5aa5@mx.google.com>
Date: Sat, 26 Aug 2023 10:26:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-982-g80a0585c0aa62
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 6 runs,
 1 regressions (v5.10.186-cip37-982-g80a0585c0aa62)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Aug 2023 17:26:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12854

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 6 runs, 1 regressions (=
v5.10.186-cip37-982-g80a0585c0aa62)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.186-cip37-982-g80a0585c0aa62/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.186-cip37-982-g80a0585c0aa62
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      80a0585c0aa62f4c1dd47f7b489c39ee5bba99ab

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ea2712ff1c44c6e5286d95

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-pty-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.186-cip37-982-g80a0585c0aa62/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-broonie/ltp-pty-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/64ea2712ff1c44c6e5286d=
96
        new failure (last pass: v5.10.186-cip37-770-gddd36cfc4c4c8) =

 =20

