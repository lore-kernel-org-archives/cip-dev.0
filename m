Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F18EB64DC
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 13:47:46 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web11.13387.1689860858885777299
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 20 Jul 2023 06:47:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=wwoRGmrj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-55b1238cab4so403414a12.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 20 Jul 2023 06:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1689860858; x=1690465658;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ns5x+ecAhNxZIoAKLgjWrBCr93X5X0+l9PjhTJ9iiKw=;
        b=wwoRGmrjV73pRwiNOmXPVHuUh7csusU0TEy6kDa/P2PdDoRHpIujKcC6WAqycyGupr
         8MXRWSxfdrxivaBx2olNRWE5oNHSn8F67ysRnP/IfrNZw2BdzJkCxXnR5fwuBJCcwgnf
         H18nG8n44vuOrDCTWUMVY/UA+jOlf5RLFA0vat68nRDWDWkwZyVthA3TQX5NuhEfJoED
         vH26V8ukNHWhB2pURT+bvip+UDrR8dP+z7LvLvQi77LZU2F8eNc/w+D6gReT5vHOa7ud
         pBwwfZ4tblbQqsNpl51ctL6Ywl4fBT22IDyoRoQ6JbIthXwr/Z39BqWKqtQtSSVjof8K
         +G5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689860858; x=1690465658;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ns5x+ecAhNxZIoAKLgjWrBCr93X5X0+l9PjhTJ9iiKw=;
        b=eAMZWc8Q8A75tKO6qYj+Bbw8evR46Ha/QCSE5+mn8/ByaMuPMpB9fIvbnZ4VsTkqOW
         5FOZuVxzMtbZW1Sxum5/19TQWRiw3cZlSwtARBHmgEa6ErSlc0h7aNEk0wXPJ/jiktr3
         dSW6ldYElEqIwJ3u2WDEAkDqTml1JDAsibzVOYMmmEKJThwOZvGpwJJid6SnvB/2/YYI
         bvsLj+W6WPC+9rvJwYVzFrVkBBpiJwg5AbwSbNsqJSUI22JAoxv3z5VVaXx5X0mS6Fh7
         VJQMsO2JHzpwdpAFbGmj5P5czMsn9xoamFFSQvsoCuRidF0lJPTdVpjY2Bze2rdXZmau
         aR6A==
X-Gm-Message-State: ABy/qLamO67xV+960O9IC4p1WWdakO6RObWLcr8cLx8rw7f+geTm3NpS
	zDu7NnEaG0kznU4z4bhKNQHJdolH2nY17/xDZ9b6aw==
X-Google-Smtp-Source: APBJJlFR6kdxUje63iI/W6W5LgtHOOs6cHYpYDjUvXXGq9i/MRb4hoZ4IrmoLcUFldlKgsaly+l4rg==
X-Received: by 2002:a17:90b:1d81:b0:25d:eca9:1621 with SMTP id pf1-20020a17090b1d8100b0025deca91621mr1837815pjb.6.1689860857957;
        Thu, 20 Jul 2023 06:47:37 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id nk15-20020a17090b194f00b00262d6ac0140sm1038372pjb.9.2023.07.20.06.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 06:47:36 -0700 (PDT)
Message-ID: <64b93af8.170a0220.8deaf.17d3@mx.google.com>
Date: Thu, 20 Jul 2023 06:47:36 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.38-cip1-7-g5cff59cac977b
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip baseline-nfs: 17 runs,
 1 regressions (v6.1.38-cip1-7-g5cff59cac977b)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 13:47:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12470

cip/linux-6.1.y-cip baseline-nfs: 17 runs, 1 regressions (v6.1.38-cip1-7-g5=
cff59cac977b)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.38-cip1-7-g5cff59cac977b/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.38-cip1-7-g5cff59cac977b
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      5cff59cac977b1b5b2762b500623602540959ab1 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64b92e0289f834d3418acf76

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-7-g5cff59cac977b/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/bas=
eline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.38-ci=
p1-7-g5cff59cac977b/arm64/defconfig+arm64-chromebook/gcc-10/lab-broonie/bas=
eline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64b92e0289f834d34=
18acf77
        failing since 35 days (last pass: v6.1.31-46-g4cc1cc26e90f, first f=
ail: v6.1.31-53-g486caac40d06) =

 =20

