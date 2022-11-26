Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8ABC4167B
	for <webhook@archiver.kernel.org>; Sat, 26 Nov 2022 12:14:05 +0000 (UTC)
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
 by mx.groups.io with SMTP id smtpd.web11.68897.1669464844686124751
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 26 Nov 2022 04:14:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=oyB7I+fE;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.51, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f51.google.com with SMTP id k5so5626568pjo.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 26 Nov 2022 04:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EDKkqY5sZ7cd/3dyWhO8BCmXZt7i0+5V3Sv8Y1Mq0V4=;
        b=oyB7I+fEeiCXBqK79W99A2TUokxpKpl9wvETjWwsCHt3XlTevQ69zkUSoJsveRJ7dd
         9F0o7qaOUzgK0eDSR75Ft7rr1dNpXGvYaLhKkFW5FvfI/oLoVETGrsXaxI9Jyv2VuaMK
         /Sx2H7uxVWfgkZuRTBmdoX27KhEfiwR1zQPWlksqpm3mPD2X/IqYMuYkJ/xvfUT/XdLA
         voMqFqr88gTX8covQfXCmM7da8vziNUL8Ibw8LNDCY673tknJsr08lmcFZ4CPKp0qqsK
         uy7K0mnfv7eBhwTxvh2qHPL/Oiujy3OC/iNDvw52uYDCc8rFgScv4mMVyz86Ibur0rTK
         slXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDKkqY5sZ7cd/3dyWhO8BCmXZt7i0+5V3Sv8Y1Mq0V4=;
        b=Jt2+/5gXCJ09AJkoFmnHIOeak7fzNWQc3bOSTA9BW5YG6rhpaC4xWuDTt8iZI6cEcg
         mfl4omKanwb+ssJAzwx27VPxSDRicidwHcTOSj9VB2Je8Hizhv9GIXr5ha2zx+q/V4Q2
         s6ku4D3R7UHWL7V2fiPNcmjxJ4cuC28EC2Jft2IHgCyoAPYOFCei2pFZfdlPQMXwhz8L
         csyPI+76sd9nznqF+uPbpbMPyugJvAMsLuEI3xxByVHPDn5oQT1YD36qFZ5dq/a49SH4
         FxMuFh4P+Ydn5scrw6b1WKZbd0L0VY/cXrRUlNO4mdHKmpXTE21StAaMVfH73Vwo0Oc6
         pzyw==
X-Gm-Message-State: ANoB5pmQSVCi3w5qC5a3evTuq7nCtY5pLaMP6pC9Jitv4CGev0WWTKze
	DBS9yd+QNi5lkfE/Oe9cJtdzoaJYi33/TxP+eeQ=
X-Google-Smtp-Source: AA0mqf7Y8ZX1fyfZwWGHIW1RpJkridiRSVxyhm9FDjEHR3VYcHDw8Km31Y4doP3ZZpOAydKf6KocTg==
X-Received: by 2002:a17:902:7445:b0:186:b5c8:4c8f with SMTP id e5-20020a170902744500b00186b5c84c8fmr23514412plt.124.1669464843841;
        Sat, 26 Nov 2022 04:14:03 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s28-20020aa78bdc000000b0056bcb102e7bsm4657435pfd.68.2022.11.26.04.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 04:14:03 -0800 (PST)
Message-ID: <6382030b.a70a0220.7a2b5.644e@mx.google.com>
Date: Sat, 26 Nov 2022 04:14:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.266-cip86
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip smc: 6 runs, 3 regressions (v4.19.266-cip86)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 26 Nov 2022 12:14:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10124

cip/linux-4.19.y-cip smc: 6 runs, 3 regressions (v4.19.266-cip86)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =

qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.266-cip86/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.266-cip86
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8c8d57a3cae5b94b0a26c176e2a32f260fc529ae =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6381f65ef97761b88f2abd02

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/6381f65ef97761b88f=
2abd0e
        failing since 140 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2022-11-26T11:19:49.325941  <8>[   11.790121] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/6381f65ef97761b88f=
2abd0f
        failing since 140 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2022-11-26T11:19:49.315331  <8>[   11.779283] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
qemu_arm64-virt-gicv3        | arm64  | lab-collabora | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/6381f467ab4e8026512abd15

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.266=
-cip86/arm64/defconfig/gcc-10/lab-collabora/smc-qemu_arm64-virt-gicv3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6381f467ab4e8026512abd16
        failing since 95 days (last pass: v4.19.226-cip66, first fail: v4.1=
9.255-cip79) =

 =20

