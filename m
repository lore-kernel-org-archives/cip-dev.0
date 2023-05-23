Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA45C7EE29
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 01:46:26 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web10.11281.1684806384693519780
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 22 May 2023 18:46:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=jQOQZtCp;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so3071804b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 22 May 2023 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1684806384; x=1687398384;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RlqJctDRtq9+vblwTyD6VF3Qj7+RgAk8ZfWMvy67/NM=;
        b=jQOQZtCpi3eJZIBHAwPFgR3IFZC2KfK3ap/NCIZpnmKJLDC5u/y5WQwgznci7sc3+d
         KoyAvKB250N5KANIOsBJOQAEhFX6+vgorECUse+hkbsfvWw73Oi403W2yme+U6lo7aqb
         8BbtG9MX22pXK9CELEzGXCuBDd9rmclX/SpgnmHQe+03XkK2iTzV/wC8tSvf9eYtWL6M
         r4FocLijJhAudxEFBwgWPy1St2bSoquYynec44D94MaGd49SiJeALrn5jZUfHHscnzYP
         rSNir5G/thiolXtBw3VGuZ8fqUm+r642yYvqaJADPiNUh6Oy65tjWBuoLRIkrYPtQG/k
         ccpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684806384; x=1687398384;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RlqJctDRtq9+vblwTyD6VF3Qj7+RgAk8ZfWMvy67/NM=;
        b=ImJVTIeJkpxAFXP3MtY/V1hwp+EFzCb/vO9D0qkHSORFXKuZXnDWWvlKG3GCwaQq8F
         PECeqgHhuo4PydmUxtvxRPonvuGrVg8e7jYKrkGhih4WjB5r3igFy3rbpYvqhw2an1jl
         Cg3kpxbjsSsTZk+7pMd9V2e+XEGxcOLrg8lItIRpW26+LYcXfnk7EHoldsM/FB532IxV
         1eEI2ad3N1bQ/1w9Tq60DVtSOS1c0tTZbN3MOi0yv4bM0HPBfw18iAkzZAZWnZHF0cOa
         tg/UX2nQub0HihK2wAnWDgJCcRfeMLwwPjdv90MeiC1V6B/miRxW+2YyNAIGx5v5Hbv/
         hN5Q==
X-Gm-Message-State: AC+VfDyOjvv1dlGNZUjzaacWjk/oMP4dITWVkCBn0Dr2DeEfULyKwOfJ
	lRWcE8+GtH9k17atrqGy9rzb6qNioeffl9qiNemqBw==
X-Google-Smtp-Source: ACHHUZ5HXdBzp1GjGOQyKclNHp5uzQAcA5KLhSC5WKUaknPfEGj4srS/rFDSf8Fw2HpNcDJo7crD0g==
X-Received: by 2002:a05:6a00:2302:b0:64d:4188:ae86 with SMTP id h2-20020a056a00230200b0064d4188ae86mr14042953pfh.6.1684806383865;
        Mon, 22 May 2023 18:46:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b005d22639b577sm3443743pfh.165.2023.05.22.18.46.23
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 18:46:23 -0700 (PDT)
Message-ID: <646c1aef.620a0220.5f89c.67b3@mx.google.com>
Date: Mon, 22 May 2023 18:46:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.280-cip95-rt30
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs,
 1 regressions (v4.19.280-cip95-rt30)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 01:46:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11598

cip-gitlab/ci/pavel/linux-test kselftest-futex: 9 runs, 1 regressions (v4.1=
9.280-cip95-rt30)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.280-cip95-rt30/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.280-cip95-rt30
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcee20e65677ab5d0e0d47c572f2c71dae6074a1 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/646c0b9edf646a06532e8611

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-futex-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.280-cip95-rt30/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/kselftest-futex-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230512.0/amd64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/646c0b9edf646a=
06532e8612
        new failure (last pass: v5.10.180-cip33-11-gfea7994097935) =

 =20

