Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A416C677F1
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 00:28:47 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
 by mx.groups.io with SMTP id smtpd.web11.34323.1674088126326413641
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 16:28:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=v7psWX7Z;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.177, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f177.google.com with SMTP id jl3so761692plb.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 16:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=25P5lHOTZkrrtuZpzUsOn+ZigLiBNOicj/GV7nKjmss=;
        b=v7psWX7ZB3ZRv04aRm7KkFJXknRmrhzqzM8F7426Bx4sg+s/I+NHx+MHNyDN/QdgCm
         5cxiL0b2gDr1DpWPNla3ino4N/aoR+Jb95lRdl1Rxfh1qeLqmFzbTcT40ULeKMzXWhdj
         Vg3a+qICdqizy9TzCI0eUt5PkDEQXZLJ0ufHb02bqPCWb0TbsXe4ql9MKDUCrJWjPDL6
         Hmp42a3zl7EUfoPQ8NgjykEPSkV8YHWgWT8wW4JireFluHxxdkjhH0CXDRLNlcXB6KMY
         1gl1B5gwD5+gdIW+OB+ovl90+eDAlOa4ArTTn8Em93XOrndpZPfha9i3l6a9E2R8XQSp
         1+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=25P5lHOTZkrrtuZpzUsOn+ZigLiBNOicj/GV7nKjmss=;
        b=HKmejeWegsHGUzNoH613RtaJaX0Jx5FldZ4N5QGB07/+jEizDCocdwiSBzU5qC/3eq
         88c2BWYdBZKFCffsUTnStFm2PiTLsEp6WFyXP5r2ou8B4jSsNrjQq7S3+j4PVeDqS5Qm
         1FBLYJ0vFJ0uYFHZBchvvCgB5Fags81/1h5MB7Fq1ljeuvJ13x2dRfXSTGpSi75z01/E
         r5rhDUJO29jzvECJ1RHGz+med2biVsAByCJzUWX5n5MkHCJ2rNxpj22S9Ow8wxc4Qwgx
         BGys2cRcfZpWNDADOB582Oijx2M6IlW4FBR4I6K5VCT8t9bgLzhqbvBlYU7G4jkpmzmz
         1ONg==
X-Gm-Message-State: AFqh2krF5VNKFv6gN9Nw8C8oQclAf4ukG4HbgLSyWlZFJSgkbLpMvubu
	tsSea9280um+BusM3psr1XpDnv3lgBkNt1XEAwQR7Q==
X-Google-Smtp-Source: AMrXdXt2AgEQXXukO5nbGD71oDW3ZuIetgCiYWbaKBGwwcFK0BYeA3BD/fVr5+3Td33DA1cq+pnMTg==
X-Received: by 2002:a17:90a:e395:b0:229:dfa1:45b1 with SMTP id b21-20020a17090ae39500b00229dfa145b1mr1388064pjz.42.1674088125467;
        Wed, 18 Jan 2023 16:28:45 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090a280f00b0020b2082e0acsm1892493pjd.0.2023.01.18.16.28.45
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 16:28:45 -0800 (PST)
Message-ID: <63c88ebd.170a0220.378f9.363b@mx.google.com>
Date: Wed, 18 Jan 2023 16:28:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-rt119-858-g4aae57dbf650
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 6 runs,
 1 regressions (v4.19.269-rt119-858-g4aae57dbf650)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 00:28:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10416

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 6 runs, 1 regressions=
 (v4.19.269-rt119-858-g4aae57dbf650)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-rt119-858-g4aae57dbf650/plan/kselftest-filesystem=
s/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-rt119-858-g4aae57dbf650
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      4aae57dbf650bb88d187f251ebdbd3984020b619 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c87bf75b0061534b915eed

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-rt119-858-g4aae57dbf650/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230114.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63c87bf7=
5b0061534b915eee
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =20

