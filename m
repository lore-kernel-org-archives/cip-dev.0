Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E2BC74A4B
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 13:31:15 +0000 (UTC)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
 by mx.groups.io with SMTP id smtpd.web11.19827.1678714269040741878
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 13 Mar 2023 06:31:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=DTmDhmYM;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.49, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f49.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so12965927pjn.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 13 Mar 2023 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678714268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2nTPD1jWU2c1qTmisZcPKk6riWoqBHfWGRz8/1JCoaQ=;
        b=DTmDhmYMwVmTwIO7A0fhWraC4QkWzsZIaPvPC8LRNgOXeYzEoy7plgqMzDtWVFjOoI
         KD2uMK+EOidfEcuOa6iiigs3tBNAoSJ4Y0HeRh6CiiDt/6/BiqY+DibSq+3F+SsyoF8a
         4xrhEfmrWtG1s6JBLWw/3njsJIhxEkCep+FKF1gV4zveXpoFOffsHArTy7utE8CVbf8y
         HOPKrSOomZpqY9IjvHdNokLhsE9U6g/BpOUm3s5+VtSkJgKeo4Rg8ThVup7uKcRFFMLi
         UiB8deZWmYs1QPLyqZLvGr8QyRgS9Lx5pFT5ILV4ZyIaY+dl17wR4oV1UjoT+aHuuLdh
         QIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678714268;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nTPD1jWU2c1qTmisZcPKk6riWoqBHfWGRz8/1JCoaQ=;
        b=qzGTPmQ8gCnst8QGyQN4NXU7K1/eB3Vf3CcJwngtn1hLY8Oqczp67eZzZKfZYaqvMU
         O4o8S6bL8b9qpyLU5N1LN4ZEPRgBjlgBm4kW5ocySiVMhAwl9JelHPtMwWGgzdX2EjQ6
         Hxlda/1F3YZpVtNeciUTHq3Egqh3eZc3Q8oQXtlNzSgWUt3BY8QK8EayKrXZyCQcSGsz
         N/j2L83eT5mR+QwNzJ8YjoX2D5qd0witx6kgC+01qxCvNsv50pLeRMkBCKbuagJACPna
         hlNcLIZcuzlIeY2JbVaxVDtOXxvXk/gSPm+GGFd/dAmhtWrNI3UpsxKKly9jfGY8FAlp
         qZbQ==
X-Gm-Message-State: AO0yUKVopjgazUEtt9xKWCnLOtyNytpoN/w1jNEP39cLOzZHCVOCZ9Q1
	5/RaGlj2tCQfSXmPUpi4m5Evg/+REqexAn7Wv4aMHjY0
X-Google-Smtp-Source: AK7set+HzWEZaVxAB8aV46/517IQyg1prhkh9KrjjEiGatmP0Lf1uxTdR/2HvSjLxyQMqtPFcIZhHA==
X-Received: by 2002:a17:902:8211:b0:19f:31a9:46c with SMTP id x17-20020a170902821100b0019f31a9046cmr5940904pln.67.1678714268209;
        Mon, 13 Mar 2023 06:31:08 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id jx4-20020a170903138400b0019edf582a95sm4794460plb.20.2023.03.13.06.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 06:31:07 -0700 (PDT)
Message-ID: <640f259b.170a0220.b5171.778e@mx.google.com>
Date: Mon, 13 Mar 2023 06:31:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.173-cip28
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.173-cip28)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 13:31:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11010

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.173-cip28)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.173-cip28/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.173-cip28
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2988848bfa1d1f2c02318f2193b06874fb5f62eb =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/640f1884252703aa488c8638

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.173=
-cip28/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230303.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/640f1884252703aa48=
8c8644
        failing since 252 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-03-13T12:34:55.176070  <8>[   17.282348] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/640f1884252703aa48=
8c8645
        failing since 252 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-03-13T12:34:55.162459  <8>[   17.268746] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

