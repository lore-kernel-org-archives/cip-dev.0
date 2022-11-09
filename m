Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384AFC433FE
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 22:07:24 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web08.200.1668031638263165923
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 14:07:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=xFTiUqvl;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.41, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f41.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so925pjd.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 14:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QzC6APVaVaYPpMLreLkTUtI3MX+Z6r3153gM54eocyg=;
        b=xFTiUqvlTwP+xoxj8K2cKiPTBKArKqk1VyWjHt3GYKwRXBGc2CXBxi53EyX4YvRpE+
         hrZ31QjCwpGlnCbaNA0oNq+3aEhiEtajD/t+Uf8iLPbhCx+1W5N8v1N/2j7U+74YoQ1e
         3PWjLO+M1n9meSkWO41Jq7uZ1TzDK6Lny31WOqZnIhBxRgTxixj4KJYpH6+LXezepmqo
         VbRV4mtqFXqLS4Py/IQtXw1RVf1UX4oDaR1pMcoEQc1FSKZOh3M/Yxf0My59Nefyk1ks
         Al3vKeJxdmN5IyiDuXV0Y3L/CHcgOlrZXu75LPdVcOBfXRYMVlkn+VQSbgYwbogsfjQf
         X+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzC6APVaVaYPpMLreLkTUtI3MX+Z6r3153gM54eocyg=;
        b=OiUTdqB8Ikhb2+tBIzsCtbvYOPZNRy+GtEEbggMOuj0ZGI4vrV458zjtVlNh/Gh1PM
         aHCkPUYlXWg2+kRDlbxAdtMf3vcT/FeCrizs4Uv45Z/jw206FBe+au92wNAj0bgtmyNt
         htAU8DNoGRMfWr5wD3o8YNRioyJ4Vv+YrWGL4pqtH9QInVvreKYdPo6FevhcEO7lRnA6
         IREwYNpoiYEm8OIAuTbw25CbCEY1J4RacoCdiWY5Qec7jwI3yG7wyYVVwQWa069Kbvq+
         Cr9HYr2PNQoX1WfYuxZo0F4gAjA/1Q5wFWJUUkd1ez6XFYFmCajn0IqZNno+dkPcV7yC
         QELQ==
X-Gm-Message-State: ACrzQf1FsWYW7aEdiXXXHUn2D2tiNsQw5plBuWMzZi8xx3zrWX2jXSkL
	Ug0voqKe+V6EbmyY7HrqF83v2g276aKX4dbbnyA=
X-Google-Smtp-Source: AMsMyM79IOR7dTRK1fDU/SKw+lR6mbKNrDH2fyGDlN6k+/y3HH8tqO9v8cI8Dvgx7hbSaW/auxfemA==
X-Received: by 2002:a17:90b:3b88:b0:213:1849:ea33 with SMTP id pc8-20020a17090b3b8800b002131849ea33mr82530177pjb.78.1668031637476;
        Wed, 09 Nov 2022 14:07:17 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090a7f8d00b002009db534d1sm1703233pjl.24.2022.11.09.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:07:17 -0800 (PST)
Message-ID: <636c2495.170a0220.3b8b1.30e3@mx.google.com>
Date: Wed, 09 Nov 2022 14:07:17 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-3-gc76f4e7e5c71
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip baseline: 118 runs,
 1 regressions (v5.10.153-cip19-3-gc76f4e7e5c71)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 22:07:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9969

cip/linux-5.10.y-cip baseline: 118 runs, 1 regressions (v5.10.153-cip19-3-g=
c76f4e7e5c71)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19-3-gc76f4e7e5c71/plan/baseline/

  Test:     baseline
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19-3-gc76f4e7e5c71
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c76f4e7e5c7160107c9b5d8ec188f61fe326cec3 =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/636c1eb6080fb59feae7db63

  Results:     90 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19-3-gc76f4e7e5c71/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabor=
a/baseline-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/arm64/rootfs.cpio.gz =



  * baseline.bootrr.rockchip-i2s1-probed: https://kernelci.org/test/case/id=
/636c1eb6080fb59feae7db85
        failing since 225 days (last pass: v5.10.83-cip1-178-g2cf1d12aab81,=
 first fail: v5.10.106-cip4)

    2022-11-09T21:41:55.781601  =

    2022-11-09T21:41:56.804637  /lava-7922571/1/../bin/lava-test-case
    2022-11-09T21:41:56.805186  =

    2022-11-09T21:41:56.815660  <8>[   33.696391] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3Drockchip-i2s1-probed RESULT=3Dfail>   =

 =20

