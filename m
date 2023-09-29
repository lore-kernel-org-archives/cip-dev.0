Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF815E743D9
	for <webhook@archiver.kernel.org>; Fri, 29 Sep 2023 01:08:40 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.8436.1695949719746015355
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 28 Sep 2023 18:08:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=BrvE34Jb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1c5c91bec75so102646565ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 28 Sep 2023 18:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1695949718; x=1696554518; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ovmrfRDsB3glU9+CTfXMfiTuG1E1VPf4I6IK0hKh0dY=;
        b=BrvE34JbErnx5RhoZuHdQ104Luk8AbVj7/CJF+N6qu45/jFsu9gu2l9nHryR6d1uxe
         J7tg54NRokybRoqry/YLELwU+icCz5et8lDeG2O29slCp2YPKcisixJtRpwzuKEtfkG5
         AMdqlxtWjZvTl+O6/yS2CID5pWOylOM61waewERvFcf11Amj2hpcAVkTiJ2R+I1iv0S4
         Oja9lTupvhziNopffqZVAPjjdZJZKr/t5QHHd/SoBGYzDXCjNZvclZMOtK6/bgq6jLfa
         R3dB8UVhQ8ZT7/99C6UeMhETKN/2If0nVpsNWlbY9S+Aey91aeN4T/ggEncOa8cGYLr7
         fjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695949718; x=1696554518;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovmrfRDsB3glU9+CTfXMfiTuG1E1VPf4I6IK0hKh0dY=;
        b=mMulNVaSqGusJMyQnEWmBEIc2nN0hltorsHtg9u6VJJGBklwmiDVN4dKdNALEFhuwg
         x50n0TXqUd5mUrublHtph+KOmBqSXqjWjBvhEEOsBbfTDCnxrc6xa59cATREGi/Pa1ZM
         9njIY6z9QALoCpZkf60Gpz9dWdyzPXf3HhvJKIuJppKtvT0wycc+SOd4qrPSoiwKVy5o
         smTbBOpMcm3ate0DV5XLghYoUWe8N5cQ16HR0hWsHGYEmjJfPcq6riXaJOmdN9Pvzv7p
         0d+XPFHJwLVrVo5rLyopygN8VYNgTFzK7/DThIcVYNTGfKLixqGgYT+4zCFTJmke08Ec
         kCHw==
X-Gm-Message-State: AOJu0YwkaRX1ZCkKzdb6NIE7Kc/4JLq8bCIFBLEc+wZaUYvKTl3xPLro
	N8brvuxkSmhV8dvsWlqm3sBX1fPi14+5KYrCNDhF0A==
X-Google-Smtp-Source: AGHT+IFFcKqRYEpF3W437HyHWQnw0x4cdhoMQZUu+RUIXiw+kInJ4xerVAi1DpSsHo8LoXpVpvTgXw==
X-Received: by 2002:a17:902:c084:b0:1c6:349e:fa43 with SMTP id j4-20020a170902c08400b001c6349efa43mr2268943pld.67.1695949718461;
        Thu, 28 Sep 2023 18:08:38 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902cecc00b001c42d4b3675sm8125975plg.309.2023.09.28.18.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 18:08:37 -0700 (PDT)
Message-ID: <65162395.170a0220.fe008.c552@mx.google.com>
Date: Thu, 28 Sep 2023 18:08:37 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.295-cip103
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip smc: 5 runs, 2 regressions (v4.19.295-cip103)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Sep 2023 01:08:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13251

cip/linux-4.19.y-cip smc: 5 runs, 2 regressions (v4.19.295-cip103)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.295-cip103/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.295-cip103
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      f0bb9fab6f834f73d3a71af029f5bda19d99b33c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/65161434844ac73ca78a0a99

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-=
x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.295=
-cip103/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-=
x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/65161434844ac73ca7=
8a0aa5
        failing since 447 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-09-29T00:02:39.902695  <8>[   11.747267] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/65161434844ac73ca7=
8a0aa6
        failing since 447 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-09-29T00:02:39.892916  <8>[   11.737735] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

