Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6B7E7B605
	for <webhook@archiver.kernel.org>; Wed,  4 Oct 2023 12:23:11 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web11.16797.1696422184217037644
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Oct 2023 05:23:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=lDpU17Ja;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.181, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3af608eb367so1351278b6e.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Oct 2023 05:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696422183; x=1697026983; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1wGdm3xkEdYZiCN7/zh38Pdq8/dbvFBzrUW6NWGXVFQ=;
        b=lDpU17Ja343HdzLC1JWr62IRj7pmo9xieAdfPMrwFMkIRg3Bq9OrdfRKpq22QODQMB
         gMwvk5Qwu/hdLC5VtRt9IGw2oQO2NesWXHHXvxkXwEeq1xzFEaPy16+nfUzArcRVqQLg
         b8/nWH4lZGfXGQNbocxZ5SzsLgVp4Bg3N9yR/V0YGDbfpM6OmhKw3cI7ESErGPWm0Med
         9SYjVKLf+/YyBP2GNu2IMBht5alU1o+vVrXYnYoQA6gG341RweHKOTkY1OcU2zKhrOQv
         FMk/kpocLp8Es40FILHtsAcQ1bqp53LeqL82EiaRJHjBzK8ncFCGBX2j3yfUiE7NJqA9
         Gy6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696422183; x=1697026983;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wGdm3xkEdYZiCN7/zh38Pdq8/dbvFBzrUW6NWGXVFQ=;
        b=NTmYsdjV5EKhDaFNG0Px4MzOe4YU4xLFH9zARfk9fs0bRMFWAHLBgbuFaBuDcqD2M4
         3v4Snggn6hKn73A2UHh9fARTRlBM9bKmMikFcAkGKDA3esKPQU4NjpgumRVNVIQ0D8JX
         JrhGGV/U5xnQGSmSirOmiajIFiQQsazWBrkU+ih/jVrRZlVAUDGjKcntU5r3J4l52ekg
         ahE0S6CeHSB0rmaz8BHdv+cbuIUCLiOFSP+6hDqwp/fmI1dF63duqKhZQ8SiBOZrVDQV
         vydafADHeH5105mBQEsGhUrHRvq38QMp6U2jcFx/w439duYNaR0CFmJipwr5bOcK+F7R
         xKIw==
X-Gm-Message-State: AOJu0YxDO3ffcupgyQ5BzmpKCvvjL2QPzA+TnQ1vRL93vk6Os5oa5KJS
	XziQe78938yfYrhvlpTSohxcl8htEguLBgeYAa/MxA==
X-Google-Smtp-Source: AGHT+IGxWP9JZYmmzJuBR6qIeyognnSgEiQISTATqwYw2O9HKvN+MfHeFoSWXsWypIsMFXRW2QfnQg==
X-Received: by 2002:a05:6808:18aa:b0:3a8:4d1f:9dd0 with SMTP id bi42-20020a05680818aa00b003a84d1f9dd0mr2681578oib.30.1696422182854;
        Wed, 04 Oct 2023 05:23:02 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d23-20020a637357000000b0056c24c2e23dsm3247823pgn.25.2023.10.04.05.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Message-ID: <651d5923.630a0220.f0d3b.830b@mx.google.com>
Date: Wed, 04 Oct 2023 05:22:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.194-cip39-1-g53e59f50ca3ff
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 5 runs,
 2 regressions (v5.10.194-cip39-1-g53e59f50ca3ff)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Oct 2023 12:23:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13284

cip/linux-5.10.y-cip smc: 5 runs, 2 regressions (v5.10.194-cip39-1-g53e59f5=
0ca3ff)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.194-cip39-1-g53e59f50ca3ff/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.194-cip39-1-g53e59f50ca3ff
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      53e59f50ca3ff023b612a48397ad7e057a9fd408 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/651d4ba1c715b1e6c58a0a62

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.194=
-cip39-1-g53e59f50ca3ff/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/651d4ba1c715b1e6c5=
8a0a6e
        failing since 457 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-10-04T11:26:44.038475  <8>[   13.248059] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/651d4ba1c715b1e6c5=
8a0a6f
        failing since 457 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-10-04T11:26:44.024653  <8>[   13.234355] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

