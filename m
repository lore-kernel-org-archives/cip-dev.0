Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF48C3DA66
	for <webhook@archiver.kernel.org>; Tue, 22 Aug 2023 13:19:48 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
 by mx.groups.io with SMTP id smtpd.web11.7913.1692710382756498398
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 22 Aug 2023 06:19:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=vfj82+5Q;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.169, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-68a3cae6e1eso1785746b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 22 Aug 2023 06:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1692710381; x=1693315181;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZVVPDHIoZinWmRlrC5ri4j8cpeVHXr4A/6KpK3Nilw=;
        b=vfj82+5Q+PUQObXxNY+LqYHGzxgfcyrGJeWguAgQZZmqEvW0yLhwzapPLCKdGp/VzY
         9r4+F4M4Gfh4DW2fP/SUMO9Ph87ja8/PB/QtAPZFG7jAnMwj8N95ewSfCWG2rwf43MZo
         4SaibB98lZ7psHrKoVXC9e+hjqoq3syqM6ZsoZKCArybDLyvL/MBGAGp1pSxIuo5U0tK
         QS2esNp16dN0pv08k8bVkkrsiV72RAh6F6iQWOPRRvaHDUINfLhiae5zwAhRFNrKFo8y
         g/B6p5JtfqxlFeQkajhOFcEzTowDzsK9KMfPjpa0ZUohcwRmxYw2ZoUaN8jSIx7CaqLp
         XjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692710381; x=1693315181;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZVVPDHIoZinWmRlrC5ri4j8cpeVHXr4A/6KpK3Nilw=;
        b=Z3Zh+oUTvIEgIQ++/yx6OKxU0rPHE9RrOHtHlbAXFjiQJwVIHE8uthdV0FsOfjjVgO
         Uj7UeyBZdx409UKvIe7RQMPBI67ZIer0UEmlFHBV/FGFpofSN4e8vRLlg8zLn810v98U
         SZRQOGeLoZpDINxc0/beY1YMN8HSa5jUHXoy/6sI8bL9xnhH+/e7VBQuKwka5zpSCUPj
         bjlj947I+3K3EHx8ThvO3VYrEfLc3MA5d577CLRdM+vboMqF/NV4U1BXSL1vgEVuYEUu
         cy+D6MoYsMk+x9WRd6C8HpF36awNZXj6iI1AmL542BKGvhqt3BwsakA4Q4eK6oGlk0Nn
         iOxA==
X-Gm-Message-State: AOJu0YyRwQYCCOB3S74x750dAqNQfgM2OZDdi3k+/g/wJIPYoJvWJjE7
	2Gv2nVu3Z0bmp0zqEEQW3V7OkwfmEobgyl6vaaS0bg==
X-Google-Smtp-Source: AGHT+IGFvWZ+9O0y2buhT8rHadQrjvKeuNkolzg3Y9HohHdhCVu01ryyXM5a/bYTcg9d63WA9AtaLA==
X-Received: by 2002:a05:6a20:5509:b0:131:5f8b:9c7d with SMTP id ko9-20020a056a20550900b001315f8b9c7dmr6625389pzb.22.1692710381646;
        Tue, 22 Aug 2023 06:19:41 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id m16-20020aa79010000000b00687494a59bfsm7820366pfo.61.2023.08.22.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 06:19:38 -0700 (PDT)
Message-ID: <64e4b5ea.a70a0220.e7121.f3d2@mx.google.com>
Date: Tue, 22 Aug 2023 06:19:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.186-cip37-27-gd6d928db0a620
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
Subject: cip/linux-5.10.y-cip smc: 3 runs,
 2 regressions (v5.10.186-cip37-27-gd6d928db0a620)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Aug 2023 13:19:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12825

cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.186-cip37-27-gd6d928=
db0a620)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.186-cip37-27-gd6d928db0a620/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.186-cip37-27-gd6d928db0a620
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d6d928db0a620394e433833b5dda4ec7ac822999 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64e4a2a9d4988419e7b1e3b2

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.186=
-cip37-27-gd6d928db0a620/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-=
collabora/smc-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64e4a2a9d4988419e7=
b1e3be
        failing since 414 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-08-22T11:57:25.430923  <8>[   12.739679] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64e4a2a9d4988419e7=
b1e3bf
        failing since 414 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-08-22T11:57:25.417139  <8>[   12.726012] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

