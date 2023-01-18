Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143E1C004D4
	for <webhook@archiver.kernel.org>; Wed, 18 Jan 2023 06:38:42 +0000 (UTC)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
 by mx.groups.io with SMTP id smtpd.web11.9845.1674023919168289341
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 17 Jan 2023 22:38:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=7fFVuT6Q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.172, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f172.google.com with SMTP id k18so11900709pll.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 17 Jan 2023 22:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OmE5cJb0M7hoqiS/RZ3lyngAmjEKmk0LvIlzC/fhsUI=;
        b=7fFVuT6QCMDhG/NPtjO+CkXkiNKI8XJ8uE/c3Dx2MAyElwVrdG7Q0qiPM8aiW3QTfV
         lVE4ZqzgOSLBVXfQrpFkjo4wesbizT+cUvbDsAPiJ6yftP6F4MIPTAfLaJo9aeLOF7SB
         b2gsUXr4FZDOS1zwXGpR0q/D9t4vZPYDMxbMr9bvW2STxN5QjB++TM8LhNgn0/Z0QIj6
         Q1/DN3tOD0rGrepjMQEnmz+F4Nc4GDuF2FpmVEajryWxtTY76EAh+djhqogLGHVvGDf9
         hbq/nEPnwv3yeJQJP6veR1iUjZZMWxzILVPsPkoPIFB5SbB5KQVFPyP8gvFy2EcTfo4m
         Widg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmE5cJb0M7hoqiS/RZ3lyngAmjEKmk0LvIlzC/fhsUI=;
        b=KCPX9nt6Cy/qbTFcSWq7Pv7xWQ1P4Vr5IrQO/bO0ClFM8Bn33WXJFGdQQwPUSqM+3c
         YP9ekitvw0rB6YjQMIPJ9QgwzuphgpFTdxL5c86V0MoTCnlwwUOIBtBjtDf+HcleCQym
         Do0sjSafhTyyJTTvCL/gGLmqZW3dbDMFngb5/s4HXIuo1/X/PQ3Ls01+ceMPFHrrCyfT
         /MzrH9+pFTMFw1ubbD61Q8Q+pvK9i/VL4Dpp3n9TO5zzeTYTWocbOTCTkq/VLKCArzCD
         TNhwvq4nxDBc4qggsq7v+HASeckhgIdP7k1i8Ml0XkXK/1OLxX3t0B7ke2Q8hI8sEjMc
         GmPg==
X-Gm-Message-State: AFqh2koRzxg8HMecWKmWxlNNRCC2e6/rkUO3cfVUZEDoNTE0K9hI8iQu
	J14tRE2SnmHrpickEmDevBTRD9y/AZEfg3dJLdYYXw==
X-Google-Smtp-Source: AMrXdXunm8xRTtoY/n71OoCRENwridkMKViYQJOE+OPz9uIpheaidf+AzDsQKGqtOsUxaeEG0pyi2Q==
X-Received: by 2002:a17:902:be09:b0:194:92a9:ced9 with SMTP id r9-20020a170902be0900b0019492a9ced9mr6393769pls.47.1674023918353;
        Tue, 17 Jan 2023 22:38:38 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b00192820d00d0sm22176732pli.120.2023.01.17.22.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:38:38 -0800 (PST)
Message-ID: <63c793ee.170a0220.c222.3eca@mx.google.com>
Date: Tue, 17 Jan 2023 22:38:38 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Kernel: v4.4-st20-821-g39bdf0444b23
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-timers: 6 runs,
 1 regressions (v4.4-st20-821-g39bdf0444b23)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 06:38:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10385

cip/linux-4.4.y-st-rc ltp-timers: 6 runs, 1 regressions (v4.4-st20-821-g39b=
df0444b23)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-821-g39bdf0444b23/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-821-g39bdf0444b23
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      39bdf0444b238ce8b92fda121bd1462a27f07a66

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c7893c5107169058915ec1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-821-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-821-g39bdf0444b23/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63c7893c51071690589=
15ec2
        failing since 7 days (last pass: v4.4-st20-234-g4e6ec7162c8e, first=
 fail: v4.4-st20-799-g1229c813bcd9) =

 =20

