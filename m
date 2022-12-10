Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9D0C4332F
	for <webhook@archiver.kernel.org>; Sat, 10 Dec 2022 01:43:29 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.5520.1670636606481844446
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 09 Dec 2022 17:43:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=vs9+BgcL;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso9986531pjt.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 09 Dec 2022 17:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KsHNpNmZSOQbhlUoT1lyVyfF8nwDOYHsuSSk14v2s2E=;
        b=vs9+BgcLK06JVdmHOr0nTTN1emeHA2zm3DImmpV/8xUEDySd2TLaROUvTKG33Llspk
         PEXoTGfAH2TM0UJeyI/5I1GUuvdZwK5Anq50DYNU2ekd9UDIpG7XAlvGY1S5Ed0Zd+8+
         AXJYGTgV5tedC3nks3bt3hYiwbWJmFMG8YLK0hrmIQoJCmXN/J63scAM8DiMKudNzyT/
         bGPaTSEs1SKbIp6bA2zhKjUe2XozAa+TGCRIZDnLtJmv8VrBIduYieLw5YA5xuYccURj
         cDV/pKTTLvn88euvVYeqPiPACvoDEmk07zoZ8mE6xJvnVDBK7eeMbyntsPBV+4X0HPza
         vLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsHNpNmZSOQbhlUoT1lyVyfF8nwDOYHsuSSk14v2s2E=;
        b=PEH0b0OpUFmJvyW9eTRuobBPCDiCax042iZvX66gMGFXm2EcwaFwEu4yD+dMiPuVTW
         BdaUCcmsvx3mNJKAnpDd6nla9FkqcpdrMVXbKqV6JAU+Bqt8o4XqQmvqKoJQyGnan2at
         n/OjWZ4cMy4fcYqt6BPpPaEcXEAB+KMqxJeivaOxXm2X5xdB9MYwH7lsH0Jkwr7gs3Tv
         +TShCjDFo1kWliXzV5FEDoIin9Rc11HgZblN3wu80i/EIq7erECPekqwAm/Nb3ljM5/Y
         uAb8T6UNkIQAjlbZ0vvDglOF6+UrSn2X2w1d1sc0zrdjj0Nmo/wuyTMokvzQOhSahX5B
         bGHQ==
X-Gm-Message-State: ANoB5pnoeFNXPrOS3oMHBzZjZNIb+9S57N/8PhykXHRU1MiYP9np/dZQ
	u7vsVxi87XwMiR/xXULJAY7bw12CbWF6+fuGNzE=
X-Google-Smtp-Source: AA0mqf5jRhRNHReu1s24Q1j9ulOMici6fSwrdcxuBVOVbk7GRFVP/nYpX1eWnooFNVMOiL0DNIoYSg==
X-Received: by 2002:a17:902:f688:b0:189:77c1:b5ad with SMTP id l8-20020a170902f68800b0018977c1b5admr10425412plg.20.1670636605360;
        Fri, 09 Dec 2022 17:43:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id y17-20020a17090322d100b00188ef3ea2b6sm1898713plg.262.2022.12.09.17.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 17:43:24 -0800 (PST)
Message-ID: <6393e43c.170a0220.4afb5.4b6a@mx.google.com>
Date: Fri, 09 Dec 2022 17:43:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Kernel: v4.19.268-cip87
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip
Subject: cip/linux-4.19.y-cip baseline-nfs: 36 runs,
 2 regressions (v4.19.268-cip87)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 10 Dec 2022 01:43:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10181

cip/linux-4.19.y-cip baseline-nfs: 36 runs, 2 regressions (v4.19.268-cip87)

Regressions Summary
-------------------

platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
cubietruck            | arm   | lab-baylibre | gcc-10   | multi_v7_defconfi=
g | 1          =

meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
  | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.268-cip87/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.268-cip87
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      268e570d0a5691ceb479fa0368a6c73c5b080f89 =



Test Regressions
---------------- =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
cubietruck            | arm   | lab-baylibre | gcc-10   | multi_v7_defconfi=
g | 1          =


  Details:     https://kernelci.org/test/plan/id/6393d8ce8a00d990272abd03

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-cubietruck.t=
xt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/arm/multi_v7_defconfig/gcc-10/lab-baylibre/baseline-nfs-cubietruck.h=
tml
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221202.0/armhf/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6393d8ce8a00d9902=
72abd04
        new failure (last pass: v4.19.256-cip80) =

 =



platform              | arch  | lab          | compiler | defconfig        =
  | regressions
----------------------+-------+--------------+----------+------------------=
--+------------
meson-gxm-khadas-vim2 | arm64 | lab-baylibre | gcc-10   | defconfig        =
  | 1          =


  Details:     https://kernelci.org/test/plan/id/6393d8d5d198f1f3592abd1f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.268=
-cip87/arm64/defconfig/gcc-10/lab-baylibre/baseline-nfs-meson-gxm-khadas-vi=
m2.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
221202.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/6393d8d5d198f1f35=
92abd20
        new failure (last pass: v4.19.266-cip86) =

 =20

