Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4ECC4332F
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 08:49:22 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web09.1029.1668329348933450131
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Nov 2022 00:49:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Ws7I3fnX;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id s196so7847598pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Nov 2022 00:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BWgtBNjt1FSTKJEuuXxim4KW9haAPJLImFbOL2YGCSM=;
        b=Ws7I3fnXRuOvDEkXZ6xkaJe/ryZOZwwI+jvthiNP+A/6qevlfmg7FUBA6yN3U1xDwN
         4Mwa2P05V1y4+bA5EK44YDx15d6pdI4WV5AkLb4Gl5Hjn0nu1oTONSbg8k79UJy0Fiy9
         hJXe+5gfvH5NAuSoG7DFVYArl1DC60+sBDXi1LjH5uOgKMowyrURfLiJ7bRnKosnURUQ
         zFQ1avtngvizhZgwq5N5xhqPIq8nZ0Z/qKYaDazI9dDzizgYlPqlAJD+UjI6Ug3WJBYK
         +hEJtzOZap2ucPWZiNk17xJlp/Xx+2CzrJeL6+WpKoHWeo/HRXCJ1nTvyIztwvuuNiSb
         M/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWgtBNjt1FSTKJEuuXxim4KW9haAPJLImFbOL2YGCSM=;
        b=ukeOxpQtlBcok1GguxFM+90EHe2CJEODWqKCy9Zwo+wlyQHUfn8lT8Kd3ClNhGf0nI
         utjClfW8ZkTu3xwCF3gxUkPXJkv7gc0SnHkrCcEpIn6quTj9uoRsq4i0riFbCBchnK8G
         k+WbZKVAXrMesGHJKmrNYuf3eR/nFGwXFibGLSqnzHKx0751yhGDywCR7tgLJ1iX9PsY
         sxmb4GAU42roJ8f085ttxqeuLoX1braS8baNoiCl7Bhsi+QB254iOd6Co+kK9OPRYMkm
         WJHdqi8VBxlmYnryj2AzQ0/lrcP1CMFJn2e0eHEIErSUwqPaHFRvd/dcegSFqNI5riSv
         tsxQ==
X-Gm-Message-State: ANoB5pkZWNo2pWay+MTH+ui93SxUNEZAf3tqUfS4IikzXqpYQNzNrob/
	2nI0nywE6P2w8GKQHiUNN7zgkJXhyUzDuyXCp+E=
X-Google-Smtp-Source: AA0mqf6bFy5dAsZkddFWDJgKY+scpER3QlasJ6uBgMcR6N1gpJDEMpt0wn/CYgbfSIYWjaclN+yY6Q==
X-Received: by 2002:aa7:9706:0:b0:56b:9bf4:c1c4 with SMTP id a6-20020aa79706000000b0056b9bf4c1c4mr9641817pfg.67.1668329348168;
        Sun, 13 Nov 2022 00:49:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709027ed600b00187197c499asm4791731plb.164.2022.11.13.00.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 00:49:07 -0800 (PST)
Message-ID: <6370af83.170a0220.52349.6e58@mx.google.com>
Date: Sun, 13 Nov 2022 00:49:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.154-cip20
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 133 runs,
 1 regressions (v5.10.154-cip20)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Nov 2022 08:49:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10026

cip/linux-5.10.y-cip baseline: 133 runs, 1 regressions (v5.10.154-cip20)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.154-cip20/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.154-cip20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      efa0ded8f5c8a9e3835e4aea63caa6cffb0ccda8 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6370a769b464ce5a31e7db88

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora/baseline-rk339=
9-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/6370a769b464ce5a31e7dbaa
        failing since 228 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-11-13T08:14:11.484657  /lava-7961939/1/../bin/lava-test-case
    2022-11-13T08:14:11.495361  <8>[   34.006448] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

