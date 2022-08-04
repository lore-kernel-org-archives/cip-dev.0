Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C1DC3F6B0
	for <webhook@archiver.kernel.org>; Thu,  4 Aug 2022 05:30:53 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web08.1561.1659591043862999378
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:30:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112
 header.b=60Ib4vo3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172,
 mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id f192so8950960pfa.9
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 03 Aug 2022 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=Cy3A3RtyfyRmp1zDZyMdoDSw5GCfyaaaXL6cUnpmUTw=;
        b=60Ib4vo3q1thXy7cPgd/qRfwQhmGYB5+Sb7pMbRvJWK9MWc11y8AV0S/0HMB/ZPCXK
         zGjuPV2sc3aEdyctU8eUhlixUkatAcYla5nSn/jpKPe3XldSBb4veWQXatGwHiHj4N/9
         ee4zSlteeYJOxyORtacWo4m15rBKZRDSX/RiryMl8iR9MpPPhJBjb8Bmfgouk7JAi07+
         TWEzqGY52jViOH/KldRJ9GgNDN4byIP0+fNW9ail66kx2/Eu8f01O9Fb17uLrJKNH/bb
         xI6HKIySgNaERporGO58K22xugrhs1qYaaYy3nJmGFlUq2uhQJh7Wl3+SH7a3/6x2cDS
         bA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=Cy3A3RtyfyRmp1zDZyMdoDSw5GCfyaaaXL6cUnpmUTw=;
        b=WCorjbx8Phim6qfwCKudlLOaDbzGnrikkByH1TcsaFnvl5vfanpHQ+c59TPvxgxyLQ
         jHFwrNQEbe562fwPbug8kPGbPt7f9GZcnXTgAzb7N7Dljen5Z2WpVxYkPW7O1FkXdfeQ
         NBVcqZNaFR8+RL6K5vLzjDocwj+kQ5yr9c74rzW/JW1Ot84rz2r32W1ccZ9r12Q60VqT
         7Ip9RRCh0T4TE37Tox1JqdpIS51Xa29dRhxpw9fslfRryfiOhub0ndgvS82BsU3AZIeX
         L8/eYDpI9G0S4Ohcc6gWHmqjbtulN9+Aoe8/eDQN33ByZLlSZwgpcdL7tjt1WxXMtog5
         HoMg==
X-Gm-Message-State: ACgBeo0s30dAvqvdLizuOxxv19NmxlQbKkwpA3RwEOYj2tw4wcjkASSA
	LJgwKtrB/MFDkfETEiKqghK/hdDtVx5yDcSdUrE=
X-Google-Smtp-Source: 
 AA6agR4c103tQmOCFncs3PAGxPR4Se48oLMLsdZJHJZwUkwcS4Q13ZmWB+a7NyqR33YaMmIqIr1cmA==
X-Received: by 2002:a65:46c1:0:b0:41a:f5f9:b878 with SMTP id
 n1-20020a6546c1000000b0041af5f9b878mr267441pgr.497.1659591042871;
        Wed, 03 Aug 2022 22:30:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id
 s2-20020a17090a764200b001efa332d365sm64788pjl.33.2022.08.03.22.30.42
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 22:30:42 -0700 (PDT)
Message-ID: <62eb5982.170a0220.7ecd8.0137@mx.google.com>
Date: Wed, 03 Aug 2022 22:30:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.131-cip13-37-ge3a52725ce96e
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 5 runs,
 1 regressions (v5.10.131-cip13-37-ge3a52725ce96e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Aug 2022 05:30:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9111

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lib: 5 runs, 1 regress=
ions (v5.10.131-cip13-37-ge3a52725ce96e)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...ok=
+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.131-cip13-37-ge3a52725ce96e/plan/kselftes=
t-lib/

  Test:     kselftest-lib
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.131-cip13-37-ge3a52725ce96e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      e3a52725ce96e4794cc31e31ccd20914f40f19a3 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...ok=
+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/62eb4fbb61d0f12500daf075

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lib-hp-11A-G6-EE-grunt.=
txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.131-cip13-37-ge3a52725ce96e/x86_64/x86_64_defconfig+x86-=
chromebook+kselftest/gcc-10/lab-collabora/kselftest-lib-hp-11A-G6-EE-grunt.=
html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20220718.0/amd64/initrd.cpio.gz =



  * kselftest-lib.login: https://kernelci.org/test/case/id/62eb4fbb61d0f125=
00daf076
        new failure (last pass: v5.10.131-cip13-431-g420b8f43ddc46) =

 =20

