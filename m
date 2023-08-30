Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4938C83F14
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 13:11:32 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web10.13520.1693401084891934039
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 30 Aug 2023 06:11:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=I1kLKwM1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1bf1935f6c2so6299815ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 30 Aug 2023 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693401084; x=1694005884; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9sLlp1d08jy00uQ1AbtsvNuBTqXDAXtl37dANeCiQso=;
        b=I1kLKwM1L7bUY0WQ0+sQHeBFeS65z/bZOkI9cu2umCzqUXr7hKJLJuu/9rnUevyMPK
         QO5BBi8b88MiQBWU3oAv8/GnhmpSbFJepfLfWbEFdXa/J7n5gSraIPdumXOftq4tpfGc
         dhs2yEao+zOH+ud6Hy9L2rlpbXEobAO1h5WN9wlrq9C9ZyYZ4OTZuAJ8+Kmc8SxfaN1E
         +zIjkDyqTGk6U3zgHXxJtTSG6l5/UCPN8V9cSKhqziywULW7AL5CdH80mIqM0bDcLO++
         Blzt3qr6J5Jk1Yy0iHv2Dfe9YqxrSxRFFYgfLOLQrrOtQpqsU5A3VVOglCXW4TY/fhpZ
         6fDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401084; x=1694005884;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sLlp1d08jy00uQ1AbtsvNuBTqXDAXtl37dANeCiQso=;
        b=F8pX3EmY9ZPCVS/iwl8HVXMNbgmu01XnJzbhIHumOHvruVMtftB17TcbnPbMipYuDw
         HIffodXu8p6a3zMe1UCYyD44nccOCKWDAZ96d9ym+9jfoW5WK7r4pj0gyhkuej47Zr/n
         D1beB6/XbciGS+rSG1f4vZP6kiQWfnebgXuZk8vpBlfV6xtYbx5l6pJvDhEUoaPIaYwJ
         xMHXcWZcOvK8lr9auhBr+cvCSHoTTMQHIfIC7QWCW7845G70YVzTFaTTCom3D/PdKe6J
         59jZWxTJy7EG7SHrxJaOUswGLKtaONmyUWA+pgrC/R310Lvd0ijD4HMMpSJTSfPT8kzf
         y1tQ==
X-Gm-Message-State: AOJu0YyP5CUTTPqSreDxkZBFPGwQD4OXkayJiQZxu4ZoJ8J2GwkgnpDl
	Txau0x31dut1fuMdJ5wGqfc5s2BuyBv3xbaCGx0=
X-Google-Smtp-Source: AGHT+IHyDGYaaXFDIsh6T3pojVJD8OB7IT6Afq7hE/D8OGaYSEbrNHhR8MgCFu5N5SMIuidZ7NebAA==
X-Received: by 2002:a17:902:e74b:b0:1c1:f3f7:50bc with SMTP id p11-20020a170902e74b00b001c1f3f750bcmr8239253plf.26.1693401083826;
        Wed, 30 Aug 2023 06:11:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id jk17-20020a170903331100b001bdf046ed71sm11095459plb.120.2023.08.30.06.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:11:23 -0700 (PDT)
Message-ID: <64ef3ffb.170a0220.36122.3898@mx.google.com>
Date: Wed, 30 Aug 2023 06:11:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.4-st20-1637-g085b4ca13c9a
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 13 runs,
 2 regressions (v4.4-st20-1637-g085b4ca13c9a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 13:11:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12915

cip/linux-4.4.y-st-rc baseline-nfs: 13 runs, 2 regressions (v4.4-st20-1637-=
g085b4ca13c9a)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1637-g085b4ca13c9a/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1637-g085b4ca13c9a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      085b4ca13c9a7366e74b9092b247fe8a3723ccf9 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef394726a1da0162286d9e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1637-g085b4ca13c9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1637-g085b4ca13c9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ef394726a1da016=
2286d9f
        failing since 125 days (last pass: v4.4-st20-1097-g52d843097a439, f=
irst fail: v4.4-st20-1186-g2516b357b2e3a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64ef3a4436d96c0376286d7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1637-g085b4ca13c9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1637-g085b4ca13c9a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64ef3a4436d96c037=
6286d7b
        failing since 232 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-799-g1229c813bcd9) =

 =20

