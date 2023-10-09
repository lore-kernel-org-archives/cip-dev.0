Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8EACD611C
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 18:17:01 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
 by mx.groups.io with SMTP id smtpd.web11.70242.1696875418374380495
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 09 Oct 2023 11:16:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=H66+o5ve;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.175, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-694ed847889so3522387b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 09 Oct 2023 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1696875417; x=1697480217; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm3IKm0pO1gqisaIXhxm1E/iMc0sNyRK+3SgDkD7eDs=;
        b=H66+o5veDV/+LTbgXzojMVxzBXpTA0cwkbCxAiZbrnosmvcYaau6r1baXb465m40mf
         vHU2HP5rXF1l8RQX+UFTCO3otamRNcZARHQN5lGUuloHmbIWS9W5VpaS6bOuhzwuqVM3
         DV9KBQxg1tuIM1GmBW72NPzpQeFFL5zVXwi8KHaXNo9zhpBLDw32t5bsy1LCsB1dHUF7
         aivb9AVyTnOBppH8vQLnj+JkIzL7yohpCCUn01bGp5NervBIFJnfR0sC3iyA6bbz+QrO
         XpciwqUv4c7lfTfcmgz9sFkygHc86A5NDSeTPtFJi00Y/RDbtyQ9uVLwooQfbmFvLna+
         3Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875417; x=1697480217;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lm3IKm0pO1gqisaIXhxm1E/iMc0sNyRK+3SgDkD7eDs=;
        b=DeyOL9VZ3AXstSi05gseXMklJ+HpKxU+AhqtW/pJbZ1OXXZaucdb8N+hXhy9Z3eIW+
         +D5reLamsWnLXiPgKnMz/K3IwnpVyG5SnK4Wh7RM9Vfap0Ww8EAvuCZsPm4vATWC4kwg
         i2nkXxUlw1Jj03JQ/iMwFORT8aawhzefLbLGHCXHNNJrdjCyXihIXp9oyxw9h2VG18sZ
         nQ0IM0Smr1b0UDbeF8py5DlShXk8MzYJ1XTC12+pyfW3xZOWqBkzM7wCHxAMhpJ9AY9g
         +nxEzyDJq6qNLnsj2F6FwlvmA4FQIeaHRKsggyUCuQob99mqr7HDU1fHyUWN19GPYoAm
         zULw==
X-Gm-Message-State: AOJu0Yxjf2Vgk8Uqut7xZOSOYIWe9Y75GYyorc8SgLTej4qcNmTIobhJ
	xgouqsYuTPsoVP4+lGN+kMzD+qjQPeni5tJZFfNT+w==
X-Google-Smtp-Source: AGHT+IGbrFqrM02JXuoNfQk4gB04uIJdpTAE39oBBlGVGgzrsp4hHbIlTZQb8mj7oIL/s2VoEXbdFw==
X-Received: by 2002:a17:90a:fb83:b0:262:ded7:63d with SMTP id cp3-20020a17090afb8300b00262ded7063dmr13872533pjb.17.1696875417255;
        Mon, 09 Oct 2023 11:16:57 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id nv16-20020a17090b1b5000b00271c5811019sm8648518pjb.38.2023.10.09.11.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:16:56 -0700 (PDT)
Message-ID: <65244398.170a0220.6ad4a.5fdc@mx.google.com>
Date: Mon, 09 Oct 2023 11:16:56 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.4-st20-1778-gc774a35d86d2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
Subject: cip/linux-4.4.y-st-rc baseline-nfs: 27 runs,
 2 regressions (v4.4-st20-1778-gc774a35d86d2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 18:17:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13325

cip/linux-4.4.y-st-rc baseline-nfs: 27 runs, 2 regressions (v4.4-st20-1778-=
gc774a35d86d2)

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
el/v4.4-st20-1778-gc774a35d86d2/plan/baseline-nfs/

  Test:     baseline-nfs
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1778-gc774a35d86d2
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      c774a35d86d261f0d49d25d9a02dbaf95cfd288c =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65243f9228e238046defcef5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65243f9228e238046=
defcef6
        failing since 165 days (last pass: v4.4-st20-1097-g52d843097a439, f=
irst fail: v4.4-st20-1186-g2516b357b2e3a) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
hp-x360-14-G1-sona       | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65243eeabced71e4e2efcef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1778-gc774a35d86d2/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/baseline-nfs-hp-x360-14-G1-sona.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230623.0/amd64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/65243eeabced71e4e=
2efcef9
        failing since 272 days (last pass: v4.4-st20-234-g4e6ec7162c8e, fir=
st fail: v4.4-st20-799-g1229c813bcd9) =

 =20

