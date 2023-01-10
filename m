Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9F8C46467
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 07:56:54 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.98855.1673337410109207625
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 Jan 2023 23:56:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=3tOzsWdc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id jl4so12344990plb.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 Jan 2023 23:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2S+NdoTPO+E15S4sm+htUSV3BGVE3AXvTAKJacwMOHg=;
        b=3tOzsWdcOcYThZed8EPKKOgQlWh1By5ewc122NCnV0Xz/WJyk2nv3epsmy3u+4+0qF
         PkqHeS7rUvitjtuo9wAf0IRWJZvCpkw7JVH3G0CRWr/5k7s9Gj2sE+wE+UT5RnEOXbtL
         lHnFRlv3HzRYF6RuPu6DZuiBfmF5eHdb7yHHsw3KzGE8y6nCQXxQK4voNNUgNEcvhUDm
         EgjzmbxN0ddD/e977sXjuPNEqfLzjOn8gZrrLu2mBrwBWONEypXHxnEge2501RPJ8PWu
         Qdq/a3LGnM57adxvi1EbAsvNl9nnyc4WFUMJEoUHb0g7Dn6aQ1bqrnpx3d691EnSsSn7
         3kCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2S+NdoTPO+E15S4sm+htUSV3BGVE3AXvTAKJacwMOHg=;
        b=nLZMs2YXScDf2jDdcz31BVZ6V1+YzdDnXsTrTeoc4U7dQO28VI9e7PpXHS/LRpBbKK
         o3WoYWJinu4i5KxTkGEFL4XkJ5buYCbHHZHahUuvo7BaMFJ7tBRV9iBCI/lsjLASECvo
         n6bsLAZTJjwtqwkdj88Lq2KFFNVYDWJ9pSjMMULKiEztL3achtO9oTupQRw+jCSs0Q3r
         cP0XZsQfWAOn7iRkX96p6QN9R4NWUnzHKQ+9+z0wICjRfsEdJ+0yaDImMtGRAQe9qEH+
         jV+3MvybgR52Jkj+cAyWI67ucQ56sLYjotZYAw3vBxtCKscq8K7X5XrcLdM7bjwcZOzu
         +A7g==
X-Gm-Message-State: AFqh2kqXA4NDsCctKyIZ4Sa25UO8oNZvcEG34LOyXNN8JySAhZAYdXMB
	wh65sAR8eKmtMJC9UkYE0znP/sD8k+MPrrA6LNrglw==
X-Google-Smtp-Source: AMrXdXsCDz3Ifiulq/SNjX1Bqd2kTWI+E65pl+dS/crwu0p3LrSE0I0vkIO1vFFEr3YuIDJQNmuHDA==
X-Received: by 2002:a17:902:d355:b0:189:7e2f:d64c with SMTP id l21-20020a170902d35500b001897e2fd64cmr96745835plk.55.1673337409113;
        Mon, 09 Jan 2023 23:56:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090341c300b00192f4fbdeb5sm7437763ple.102.2023.01.09.23.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 23:56:48 -0800 (PST)
Message-ID: <63bd1a40.170a0220.2a724.b697@mx.google.com>
Date: Mon, 09 Jan 2023 23:56:48 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-799-g1229c813bcd9
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 14 runs,
 2 regressions (v4.4-st20-799-g1229c813bcd9)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Jan 2023 07:56:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10333

cip/linux-4.4.y-st-rc baseline-nfs: 14 runs, 2 regressions (v4.4-st20-799-g=
1229c813bcd9)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =

lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-799-g1229c813bcd9/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-799-g1229c813bcd9
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1229c813bcd90da9135b1ab2968110362be34bda =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-x360-14-G1-sona        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63bd0cbcbd844e910d1d39dd

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-799-g1229c813bcd9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-799-g1229c813bcd9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230109.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63bd0cbcbd844e910=
d1d39de
        new failure (last pass: v4.4-st20-234-g4e6ec7162c8e) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
lenovo-TPad-C13-Yoga-zork | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63bd0bab6397041b261d39e4

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-799-g1229c813bcd9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-799-g1229c813bcd9/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-colla=
bora/baseline-nfs-lenovo-TPad-C13-Yoga-zork.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230109.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/63bd0bab6397041b2=
61d39e5
        new failure (last pass: v4.4-st20-234-g4e6ec7162c8e) =

 =20

