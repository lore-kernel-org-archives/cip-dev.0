Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6D8C77B6C
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:33:02 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.37873.1679473977808906589
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:32:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=a4QucNAR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id l7so781808pjg.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679473977;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OtFC1f5N1mPeeN6L1EfxBs3C6dw8qiwEQ0bFyONvvLo=;
        b=a4QucNARDpZ/9N+ECivd3QhUt7Jxczs048TpCEbjVnMwB97pEwz3VDyQAqLfUY6ABn
         7CFCealiaJqCIt6yOZ1lZQeg9DP/hY639dbdd9V2YfJAuhyqwWQ9nJs8iJLv6MoBLYmz
         LlyAlf1ZpiHihsJdUlpq9LlYGdV+DtJpDfE8ZpTPP0dJQe18JivnwYPV+AdNmHwDwE+3
         hB5nsvHAT+hL2IRpJoU3REawo/h4BscUlw4l7pP1txeFtXZrv2Rn2Ze18mDcL3LxXXx+
         js9rxpF84qUhM93X19bCoKGsssOI6fzhoMSn1cVWiJbT41ZAXWGvrfbmRRRO3e7DFiSG
         ZA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473977;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtFC1f5N1mPeeN6L1EfxBs3C6dw8qiwEQ0bFyONvvLo=;
        b=Gl/FUnGLRw5oKsTb2MhI3bM3U/ZnaJngRZoPaeN+As5Erb34eiXnErlnLgTJFDfAcs
         rONWndtnFtPYnair2ivgc+rljjtQJo77nVpga5H20SV61EpJCEzPy748VOlir5MV5+J4
         CW0UP7TqosuQLENpoXp3kxqgXzkzwMmFUl/36WuP6En12MDvKMzOdcNCdDXQAY3N6Ffa
         RzPWrhbNf2daJrIo9wixeXnSBGzpRJEIoaSAU8V2vtEvVu0gRdOpCm/rBzx23omMwiFt
         bPfojhx3WKz17/wGWib88FGA9uxknVzT3b6076DVZcJcqgjaWBlb0bCOnzyJ+OsMLlQV
         AHiQ==
X-Gm-Message-State: AO0yUKVHS/x4VtcIJtvzebA+JCEqWf3iqGn9LBohV2BZkpdv0YH0Xqq2
	nQ96eJ0bWz7lY2WNPsrBManlI32RN/x0gV7VjVc=
X-Google-Smtp-Source: AK7set+5NInXiDXmBIo2ZHp5CxxBiw15kOFQw3iuGuEyqWHsvfC7ATO87VCECn1SIoyRQ7oBiv+CsA==
X-Received: by 2002:a17:90b:1b0c:b0:234:ba34:71bf with SMTP id nu12-20020a17090b1b0c00b00234ba3471bfmr3348351pjb.1.1679473977149;
        Wed, 22 Mar 2023 01:32:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id s24-20020a170902b19800b0019e5fc21663sm9809723plr.218.2023.03.22.01.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:32:56 -0700 (PDT)
Message-ID: <641abd38.170a0220.e12d0.1516@mx.google.com>
Date: Wed, 22 Mar 2023 01:32:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29
Subject: cip/linux-5.10.y-cip kselftest-futex: 10 runs,
 2 regressions (v5.10.175-cip29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:33:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11055

cip/linux-5.10.y-cip kselftest-futex: 10 runs, 2 regressions (v5.10.175-cip=
29)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.175-cip29/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.175-cip29
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      bb7267e6d2a6f131bb46ba14f0d3c418379e8bd4 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C436FA-Flip-hatch       | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/641aaacbe74632cc829c9508

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/kselftes=
t-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/kselftes=
t-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/641aaacbe74632=
cc829c9509
        new failure (last pass: v5.10.173-cip28) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
meson-gxl-s905x-libretech-cc | arm64  | lab-broonie   | gcc-10   | defconfi=
g                    | 1          =


  Details:     https://kernelci.org/test/plan/id/641ab40253b93c36509c9507

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-meson-gxl-s905x-l=
ibretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-meson-gxl-s905x-l=
ibretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230317.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/641ab40253b93c=
36509c9508
        failing since 26 days (last pass: v5.10.167-cip26, first fail: v5.1=
0.167-cip26-2-g1e87e7748b91) =

 =20

