Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358EFC32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 21:20:46 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web10.29285.1674076845015505146
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 13:20:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=x9TIXYYZ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.172, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f172.google.com with SMTP id v3so25525300pgh.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 13:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L6o1+5Zhy1D9Ppy84YY+SM2t9MysAdXB+63Wqd3dGd0=;
        b=x9TIXYYZ9uurXlQXxIfjs0+d9OXwYfs5bmwMIzLn3SbPYNjscNk1DtadJITb88S2IU
         IDIq2ViS/YCJik3FpcHZlvCZECzP7OgbKyKaHsECDzlpi8uwMagapgcRYFD+pPqWZi9w
         e9jYCkS4kvFs5Fmf5OoMOyZiyRryRIj4fFRT6OTHRSVVgVNM4MrM1eg4GBJu8XzaxAcL
         ub/yi27h9CNpZ/0G2JXmt/rYjASZ3we8Tyqyl1yI5scezltlXPvocoIKgSpbZ3vi8ntX
         FQAACjycsxMU1gv6GUX9BgjXoshw7jACGHneRVPBoT4deZEKZBECsHANbXBMJ/dmtyGr
         Jojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6o1+5Zhy1D9Ppy84YY+SM2t9MysAdXB+63Wqd3dGd0=;
        b=T8lNV0GOqUA4MbdRwmGxkg50p8WCimp5lO5BhrVEyaogsTEDFWXcQxD58fOLMZ7viQ
         TJmN5pDq9nyBVvqLcBcmZw5dyeY1k1e/jnxATYR/M8fvAvFlfHPqMgebwKOITsxLrpEC
         ZDbmD+1h829oCnIoM1T8mONI80NqhCTNfnlRMYHTNuKmbWKHyNAUCS4tUKTmxA4JIpG9
         y80Ymr2UNCXzEqdwJPTA9IO49khy7VH8AdAh7XtyKI+uxMcilxxEaCsSfmJtInoqeRNP
         3r9o3DPMYrqKZXWgNNoHwwJlb50sk5WHP0UW0Fy7ZSCk90dLSzNrWIY5CAI5T653tnvY
         RU6A==
X-Gm-Message-State: AFqh2ko9kkKeJPZ6ECl0H2P84qPRXKMJZgYhMoWrHXeA8k4BknImZ548
	OLMuZnEch/e37cE1L80o0oP+t0qpn+Ega4eSsBFGEg==
X-Google-Smtp-Source: AMrXdXuGgqHNRbC/6df1ILXPOyFcmXD6NJYMKeVL2x2yTDkHYJnwX7peF/DUUHA7M4XGrNeYrHX9dQ==
X-Received: by 2002:aa7:888f:0:b0:581:a55:d213 with SMTP id z15-20020aa7888f000000b005810a55d213mr32173148pfe.29.1674076844185;
        Wed, 18 Jan 2023 13:20:44 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n68-20020a622747000000b00588e0d5124asm8346231pfn.160.2023.01.18.13.20.43
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:20:43 -0800 (PST)
Message-ID: <63c862ab.620a0220.ae5f.d6db@mx.google.com>
Date: Wed, 18 Jan 2023 13:20:43 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-1495-gc851fb1e222f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs,
 1 regressions (v4.19.269-rt119-1495-gc851fb1e222f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 21:20:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10402

cip-gitlab/ci/pavel/linux-test kselftest-futex: 5 runs, 1 regressions (v4.1=
9.269-rt119-1495-gc851fb1e222f)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-1495-gc851fb1e222f/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-1495-gc851fb1e222f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c851fb1e222f4acf955da1ad9b020f3fc8a51c4b =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c85406632cf8d10c915ebb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230114.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63c85406632cf8=
d10c915ebc
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =20

