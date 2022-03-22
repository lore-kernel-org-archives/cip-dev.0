X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web09.6463.1647928252480024845
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 21 Mar 2022 22:50:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=EB9DRCSn;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id o68-20020a17090a0a4a00b001c686a48263so1089919pjo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 21 Mar 2022 22:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=rvY+CEa6eQULZKh9uxaL8uRTO0w5TpYmuSZU3rlohws=;
        b=EB9DRCSnmktc/jCFWeV0/h5srNNRJjCWm2VokUqrwZb7kBHf+jnSVkWSQDyjq3apdZ
         ZcN8d2KZBMJGxrZ8SLbym5LpBaQgBogZGEQT3xbwuBpe7kcxpEIubkwISQExSAJCwk3l
         8977pg+i3LNMehnuKwmKdvz2Ue5n3U26jB9cDwGVMTus8YvJatjKKO56XjlUWU3gXVzo
         bTAMISQSLJaZBe+GUGvJ1EiF0f0O7tbBkmVW2ZrcLoUdVHztndDslrxPjtlIRshjKpbl
         crjXfw75zjyGVVPqo2u+84N2gXubEjc0qPOmXxKsQWHJ/jpPoZbPQ+2qVpL1zduv8d6F
         2g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=rvY+CEa6eQULZKh9uxaL8uRTO0w5TpYmuSZU3rlohws=;
        b=StUepLqiR+xqghHUPKUCkKPUbi2JfzOoe9POE6uQ7fIld+OZaKtsPYswTZFutauLVu
         wuMotQZkyrC+lDgUeIHmsiGb6Ge4oaosAIkPmUQ0uLcn9Lo6wPKEQ6TgzlG5d2NVLft3
         VOwJrkEAFBqTOuTJ+SVhT9zZvnTpf/5hAcZ7dVDxdzml48GU+JHRaCZ6OnZsX+QF6dMM
         JzY0IYaRwkg/HmP15uCUKZ47jKy1JFFN1xiB7Xgn+HtiWTdBiPVmPS17VBFsciAq5qTE
         jG8dEZ9iixwIk5SrfXv9e1uq/SFyud8j0fZI51ZHJNFie/PPxksG43NVP4ff1RAUTXnX
         4dZg==
X-Gm-Message-State: AOAM5314PxNaDM1fAAIPqzWrHqBxisTD1LibLJ7tqyk9sM5Eg5VlVoYS
	m0cuMDwW+bKzwfjvj/EplYG93NVsu4A0EqO9o+Q=
X-Google-Smtp-Source: ABdhPJyrCZzKEZPhvhOYiXyDlG1SKJhoxHz2gQofqxWmswQGhn8sPjFxo4K7wS4HUiTEfSHRyl7psg==
X-Received: by 2002:a17:902:7606:b0:153:8441:b5d0 with SMTP id k6-20020a170902760600b001538441b5d0mr16374891pll.120.1647928251925;
        Mon, 21 Mar 2022 22:50:51 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m10-20020a17090a858a00b001c6a874142esm1232254pjn.17.2022.03.21.22.50.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 22:50:51 -0700 (PDT)
Message-ID: <623963bb.1c69fb81.4cf52.4bf0@mx.google.com>
Date: Mon, 21 Mar 2022 22:50:51 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4.302-cip68-128-g4031bdd82383
Subject: cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4.302-cip68-128-g4031bdd82383) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/pavel/linux-test smc: 3 runs, 1 regressions (v4.4.302-cip68-1=
28-g4031bdd82383)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.4.302-cip68-128-g4031bdd82383/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.4.302-cip68-128-g4031bdd82383
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4031bdd8238386ea87c992b18bc65b684bddc2d7 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-12b-n4000-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/623958658aa6bf61952172be

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/smc-hp-x360-12b-n4000-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.4.302-cip68-128-g4031bdd82383/x86_64/x86_64_defconfig+x86-chromebook/gc=
c-10/lab-collabora/smc-hp-x360-12b-n4000-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220228.1/x86/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/623958658aa6bf61952172bf
        failing since 5 days (last pass: v4.19.233-cip69-1019-g2e5815777e97=
5, first fail: v4.4.302-18-ga78419826225) =

 =20

