Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0249C6FA8E
	for <webhook@archiver.kernel.org>; Sun, 26 Feb 2023 04:30:02 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.60382.1677385794171802387
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 20:29:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=dLGscG5I;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso9372319pjv.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 20:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6h6TKzyP8GT0nj89Wo8YllWUPmz4qGzMrO6j8ij9dPw=;
        b=dLGscG5IaLa1bnrwRcbbPnBT/bScZCEWmeG/R8HSOekQNClj0iXrpSlHGIWsdplHBY
         SWP6T0EefAi9WHgGcHtSsKeEkOhNUrBqIXpKnctlQaAaePPcR0EdBLyAlIJh7iYGqxdy
         wEqpE9WKUzjCQ2lQPUPyId2McnhHEy0nvrD87i7eBZAQ3bH5jkOpWEIu1ZXxEMofB3TT
         2pyoZZBiktL3ozGhCj9KO5Allb9j8KvHKr5K94KZigNLGOfQMeah2rWKDuqhZzyHflte
         DRjrMqPgj1CGuu969Q6XncCI+4ElAmSQjWxRzSYX6Rgl9V/lXIJ9CFEwIsMZmBptnWMn
         2aVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6h6TKzyP8GT0nj89Wo8YllWUPmz4qGzMrO6j8ij9dPw=;
        b=Az4czedMb6qUmm3Fl/A2FO7Ld874tuP0IMyf9xN34RpXhjnqQR8+vzkiBpPmspGZfI
         pqT1KiR4KPfhpVJRg0Knt3hcD1Fafv7tb38uBg/ADBdSaCa3XTqUPgyNpe363DJqkMjL
         2JYvDx64UHeSEaRaqlYyiT8fpv+xAuurOqniPpFG8GR8v1mC36MpD6xB18owoXGOfIOV
         a9j7Jdx2Gow0raJodn4ZMKGLKbk21d8IsNZhweLA6v40Ud4rm+HNj2PgK0sGiWzFW5w4
         1vd89lXbMzXQ/iOwbV70QHIJCz5q2nv4rQGIsa6b5uu+NpdR4cl9Dl24Ti6+eKDHgCeM
         aJuQ==
X-Gm-Message-State: AO0yUKUz4Sc4DNqpFnSpLDMqbe0lby87iYRTp5BHb31E0Bo+xGsMa2Ht
	CpCH0+RjQNdfDtVUbO9cEFAW+n69oLxMZCE1DWU=
X-Google-Smtp-Source: AK7set9JDt0BgjJpn9wbRvWAp2XKFEPNisHkO88kPnbmo3aGgGRJaOq7H6hCWXIXygrzOie2rkJmwQ==
X-Received: by 2002:a17:90b:33c7:b0:237:8f8a:6e4c with SMTP id lk7-20020a17090b33c700b002378f8a6e4cmr8230852pjb.30.1677385793429;
        Sat, 25 Feb 2023 20:29:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m5-20020a6562c5000000b004fb5f4bf585sm1729105pgv.78.2023.02.25.20.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:29:53 -0800 (PST)
Message-ID: <63fae041.650a0220.fb08d.2c11@mx.google.com>
Date: Sat, 25 Feb 2023 20:29:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-938-gc773c630d0e4f
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 26 runs,
 2 regressions (v4.4-st20-938-gc773c630d0e4f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 26 Feb 2023 04:30:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10854

cip/linux-4.4.y-st-rc baseline-nfs: 26 runs, 2 regressions (v4.4-st20-938-g=
c773c630d0e4f)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-938-gc773c630d0e4f/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-938-gc773c630d0e4f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c773c630d0e4f5868f0b4c7199749524f7c08fe1 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63fad947345051218f8c863b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-938-gc773c630d0e4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-938-gc773c630d0e4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63fad947345051218=
f8c863c
        failing since 46 days (last pass: v4.4-st20-234-g4e6ec7162c8e, firs=
t fail: v4.4-st20-799-g1229c813bcd9) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63fad8432d32df2a7e8c86b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-938-gc773c630d0e4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-938-gc773c630d0e4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230217.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63fad8432d32df2a7=
e8c86b2
        failing since 46 days (last pass: v4.4-st20-234-g4e6ec7162c8e, firs=
t fail: v4.4-st20-799-g1229c813bcd9) =

 =20

