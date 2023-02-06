Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0D2C636D3
	for <webhook@archiver.kernel.org>; Mon,  6 Feb 2023 16:26:25 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.57866.1675700783232859220
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 06 Feb 2023 08:26:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XfHC0kFR;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.178, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f178.google.com with SMTP id t17so8813401pfj.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 06 Feb 2023 08:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KuUscVmIzzuKhp34AgnJNDwTSrGaeLW2i5oXUqp74Uc=;
        b=XfHC0kFRYoY/p2DMCz6R5B/2OQrgXj+HH/FcaWOCxkJsPxZrrRNTf5QVfC0EAKg8Rn
         yMNbnfcBYtfOxrNROfJvRcSSsjwZ/OJwhnELeLsAyscyuYYm4Q4vD9XHIJYr3XMqdYBZ
         Pu1PqW2Ltuqh+5OIFP/h3+DapfMi4OlFNppyzZw0qtMKL/RBA5nKAhI/J4887L0Sbdxp
         J5GPR+s2tWH7hs2PHYHA4LCFZ0YKKt0gN+maU6SKp1sc35WhkW20K4f1I21tOT+dcUNL
         FdJ+a+642o7AOe9h/DnJDbWjklyxHs8kinuyrFHinbCiL1BDcOhXLO3yBZ99XMEi2B73
         T7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuUscVmIzzuKhp34AgnJNDwTSrGaeLW2i5oXUqp74Uc=;
        b=NNHcYzBuCft/WZqNweFOp3yWWr7Ok+BGKPtjwGyC/UUpUKRjMkY9GnYzAW/1LXiluI
         H51BeIAVNXX9/yY3iap6ycwHxiM2PguSSjA1eXzLb2Qdjl6tllog3xYln2e+rY+ufXoi
         AqT3SZ1886+OISyKcg1z0eal/gG3grCTXOr+SwOiChVwII93uQYmHwf7lYK5Hn8ory15
         b4CvZ3Qej67Vt9mBDIKEWHUrF3cogEZnGA/uZp0S3/1u4cT+ht97T97hoAWdjRX1YU3P
         /0gsRGe0/1nkZzMWGlLCpx7dPHQ2jwyGmZ62MPPQiJla8DVOMH3JOOjqJZxGrCofmP/W
         4ZLw==
X-Gm-Message-State: AO0yUKW/80HQgRDyn2AswsCZxcR2EXJ67YxNW2oeYO2rOcZ2sIxihZ8s
	U1naTPGEIkELEXtTZ0WN2pj3iLBRBScow8AGrkM=
X-Google-Smtp-Source: AK7set8yZq/U2kYtm9loW8WOl4kX+p6cGQXlRdNaccACjBNRvtn6WNZWlK/azaHZqw2DTU5IrgiJ6w==
X-Received: by 2002:a05:6a00:d75:b0:593:b0f7:873d with SMTP id n53-20020a056a000d7500b00593b0f7873dmr19256752pfv.19.1675700782476;
        Mon, 06 Feb 2023 08:26:22 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id d3-20020aa797a3000000b0058d8f23af26sm7300550pfq.157.2023.02.06.08.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:26:22 -0800 (PST)
Message-ID: <63e12a2e.a70a0220.bfe6c.ba62@mx.google.com>
Date: Mon, 06 Feb 2023 08:26:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-4.4.y-st-rt
X-Kernelci-Kernel: v4.4-st20-1684-gd04aea87b5a3
X-Kernelci-Report-Type: test
Subject: cip/linux-4.4.y-st-rt kselftest-filesystems: 3 runs,
 1 regressions (v4.4-st20-1684-gd04aea87b5a3)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Feb 2023 16:26:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10609

cip/linux-4.4.y-st-rt kselftest-filesystems: 3 runs, 1 regressions (v4.4-st=
20-1684-gd04aea87b5a3)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-4.4.y-st-rt/kern=
el/v4.4-st20-1684-gd04aea87b5a3/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-4.4.y-st-rt
  Describe: v4.4-st20-1684-gd04aea87b5a3
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      d04aea87b5a38240295bdea964c5d442c69525dd =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63e12323d4027b9a60915f4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-4.4.y-st-rt/v4.4-st2=
0-1684-gd04aea87b5a3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip/linux-4.4.y-st-rt/v4.4-st2=
0-1684-gd04aea87b5a3/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-coll=
abora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230127.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63e12323=
d4027b9a60915f50
        new failure (last pass: v4.4-st20-1094-gf7138ca4b303) =

 =20

