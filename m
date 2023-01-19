Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EB1C00A5A
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 14:05:51 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
 by mx.groups.io with SMTP id smtpd.web11.45941.1674137147833413212
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 19 Jan 2023 06:05:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=lZB03LEB;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.52, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f52.google.com with SMTP id a14-20020a17090a70ce00b00229a2f73c56so5930882pjm.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 19 Jan 2023 06:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MPyjxqDDgkoJM7LVOaYDd4BeyF2LqPyosXKrqOEGW4g=;
        b=lZB03LEBEnKg+ojjOZr7qSK8f2NpHkv+R8WXABYWO7ZYcDF6LAIomjiZsPaBA3toB0
         qU5s3wZkG88BVtmDYNwdTYUYhldKuPgGHJ4t11/EzwjZFyo2NC0d/IappIslCp2FIoCF
         kzxgB3ZlQQbOSIQaYL8LNwUBDH98QuUtmTgw+CVB+FVo6ygqTLf3l0wbtDTjkdWNOB+n
         1hrRg4BE6et7g81cRBC7ljX/Lwroh2upBbTguG0QAgtCqqUNroWXow3kYzDkdUNwDmIX
         VcTQEDsNJyU3+rc7HXkh098x2x4XQl1RS0ZbAqmfj/szVJILqoM1Mq1uePvEFokKIG/L
         Ry1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPyjxqDDgkoJM7LVOaYDd4BeyF2LqPyosXKrqOEGW4g=;
        b=d8HstmV2aTVi7wBWAKLvFrIrn3T6X6jNpY/recenedI5v5FF46ZVxMOfruJya+Z0+n
         hjr1NxXYBVVvHxx4VAjm45uv7T01M3k/key9eAJLHQH9kvKiG+BMWeaHR1PfPIkV+bxr
         K+/eD7HeT912psef365a40fIkXCeACtZgqEWr5FEahrZaDRZNg7wMQ6rqO5agH9REB2O
         cND8BV4xla9+FAeinBHCAEu+Aksv9Bsyq7Law+dQEp9f9oT4NR+uzH0Seiex1nKNUz85
         C8ab1xTiQNGFss77ZiGSkEjhoId8mDFgEDdOWHq+jpA89HcAQyvCMvgT6eGWL1MfDnoz
         uYLw==
X-Gm-Message-State: AFqh2kraW4cKx2OG94hX049/hpxDr/XnM3uLauxDdGYSlaGFnLr3T9/8
	Er/3y115al/m4LK+RiE41o7kWAOgs9IQ/MewnuYOig==
X-Google-Smtp-Source: AMrXdXuIO9yi1OAURDfScu51q79glxyPTYYd4GvwdaTwzopSmg4D5iU8T0ILqf2EBGfPZKOdCyYbBA==
X-Received: by 2002:a05:6a20:d704:b0:b8:499d:7c9b with SMTP id iz4-20020a056a20d70400b000b8499d7c9bmr11375546pzb.51.1674137146589;
        Thu, 19 Jan 2023 06:05:46 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a4-20020a63e844000000b004b6c3d7aa21sm13980835pgk.8.2023.01.19.06.05.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 06:05:46 -0800 (PST)
Message-ID: <63c94e3a.630a0220.c177f.5fcf@mx.google.com>
Date: Thu, 19 Jan 2023 06:05:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v5.10.162-929-gae713b3c4626e
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs,
 2 regressions (v5.10.162-929-gae713b3c4626e)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 14:05:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10445

cip-gitlab/ci/pavel/linux-test ltp-mm: 3 runs, 2 regressions (v5.10.162-929=
-gae713b3c4626e)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =

hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.162-929-gae713b3c4626e/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.162-929-gae713b3c4626e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ae713b3c4626e7f02c44b3495f9b37717dd93ef0

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  cf59c1fb5f7181453b16171d75654ee9a1216dde =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
asus-C523NA-A20057-coral     | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c94d8d616e4dbe0f915ebe

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-mm-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63c94d8d616e4dbe0f915ebf
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63c946bf04d5b91374915ec5

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.162-929-gae713b3c4626e/x86_64/x86_64_defconfig+x86-chromebook/gcc-10=
/lab-collabora/ltp-mm-hp-x360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230114.0/amd64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/63c946bf04d5b91374915ec6
        new failure (last pass: v4.19.269-cip88-rt28-rebase) =

 =20

