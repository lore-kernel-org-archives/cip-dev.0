Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DDAC7EE25
	for <webhook@archiver.kernel.org>; Fri,  9 Jun 2023 16:27:19 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.17849.1686328035196133377
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Jun 2023 09:27:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Tcdi+D/6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-651f2f38634so2005519b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Jun 2023 09:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686328034; x=1688920034;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O6h76S3rSv+8LyFv7ilc7aVhDVDzJD+tBHaWHZnnwF8=;
        b=Tcdi+D/6F8IyWdUGmXNr9Ph80EGpxLNsj0aGiCcL1E6AWK8KZU8HMtmep/6xN47/gH
         vX5mocaINIVy+yORpTjpzImwud7TYFqgHu+SBFGSoAXqxNHL3q6fl46kbKIkSVgJqTku
         X/yGKixEMT99q/5JYmLXgbFsqnKzn6BGSyV6sV9+oanrIKLeOjRFT9sJHcv/CSXo8H3r
         FLMoAJGUVdMNkiwHLb/TVeM2a3x0gwANNStgbHUZgKkLEjBJWeTM2LfrbvZFfjteOdLE
         gSx+AyremfYw/Xnhyb+iMlleE1jqpEASAo/fV+rRtS1zxhmkh8txu9t3LuQYWqIei4t2
         DRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686328034; x=1688920034;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6h76S3rSv+8LyFv7ilc7aVhDVDzJD+tBHaWHZnnwF8=;
        b=OGAR+tBhVVQ4kl6lAAzZOVBJVi69GFVIiP/OuQbbOWaxBb39BmfJForVfB9lc06/ES
         +D8K6JjwQUDFgcz75urYBiyRrj6SwEB/DalqfM5u/DXHPOzqBztC85Uz3jYpaIFxD6I1
         TUaB+puXykzZYHWu8lGRAyq+4XUtHHuJ5C567MbluZ7M0SiwljGzWh4TzG4MOMWzFb1k
         RfHQ/vBMlIvSLMlR/j5myatsK9kMWLY1KdHLKNdMd4uHDRvpNBDfoMbz1+pLz7Cxa3KQ
         Jt3Qy/Jw6cS2Epsbh/mNuKmVEFfWYPLjnGlBLmub3fQFK6oFyKbo5282yeNhBUXFUJI/
         V7Bg==
X-Gm-Message-State: AC+VfDxRgBvW5GPUae+pzpkXbJ5BXwX/LjttPD9sYDT+PWeQfLEv1Apb
	i1Uql4LAo+Ht84Ary/agZe2qWRhqoBwwn+hzAFQ4Tg==
X-Google-Smtp-Source: ACHHUZ7qzb6SV8q4TDRIXiX2A5+DrSS0aCgPVDrZyqEtfdCtadQ7Z4RysODxymczFKPdl5CyhIuP5g==
X-Received: by 2002:a05:6a20:760f:b0:107:10b6:4c84 with SMTP id m15-20020a056a20760f00b0010710b64c84mr1568884pze.21.1686328034182;
        Fri, 09 Jun 2023 09:27:14 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id k19-20020a6568d3000000b00543b4433aa9sm2918490pgt.36.2023.06.09.09.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 09:27:13 -0700 (PDT)
Message-ID: <648352e1.650a0220.bb212.5f80@mx.google.com>
Date: Fri, 09 Jun 2023 09:27:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35
Subject: cip/linux-5.10.y-cip ltp-timers: 6 runs,
 2 regressions (v5.10.182-cip35)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jun 2023 16:27:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11949

cip/linux-5.10.y-cip ltp-timers: 6 runs, 2 regressions (v5.10.182-cip35)

Regressions Summary
-------------------

platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.182-cip35/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.182-cip35
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52f00829380df13d144d530b732464a175350508

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform     | arch  | lab           | compiler | defconfig | regressions
-------------+-------+---------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-collabora | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/6483402da2db32489b30616b

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.182=
-cip35/riscv/defconfig/gcc-10/lab-collabora/ltp-timers-qemu_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30527.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6483402da2d=
b32489b306170
        failing since 4 days (last pass: v5.10.180-cip34, first fail: v5.10=
.180-cip34-19-gf0f6960f132cd) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6483402da2d=
b32489b306170
        failing since 4 days (last pass: v5.10.180-cip34, first fail: v5.10=
.180-cip34-19-gf0f6960f132cd) =

 =20

