Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD6CEB64DA
	for <webhook@archiver.kernel.org>; Wed,  5 Jul 2023 10:56:35 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.14140.1688554587447150138
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 05 Jul 2023 03:56:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=SiT5whFH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1b80b343178so35819355ad.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 05 Jul 2023 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1688554586; x=1691146586;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaN3BfdgYY+vHbpWtn+xImYcRXvaD0YDEP5QdnlIEpM=;
        b=SiT5whFHjHAOBdk8ZEYdZvbIU9R2KIFn47xL0TnwS1icTGYJZNb+/vr+CmQAepNxcP
         7CsjOGvAulepiGlyk6tIu9TfWcUoazd5Q8M3GhUNwJ/TagoArA2//nlZlRcnre1ixf+L
         yjgPkGSiwtkMyrl93q7VSvUKD/bQWCoObrByd5PZs+xf+pwVJBsNOHJwiOEoxWisfQAi
         yulVM5BkNH55eDjKpLTwdEfFwvucZDqk0OvmCm5lpZ+dbMzT/LSz8EXosE75qCJyxoZa
         DEYApd4vrP9FicGUDSNWE1Zp49j8kVMjrdPFsAfGbGAqQDezPODDo3yga1ktZfxE+7Hg
         DzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688554586; x=1691146586;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaN3BfdgYY+vHbpWtn+xImYcRXvaD0YDEP5QdnlIEpM=;
        b=hcA9QMhQFP18Rqf6YtFFOS9lLoCgPeHlXn3FgLfTJTqPCKy84n713I3PASC5uskDhy
         ke0O2R8mpM3Te7lXVZHq4ZIiGnVlcG5TuM94Bn/upyH/SePpVC+9EFNOauyH/Ezfli5+
         fW74ABdiYcm+loo1bOsRpNXpbi6Osm33Lpyw7Xjk3LdAoZi2y0s1NYMbvp/IZcw/ZtCI
         eSMJbF1tBBnj8+pZ6V8O9fp5JdNcYtTNaXowGptuSSJ6NKst4DHrN/c+Frqfgf/SvAEb
         jPeZkqpcpVgE1l8ejzBTkYU0ooMet4+rsB4fKTl8gZddTAHqOC/lYnEz1jGlpqgJiWMC
         kzww==
X-Gm-Message-State: ABy/qLayy3+zFYWYoVWkl14i06VOnEf//+4+yZ0TQsF7O9rvfw8Qz0BS
	e/bN+7qVIIE1U6dA6Wh6q+tIdfi45ywfIFWo199p5w==
X-Google-Smtp-Source: APBJJlGykfIjJtRj1vHqEU0VoPKSQwXAiUKbcHe4EuMxmR2IF3oyLrjczaIpTYLOJqQO7voDDH8iZA==
X-Received: by 2002:a17:903:1210:b0:1b5:5192:fa15 with SMTP id l16-20020a170903121000b001b55192fa15mr14949402plh.20.1688554586408;
        Wed, 05 Jul 2023 03:56:26 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902b20c00b001a95f632340sm18728775plr.46.2023.07.05.03.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 03:56:25 -0700 (PDT)
Message-ID: <64a54c59.170a0220.141af.3aed@mx.google.com>
Date: Wed, 05 Jul 2023 03:56:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1430-g2fe294a51ca0
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st-rc
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 25 runs,
 2 regressions (v4.4-st20-1430-g2fe294a51ca0)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jul 2023 10:56:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12231

cip/linux-4.4.y-st-rc baseline-nfs: 25 runs, 2 regressions (v4.4-st20-1430-=
g2fe294a51ca0)

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
el/v4.4-st20-1430-g2fe294a51ca0/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1430-g2fe294a51ca0
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2fe294a51ca02b301704e4ab494c690d4b6342b1 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a543a62a9b4055b9bb2a87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1430-g2fe294a51ca0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1430-g2fe294a51ca0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64a543a62a9b4055b=
9bb2a88
        failing since 69 days (last pass: v4.4-st20-1097-g52d843097a439, fi=
rst fail: v4.4-st20-1186-g2516b357b2e3a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/64a54462cb847f8586bb2aad

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1430-g2fe294a51ca0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1430-g2fe294a51ca0/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/64a54462cb847f858=
6bb2aae
        failing since 176 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-799-g1229c813bcd9) =

 =20

