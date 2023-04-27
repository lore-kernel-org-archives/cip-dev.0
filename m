Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312F8C77B7C
	for <webhook@archiver.kernel.org>; Thu, 27 Apr 2023 10:18:32 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.web11.16723.1682590704705663114
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 27 Apr 2023 03:18:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=lckMPEoD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.171, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-51f597c975fso8278021a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 27 Apr 2023 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1682590704; x=1685182704;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8XmXFjmEUxwmYvl3cQzI8gzb8wdbbWYkzXMafenGXUw=;
        b=lckMPEoDd21tIe1auaVuM+I6howz7sCGhuWe8K2aeNFTjFu/KqkFLyM0ym6DwD0gAq
         oqtu92Iqm0cQ8aAfrnWOHdPL1YOeSfIKNphCRX6atd51OqqUORBiJ6rLZ89NGJzh81Q7
         hhw4/shuwEvCvrOOWw1JtrNLfZ5JeuHKSOLnJJo75FKxQ3Gl4dMoNi9GyJdwYanbRB1S
         U2H9G7AD/Qa5RM4aYWP8LlwqfNkGOvWERESmwEFTsU9BoRB0p/XLHC5vqKtf6feh8K8Q
         P6g201cuPl0oqOL0Ud3/caTFAA/sAzwvaDmJNbbXIBaaklJg0In4jvxwdl+hdBtVn1e1
         eWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682590704; x=1685182704;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XmXFjmEUxwmYvl3cQzI8gzb8wdbbWYkzXMafenGXUw=;
        b=cNWCVkBEV9et0hae2N7xuprYbSwlKGjvU4PDfSbD3Q6WuSwCTTqMNMRfv/7In6qeKH
         46MSkisNTey8ToeIL7Aw5MV8+dvTYM5bCCpX3lsSDg8CZ7x7HTKrtkbaGYB7Vh09RcF0
         ihEVYzU3IW/3+Gb94b7nJ88hBgs96YmTCPF9PqHGWBR3E2SWF5e9gU3ByWRwI9znpl3q
         yxHMCDe40X4fy6eWEwmH/HmRZGD9QPMHAS8Uuc3UJL6oYAQA7LFN6F3iyRVPoSC22NzL
         F2hTL9uUvtc2la0q486aMzIdExtB+PsnPUflqqzatGh5lKbEnHUgLswx6qwua3N/HEig
         sPIQ==
X-Gm-Message-State: AC+VfDzZJ8NT1zSPEToh9+z0bzrEgrnsETfeO+oLfl7wtRdGhLFdGk7c
	nHB/7+V6RJJTprIRJMDdJ0HKQtguA1Ca/YFt7fKwng==
X-Google-Smtp-Source: ACHHUZ7LrDdUyqlQ39BHzIQ8n/HRgf7N5fjVswEiaDEE8dHAZmj/j1JykZ0mxVFj6oKls8K3IkEEgw==
X-Received: by 2002:a17:903:5cd:b0:1a6:3799:ec2a with SMTP id kf13-20020a17090305cd00b001a63799ec2amr897795plb.35.1682590703812;
        Thu, 27 Apr 2023 03:18:23 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b00198f36a8941sm11350423plg.221.2023.04.27.03.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 03:18:23 -0700 (PDT)
Message-ID: <644a4bef.170a0220.35bb5.7128@mx.google.com>
Date: Thu, 27 Apr 2023 03:18:23 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y-st-rc
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.4-st20-1186-g2516b357b2e3a
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rc ltp-timers: 6 runs,
 1 regressions (v4.4-st20-1186-g2516b357b2e3a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Apr 2023 10:18:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11367

cip/linux-4.4.y-st-rc ltp-timers: 6 runs, 1 regressions (v4.4-st20-1186-g25=
16b357b2e3a)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rc/kern=
el/v4.4-st20-1186-g2516b357b2e3a/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-4.4.y-st-rc
  Describe: v4.4-st20-1186-g2516b357b2e3a
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2516b357b2e3a612ef2904362b0acbb97746d0a1

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  458f3554675aace42e9750086d26799e82829f11 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/644a3d38cc27cbeb0f2e85eb

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rc/v4.4-st2=
0-1186-g2516b357b2e3a/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230414.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/644a3d38cc27cbeb0f2=
e85ec
        failing since 23 days (last pass: v4.4-st20-1097-gd51b0e04681f, fir=
st fail: v4.4-st20-1097-g52d843097a439) =

 =20

