Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23245C32793
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 21:20:56 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web11.29546.1674076847256701186
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 13:20:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=5NMj4lSB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id b10so390874pjo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 13:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=39WlcUmuhqDWLbfKlIvdYQwBRnLd8jqjaRjgBcxGI9g=;
        b=5NMj4lSBRURWUc1klxCuhdnzLSMA1Nzq63V2y0rjrUZ1IyZoLXU+hRs+S2R4m5Rd8R
         GJdo9ILpInfNu/oP3SAApNou+PKaz/kRbn7IAwDnJoDtPGxFMiBvcdP5zUzSIqVUx5Tn
         sLDnbzxu4wTCLbZ0Ald1PUyWzO2Qs/qv6144Qjy0xPyAvFSR0d6iOkYFz8sjvYOOG2QL
         XEO10ko47TZflcqWumuR07tg0dvLVx3nkGW54IrISwQ9K0khE4P2DpfYoIOQi1gl5IHq
         3ZznqkY0lM8FIpAMcHuanFepNOST/IWpuQGYOf/LNlGjJYaM4jhmNK1T6VK6VONsiZib
         z/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39WlcUmuhqDWLbfKlIvdYQwBRnLd8jqjaRjgBcxGI9g=;
        b=8LDBJoLsarToQow6Mu7ekNOlRe2Gt0UL+5n+ZW5a6wDK2+yAgV52DyhjXIm4yIdIqB
         kayzoxeTuIOGUNrQg2m/etGlWZ40G57CMA+4fUfPw+3+8U3FZyswYjofvGfcL0fG8u4f
         m15Y3nUitxtruuLkLyzCm929FG8tvSN1Xh+vsTOOVWBdxcBjzMVGXp8Lv6xESgh6+/0f
         wRUZKT2o/Cjmszsqssd5iNzIVCvEKN3CNs1437j/9bcF+kc0SRSPPw02Bibf6nCmjQh6
         itzbmrgN6DlvbthJr8LkXKVzfO0tZAwuIclZfJm/AKoj40Q31gPV1XfH1qyiXxSnC3MY
         4nGg==
X-Gm-Message-State: AFqh2krnZSdMnNeMp90zoOgoxYB7eL73KjvIQNGC7A3X/Jo8gfHpvL93
	FH8WG7ZLFLULEEp0Y7LjmpbjH4x3V3h5O/KjJk0x+Q==
X-Google-Smtp-Source: AMrXdXs6d5h1hUJwtBnRkICe/X22J2vy8zSTOlbw8xKbnoE3/sW3sfP6zwHtFgoc9gY7/b22NN0tvg==
X-Received: by 2002:a05:6a21:3946:b0:9d:efbe:e607 with SMTP id ac6-20020a056a21394600b0009defbee607mr9756605pzc.35.1674076846504;
        Wed, 18 Jan 2023 13:20:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 12-20020a63114c000000b004c13dddf521sm9216910pgr.30.2023.01.18.13.20.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:20:46 -0800 (PST)
Message-ID: <63c862ae.630a0220.bc350.f1ee@mx.google.com>
Date: Wed, 18 Jan 2023 13:20:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-1495-gc851fb1e222f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 5 runs,
 2 regressions (v4.19.269-rt119-1495-gc851fb1e222f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 21:20:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10403

cip-gitlab/ci/pavel/linux-test ltp-ipc: 5 runs, 2 regressions (v4.19.269-rt=
119-1495-gc851fb1e222f)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-1495-gc851fb1e222f/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-1495-gc851fb1e222f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c851fb1e222f4acf955da1ad9b020f3fc8a51c4b

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8556c817fb777ea915ec5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63c8556c817fb777ea915e=
c6
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8541a5221bfb501915ed3

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-1495-gc851fb1e222f/x86_64/x86_64_defconfig+x86-chromebook/=
gcc-10/lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63c8541a5221bfb501915e=
d4
        new failure (last pass: v5.10.158-cip22-435-g2c52868ae1cbc) =

 =20

