Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE26C7619A
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:33:02 +0000 (UTC)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
 by mx.groups.io with SMTP id smtpd.web10.37878.1679473981280868596
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 22 Mar 2023 01:33:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0sU7Gdxg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.53, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f53.google.com with SMTP id a16so13488106pjs.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 22 Mar 2023 01:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1679473980;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OBkMJZrWPAoldspcqC9qjBzjzi5c9MaWwVQBVzQ7unc=;
        b=0sU7Gdxg5P1+R+9KZZJkc6/aVFu2dOLufcOboXtt3pbd/GDrj+85m0ymwh6cM/me77
         FVUenXLCQmjhyTLkyVg4s3JmLAcstdmwGMuUfUA8mtA1H3tG9zrGvqBCujepkEQiJEZF
         /1KDoJUNrgjy6ltxS8E6Py4y9QDy5tQdQ7rTtar04vh15XPFUPZ6O0qYDftr3c5MvXvs
         O4IBECJfluQ3e3L9QOoZa/VaF3DkvkO3vFfUKUo8ife1QQqaRbRynr6jy21/BQpOJh46
         MUhDJlwS8QnqzwFfbpc3s/z5U45xrIICeAuvlBU82D27lGoUqMGtolJE3lnKqC9M4xPa
         1QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473980;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBkMJZrWPAoldspcqC9qjBzjzi5c9MaWwVQBVzQ7unc=;
        b=Mmmyy20axM2uGbS8k3hbdj8bjbz5FV31C5awsxMVh7fJ0Va6c99Umt4wxWWZdzg7hq
         GYkySGZKoZAoyh+rHDhico/uIXD3aZkVBT9GSgj1ax1gQ430Lpra+wdZkc0e0k2smAov
         iUcV5jtEcP9k/l69S7D2LeTO4e5T+UJLcecfqVMn9h+eMYd6BSNzLmUsk+qdNwxdb8NC
         CzXFK1Cr0iKm6furM5pd8MXq42tefaoxH/vD+ODruY/zMusJm0rHTagB5ApCvyoR6Wyy
         ApE8hra3ws4ArT90u/XUNQI/2gwSZVcn4TEch0HcOcxmHEbr0erasTnfmER0ep2zjYvq
         jqrA==
X-Gm-Message-State: AO0yUKWX7YTCGvVrdgqd6dNI3EHMtg7qyOYH4449YPK8+cyP0YIgB23d
	n2FhjFMkHRyfgdiv2pUmAIeSuGrIaArLa1d8KSs=
X-Google-Smtp-Source: AK7set/aJLZZdGv2agTUDeT2/bYqMXVKqrZx0MTP7WMpbrGplccghGPQTFaFYWP0nfFNOaANSJPoAg==
X-Received: by 2002:a05:6a20:8361:b0:d6:c9e2:17a1 with SMTP id z33-20020a056a20836100b000d6c9e217a1mr3325461pzc.62.1679473980650;
        Wed, 22 Mar 2023 01:33:00 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m7-20020aa79007000000b005a8b28c644esm9537398pfo.4.2023.03.22.01.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 01:33:00 -0700 (PDT)
Message-ID: <641abd3c.a70a0220.293ae.1375@mx.google.com>
Date: Wed, 22 Mar 2023 01:33:00 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.175-cip29
Subject: cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.175-cip29)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 08:33:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11061

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.175-cip29)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.175-cip29/plan/smc/

  Test:     smc
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
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/641aa8d576415753769c9528

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.175=
-cip29/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230310.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/641aa8d57641575376=
9c9534
        failing since 260 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-03-22T07:05:53.280570  <8>[   16.914739] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/641aa8d57641575376=
9c9535
        failing since 260 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-03-22T07:05:53.267092  <8>[   16.901125] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

