Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E42DC7EE2D
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 00:22:50 +0000 (UTC)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
 by mx.groups.io with SMTP id smtpd.web10.1179.1685924561435102050
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 04 Jun 2023 17:22:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=JJM34mU0;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.166.51, mailfrom: bot@kernelci.org)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-777b4560ae8so17941339f.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 04 Jun 2023 17:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685924560; x=1688516560;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dRF7vR1oL4U/Ow1ceC1L6uspJmfnlDxvldY0Dyfl4uI=;
        b=JJM34mU0EIJuRHxMZaSk2xt2HXYlJggqjcsen7Wd8Rl9famqBKmPler96MJ9/v8A2Y
         iNKuTj3g6teMqwJIUyAlcup2JhllteiO1rcC6k83W+GuHiirW0tmOOfRqWmvHiFHrmYD
         Uv/5ZrAG27bl7r9goCvvH6z1mdKbw0pv+e4T+u5IAqNZWJB9eWI+zzlkzgv/+3P1g7Az
         etsTmekWlmAzBkG8XvwNdDu6xjWFhtAcXwUsz3XifbooGbGhA9b7TOWAwAIhlhcFwW0J
         GW+fxWXZ88NUv9S9yqSRC50FtVeDOk9rcBsVeBuPqjrQDBGRUj3iHjZitXS58xne9mqx
         pG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685924560; x=1688516560;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRF7vR1oL4U/Ow1ceC1L6uspJmfnlDxvldY0Dyfl4uI=;
        b=SvmbjknE6C53FsEEtonWkjPV0goKMxjiN8iKg0aaru13/Y9+uSPTUEkq1zic6fvsBK
         kAOxy9ccyecX57jCDA2kM7WPeRGy4XKUiYAir++UuGU1gFqJ9eIgfPOp2r8cVftWi8JY
         xl6KQSnw9PUq9fbi8WMlJKfS3yWnoFHxeJv6kDmIksBGrAe2xqlzFGi8H1mTwG/f4BxO
         tC1uYin4bb3235zi0pKAz5uur4LpP8ym1pILKgkp6Z8b3zQUUBMNnUmXjhvgD7ptxdMN
         EG8nx/A/t5K414HespjxmAuimQjYAOVBcJqOeVlJpWhAOhJC79WEcwYQiO9qxa/M5obk
         w8pw==
X-Gm-Message-State: AC+VfDyRonbzI+jGEbFy/bl7bwL+fa8XUh0IMgkpenwSXmCM4wjWoUeW
	CchVLeM91g0toLdapLf7uKz7VabOIDNnA6vkU0ey7Q==
X-Google-Smtp-Source: ACHHUZ5stbRGK0VtCTQfxxgqEdtoskcTrAukO1Lk48KD/5gB33NlNBZ+9SYm8mhkDC/Xo8G3HbLcDw==
X-Received: by 2002:a92:de0e:0:b0:335:6e5d:afb4 with SMTP id x14-20020a92de0e000000b003356e5dafb4mr15350914ilm.24.1685924559843;
        Sun, 04 Jun 2023 17:22:39 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79150000000b005a8de0f4c64sm4073812pfi.82.2023.06.04.17.22.39
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 17:22:39 -0700 (PDT)
Message-ID: <647d2acf.a70a0220.dd66b.6c33@mx.google.com>
Date: Sun, 04 Jun 2023 17:22:39 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1301-g6369cf0363211
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs,
 2 regressions (v6.1.26-1301-g6369cf0363211)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 00:22:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11767

cip-gitlab/ci/pavel/linux-test ltp-timers: 11 runs, 2 regressions (v6.1.26-=
1301-g6369cf0363211)

Regressions Summary
-------------------

platform    | arch   | lab           | compiler | defconfig                =
    | regressions
------------+--------+---------------+----------+--------------------------=
----+------------
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-chromeb=
ook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1301-g6369cf0363211/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1301-g6369cf0363211
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6369cf036321117aa7bd9be009c3b7107cea2007

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  604701dc19c5499403ae5afe48103b8e2872952b =



Test Regressions
---------------- =



platform    | arch   | lab           | compiler | defconfig                =
    | regressions
------------+--------+---------------+----------+--------------------------=
----+------------
qemu_x86_64 | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-chromeb=
ook | 2          =


  Details:     https://kernelci.org/test/plan/id/647d1b780463dc408af5df16

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-qemu_x86_64.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1301-g6369cf0363211/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/=
lab-collabora/ltp-timers-qemu_x86_64.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230527.0/amd64/rootfs.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d1b78046=
3dc408af5df1b
        new failure (last pass: v6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:16:56.536409  =

   =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/647d1b78046=
3dc408af5df1b
        new failure (last pass: v6.1.26-1281-g84d5372e0f31)

    2023-06-04T23:16:56.536409  =

   =

 =20

