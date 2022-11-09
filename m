Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5710C433FE
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:37:57 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web10.300.1668033472118390021
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:37:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=o6S2DYPY;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.47, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f47.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so119223pji.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vQIPXEw7EI0GthdIkk/9DNRIL/xe+927ri4STwXVGhc=;
        b=o6S2DYPYn7pOhoSViOHu8EvrlxaXAtUGDMDnB1E8cbZzAkKAlMjwASBbFWUERIbFbM
         moRneWBk7qEGbTMzWCHbq5Pt32McHatY8v/sRc9xYJ8Y2onNbsTVIgoX37CXDIIBNxmV
         uAfsybgXr+862WLRQwovBGevVrPGTOesi7NMhUZ+krvtw8sMxSsQhyW7BI6AA57yurwF
         ZSBU/y67OG4YkCm/ygc65tO1fO8m/GN9bVT/xQY8qD7diMtKtzj7sgg9mp/dqEW8s1r3
         ZEdw2NozceD8xajtomkhoTe9Ra6itM8gNfetQT2aEPOtDjBNhbhFTXewm1+sFWF0fjxt
         JLOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQIPXEw7EI0GthdIkk/9DNRIL/xe+927ri4STwXVGhc=;
        b=UwGf2ohqYZuCS4g9cytbbQGbnc5iVNCzwM3pJ5to7ianHulAzXkgd+0P0MqY4SmCvc
         KbcHdJJ3KdJQB2AZxDvj4EhlrvyDHTFhX8bWUDNu2LUHlVizH5KtRJjgKg6HGwmvTXHp
         mInAEL8wABHvGpUOSDXrHWVkJInlgTQefUG0hdxl/ujATx5pp0Xwull5GkWBynZuITiO
         lNNkxmoxiWIsKB02V2LdHFhvgoeMw0GFPzsL1OR+GfFB3f3EfiymTB2fkUjzCOZ9BM0e
         DczwjkvqC6Ruq9aBLCNxXsdD9REHoNjf2lJTpT5gTP35KrnZDvWngmaJIkdLXImE3O2K
         UNeQ==
X-Gm-Message-State: ACrzQf2AQcfq/PWJxV0VCcnqb3raVFIdwtCZhGV8lXyBmVmy79upUGmL
	8ZfGUlld+wbJIezedlrUD87mwLFHWjCbQRC3PSQ=
X-Google-Smtp-Source: AMsMyM4AnsDMPyZh7yuufoB5QqP0CNzqOoJL0T6yc7BuVpsenJwNzHAvpZXD5tHjh4toe1mNEIXd7g==
X-Received: by 2002:a17:90a:7808:b0:214:1a8a:a40a with SMTP id w8-20020a17090a780800b002141a8aa40amr46463320pjk.137.1668033471446;
        Wed, 09 Nov 2022 14:37:51 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ix15-20020a170902f80f00b0016c50179b1esm9634067plb.152.2022.11.09.14.37.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:37:51 -0800 (PST)
Message-ID: <636c2bbf.170a0220.3db9c.0a60@mx.google.com>
Date: Wed, 09 Nov 2022 14:37:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.145-rt74-1329-ga59fc50f38f6
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test smc: 6 runs,
 1 regressions (v5.10.145-rt74-1329-ga59fc50f38f6)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:37:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9985

cip-gitlab/ci/pavel/linux-test smc: 6 runs, 1 regressions (v5.10.145-rt74-1=
329-ga59fc50f38f6)

Regressions Summary
-------------------

platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.145-rt74-1329-ga59fc50f38f6/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.145-rt74-1329-ga59fc50f38f6
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      a59fc50f38f6208d7d36629eb501bf5191bde812 =



Test Regressions
---------------- =



platform    | arch   | lab           | compiler | defconfig        | regres=
sions
------------+--------+---------------+----------+------------------+-------=
-----
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/636c1d9745bc3c1e04e7db8f

  Results:     15 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/smc-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.145-rt74-1329-ga59fc50f38f6/x86_64/x86_64_defconfig/gcc-10/lab-colla=
bora/smc-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/x86/rootfs.cpio.gz =



  * smc.CVE-2020-0543: https://kernelci.org/test/case/id/636c1d9745bc3c1e04=
e7db91
        failing since 84 days (last pass: v5.10.131-cip13-49-g1145e9c6352e6=
, first fail: v5.10.131-cip13-84-g5fcbe4a63ab4d)

    2022-11-09T21:37:11.623427  <8>[    2.485427] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-12207 RESULT=3Dpass>
    2022-11-09T21:37:11.623603  =

    2022-11-09T21:37:11.626878  + set +x
    2022-11-09T21:37:11.627181  =

    2022-11-09T21:37:11.628732  <8>[    2.491351] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2020-0543 RESULT=3Dfail>
    2022-11-09T21:37:11.628949     =

 =20

