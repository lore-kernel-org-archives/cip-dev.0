Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADFFC38142
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 05:00:58 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web11.38864.1674104456309289072
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 18 Jan 2023 21:00:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=j7sr1Emq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id s67so622942pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 18 Jan 2023 21:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rISm26PuDmXwdSFDH7b4QtBf/utoPitTWXOUZAncWgk=;
        b=j7sr1EmqoS/ht9sg85S0kRJ19i9MJ7g+ACzCpXLa1QbA3Ho8QFZoTcIyYoa6dXHbVS
         qQ1PgtJusKBlk2cSgDqpcP4QY7PxMTWFGO18yvFvjI38ZQ3A/3+wXmRMDyzI7o56MMjj
         6Xjvx0zeodp/taegbcgEiAdXJOGKlw66Gld5aezlIQ6GQdFvnzpongu9AeB5aF1TwUrY
         dZn+ZhbnFPSCh0HYPpao4fCzRRB16zrecVgUjygiZ9EsaigRhU9mpXCZBD1NSZK2vMJU
         6OjLdhxnxR8FKlSzKzwDev43VElBntztRt5vgriD749KTAAjaWyERVvMtniisOqAwIUW
         rv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rISm26PuDmXwdSFDH7b4QtBf/utoPitTWXOUZAncWgk=;
        b=GXOrPE4mTQ+bSQhs1wlbyylPluSOtIBLstSH0Vr44Ts+v/qqNqIk5b4oocwn8EXy5R
         2p9gDXFyX0DMs3EQnvqM9HrjivJuqNXyy8ZcuUaRCvGf+6hj7zL5HGX70E4S4iq8orLr
         Bp6jDRHbYkAyYsAemeq9TyQGImGQwhK9ocsyywfW0IIEb7tfOGSGJuEcjWaqjYyMo1g3
         xC+CqhWq95b9nh5mu6I8Ukv6FYg4x0smlMQfZtfUxRQAnIFXE2U0Y4jUSbIcRUEryQEC
         5rTyB2Oi3a09xC1EWGprn3LXwLy2h+/InZVniGrDLmUlAm04SIr8QrGgF7GWwDn9SLMJ
         QhtA==
X-Gm-Message-State: AFqh2kpkwfS/vx9GOjtXDZJ1W3BVwPELa6hCpHAi9FywHehhocsNWQe8
	bRP9FwJiu3O+AcA1bbuq/Wuvze8yMh9daC0HD+iRwA==
X-Google-Smtp-Source: AMrXdXv4pHbsR36G0sHKDLOFuDh8j7nmNN4IgVvfd8lx3EvPv//Rzffn7Rrl5qwi4eZU+KzqbgGEJg==
X-Received: by 2002:aa7:81d4:0:b0:581:b3b3:7717 with SMTP id c20-20020aa781d4000000b00581b3b37717mr9611869pfn.26.1674104455426;
        Wed, 18 Jan 2023 21:00:55 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r10-20020aa79eca000000b00588cb818ea8sm18739600pfq.163.2023.01.18.21.00.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:00:55 -0800 (PST)
Message-ID: <63c8ce87.a70a0220.3b8f2.fbb8@mx.google.com>
Date: Wed, 18 Jan 2023 21:00:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.269-cip88-rt28-rebase
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs,
 1 regressions (v4.19.269-cip88-rt28-rebase)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 05:00:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10426

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 5 runs, 1 regressions=
 (v4.19.269-cip88-rt28-rebase)

Regressions Summary
-------------------

platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.269-cip88-rt28-rebase/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.269-cip88-rt28-rebase
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      09932a66d6b63564f8b94b34721b1f2d38ea9575 =



Test Regressions
---------------- =



platform               | arch   | lab           | compiler | defconfig     =
               | regressions
-----------------------+--------+---------------+----------+---------------=
---------------+------------
asus-C436FA-Flip-hatch | x86_64 | lab-collabora | gcc-10   | x86_64_defcon.=
..6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c8b7629d734d58fd915ef8

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.269-cip88-rt28-rebase/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-asus-C436FA-Flip-hatch.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230114.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/63c8b762=
9d734d58fd915ef9
        failing since 0 day (last pass: v5.10.158-cip22-435-g2c52868ae1cbc,=
 first fail: v4.19.269-rt119-1495-gc851fb1e222f) =

 =20

