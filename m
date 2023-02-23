Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F86EC64ED6
	for <webhook@archiver.kernel.org>; Thu, 23 Feb 2023 23:17:55 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.4801.1677194270894964278
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Feb 2023 15:17:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Guz7nQdJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.182, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f182.google.com with SMTP id bh1so14870058plb.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Feb 2023 15:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mxaoVefT6/Xox+v/l74x1/Y77YyLfHEg7pPF2u/aZlQ=;
        b=Guz7nQdJFva18nyi9NVPgYW+QlfUKKwtX1NMAN6FdRDvVDzD5l1abI8BSPOXyMrKrJ
         z7iAjGVFPvMz07TrGCcxHteDErs6rAHxXpDxeEs/iOMboRRPGNldIHJUgepklTJAB2mJ
         QhhlwkaT2ZyhCmh+NQM8OgjTwawvmhjEwjqLWSWkqK/WH0+TAYvEdTeadSYHWk39rHQT
         qYNiiaDWbUCrq7YLLMR5gAYf0mHBhcT2Kx57+ktcjY4W75COLEONQyMxcT7yq5VT0j2l
         qIXqkJI1WBuSgwYVjgJ+dgx620kSSVAmQGrL9wttAaqCU89UTIslad01Xf/EHQbwr5Kq
         AEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mxaoVefT6/Xox+v/l74x1/Y77YyLfHEg7pPF2u/aZlQ=;
        b=EJ9tLbnxqE+HJ0K/mdLh/VPznmM99CL0c2CkzdW0guAGlCUmOM01KDLmWJLr0t6R8K
         j0IfO9ICNlHFBKm1dCj7lMZV4sRBaUjlcxCPUHV4E8ve+mkBnXdRyxjmaMBlWqHdrk0L
         gYgQ/+5FQKveTXiOA0clWjcduhhDzvx1P+Iwgl29daDzSlmHtTWU7TxattrMWv/gueg6
         57uJJ9flSftITucYb0/kquKpA73Kl2dpYXZ4pq314/x9b2RDG0+dz0Jq3gAdMlfD1OF8
         DJn2GLP+5Q3kWd4aCXnlHIZpsAe1hq882QUwJrpLwqfoLJm4QXm+F8jWFa5OZIHFtfzk
         LBsA==
X-Gm-Message-State: AO0yUKVOj+776kK9ds6zUhwIX4rW27U2qJbMRfCGGeqzmLtT6rojDvyE
	nb1ldOatD4HawEtl/4xow9Xd2Ak/fGrV8d9SR/w=
X-Google-Smtp-Source: AK7set8bzIwle+HF2aGzkpAIVLBgP4OyJcIQHgwI45bYMClf+2ptB/vi6RimOnjuvlF7NfHp/bicwg==
X-Received: by 2002:a17:902:d2c2:b0:198:b284:c2ca with SMTP id n2-20020a170902d2c200b00198b284c2camr19658991plc.51.1677194270147;
        Thu, 23 Feb 2023 15:17:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id o2-20020a1709026b0200b00186a2dd3ffdsm3131645plk.15.2023.02.23.15.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:17:49 -0800 (PST)
Message-ID: <63f7f41d.170a0220.c07a1.6988@mx.google.com>
Date: Thu, 23 Feb 2023 15:17:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.167-cip26-2-g1e87e7748b91
X-Kernelci-Report-Type: test
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 5 runs,
 1 regressions (v5.10.167-cip26-2-g1e87e7748b91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Feb 2023 23:17:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10803

cip/linux-5.10.y-cip kselftest-seccomp: 5 runs, 1 regressions (v5.10.167-ci=
p26-2-g1e87e7748b91)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.167-cip26-2-g1e87e7748b91/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.167-cip26-2-g1e87e7748b91
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      1e87e7748b91cc6ec7f9f32d6d156ee15f651805 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63f7e39121d7885db28c8668

  Results:     87 PASS, 3 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.167=
-cip26-2-g1e87e7748b91/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc=
-10/lab-collabora/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/63f7e39121d7885db28c866a
        failing since 106 days (last pass: v5.10.153-cip19, first fail: v5.=
10.153-cip19-3-gc76f4e7e5c71) =

 =20

