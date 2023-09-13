Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78068EE01EA
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 16:54:21 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web11.2112.1694624057244924482
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 13 Sep 2023 09:54:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=xuJU80nN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-68fc9e0e22eso2780505b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 13 Sep 2023 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1694624056; x=1695228856; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a7jqBap6kgxNLe36WCXfTNs+6KOADH2DK9i3mvMUwN0=;
        b=xuJU80nNJJ+gptut6ih8PuMyhsgfHYAFlrLVoR/v0KYNuIy6wmfAHMPiwIHtQAoEYg
         HQoYoklBzFJby7u/HpMukTprCAVkvyq0rbrXgKuGLeYX68xg2S3aFTgZLK8nbrV7EWPM
         PB0P2LvMJ7WsXMvvhDBgfBJ0QCMgnolFadrFcRAqVnatPzkO0OGnTLb6z2Hb8o1ePCWr
         YZ3EjzCdCjqjh8TqjNpa7kZ0rGAfyNB7EERpMUelLnozTTGK+NymsNriM6xZCfhR9MlV
         bYXQWIWCG0/w+pu/n9dn6Fy+NmaF7ZyOSQX6ajCI+0kzWBSPnk9dDVpAOyKBTnI7YMez
         15Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624056; x=1695228856;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7jqBap6kgxNLe36WCXfTNs+6KOADH2DK9i3mvMUwN0=;
        b=i4OXpH5geJMGcg2+phoSzqHPdI4eVWDGo+Gvj4GFDLbH2BXf0eMUCLyG+D8CsMDV72
         DWyR3V0xwc9LLXu6UhNToPSQWhh8AqypoT2rVPYMCDOcID922B74mMC5RABoJKHEITJN
         OtWTHj/7qqo9mxqE2JM2HM1c7UJLpo22Q/zZG0Q3Npm46fH4RSJhg94XxPm91MvhbwfS
         LTutUcHp1t99kASqocJo7LVB3CsEUnlGryMeM0p5/skYRp69waS214gq0XXcXT6fXden
         qTE42E7BoxequsnJEjdGQRHqQ19xgDPviMDZH9gTO0OIrNCYc7xOic4DMEOq55fmF7e/
         lUIw==
X-Gm-Message-State: AOJu0Yxizuhzbmn3I1BQJWrolOD6B+mRuY8ybH8vGaKyCKuE/E28U0RA
	sqN7jpudXEwVOFSyHc9hccWsNv/TqQevVg76JN0=
X-Google-Smtp-Source: AGHT+IE+eWkZ/46AUNRK/1QVL39dZemAJ9SCG+8EfXDkFUY0tH+R5C/d04NqkpkBRwwJn9wNTnUy1g==
X-Received: by 2002:a05:6a20:4287:b0:153:a461:d96e with SMTP id o7-20020a056a20428700b00153a461d96emr3503908pzj.47.1694624056206;
        Wed, 13 Sep 2023 09:54:16 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v11-20020aa7808b000000b006884549adc8sm9336643pff.29.2023.09.13.09.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:54:15 -0700 (PDT)
Message-ID: <6501e937.a70a0220.56b62.a942@mx.google.com>
Date: Wed, 13 Sep 2023 09:54:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.191-cip38-17-g8dad6b499cfe5
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip ltp-timers: 8 runs,
 2 regressions (v5.10.191-cip38-17-g8dad6b499cfe5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 16:54:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13111

cip/linux-5.10.y-cip ltp-timers: 8 runs, 2 regressions (v5.10.191-cip38-17-=
g8dad6b499cfe5)

Regressions Summary
-------------------

platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38-17-g8dad6b499cfe5/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38-17-g8dad6b499cfe5
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8dad6b499cfe588bb00bdbed4e46649fe88260b1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform     | arch  | lab         | compiler | defconfig | regressions
-------------+-------+-------------+----------+-----------+------------
qemu_riscv64 | riscv | lab-broonie | gcc-10   | defconfig | 2          =


  Details:     https://kernelci.org/test/plan/id/6501da6c283c60e9008a0a47

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_riscv64.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38-17-g8dad6b499cfe5/riscv/defconfig/gcc-10/lab-broonie/ltp-timers-qemu=
_riscv64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/sid-ltp/202=
30623.0/riscv64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6501da6c283=
c60e9008a0a4c
        failing since 14 days (last pass: v5.10.191-cip38, first fail: v5.1=
0.191-cip38-2-g09e5ecd8645b) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6501da6c283=
c60e9008a0a4c
        failing since 14 days (last pass: v5.10.191-cip38, first fail: v5.1=
0.191-cip38-2-g09e5ecd8645b) =

 =20

