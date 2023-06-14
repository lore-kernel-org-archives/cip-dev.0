Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D367CEB64DD
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 12:57:25 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.10962.1686747442561223530
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 05:57:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=0eiWos0G;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-66577752f05so2651146b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686747441; x=1689339441;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aNu6MdgmnQE3/27EPbR5MffHBuvXmc/C1OhaSaD1oxU=;
        b=0eiWos0GrW2zT2c09FNFQ6bdLYwvs94S5/kdFS9YD7r+4OvpOodPbHJT3C/jaQdWne
         bw/KsVR0Jtg+VL3QcUwCnUkOyp8S4vLjOcHgsPjGOhV11JUwPbd31x3pJ84IrM3jRmdN
         H5lKHLEdnRzeBcOoVY3slAh/eLLemlNKq9SMnig4LYL+j0K+BPnZ5zyUiErRxcZ6KWIu
         EpEhWssowdnEZWfYpuZX5KNNGP4gudMjGWTM2QN3Gm5PXzpgLyVjgsYBqfXeGXrSWz3g
         W0LaTFG4S1wdIG9/w1uP29R5g6TkPwzEpq9yl/5B5o23Vebb78mPPbPSVHOAuwB0QbFd
         unvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686747441; x=1689339441;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aNu6MdgmnQE3/27EPbR5MffHBuvXmc/C1OhaSaD1oxU=;
        b=YCTqeeqiLLBNB9Drlpm6I17UdzL1nnpBFWNgI5VLMcjPnU4M4pmprNeEWI4ef+6njB
         sc8/gbORdIhQ2rTguXsOw8Zf+VUOgY7fKvYBHrmaZ8DR+VbppbHWAO0WCxXXc32X82P5
         ZC+1LIetNPS6OL1INN8M4ML+AOY/SIckXUjAmYrjbH+0iK471Sudg3F0HeBDdTfD61/S
         /APppj8GMQAsrW1YmSOxOOKgASua60U1jKW59rrmL10JPhpBkgTNJnup/aUdL0/vK1Ym
         ZV76T6tU5fhTK3KSBw0d34hdd7/qshXQkHCxzacyx+i00xPenFyTQGBDAowSi/GUtHsk
         DZ7A==
X-Gm-Message-State: AC+VfDykJbJie4W4ZMY0b11jqUNkPvzhXkveq4yQh9pfhpk5s2GsJQOy
	d0vMRHDShdvIe1F8u9md6tY/zC8HzNNIJ5Q4I7m+Xw==
X-Google-Smtp-Source: ACHHUZ7mtOLv2+cuATDPL5qHLxghs5tPZzhg50XlcjQk7SABLSSo/SPV9OIEJu1hANaLZ2L1o8YEOQ==
X-Received: by 2002:a05:6a20:1448:b0:11d:992:dffd with SMTP id a8-20020a056a20144800b0011d0992dffdmr1911040pzi.40.1686747441568;
        Wed, 14 Jun 2023 05:57:21 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 18-20020a056a00073200b0063d2cd02d69sm10362167pfm.54.2023.06.14.05.57.18
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:57:18 -0700 (PDT)
Message-ID: <6489b92e.050a0220.e13c3.463b@mx.google.com>
Date: Wed, 14 Jun 2023 05:57:18 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.182-cip35-191-gf4efde512959
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs,
 1 regressions (v5.10.182-cip35-191-gf4efde512959)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 12:57:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12020

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 5 runs, 1 regre=
ssions (v5.10.182-cip35-191-gf4efde512959)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.182-cip35-191-gf4efde512959/plan/kselftes=
t-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.182-cip35-191-gf4efde512959
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f4efde5129594b413888498ce6f27da48a03771e =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6489a7119ce06b605c30613e

  Results:     37 PASS, 17 FAIL, 17 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.182-cip35-191-gf4efde512959/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lkdtm-asus-C433TA-AJ000=
5-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230609.0/amd64/initrd.cpio.gz =



  * kselftest-lkdtm.lkdtm_USERCOPY_HEAP_SIZE_FROM_sh: https://kernelci.org/=
test/case/id/6489a7119ce06b605c306148
        new failure (last pass: v5.10.182-cip35-8-gc3d08808cfa7) =

 =20

