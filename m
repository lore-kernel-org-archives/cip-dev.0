Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED9C43334
	for <webhook@archiver.kernel.org>; Tue, 26 Jul 2022 03:36:30 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web09.2591.1658806585046250519
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 20:36:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=rKwj3SL6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id w205so8817609pfc.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 25 Jul 2022 20:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Esa0zgItVcO+GGXdr9Idq9HhY7m7vCPy6JgnHKTaBXU=;
        b=rKwj3SL6pC9c7nz4014LxPO+co/l6j1Evz65emCEcrct1HsxXnfjVqAHOvXEoWwNqP
         5jiteRxTopUcZouAqprg1nsuCUIBobUavqgx4cwLyC9XJw/HTB/ulbO3HscWeoX5qbck
         YVYBNb7U7+K3eYjhvUijavHOKc4/Z0KiUlZnGfgcan/LbdlfYP3j9M2x/rGA94lXWqtx
         odr9XbnDyP3gH5plvvv2ncQfTgeXsfa//esYQf32cRWDTwJgoV1HZmV6t82Y4alDj+7L
         A0dw0m0VpIMWLpmY7e+3wtVZWHlmyH1czmjRdmQoXR7w3fico64zS6u5ss/cSe6dNw1G
         uORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Esa0zgItVcO+GGXdr9Idq9HhY7m7vCPy6JgnHKTaBXU=;
        b=WyRVPyfqYIR9PuwXxgJopHniHm4F25NrX10tmmg1pMGNmhKuHTunMZYPJqiwbRptlL
         Kh8Hd2C1VZtO4VAk9gaOm/Q+NhFStkat8SxBBf+HYpMv0eUFBxdeHG+lEce7kEPQmo8s
         61kwc6f4fBXCiN0hMpg+jwh329mQ7B712J7T5Ra7by9nj1XNerEITajUwLZb7EoDTnKB
         eBq/AYEhoMkbFmdhans3XZqpJ8rwLXBD4ZynRcU7zqSdEc/DOiwbvivX1uCaVixD091m
         8d1gqHWP9k181VVG3vQ7xqF4pXxjmJ/jyI/Lo6mk+5vvS5w5pvm32hbpTqJLtk5Q3FtI
         ajAA==
X-Gm-Message-State: AJIora89sjVjwCmLL3hl0G1umlzF3Y3JW6RDO93il9v3EP5inSCGEXIC
	rRISntU+pSQVH909eccBFaX9rYBRaK1ouv+u
X-Google-Smtp-Source: 
 AGRyM1tdU+32rkhv/Wwv8tUOuW03v2MbIOHGiOFBdUDkXtCt04PdmA5jXM30Xi+J2tXH0hwn1TXEHQ==
X-Received: by 2002:a05:6a00:188e:b0:52a:b545:559f with SMTP id
 x14-20020a056a00188e00b0052ab545559fmr15727461pfh.18.1658806584435;
        Mon, 25 Jul 2022 20:36:24 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 z7-20020a170902ccc700b0016c09a0ef87sm7698960ple.255.2022.07.25.20.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 20:36:24 -0700 (PDT)
Message-ID: <62df6138.1c69fb81.e6c7c.bdf9@mx.google.com>
Date: Mon, 25 Jul 2022 20:36:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.129-cip12-12-g93db31b19404
Subject: cip/linux-5.10.y-cip smc: 9 runs,
 2 regressions (v5.10.129-cip12-12-g93db31b19404)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Jul 2022 03:36:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8923

cip/linux-5.10.y-cip smc: 9 runs, 2 regressions (v5.10.129-cip12-12-g93db31=
b19404)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.129-cip12-12-g93db31b19404/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.129-cip12-12-g93db31b19404
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      93db31b194040f61924e230fdae0266bd92c54cc =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/62df4f717df2ee4bb3daf05a

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-12-g93db31b19404/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.129=
-cip12-12-g93db31b19404/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20220718.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/62df4f717df2ee4bb3=
daf066
        failing since 21 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-07-26T02:20:26.471216  <8>[   12.331174] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/62df4f717df2ee4bb3=
daf067
        failing since 21 days (last pass: v5.10.125-cip10, first fail: v5.1=
0.126-cip11)

    2022-07-26T02:20:26.453382  <8>[   12.312952] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

