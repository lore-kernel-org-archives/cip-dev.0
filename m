Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3876EC61D97
	for <webhook@archiver.kernel.org>; Sun, 29 Jan 2023 23:00:24 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.28536.1675033216850894383
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 29 Jan 2023 15:00:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=PhuCX91g;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id z3so6556185pfb.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 29 Jan 2023 15:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f0YC16QYuI26iSEqouzNHzLfNLNpzmf4/PF2cxJjI7Q=;
        b=PhuCX91gN1BSMGDzviIgmUfcmn/M9rHGmLBr9fYB/PISEK4HkVvLjKL7SAOMD/E5tv
         98bAouck9ac6eNeSpK4paN+LL+jeS1T87SZPcoHuA2/wmrLmYRStCIdREL/RIlYZu92a
         /n5IHLaZNg/FaAiLp2txpt4xDN8pEFN0N2rAKD21yvjeruc+b0xcXBcZZxhic9EthSP1
         qf/vitomanCLCxhlAv/SCaqA3kotzHFIlt/et1rAkka22bKhuLqmYU4U+86uc5R3v/ms
         YU8kzkrY8/nrbv6odTg5Lw1cb38J4UWsXSaF/pjcVK9y4jydaZFsdZqNzJx2VlUqFutW
         YhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0YC16QYuI26iSEqouzNHzLfNLNpzmf4/PF2cxJjI7Q=;
        b=1YPsARZitvjLQiWLqtdPY5OHtjOLLGqA3Wpph2duT6mvNH6tO1Yxlp5lmlefkguxEO
         u18UjIj1vmUdnCMGGRh/1OTJy3FZI24w9ACQYf8Ldut3NFnqT5aSwRyfmj0r3tMxtbkY
         BG64iQS9h8Wb7MeYKp4xZYp1J180rR4VTuoR0IxLyiwyH0l4delH4XTAb3qnBXdrHlOE
         fnfdrSJNJd+mjume86v+QzgKdVYWcL8tXjo46tpdqpnA/cD+W1aXiO7ZL2jyZhKxc2I7
         CDXBgvUK7k/16gdHTCasouivvqfMjvdS1N4sSxtYPCnMNYw1KP6CdTM2UTjaGT+NwjuZ
         pu7g==
X-Gm-Message-State: AO0yUKU6dROhpkpHPY3P6HZno+A02izttHoO4ns9N19vPWzXWx0Vxj4j
	o5V0WiMcdTuAf1FAcH6X0JRVkSKRL9ZhYNOO8iKIbA==
X-Google-Smtp-Source: AK7set8/mYXoiu5eIxRcs+qTRqBTTKumH8rtPOU9plQ5mcfgkNxDFjN5Ez9MuC1aaIEzMjTF2fNuDQ==
X-Received: by 2002:aa7:87cf:0:b0:593:b17e:ff89 with SMTP id i15-20020aa787cf000000b00593b17eff89mr3404359pfo.1.1675033216001;
        Sun, 29 Jan 2023 15:00:16 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h8-20020a056a00230800b0058e08796e98sm6009284pfh.196.2023.01.29.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 15:00:15 -0800 (PST)
Message-ID: <63d6fa7f.050a0220.e9ed4.99c6@mx.google.com>
Date: Sun, 29 Jan 2023 15:00:15 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.271-cip90
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.271-cip90)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 29 Jan 2023 23:00:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10501

cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.271-cip90)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.271-cip90/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.271-cip90
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      6cd0670e124d09e80f2daaf2ecb13922a603f30d =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63d6ec2040ba8a97cf915eec

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.271=
-cip90/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230120.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63d6ec2040ba8a97cf=
915ef8
        failing since 204 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-01-29T21:58:48.410011  <8>[   11.832017] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63d6ec2040ba8a97cf=
915ef9
        failing since 204 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-01-29T21:58:48.400298  <8>[   11.822220] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

