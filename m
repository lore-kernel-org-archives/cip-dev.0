Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B927C7EE2E
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 02:01:34 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.36434.1677290485377998369
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Feb 2023 18:01:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ok0NDDpb;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.44, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f44.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so1064225pjz.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Feb 2023 18:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SLiZoNC8dIA/OfXX7lF065m12SfIZOHbahAmK8MNGWM=;
        b=ok0NDDpbsAnyPRVPKkXz2aTJWmQvT4m0rTGDBP0KneOtONK4BZpAEgJzWSaIUf/9sC
         SzOYjHW7OV3LbGh8cMsRh/mf68WLqANhTSy5pMj3bImgnebfWjG5GS2C3Lczios11wZ6
         TJJobVcIjTQCjS811ADwaPpAT9BwRwck//4SOcJYWiHKOCzBGx1JRQPHLDLQDqj2IKzf
         6VEtuRvs5e6rvnp3TaqTwKMJY0h8mgwRDGkD4iLro7EB20OzOU49ziNwqRk8fEDfclK1
         catKZ/fQOUi7Q4ou6NoZSXJkOyfYy2wPz8vTD6xsGTZyK+OPYisffcWNWRjrICc9MJmP
         Fjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SLiZoNC8dIA/OfXX7lF065m12SfIZOHbahAmK8MNGWM=;
        b=tJ1b0DEPmo2W8HGVNV++120MAhRJXYUCDC66ISCA7taqxk6ASOefZYy4k3O1UeFcG4
         VZn2+aq4ghytKhCDPne0ykXXSXzaJS/nbcdt3s/0d6UUe7kLYr1pwTM9LiijKCyxQ36t
         B95E8LLK6Z3CTBks/rFzkwbnwEFg9ZrYe+owxZ2X58vhGYMBcuSJND4PcCdTzuB/a8Oo
         X0WTANQLyxuweIMYGBeNUnsdZ+vWOhczppEq4vvCg2h7FJJCnI5syOWT9CyydVRaWLCC
         EqaryHH9Efg+laXIUt5MIRcranR1P6AgdSM6JWA3Wj7+n8Xvmhe93Gj/BLmWTbbSptsm
         +AOQ==
X-Gm-Message-State: AO0yUKVPhXw06zYm2fQdLboNgucOZXLIB88ESOSaGeWZk7v4bV86JTga
	23JVE/hbzaf/FJXzqbvfuaCFMIF5IQC19BQdYHedsA==
X-Google-Smtp-Source: AK7set9osZi494RWqlx+owMqbWMuhOFmdp85O42tEiTFc7yx2XJi59yJKwBMlIkbCPDd206vkxj0pA==
X-Received: by 2002:a17:903:1208:b0:19a:eb93:6165 with SMTP id l8-20020a170903120800b0019aeb936165mr21145873plh.22.1677290484713;
        Fri, 24 Feb 2023 18:01:24 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iz10-20020a170902ef8a00b0019c901b35ecsm143400plb.106.2023.02.24.18.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:01:24 -0800 (PST)
Message-ID: <63f96bf4.170a0220.8c099.065e@mx.google.com>
Date: Fri, 24 Feb 2023 18:01:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.19.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v4.19.273-cip92
X-Kernelci-Report-Type: test
Subject: cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.273-cip92)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 02:01:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10840

cip/linux-4.19.y-cip smc: 4 runs, 2 regressions (v4.19.273-cip92)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.19.y-cip/kerne=
l/v4.19.273-cip92/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-4.19.y-cip
  Describe: v4.19.273-cip92
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      13b591404faff8a66449dfa80682930f5325b869 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/63f95eaead82c074988c8662

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.273=
-cip92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.19.y-cip/v4.19.273=
-cip92/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230217.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/63f95eaead82c07498=
8c866e
        failing since 231 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-02-25T01:04:35.805478  <8>[   11.165332] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/63f95eaead82c07498=
8c866f
        failing since 231 days (last pass: v4.19.249-cip76, first fail: v4.=
19.251-cip77)

    2023-02-25T01:04:35.795457  <8>[   11.155785] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

