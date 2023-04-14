Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D609DC77B6E
	for <webhook@archiver.kernel.org>; Fri, 14 Apr 2023 11:23:10 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.6875.1681471388216778130
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 14 Apr 2023 04:23:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=Mt7PCCdH;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id n17so2021856pln.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 14 Apr 2023 04:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1681471387; x=1684063387;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V4q4JQ30Cq0y5GhI2ieEt5EKyyw1fUtInOSZNfUNfAU=;
        b=Mt7PCCdHALMzd1Kw375k0Fh4QpeK1J5cuxRbTQa8izdjC5B9e3dWke5G5srC39foHl
         X7BTLZrB51DRZcmEJKeY7gJKX6BxDRlSWMusYXJgfY80tjp/owiW2eJFvipl3bguwv7O
         qRGZNPvvjJBVfLoYLQYY2RBbq+EKI72zc2uO+0vWFgQvSBu/3I/kd4c+SfdVJJcT9Qsf
         oPBuaIYjBJLh99/01rJqZW+XKznl/+brZIORZF/NorEdOOOkZa0IbmjbFw4lrcx/4A7+
         5BNwKCP6F+nNPlv4pB9R+fg6hIMFCB/Ea3MgNZnLSSKbpPqb3goAPao23G/rHAU5jfob
         xVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681471387; x=1684063387;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4q4JQ30Cq0y5GhI2ieEt5EKyyw1fUtInOSZNfUNfAU=;
        b=eGqwb1SQTzQw087AW+2BLiWVCZgy9Mc75lJ6uvBYu0qRDQL7Y1LA7qYxIYfPadqWOV
         gDW4bYg+SPUEiIMXrJDNycuz6gXRH4jo+Dr5+OQCOazEn371TTbegIeGOcGri5lmhtJQ
         ah5Tdq4UzGW/hivP1f1Eu06JMf9HoO/g8ycM1OiVZgtasUVhuEPvpc3A5Jj8KmNZNQZY
         htvKTqgETp5o71i5JqFN9xXog2730XPJowXVh2G49YwnEJmfLTS9CKQZkJnp/hfX7yY8
         inoXwbGtPJuvBr2wUmerVmBzxAfiux4iWvkTR7Ta/2MmS/zg6ObaepupeilZ6zEfs516
         dRfQ==
X-Gm-Message-State: AAQBX9dnB5sZWCyGSexcHDIfib7qpp14xRRPg1+bWm9lpb4CF+Cq2ReJ
	x7JVxtl0DWUcqHTPD82Nw7G1fOjbxSi8NdN0iLRDW6pz
X-Google-Smtp-Source: AKy350YWZuSQFkIyz8SPa9aLspaY3HsmzdCm9X5CUsKRhp+LkNm2bVObDgX+MGudt/NVqmIDlQXOxg==
X-Received: by 2002:a05:6a20:1a9c:b0:d3:5224:bbc2 with SMTP id ci28-20020a056a201a9c00b000d35224bbc2mr4958692pzb.42.1681471387242;
        Fri, 14 Apr 2023 04:23:07 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x15-20020a056a00270f00b00625e14d3a15sm2847919pfv.166.2023.04.14.04.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:23:06 -0700 (PDT)
Message-ID: <6439379a.050a0220.e027f.668f@mx.google.com>
Date: Fri, 14 Apr 2023 04:23:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.177-cip31
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 5 runs, 2 regressions (v5.10.177-cip31)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Apr 2023 11:23:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11217

cip/linux-5.10.y-cip smc: 5 runs, 2 regressions (v5.10.177-cip31)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.177-cip31/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.177-cip31
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      deb75c99ed78d677587a345854b8a00fb2cac68c =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64392e8af45872ca1a2e85e9

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.177=
-cip31/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230407.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64392e8af45872ca1a=
2e85f5
        failing since 284 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-04-14T10:44:06.443372  <8>[   17.518036] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64392e8af45872ca1a=
2e85f6
        failing since 284 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-04-14T10:44:06.429828  <8>[   17.504398] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

