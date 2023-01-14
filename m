Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B293AC46467
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 03:30:29 +0000 (UTC)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web10.109136.1673667020778437505
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 13 Jan 2023 19:30:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cP1/3nw1;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.45, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f45.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so11130542pjl.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 13 Jan 2023 19:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=G04CDXV8dOpZCq9d7sLlgFv2nCNTCa9Wl7xHngRxA80=;
        b=cP1/3nw1T956+AQ+LhPPn+OWysEt3VB0cqbUX9EC9K+XJzBjuPJDQxPddXffArQwpV
         82dRcS5Z5Hbfj/7OuTk1F1dohfh10NzXauR5/hoN/2hJTcLswONF10YPbRIUICKNcEW+
         O5UKJycX4Fz7e67rzbr5PL5DKN30H0oiyYqA+7hPFa1WDV6fcOJ5Bktk7jx8hhlDxuW4
         tBofhS8ieI3woFCV0ttCXQmBZLAohH5BFjVGEqDffDwp+fZjtt5uWOecxWk+om1a2BuY
         6c5V22xZ/ZXjcWUAns0SRGj93fbNwak5Zfjc8uPUCK2luEcqkIyCeI8AU9Sw61+k4ZQ+
         KKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G04CDXV8dOpZCq9d7sLlgFv2nCNTCa9Wl7xHngRxA80=;
        b=a54DUBhanktk1LqC6fKbLukbeSpmud1bduxoKkjTUQlDBWPfWC7i/22T57rvXyqIu7
         uHy+V4fHTYepK/0ATvz2fHwWl8Mi2DimNqPYMfKj7+FKRM4szqiNL7Fi/VGxzBOOtzvO
         vZTAcgMIqzWRdRVzoGtswWkBWGrwocDIDi0CfrgSuWtifIb3Zuye+KBNNowHI3uyfzK0
         fG4P9UpE3CLrgslInv8H4UmRn6ChKKSvO8b9miOVthulaRXPW4Sk7ATVj/0PWs8eghWn
         qQ6VatkqcjK04XWwmnJbjR3QHvheUP6Q3SayGvOVTrrDi+226gPApKM+tcUuDohx15nq
         L5rw==
X-Gm-Message-State: AFqh2kpUcz5aj0dkLCUBziu7Qdy1dSyb4mI08ewutPCFJ/6QPqrt5jqm
	c1iw3VZQFjHov95POM5e1fdp+TXq+/RpcssQ4ws=
X-Google-Smtp-Source: AMrXdXv9nvvABTrjkIMRlgi5boR7uViNdPy96Gvcdp8QY576XvJ7tMYZfzj3iXu7ACAktPAvxOCVbA==
X-Received: by 2002:a17:903:134c:b0:192:b927:39d1 with SMTP id jl12-20020a170903134c00b00192b92739d1mr45832821plb.3.1673667020075;
        Fri, 13 Jan 2023 19:30:20 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id j3-20020a170902da8300b0018725c2fc46sm14747445plx.303.2023.01.13.19.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 19:30:19 -0800 (PST)
Message-ID: <63c221cb.170a0220.4f155.82c0@mx.google.com>
Date: Fri, 13 Jan 2023 19:30:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.162-cip24)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 03:30:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10359

cip/linux-5.10.y-cip smc: 4 runs, 2 regressions (v5.10.162-cip24)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.162-cip24/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.162-cip24
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      7ef5f1fda52a95426084959dac09acdb3c81327b =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63c20df63dca3765bf1d39f1

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.162=
-cip24/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230109.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63c20df63dca3765bf=
1d39fd
        failing since 193 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-01-14T02:05:33.900792  <8>[   12.418729] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63c20df63dca3765bf=
1d39fe
        failing since 193 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-01-14T02:05:33.886780  <8>[   12.405014] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

