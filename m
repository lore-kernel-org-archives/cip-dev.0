Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6CEC38142
	for <webhook@archiver.kernel.org>; Tue, 31 Jan 2023 14:11:34 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.13196.1675174285899760269
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 31 Jan 2023 06:11:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=HoLT48qV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id 88so14295771pjo.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 31 Jan 2023 06:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MRSnC6y0VE34yeihYvh0IziwFEV8rcVm/HYQwaxRRDI=;
        b=HoLT48qVWCAAG/9TkukPW/kr8GbbWyTJSGhfXDCZgwm07qzexQX6KfKOwckDjFt3yX
         HkG9IdMR2WIvvmdSoEbokXNCk+FxE/YXgXBLiNLQOkRHxqmZNVCoHjfqYOShoCO0AhOn
         qNp8MEpXc8Vr7M5aRg503LquAbLV897pU0rGIcOjrKx3TWv3xr5kOFzvlHv/MQKR1Es6
         xEJmIftbBhAC1g8hgWjE/n2NdKIyn3OABIBaSy6NZA96u3dFUuaLz29zriCKqG4TJ5Ot
         3IFGXh2hzpZHaFkjaWWIHtSZrzfsHgtAwuExBJX1mhbOvd0rLw56ihhONB/2THJiisKm
         yIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRSnC6y0VE34yeihYvh0IziwFEV8rcVm/HYQwaxRRDI=;
        b=yZw7j3QMcna/f/JymXu8fKfnF7Qdr0efU6JrIfN6iDr/ia/IfBZqMxrIOHchzN6/pI
         PecUXzeHLCTxtDiqDT0eXk3tGb8hQXexRFJH/oyTG2Hz6gNllGRcN9ExpsB9Bq3Twf/9
         Z/S2Io9JBRbwPZzuNE1tr3y5UmMdb38xSDsp/rzTzauZWcgUMzwcDzmEnGnVHf6kpaxI
         Fg0gIiwXzFQivwMOnMoDF5PnvRVABlom89Z+B/IwGS0/Gn8VtRocRRANOGMmZJvgYcE2
         1XH1ubaQn5zXsjG39QCljfojtRHRejgFrX61Hi7uhLiszGbS/5N/fR/9B2I1tW+dK4K0
         +SAg==
X-Gm-Message-State: AO0yUKVoeFiAT4QL91mKp+A/A4IZWKpnQ9KahR06N2dkh8CkgRipOGeL
	cc0p/sLdyl7y4yUk0KxmpdnBtDicQFnwfTbTGnBG9A==
X-Google-Smtp-Source: AK7set+anNVZwaXcUTwQFRVuMIBicN111FJKVaOpSJlQXnxho4TSO5VSX9sG8HcF9FN3rKBYn3HatA==
X-Received: by 2002:a17:90b:4ac3:b0:22c:69b6:2be8 with SMTP id mh3-20020a17090b4ac300b0022c69b62be8mr12762087pjb.8.1675174285056;
        Tue, 31 Jan 2023 06:11:25 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p17-20020a17090adf9100b00218a7808ec9sm7399102pjv.8.2023.01.31.06.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:11:24 -0800 (PST)
Message-ID: <63d9218c.170a0220.4456e.c4e0@mx.google.com>
Date: Tue, 31 Jan 2023 06:11:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Kernel: v5.10.165-cip25
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-filesystems: 9 runs,
 1 regressions (v5.10.165-cip25)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Jan 2023 14:11:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10536

cip/linux-5.10.y-cip kselftest-filesystems: 9 runs, 1 regressions (v5.10.16=
5-cip25)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.165-cip25/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.165-cip25
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      52aae1dc6afe62fedb14c89fd4feca1d8bb13416 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/63d916ff01d8a5854c915ed1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope=
-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.165=
-cip25/arm64/defconfig/gcc-10/lab-cip/kselftest-filesystems-r8a774a1-hihope=
-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63d916ff=
01d8a5854c915ed2
        new failure (last pass: v5.10.162-cip24) =

 =20

