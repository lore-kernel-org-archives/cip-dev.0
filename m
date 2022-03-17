X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.7282.1647501245903806813
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 17 Mar 2022 00:14:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xGR3RxR2;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d18so3744709plr.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 17 Mar 2022 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=2AHKfUkd/PIZS3LYrTLw6VGyppaWspbLbAOs0IUSmWc=;
        b=xGR3RxR2JcoGvp0VI1R9AT/z6fvAzxkuGm35bEDtAmuYj/DFby+FC+NB0M7s35G1Xh
         G/SAMN0L0bzC0XqR1QGq0b5U+ziuZT6X8Ipbx/x/pAbe9emoQUyjscT3/1UJQZlAWBwd
         IhaHbzckfMsfxbUnkaX1pPGJvnT9teIzG6aex479EQEvbD02yre/OxwYZ88YxftAfkut
         8FW9hJAZJzHcm2URFOOogt8gzN8zrUzhNBaEF5Enywvn27+tY5EIgnczZ4/9xqQz86oE
         BvUAAPQ9ZrHx3uYEJi+yGIKjNTcwUn8y6ea8N3LhAvE90KjNsWA/+QSdgBqMlFSgWSBu
         7gqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=2AHKfUkd/PIZS3LYrTLw6VGyppaWspbLbAOs0IUSmWc=;
        b=mSSrSP+Lc4DmUVTFPO20wb+egAe7Q9HD/C2PW0EeuTIAusJayGb8MzZCK4FumDsM9x
         KiLE3T80u6UwnlE2OedTe1YgHGJZrvxgM0mc7CPo6WrXgukhm/NjpHCzYWXKR54/mBVR
         If00GQ7M8BnW/MkRbNRpmAhGyLK/IwQtVOxbAG8j4oPgkYkt2zVrRop/7KnIsK+7AXZx
         wGDkXpo8EKxymXLSyKK4pMUtxkMHKSMylvTSY1SDTp40r6LkHw29uA+B3Z/p19F1oCAN
         FWEfbmlmkY69ejK+qIGeDRMuU6Wk99qrHK4Zf3iT7FB6kuJIaky/55Q9KknUhyFDBdzF
         eXtA==
X-Gm-Message-State: AOAM5304lKwy07z0qgnkxh+KeyPgJgYKPjpObl0X9C4B0Sgmf+Gzr40Z
	PwCmwHhxPsJX/EQ9Gbcan9qsNJdU791A8VKKKPk=
X-Google-Smtp-Source: ABdhPJyg7A0F0mqHW34cPhNQ3Ydl9ZRSGJY7j6Bc7ZS4QehFZ7f5g+3oYMUj56fIZMiQmcXdSswnrQ==
X-Received: by 2002:a17:90b:234f:b0:1bf:6906:909f with SMTP id ms15-20020a17090b234f00b001bf6906909fmr3688577pjb.185.1647501245309;
        Thu, 17 Mar 2022 00:14:05 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e10-20020a056a00162a00b004f6fc39c081sm4970850pfc.211.2022.03.17.00.14.04
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 00:14:04 -0700 (PDT)
Message-ID: <6232dfbc.1c69fb81.2b8c4.dce3@mx.google.com>
Date: Thu, 17 Mar 2022 00:14:04 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-cip68-19-gcfdd1ea3a7ba
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4.302-cip68-19-gcfdd1ea3a7ba) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4.302-cip68-1=
9-gcfdd1ea3a7ba)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip68-19-gcfdd1ea3a7ba/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip68-19-gcfdd1ea3a7ba
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      cfdd1ea3a7bab80ea3e513f28e7aa423fedf5d61 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6232db1ed60c8cdf42b73938

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-19-gcfdd1ea3a7ba/x86_64/x86_64_defconfig+x86-chromebook/gcc=
-10/lab-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6232db1ed60c8cdf42b73939
        failing since 0 day (last pass: v4.19.233-cip69-1019-g2e5815777e975=
, first fail: v4.4.302-18-ga78419826225) =

 =20

