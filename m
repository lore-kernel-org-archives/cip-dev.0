Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB0AC7EE2D
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:29:32 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
 by mx.groups.io with SMTP id smtpd.web10.5067.1685964567496371749
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:29:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Dw/EyiK5;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.170, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6513e7e5d44so2581751b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 04:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685964566; x=1688556566;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/EKXjj/3EXfuxh0BNuGbQM7/aXI+XbsSA7CcU1AbN7s=;
        b=Dw/EyiK5FtSRgScb/d5q1kuBel+Zcj3oUvbXSbhknmJye2Djpy1WCUysZnBU8kfJlX
         U3qxgMTM5WBmy0Qa7nEi/JjfSgcAs0BbGv6btqFVKWTpC+P+z2oUt5qb9H48kjuWZ5MX
         K+MJ7UgyeikGjyJ8BxPMs/UbDmzYsgOGfE2mrqDwFTlED9BwxmswhrEXqgcUNvI4DlN8
         RLiui16tGz0iVjXt/RVnksLnf6sGn4W0XlcZXPbEROeMvNnZyj94EbCY4IFDCcmd2UdO
         1Ds5ofwEglNldx/4wdLr7mK17p95+azWexzgCjXHVdEBayTxDLz20JAfPPRiFWq+hEeF
         5WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964566; x=1688556566;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/EKXjj/3EXfuxh0BNuGbQM7/aXI+XbsSA7CcU1AbN7s=;
        b=OHDOZ8PlH4Pp+B/jxsKizdF0DrDXt8dfuRCbbbf4pw/v5G7EuyrG9xlfjtWJcOxDbT
         Txq6Q8AdVLtqaLTSXZDEb7kjkxwiDQvoi+gGZKDMl9yYTY1oT8fOaAzI0afRiF3TieJk
         J0/7uWG36Ad1Jy0+ZjVqNS8PbvDS9XrXBeCBtUGNYwd+HWocXhFLo9I7PUtFMW56rCsg
         AEDFPXlQVmUDwXncAuQ9QK7REP2kh8HqmUnBXsN6rw8iUWNiqpq4LShkMcW/pOwynTgf
         j+fPX5NC5lZWlKC54jLzgrBewHGgBXtD9/1FBgQFGVFtLpm25vzThOorqA67n/SCgbxq
         4eVg==
X-Gm-Message-State: AC+VfDye4WCSCFps9rwj+ZMiw5NqMNX+jKl5mbO451ensNpLPqZoyUHM
	I1/nzT0lmWKvQoLsP2KP3JAbAo/aE5NVR/8TVUnlbQ==
X-Google-Smtp-Source: ACHHUZ7Q6nRrMe1OlHlgwl3bD9UKTOCvFwlEAAvZQDpxVpgIoMIySnUZZk2N+2zaxyiVV33vBDLbRg==
X-Received: by 2002:a05:6a00:17a4:b0:65a:6870:3ae6 with SMTP id s36-20020a056a0017a400b0065a68703ae6mr1695074pfg.22.1685964566455;
        Mon, 05 Jun 2023 04:29:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a62ab01000000b0065434edd521sm3747595pff.196.2023.06.05.04.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 04:29:25 -0700 (PDT)
Message-ID: <647dc715.620a0220.2ba28.5b82@mx.google.com>
Date: Mon, 05 Jun 2023 04:29:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-19-gf0f6960f132cd
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 4 runs,
 2 regressions (v5.10.180-cip34-19-gf0f6960f132cd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:29:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11803

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.180-cip34-19-gf0f696=
0f132cd)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.180-cip34-19-gf0f6960f132cd/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.180-cip34-19-gf0f6960f132cd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f0f6960f132cdf82ed0fcb61de7c496d33f0998f =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/647dc6216ab7d75addf5de44

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.180=
-cip34-19-gf0f6960f132cd/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230527.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/647dc6216ab7d75add=
f5de50
        failing since 336 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-05T11:24:58.448846  <8>[   13.359838] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/647dc6216ab7d75add=
f5de51
        failing since 336 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-06-05T11:24:58.435312  <8>[   13.346171] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

