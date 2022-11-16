Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5AAC43217
	for <webhook@archiver.kernel.org>; Wed, 16 Nov 2022 04:16:21 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web08.2906.1668572172418342235
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 15 Nov 2022 20:16:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Aqw2Z4cN;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id j12so15320988plj.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 15 Nov 2022 20:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HmyjZhAm3n/UlGWtD4AWjUIaCgV8mQO4JaadO3WMAik=;
        b=Aqw2Z4cNItoV3RwjbH132Hx92CTvSQ0rNYxjS5nwuJULEVR3b6smiGcsosrCNN5nVy
         mW5J5f66evpQCkhXOhM+S4IoX4GBtIHIn/kR8N+ETnOYT74GR+3KBTaMIIpADRYKEa7h
         NCdXX9buNtQTx45bzl4trxMYgLvype2zHp3ecpY0xxJ3GUmW86ddR6txOFlZhYL5JBmf
         MJV3PcGnDznhFRNX+TplIG5aRF0IdV56FRKmud6JbnpEnrsQFu+RqsDqNX1vrHc4ypsy
         m/7osv2JpfNyCDrizf0+az8Hqc08Nl5kvXHc1471yXEaMPPEAxKMYcRJLtx4nHo+cdfW
         ding==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmyjZhAm3n/UlGWtD4AWjUIaCgV8mQO4JaadO3WMAik=;
        b=5nhAnj6eswy4wD1ijGLDthn5Sj3t0xqUmjVjugAh4v9f69mrftod3PRkIajPn3hEqJ
         870X07ss2QJEo42adTZpLd/IA5rMRgA548pNex35oZLpXFhS4z3t8CdsmU06a8GjwVVS
         8juuUYSDkmvezy5+JqE1OgCWyXmH5z0ndsS/hCR9f8dWI/DTRldnrgR0TleKP9K75U19
         WaiDlObHQHF851Kp9oGhFyuYOX4UGOl6iJCk+m/ss2PN4bVvivgDG/Z+sA21VKw4wJtH
         PG3tkBSO+P3IESRpyhYcFjBJWlB6pjq+HIPz/TZA5KXKdzfXcflH4N22wp6os8CgbZkr
         7U4w==
X-Gm-Message-State: ANoB5plfYIy+SS2kigHOgMkLsA9Kj+/ZWD2lv/ZIcG/YKJbDg68QOIPm
	mmf5Fgtmp+Cl9OTAdBxpkHPGTWcRGxaEPhk9qf0=
X-Google-Smtp-Source: AA0mqf4HwRNqV8S2UGu10t0cBOzggy+W+cZNg8/UNQWny+gif+RWxDEtBtsLQZdeQM9ZANv801Olbw==
X-Received: by 2002:a17:903:25ce:b0:187:1f0:8da2 with SMTP id jc14-20020a17090325ce00b0018701f08da2mr7368833plb.63.1668572171607;
        Tue, 15 Nov 2022 20:16:11 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b00186ad73e2d5sm10934183plg.208.2022.11.15.20.16.11
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 20:16:11 -0800 (PST)
Message-ID: <6374640b.170a0220.94268.10ab@mx.google.com>
Date: Tue, 15 Nov 2022 20:16:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.265-cip85-rt27
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test ltp-ipc: 6 runs,
 1 regressions (v4.19.265-cip85-rt27)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 04:16:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10041

cip-gitlab/ci/pavel/linux-test ltp-ipc: 6 runs, 1 regressions (v4.19.265-ci=
p85-rt27)

Regressions Summary
-------------------

platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
asus-cx9400-volteer | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6=
-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.265-cip85-rt27/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.265-cip85-rt27
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      7b2b3defe99e6a33cd295c5120b96288f81f8bd7

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform            | arch   | lab           | compiler | defconfig        =
            | regressions
--------------------+--------+---------------+----------+------------------=
------------+------------
asus-cx9400-volteer | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6=
-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/63745149780c03144e2abd16

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-cx9400-volteer.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.265-cip85-rt27/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-col=
labora/ltp-ipc-asus-cx9400-volteer.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63745149780c03144e2abd=
17
        new failure (last pass: v5.10.145-rt74-1329-ga59fc50f38f6) =

 =20

