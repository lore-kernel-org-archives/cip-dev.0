Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C11C678D6
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 00:28:57 +0000 (UTC)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
 by mx.groups.io with SMTP id smtpd.web10.33965.1674088130117037300
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 16:28:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=HbgCdfjm;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.48, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f48.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so4214444pjg.4
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 16:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zAYubwxMHdfRtbaJOBQpX7mNGYafLld8i4xC7evUidg=;
        b=HbgCdfjm8EvItQEh3KqKD/fS+510dgdloxjcDLqKR9e/JA0SW3Gid3N7ZsYnktb/kz
         RDtGxFOz2sOEybubtEZ3m8uCsfcYYflfAbBSA7SY7OtTehBQ/qjtdCi+zkVipoO5c4IK
         BAkf7wUSOKDFLZMLIYXinI5vp46lpn2EQyseXNueKWfgPqgHrX4mKqnXZeC+TDXVtC7B
         Xq659CrYyZY6omI6ez+MKpSf51FXBSCSp8eE77IL8RDlyz9WqL4sJJeMi9tGr3l/001U
         0a3jy0aiRV04IcYXeaPeZ0ZmVlQh+hSmzhYATeWa0i1yEXgKmHbaBuBVqv2Y/tpqlNXV
         +1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAYubwxMHdfRtbaJOBQpX7mNGYafLld8i4xC7evUidg=;
        b=Lmwi5eHrgKeLImSYv+hnhfYUtZn8b+uGtVGyOJQd/ssFmInZXtSbEhYgH0fAathx0n
         BPJwCCBFH4ZCvuSUYyScZKqk8Xd21LZffWBVU1H+qtn7kGsnjDT/4jhlZv9NRjD4Aa7z
         UaSI0Ccg8innFfUkVQvzqUZXCitERQTsl80BQ/fTDXd0taRW/bqMMNiiU9mujCWIC0dx
         uYddkvurpwanuHYJ9ervhJXrPCPNyB3s6Afc0Kf8B6RYqvLcLl4lUxmcvHEeScFoJA86
         JJFZhSzp8iFMXS2h7O3/Gre01oyi0mCRvY1wCExmEM4bT9zK/RdHul6nyftyIXAZ5NbD
         kdXw==
X-Gm-Message-State: AFqh2kpvo9fWXUdfzxYkLmhbKy0FRuyX8UWdppQHygLK58qGby0q0Nnc
	uWn3jaVAbzN0gt4b3ZQBaP9SFaJpRCaIa9kU2lZemg==
X-Google-Smtp-Source: AMrXdXsNUm55LVPUFqIbIz2u2UQ9rvQAf2vWmZc9L7o0RpHiR78Gziv4eHXG8VUtM7T7SATlaXlHBg==
X-Received: by 2002:a17:90a:d802:b0:229:ade0:d0c8 with SMTP id a2-20020a17090ad80200b00229ade0d0c8mr7157139pjv.18.1674088129359;
        Wed, 18 Jan 2023 16:28:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a414100b002276ba8fb71sm1835947pjg.25.2023.01.18.16.28.48
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 16:28:49 -0800 (PST)
Message-ID: <63c88ec1.170a0220.e1dab.3725@mx.google.com>
Date: Wed, 18 Jan 2023 16:28:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-858-g4aae57dbf650
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test smc: 5 runs,
 1 regressions (v4.19.269-rt119-858-g4aae57dbf650)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 00:28:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10421

cip-gitlab/ci/pavel/linux-test smc: 5 runs, 1 regressions (v4.19.269-rt119-=
858-g4aae57dbf650)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-858-g4aae57dbf650/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-858-g4aae57dbf650
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4aae57dbf650bb88d187f251ebdbd3984020b619 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c88078143e6d0815915ec9

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/smc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-cip/smc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230114.0/arm64/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63c88078143e6d0815=
915ecf
        failing since 63 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v4.19.265-cip85-rt27)

    2023-01-18T23:27:44.363646  <8>[   18.978627] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =

 =20

