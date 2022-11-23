Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2110AC43219
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 10:32:34 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web11.17165.1669199545699803823
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Nov 2022 02:32:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=zb4CDhtQ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id 71-20020a17090a09cd00b00218adeb3549so1444514pjo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Nov 2022 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FneJeh7D7LDcpvV/I+hbwFysHdBi2K15h+CVWD0fEhM=;
        b=zb4CDhtQTW/tta2MqSRtjLftQGYSntAEHICk/JSfdh3ValveWjXWx65RKVg912lbyc
         dvb2fQM//Fy3JgbwQBbmewho0iGuPaRk8BESi/BJIHPRcEdifXNKrs1YGYKTgQda+eAh
         A2vRDb/Womlvo+Ibi2u/j3p7urPssQ67qeiMVWJOMd3UhzU6bByYEgp71Gix0iEudCVp
         Ye9ZZQvfLJhu9mQlArLYMjbByeg/akTlb4AB3e26VppYHlnH2zbxb5fdmiv5SGEtOWuv
         9maKINgjpdubR1C/YGAMQsZ0j5BGUcDLXYY1L1hXAq8SPl+t8TuPWDB0hVJK7V0+DgB8
         m11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FneJeh7D7LDcpvV/I+hbwFysHdBi2K15h+CVWD0fEhM=;
        b=yrHjG7rc+jz+BgOh+RkZCDHZZDmVyGLU3koENuxs2tVCqikjBc4BdY0gCJYwQTDKtF
         5OAwcKvMP/ru/nPfSQ5vLJDMzPRMX0fRU5wmMLv3wndxKBw4qS6Wvpfw/R/h94ycoTDj
         Si//XtjF6RuY86IE7nD8dQOGSEAvT6dyJUpBvkuHBLjlca6W/IOTc04y+EPK3wECs30l
         oXNc1mtO1J0vL+bfSAamB9JK0OUGXbM/27e2qEfzRZXH1mOryqi0WAETK3TE9xp+AlsD
         x+zJAE4ulSEHGKiDoFz92NOgzTM8MZzmLCl7n+2073gZC9qDp/T2fUMRNT+Ga38xztB6
         v28A==
X-Gm-Message-State: ANoB5pkfmCGvtyQ5EuDGyIUbm5nVzk7CN/TUy8K/we9pFdU00jDcHoYK
	mX6K/d3GY2LjvfaEurRtusD5X/OyDwCU1Dscvdg=
X-Google-Smtp-Source: AA0mqf7ZgfHT2t38qu5xBEmwD7peIxx7prKhcEfEMx4DIzhglCB9C8gITxksfUH7Ak70Sy6QGv/diA==
X-Received: by 2002:a17:902:8604:b0:186:fe2d:f3cb with SMTP id f4-20020a170902860400b00186fe2df3cbmr12189873plo.132.1669199544688;
        Wed, 23 Nov 2022 02:32:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79498000000b0056281da3bcbsm12748457pfk.149.2022.11.23.02.32.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 02:32:24 -0800 (PST)
Message-ID: <637df6b8.a70a0220.3d20c.35d6@mx.google.com>
Date: Wed, 23 Nov 2022 02:32:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.265-cip85-36-gf1ffb3de9576
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 5 runs,
 1 regressions (v4.19.265-cip85-36-gf1ffb3de9576)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Nov 2022 10:32:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10089

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc smc: 5 runs, 1 regressions (v4.1=
9.265-cip85-36-gf1ffb3de9576)

Regressions Summary
-------------------

platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.265-cip85-36-gf1ffb3de9576/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.265-cip85-36-gf1ffb3de9576
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f1ffb3de957658ca822f84e1016111475207d8a3 =



Test Regressions
---------------- =



platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/637de63df9b803af852abd1a

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.265-cip85-36-gf1ffb3de9576/x86_64/x86_64_defconfig/gcc-1=
0/lab-collabora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.265-cip85-36-gf1ffb3de9576/x86_64/x86_64_defconfig/gcc-1=
0/lab-collabora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221107.1/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/637de63df9b803af85=
2abd1c
        new failure (last pass: v4.19.264-cip84-50-g1e56b70eaf66)

    2022-11-23T09:21:51.782250  <8>[    2.429604] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>
    2022-11-23T09:21:51.782366     =

 =20

