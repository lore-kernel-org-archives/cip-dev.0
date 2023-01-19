Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B3EC00A5A
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 05:01:08 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web11.38866.1674104459483590763
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 21:00:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=cNUxuBcN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.181, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f181.google.com with SMTP id v23so1279446plo.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 21:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aopH02sDx+6uBTHYvWkYpRlcDHvlgP11dhOMn/AMYS4=;
        b=cNUxuBcNWgirwN3VlMgpjZbPrVlTliKrDGzpDYewBOk8HgybKwAK6XmkpDwrOfoan7
         ru/ZoKRGnljEnwiX4L1aQY8sa8kLbCk516d7ZlwxBJjrSImAUKfSL6J6uuLL2bKomDHg
         sJlY8IuvJKzsZoNiAVYwitQXoCXn1IjCsdh7eeJbKTPF/p4upDVbtIPHHJWHYwYqPeKA
         zknyZ3kekGWO+ciOtga1XuYHzxeXdb+UWEI0EZrslNneTzjkvYn2XbGFodxTlWf8YvS7
         LO0CKh6FajSW4ZkjvHBtzrFOQQCLmgohMHPEej9z+4qb3MPACHAl06yJ+/PlFrcfgBuj
         58JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aopH02sDx+6uBTHYvWkYpRlcDHvlgP11dhOMn/AMYS4=;
        b=y4MjYtw7jH1DumPhg1sRnfEH+OmMNFjZImAYfESCMPIdg5fD5y4R5kH5LKNrf+n4rx
         EX1KiYTm6evJmrce0EhWBwbIfXQpA/ftyZMAeM/zs9JXwR8HVi9IVCem0ULQYYow5GU0
         NVsvs+JaE1PyGEPYOrQd6lUf1ZhvPKlc4l3XMb95sOly4v0WyMnU5NWfxTXwX+mTj84O
         GWsbUe/2xuotUQ8/DP4MqTBPWUUtZwnN7yIjRAWT3k4VxBz8+dalFECee2VEW7H4U5yi
         02Thojo6kzuWc8H7CsSSAUkvM9B8FTICOgNohxwR0jSoPze0DtuBD6Yfj15YPVXYrVr9
         dGkA==
X-Gm-Message-State: AFqh2kpaLg0xjGs/VlTIVS54X/Z0u0+DOknNy9xb5iADnJxFh/iE8rSr
	rRIwRUF0SiNVTAh/+j6v0jUwCsA2gVv+0nMADE2j8w==
X-Google-Smtp-Source: AMrXdXsQSDXKMXra0TXzWpiA/Bq5y6nIETn+fKA+gR/0R5M+LxEu6TbKzpJEf7OfzdOYC9/B9rNVmw==
X-Received: by 2002:a17:902:b213:b0:194:5c63:3638 with SMTP id t19-20020a170902b21300b001945c633638mr9521009plr.61.1674104458666;
        Wed, 18 Jan 2023 21:00:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001743ba85d39sm23989568plb.110.2023.01.18.21.00.58
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:00:58 -0800 (PST)
Message-ID: <63c8ce8a.170a0220.fe73d.7430@mx.google.com>
Date: Wed, 18 Jan 2023 21:00:58 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-cip88-rt28-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs,
 3 regressions (v4.19.269-cip88-rt28-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 05:01:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10429

cip-gitlab/ci/pavel/linux-test ltp-timers: 8 runs, 3 regressions (v4.19.269=
-cip88-rt28-rebase)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =

rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-cip88-rt28-rebase/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-cip88-rt28-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      09932a66d6b63564f8b94b34721b1f2d38ea9575

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b8b4db7519e05f915ee7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/63c8b8b4db7519e05f9=
15ee8
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
rk3399-gru-kevin       | arm64  | lab-collabora | gcc-10   | defconfig+arm6=
4-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/63c8b9ddf4fee8f41e915eb9

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/arm64/defconfig+arm64-chromebook/gcc-10/lab-co=
llabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c8b9ddf4f=
ee8f41e915ebe
        failing since 71 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/63c8b9ddf4f=
ee8f41e915ebe
        failing since 71 days (last pass: v5.10.147-cip18-11-ge6d27ea102c3b=
, first fail: v5.10.147-cip18-15-gef247a3cd0ad) =

 =20

