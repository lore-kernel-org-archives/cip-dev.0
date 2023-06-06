Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DE2C7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 14:51:50 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web10.458.1686063100730306822
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 06 Jun 2023 07:51:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=lB6DYUEw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2563ca70f64so3050875a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 06 Jun 2023 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686063100; x=1688655100;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ixqb8vcP7UUgxTzgGcpI5bxwxoXbRQQU16IJBkJmW8=;
        b=lB6DYUEwK/yhbPMgjsKbzSUqz56FFejRy2870CpNGZr78rZyouCyM/DSRmwBaNW/K5
         nwSV8e/keRhaMabAuIsj33KGT0jwyj+BjkkqBHFHbrsCjY4AS3a/xYIIqxChNQbeu1Ap
         DlIvfA/8ODgRLPVKwulpRtX3zOiPFqmAc1LJo2Wn+3+f1Omw83jQc4ocQ4TTkluWpsGn
         SBaJdwyJZJUPao3PthbEUAxE66GM9VCQG7hKwrCNvWXYjUkuN0+HM1ynGbUBBJQL8D5L
         xw9Pmundz2d+bOeGpSKqbL4q5/MoJgjlAMuXoxVj5d0yME5yp0As54kH+9THYhKB2S37
         aKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063100; x=1688655100;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ixqb8vcP7UUgxTzgGcpI5bxwxoXbRQQU16IJBkJmW8=;
        b=VTbtwSn98qJhHNlHENE4RyJcad6k28keCYbFegGONRQzlJOa23zDys8a/94kWgUjUh
         JwgAMBB7zCgQBBDrmhB/9hN4a4uTbG/ZvH/EZL1xTeiBBKTjM9lRXgZxpRscErEE2gbK
         Y0uKCPTUn/9jRx9P+puapy6DA+Ejt6jMumJvEPtZGEuR7uEk+VClnU8AVRl1pB6q3ode
         qWCh1v4R27ICIfKKhm2CldTAHtZa5QJwg0SZFiZn2UidHvRE0w0WWeqZLsB0H6QtTX9X
         vPf8lrTU/MvZLaLdpxcN1Hk+i3Al2dHRORAFI5WRbSq1lt3ewcJTEBFO17JrMrDqf7sm
         1Fmg==
X-Gm-Message-State: AC+VfDxKa1LHDqmUg1TKQlRVLuk+5HVXwe8/r24RausBzMTfuL8OP+Ha
	Chum9jrOrgniDIS8tG5k/7kLeqlWStS09PIfQw9r+Q==
X-Google-Smtp-Source: ACHHUZ7KTdDP2UpbqlRcISku7fFlSzCJ2ARnm++yPtLAshm5Ct+lQeDPt7ENNf+9zNLcq1zLbDFwBQ==
X-Received: by 2002:a17:90a:b38c:b0:252:94b5:36f1 with SMTP id e12-20020a17090ab38c00b0025294b536f1mr973018pjr.27.1686063099664;
        Tue, 06 Jun 2023 07:51:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id gx13-20020a17090b124d00b002560ab7a15fsm7713841pjb.36.2023.06.06.07.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:51:39 -0700 (PDT)
Message-ID: <647f47fb.170a0220.fdc0a.dae3@mx.google.com>
Date: Tue, 06 Jun 2023 07:51:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4.302-cip72-495-ga0a97337aff8d
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-cip baseline-nfs: 31 runs,
 2 regressions (v4.4.302-cip72-495-ga0a97337aff8d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 14:51:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11893

cip/linux-4.4.y-cip baseline-nfs: 31 runs, 2 regressions (v4.4.302-cip72-49=
5-ga0a97337aff8d)

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


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-cip/kernel=
/v4.4.302-cip72-495-ga0a97337aff8d/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-cip
  Describe: v4.4.302-cip72-495-ga0a97337aff8d
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a0a97337aff8d76931b459e84792717c3bf6d6b4 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f3bbca0a28d24a8f5de2c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f3bbca0a28d24a=
8f5de2d
        failing since 189 days (last pass: v4.4.302-cip70-236-g69445bc0d420=
, first fail: v4.4.302-cip71) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647f3aa1d1b19c6415f5de28

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-cip/v4.4.302-c=
ip72-495-ga0a97337aff8d/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230527.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/647f3aa1d1b19c641=
5f5de29
        failing since 33 days (last pass: v4.4.302-cip72, first fail: v4.4.=
302-cip72-372-ga3bc58e64f55) =

 =20

