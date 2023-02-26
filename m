Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08563C7EE23
	for <webhook@archiver.kernel.org>; Sun, 26 Feb 2023 05:00:03 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.60667.1677387594435944158
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 20:59:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=fjYu3hhd;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id fd25so1733170pfb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 20:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vNDMD+cy44JB3Z1alqvdO5rUg98TqOn2dq65aTskN0M=;
        b=fjYu3hhd/ZTfgJR0npVFojlxmnA4Lm0Vkw6NR01fdly4q1AAwAi0E28+sjj3/S/rDW
         XsRoP3r4fiOKDwnAiUMC4fTh1u6lzzeFmWrSK3V8C+5MoQEiPn7GHNcaPCgevjnMio86
         6lFGwzg+S9x/lGR6/aM7bRxTEQalFu97pvr3MCB/hIIjmPVouQqhDNVizTkxZLS0lu0/
         O4+ld9SbTqQD3TyPIbG43y2e9m6LczzwYBNs4juyNxgtd3vbJYkcMJ2KPrcTEOeS3ZpV
         i4Xrbr56w69DPS3TgicoE9XBkKIQRJy5Rfuqv4+NCBD5O1rqzI86HiM20RqtQgCmcITJ
         8WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNDMD+cy44JB3Z1alqvdO5rUg98TqOn2dq65aTskN0M=;
        b=bw5mVEuv9nIt2bQv68iil0VW/AGPqHv+t5CVzqmOrTM4Yu5L7nYEvAI8y/QWxXMLCI
         MPtYRkxArYY3H7jesPysnGR+bAmnrKcI8u6SrQrIcso4o6Vgw7aeBiY2+5TZe0Ry0RZU
         8KykMUnrDIEVuAmze/Yz/EJ+g8JHHSjFLr4U+J3TQSIYYm5DfBsNO4GZOo2Td8H2GpSP
         CDQRac6faqqbxHuibebbqD6zpW7vAVUwgjh397eXbllD0eUxvVR/e5E6dk+Ekeiu5E/0
         98MnXRz6LWGN4zT/ySVppEdr84389tDGqv56xS9Wd4qVZQzbSUCabi5n/4RASTXhe3ew
         ctbA==
X-Gm-Message-State: AO0yUKUxzxrW7ehaAC2q7cn57fcdpY/qSk0irotmeU3Y9jlH8X+BZvIQ
	MENpLViUWC9A/XmLcFbRNP9Xv9teHdvhlLwp5vs=
X-Google-Smtp-Source: AK7set+lMejtTOrFfO3LCsNfIYIS/TmXw+qza86Pdo+ldXqVA7lqiWBzVPnZphlj3qgQbmAToYvdvA==
X-Received: by 2002:a62:7b42:0:b0:5a8:cc65:5766 with SMTP id w63-20020a627b42000000b005a8cc655766mr17013040pfc.6.1677387593479;
        Sat, 25 Feb 2023 20:59:53 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t12-20020aa7938c000000b005ad9e050512sm1879072pfe.121.2023.02.25.20.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 20:59:53 -0800 (PST)
Message-ID: <63fae749.a70a0220.43ef4.314d@mx.google.com>
Date: Sat, 25 Feb 2023 20:59:53 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-938-gc773c630d0e4f
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc kselftest-futex: 5 runs,
 1 regressions (v4.4-st20-938-gc773c630d0e4f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 26 Feb 2023 05:00:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10855

cip/linux-4.4.y-st-rc kselftest-futex: 5 runs, 1 regressions (v4.4-st20-938=
-gc773c630d0e4f)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-938-gc773c630d0e4f/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-938-gc773c630d0e4f
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c773c630d0e4f5868f0b4c7199749524f7c08fe1 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63fad8d6a51e20d30a8c8649

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-938-gc773c630d0e4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-futex-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-938-gc773c630d0e4f/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-futex-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/63fad8d6a51e20=
d30a8c864a
        failing since 38 days (last pass: v4.4-st20-799-g1229c813bcd9, firs=
t fail: v4.4-st20-821-g39bdf0444b23) =

 =20

