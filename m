Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC88C7EE2C
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 11:30:30 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web10.6329.1686051024601281517
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 04:30:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Qd0h/scb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.179, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-39b86f95a66so960492b6e.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 04:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686051023; x=1688643023;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LhoVY0clcAB192gqHS7qz3aPQ8gn1LjbMwdYF2EXMz8=;
        b=Qd0h/scbm3j6GOzJH3Y5pMELKbJJYOCP6ot8+HKJvMKA+llbB8xfvEC24dXBhd6biD
         gpWYkQnp3NqjHmzfcRyhKL06bJXdm5tnwTZoF7OldCbw8iJ+D8q75vhgod6xqw5bJXI4
         8Ug9vU2qb5UQYUsut8dghKv4yrSS0GG5QOaznu281h22l6aypS3qfmQ61gT3jcIPxELR
         FeUhLvxaO3fED7xElPb1f2mHqdPMVOweIo6PS6xp9UYTIhdemlqtN8u7Ky9sCsAIuVM+
         62sIb2joLAi3knKO2RZe7OAos8d79dxct7pPnf+4+AbgBWJZvu+d+9W+EqvNuwrN2hzT
         MSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686051023; x=1688643023;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LhoVY0clcAB192gqHS7qz3aPQ8gn1LjbMwdYF2EXMz8=;
        b=E2UcrGvr/x1npBfUjnsNStrwa7RmCOXcrIMqUteNcNplrCpGAIN/BLwoQ8s6cM251O
         +IuUnlqc4/sCSHcOmD29ps/z/SK73XYvfKUjnr18vMtstUX7EU+zFssfktXNfOCDTAoc
         bAg/0nnJJD25Du9vekM8yCddDQ6SxV9q+5wwkQUGVsi4jOIBgQ6xHyHNgxKbkhiGtQXm
         OEkkgqT54ozARRWsHmFKADgegZZb1b9yX56hoVXgvI7/jlWYXmkjRK3EeX2lVRcgZie4
         DqDHB17ClNQgT6X94LQf+CesU9nsdCnvP4IMn9Yjxx3fTnehB7xOQVCizmJEt9Z3Zvdj
         KQsA==
X-Gm-Message-State: AC+VfDx+tlCVUo/P3BSqFpRmZIKmE8kjIiwictKvJH2r5EJRCgxaACd0
	xXvNGyhtr6OYGq2mZa0w9hCxcztfrTsHupcEImI6lw==
X-Google-Smtp-Source: ACHHUZ4QyU0LOMNJVZnuL8R0/e1HnD4emt09p5jCSPGrMstcY1ByfDXFjp3HnfyWhDGvHdQwoyB23w==
X-Received: by 2002:a05:6358:c122:b0:129:c27d:9f1f with SMTP id fh34-20020a056358c12200b00129c27d9f1fmr1678843rwb.5.1686051023112;
        Tue, 06 Jun 2023 04:30:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id w9-20020a17090a15c900b00256395cb599sm9875426pjd.38.2023.06.06.04.30.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 04:30:22 -0700 (PDT)
Message-ID: <647f18ce.170a0220.3bdb2.2700@mx.google.com>
Date: Tue, 06 Jun 2023 04:30:22 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1321-g3152fb7c8d2d6
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 2 regressions (v6.1.26-1321-g3152fb7c8d2d6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 11:30:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11874

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 2 regressions (v6.1.26-1=
321-g3152fb7c8d2d6)

Regressions Summary
-------------------

platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1321-g3152fb7c8d2d6/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1321-g3152fb7c8d2d6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3152fb7c8d2d6c6a2c22edfc334cb69a5428ccad

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 2     =
     =


  Details:     https://kernelci.org/test/plan/id/647f09cae9e54f2adff5de7c

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig/gcc-10/lab-collabora/l=
tp-timers-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1321-g3152fb7c8d2d6/x86_64/x86_64_defconfig/gcc-10/lab-collabora/l=
tp-timers-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f09cae9e=
54f2adff5de81
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:25:58.972731  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647f09cae9e=
54f2adff5de81
        new failure (last pass: v5.10.180-cip34-26-gc198172c84b6a)

    2023-06-06T10:25:58.972731  =

   =

 =20

