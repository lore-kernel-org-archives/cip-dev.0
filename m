Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F66C46467
	for <webhook@archiver.kernel.org>; Sat, 26 Nov 2022 12:03:05 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
 by mx.groups.io with SMTP id smtpd.web10.68797.1669464177202624863
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Nov 2022 04:02:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=LFh4JJij;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.175, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f175.google.com with SMTP id q71so5909164pgq.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Nov 2022 04:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MyaQbwM3duuJX11AZs2pEvBM0HQxTVUdUInk6g1G/uA=;
        b=LFh4JJijDNPRI4+s1Biz42y8R7ZcQ6VkfnI3bCENYYO5hM+2ubp3kckZ+HHG+/Xc+x
         4lLo4nuu3MMjTcguwvzazlqYj1dW4xJ8ioTfLnitgM4ByOSoRTcZsf/9Rm/sakFNN5KS
         bjPpygnqNl9b0c9N8Y6+yxCBUz/r9Gi2HtwEK+p6X1T86007GRet9EzQ7ecKZPiNxTSJ
         THSeqrGf/lQ79Y2HPco3zM7wr9aIORTB5m0kzhOx03xr1vvBSAW0LS4dhQeUwmerVBZa
         i9x7OURcMfmGakueEkjmp3/T3ZvQODAI+GLGDhHCK9APBm+LS3zXzg/Ng5VI3iG034Mr
         3iBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MyaQbwM3duuJX11AZs2pEvBM0HQxTVUdUInk6g1G/uA=;
        b=hS33aos1oF+Y+eU/czxrLyyO+9rOWAjxJ5/ETbGi/7nzX9BYjm93Bja1AJnAh00EJP
         mdCRAJ/WZPi9sRQ/RZPgLVeQ1BAmEHaqWt40apvwCHouHBeY8KPHsI6V2scP3LsYxT+b
         p8F0yTXFKnzLKDorwKCdmWtMPPJvbcX4vXLZiPCqHaIBFrBF1bX71f467x5YZP2bPvmr
         RNs3Pb6spigxt3aeC4YCNXE3dJEU3E2EmJoyAqPYUVkirTNOR8g4SrKWApyOxOEFHD3S
         iku9AkyIGZS8SKFoOEVvmQERmkgLner5nxk7WyDERopG1+NWATDJ2uJjDmClDx9Qg8wq
         ppYw==
X-Gm-Message-State: ANoB5pnLKbr6DD18PSNriRLgOW9Zxl1h1ScMfQN1Qm3M3zXpVmKldrpt
	s2aHE0OyRSm3JJmhUCIjgGRHMKbZL3YBTGSWfEA=
X-Google-Smtp-Source: AA0mqf7xu4ePKMo+1YN3PUILIQrFJcrUyx3ZH05Zxx1GD13IhMkWwnfXnuaBOcsghGlaGXyWy6UddQ==
X-Received: by 2002:a63:e411:0:b0:45f:b2a7:2659 with SMTP id a17-20020a63e411000000b0045fb2a72659mr19985540pgi.132.1669464176282;
        Sat, 26 Nov 2022 04:02:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d15-20020a170903230f00b001830ed575c3sm5215662plh.117.2022.11.26.04.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 04:02:55 -0800 (PST)
Message-ID: <6382006f.170a0220.255a1.6fc2@mx.google.com>
Date: Sat, 26 Nov 2022 04:02:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.155-cip21
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 5 runs,
 1 regressions (v5.10.155-cip21)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Nov 2022 12:03:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10120

cip/linux-5.10.y-cip kselftest-seccomp: 5 runs, 1 regressions (v5.10.155-ci=
p21)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.155-cip21/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.155-cip21
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      02e30f9cbbfce3d687cb1ab288e46ad20079e8e0 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6381f144994fdb4a3b2abcfe

  Results:     87 PASS, 3 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.155=
-cip21/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221107.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/6381f144994fdb4a3b2abd00
        failing since 16 days (last pass: v5.10.153-cip19, first fail: v5.1=
0.153-cip19-3-gc76f4e7e5c71) =

 =20

