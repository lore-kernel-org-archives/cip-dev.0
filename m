Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BAAC678D4
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 05:01:08 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.38509.1674104458613473216
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 21:00:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ujwrjP7q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id bj3so1300483pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 21:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ojURNnR1p8NCtWB5TYOM7T+jtVmEOe44xF5vpTzboAY=;
        b=ujwrjP7qAtzn2ErToFebeeor7zvnnO2+2IMUO95nxI0V6DKOac65q1xVSAbqUPSn/Z
         JKLLpX8oMwWTi/4YZnkhm9XQQLNXDYu7cankdHJRqHyjyUR2dYg5Ha2DQ2rs6d3bV9hr
         0E2HaSAsFKfFXL9hB2Lkk2zw4eLSGfCCDT0qXkN+qOt7lwzgr/VW2S7xj6GBEx44i/ca
         WlgH7pE/4tmw+XfxnMdHUg7o8w3FYMWSsu7twNj773ZUdcAgH1OTBdZXte41zqORG5Q1
         USxfWlTsAx8Mln2QMxwpie2kLZZoDffceqG7rg55lZGV4S0ebiAnAj6oRzXIDZoLY3LG
         vKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojURNnR1p8NCtWB5TYOM7T+jtVmEOe44xF5vpTzboAY=;
        b=l+yCDCvBJgsc1gNWsorfaEjfVwuhKaRK36SQL725LHftgPVCk3AtpN9yNxfaiKHdqS
         MFs3PxbTnX4V9QeEfIqUhJCazw9RIusgPOJedf8tUpN3iPQQX27vX8G6LKai6XEKLCus
         U8h/gSy/iCjmH6dchuHOmV50XOYDGrRs75hr+uzytk8v4C1P47MSzKzyxxi/T4VqGhUg
         hcB35xsoWrQTueTx5nJIcTb0ade74+KW2Qzjv1BK2HoEIQFmBr+gGJX1ilBnPG44pCFk
         fFDulb6FmxLHO1Vi49243r2q8eArw59u6YrpVUIbydQqhDYWETS90zrBcCjn4a32C9m4
         d2gQ==
X-Gm-Message-State: AFqh2kpR9QTwhWFIc+IheXP8s6Gjfz0FTcCXWARX1F5KTjBk7YsqEhPb
	2dcbP4LtDdmvYDP7I3P0mhhgn/C9yPgX/WkObcGbSQ==
X-Google-Smtp-Source: AMrXdXv9a2KfbTUqmX5ZKqFIw7tXbBO4xC9Ynqcu80W5Oux0ykA4C3qoHaY3KdKboa18ut26NTCCLA==
X-Received: by 2002:a17:902:9891:b0:192:7c38:4842 with SMTP id s17-20020a170902989100b001927c384842mr30592635plp.53.1674104457871;
        Wed, 18 Jan 2023 21:00:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p13-20020a65490d000000b0048f8efc53a6sm19834253pgs.80.2023.01.18.21.00.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:00:57 -0800 (PST)
Message-ID: <63c8ce89.650a0220.94328.f29e@mx.google.com>
Date: Wed, 18 Jan 2023 21:00:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-cip88-rt28-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 6 runs,
 2 regressions (v4.19.269-cip88-rt28-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 05:01:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10427

cip-gitlab/ci/pavel/linux-test ltp-ipc: 6 runs, 2 regressions (v4.19.269-ci=
p88-rt28-rebase)

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
nux-test/kernel/v4.19.269-cip88-rt28-rebase/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-cip88-rt28-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      09932a66d6b63564f8b94b34721b1f2d38ea9575

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


  Details:     https://kernelci.org/test/plan/id/63c8b8b4f980befc60915ecb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63c8b8b4f980befc60915e=
cc
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-cx9400-volteer    | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b74c9d9ea83669915ed8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63c8b74c9d9ea83669915e=
d9
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =20

