X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web10.25848.1647440858956867834
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 16 Mar 2022 07:27:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=L7j4QIOS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id h2so4078615pfh.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 16 Mar 2022 07:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=xQEJNFXjIr5w21Pa5HvCOvRzj4ajFyqUqLRABzPwrxs=;
        b=L7j4QIOS9mOGtzU/r4P2s6ZiEc+PIOjs6Zg1zFLSayUSTBzQWLGRfTBWjHfujuoVs5
         FmWu8nTP2lQDsovkUWbupYo2JO5yKL+OPQlj1b7NsCKIzemgz2NuzuLukiLDLfyNGiuy
         8L7jJhDmaA9qcCQwk+eAREDnvbxuQme4ydIqSu9RATlFBC2KkoLEHo2JMLufif1F1IRC
         R+wqbIVmYecHP+rvTRuxjKi3Ioj+OrBlewFU2TSm7e8SNiQG6OO2/V64nCKQMw0FEv/x
         wgB21bqSWbXXMYW21KawAvHzE0j/1DVKSAv9Utya1CuuKsz+dMOhOvI3HhT8D0VUaj7S
         4LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=xQEJNFXjIr5w21Pa5HvCOvRzj4ajFyqUqLRABzPwrxs=;
        b=2zMaCiFsPs78g3orhNUcqPwm6Ur6wGoNWK4v3W2TUUY17cb8d2YsLso9vha2i/Vri0
         RJejcDmJHRCN/8sPLZEPrtj+6Hb88RRBo8+kk7+5Fqou+EjoEXkQElOzFQM/xC0+hzN2
         74a03zNbdaJuwigvey9gg0KUmowfOlEzuHYMBrytWKI2xcKL0fv5jCbBivwX/7mESUtG
         YVbzsknrCZscnCHthNiOys3g7vrUSXIhxgPaAks+KttLOurrcfT4l5HvATcHytuAEEgB
         QEZwbvAoRRlcXVruF3guSaR0WCWV9jIuJYyomhVgZORbMnf16Z+dWUeQeTJBhBC7a0D2
         SVrA==
X-Gm-Message-State: AOAM531d6AILzx62MZm9SFf5Y77Sxjwst3Pwuc+NhqDUuvatucn7LcgO
	/LqR6J5RMfakPOnLEVzqq9zX7OuoMEq421l48rk=
X-Google-Smtp-Source: ABdhPJyTq6MS+M0xxanS2fJzQXGtguYJPoaFhuuXEib7WqatnLs2kg4ucatijrK51USLQC6CjqRu3A==
X-Received: by 2002:a65:61ad:0:b0:378:8f01:7674 with SMTP id i13-20020a6561ad000000b003788f017674mr28272844pgv.314.1647440858370;
        Wed, 16 Mar 2022 07:27:38 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q10-20020a056a00084a00b004f7ebae5be6sm3663952pfk.155.2022.03.16.07.27.37
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 07:27:38 -0700 (PDT)
Message-ID: <6231f3da.1c69fb81.fe766.7e2f@mx.google.com>
Date: Wed, 16 Mar 2022 07:27:38 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.4.302-18-ga78419826225
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4.302-18-ga78419826225) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4.302-18-ga78=
419826225)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-18-ga78419826225/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-18-ga78419826225
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a7841982622594475c87d82372d03c2cd9a4786c =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6231e47ff0a08e1444c62978

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-18-ga78419826225/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/la=
b-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/6231e47ff0a08e1444c62979
        new failure (last pass: v4.19.233-cip69-1019-g2e5815777e975) =

 =20

