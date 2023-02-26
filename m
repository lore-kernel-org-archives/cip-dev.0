Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E9EC64ED6
	for <webhook@archiver.kernel.org>; Sun, 26 Feb 2023 05:00:03 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.60726.1677387595931127616
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 20:59:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=EMzU64AV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id bh1so3540699plb.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 20:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0aeJyC1SOgPJLJ66w4VpdSzBqBYzNB98l99jZhwehWg=;
        b=EMzU64AV9t3JPjsw6zDFKx3ZsK0BJQHsEdk6C9SRJPxmqVy6jdKtMs1vzHmM4t7S7g
         B70tpeRA004ojjvizvUmkMYcuPreHQdtwdivBUdInGbvxf0sXL9+2T1vD/BTuSL/rzud
         2/hYA/VJcWGdlMZW6IJ5Pw9mVzk5a1tSfwSoXNqkkBBnLSt8T5N2DDQNWUH4U6YFTHL9
         Q2iOuiMTtf09KWISrL9joTuAHwPgGIKi5hNGAP5AsewkPox1npNXGuFEVVe2Zib0hD3I
         Ukqs6AwaffwFLxv9qkyU6ueelHZEd5g8GvMI8mZL7miEt83zYtFDq0SaPFo7zNU7H6kE
         kJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0aeJyC1SOgPJLJ66w4VpdSzBqBYzNB98l99jZhwehWg=;
        b=N4PvZFwCuhUjgrBrxphVf280xzVozUYBOkJ2KFj8y/OwsSQ/dFkfDzE3xHZfBePUXY
         RspgmG0tDZI0IOblr7v3d8Gizt6HsrvOCH2qJI9O8LKf1DgiuN2QYkYCn5pOhfhVOT0C
         JTO9dIsRjA7RTDteZhceskYwfSuQpDFDgHvmi2SaQTYJ5rfthOyO62HtW/5pY9npeWPI
         HA33ODKssVQi6xB+l/eGYLxprukOCov3vm6b5YtTSdyiA4NuyupcMtgpEKKyL15nJ+km
         moVgkaFmCfgxthh0EGgfitnkC3fQPG8n378jjTMoerH/f+ezf+xrRLnjM7x3YiL6tIRZ
         5hhA==
X-Gm-Message-State: AO0yUKVCz6w+vmHUaRF32UoJuM1cBgdQQGjm7GrPAWDIp9Yf9onwyD54
	UUIHzdCDTB0KQs7HMYf6vhVTsz1uXf3+QDDabsk=
X-Google-Smtp-Source: AK7set+jjYWTAvdhbHNQtjZs8BF+ya+wC13bjqb7eUzobU3TJnLw/ORVaTWJYB54/HAQChbfq2v+dQ==
X-Received: by 2002:a05:6a20:258d:b0:cc:8a62:d0da with SMTP id k13-20020a056a20258d00b000cc8a62d0damr7397523pzd.12.1677387595227;
        Sat, 25 Feb 2023 20:59:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b11-20020aa7810b000000b005d72e54a7e1sm1856814pfi.215.2023.02.25.20.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:59:54 -0800 (PST)
Message-ID: <63fae74a.a70a0220.ede4a.308c@mx.google.com>
Date: Sat, 25 Feb 2023 20:59:54 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-938-gc773c630d0e4f
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-ipc: 6 runs,
 1 regressions (v4.4-st20-938-gc773c630d0e4f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 26 Feb 2023 05:00:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10856

cip/linux-4.4.y-st-rc ltp-ipc: 6 runs, 1 regressions (v4.4-st20-938-gc773c6=
30d0e4f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-938-gc773c630d0e4f/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-938-gc773c630d0e4f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c773c630d0e4f5868f0b4c7199749524f7c08fe1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  86f0584539eb1567f009f3e38be6940830649b92 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63fad90a8ffebc2d058c863b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-938-gc773c630d0e4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-938-gc773c630d0e4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/ltp-ipc-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230217.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63fad90a8ffebc2d058c86=
3c
        failing since 38 days (last pass: v4.4-st20-799-g1229c813bcd9, firs=
t fail: v4.4-st20-821-g39bdf0444b23) =

 =20

