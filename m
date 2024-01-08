Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5827EC47079
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 13:41:05 +0000 (UTC)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
 by mx.groups.io with SMTP id smtpd.web10.6788.1704721257569042556
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 08 Jan 2024 05:40:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=s+VWvsRU;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.181, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so1765110b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 08 Jan 2024 05:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1704721256; x=1705326056; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SKlG2JVDaz4UYa09cbuM+FTF6+v5U4v/0KyUC1oLJZE=;
        b=s+VWvsRUnFnFRnTmngqrd+d2/vjus645S0Tp8sz+2caBDUO9Sa5yDc/EaluzGAq85I
         QNzfBrY+27s8Bad1z7oX3UpRJoLTBLhWNajrMZNUiL5/v+FHqRf4g7dUyqf71zbxF7VL
         D7/SQ9JyV/cDs9p6WLywKztH5ZlaqSBo3UrMDtioc8TlKVhHTPIZM1cY6hjkpPw3/zZa
         BTuQcGOavaBcjJQAdBH2xv2DeBPtxYYufxyuc9UWz7+cFcOhsbFfmChmNPX46IusyuJy
         BPQnbSIf+B8VBCsvI6g39gYfm9LRkv7fJcES+gs4JVT4ewCTYPsCtYyeDrprS+Il93Lk
         /iWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721256; x=1705326056;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKlG2JVDaz4UYa09cbuM+FTF6+v5U4v/0KyUC1oLJZE=;
        b=ghl9V9aw5b1CpiPQ3rQQy5P8teh2v1xKXcFSHhg28OCx0wiWfjiXbHoTGh5qgbdrd4
         9lXoZbSMTyJrBTfDqilVmqgseeubev6SLeMIPk1iIhCcOmAoCFfYIf2OLurHfQ3vGjB9
         hSPkudsGSr+uh38/KkX7VWRJl+Kxdhg3Nbap7hiEySGSjxZ8RBEFwR1rlC+oSj8o1spB
         qFneP15FxJB1M4vVXDnXnLWlxMlr/7Gjx+6wo4E6W4Qw9cTmIkAB4p5nLH5Z4KiqO9h8
         AJA/PKXQmhl/846CczF+l8SzKFLkNsbrH2Z8rO0nuWYCJdEkkukGDKNrhaPGYgwA4AbB
         yaSw==
X-Gm-Message-State: AOJu0Yw12PmCIpfLHlvXD/DzUQCnLpyXDwd4mkeqmrwtqJ+khpPki+i3
	33e6dEpqgdKADyEUK3Xx8io7lkqrSMnPzNcQyDJ2wGyAyL4=
X-Google-Smtp-Source: AGHT+IGLuYq42JVxLQwtCFUUvrMCOdotljIRYYzXhnim0P42uoreP3iRUacgQxfrvFrlFnwoUMooAw==
X-Received: by 2002:a05:6a20:3948:b0:199:8a56:f3ad with SMTP id r8-20020a056a20394800b001998a56f3admr3575704pzg.50.1704721256544;
        Mon, 08 Jan 2024 05:40:56 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r19-20020a635d13000000b00578b40a4903sm5715929pgb.22.2024.01.08.05.40.55
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:40:56 -0800 (PST)
Message-ID: <659bfb68.630a0220.c090c.bf69@mx.google.com>
Date: Mon, 08 Jan 2024 05:40:56 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.299-cip105-289-gad0914f265af
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 96 runs,
 1 regressions (v4.19.299-cip105-289-gad0914f265af)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 13:41:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14278

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc baseline: 96 runs, 1 regressions=
 (v4.19.299-cip105-289-gad0914f265af)

Regressions Summary
-------------------

platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.299-cip105-289-gad0914f265af/plan/baselin=
e/

  Test:     baseline
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.299-cip105-289-gad0914f265af
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ad0914f265af139fd53d721f0db787b707de20ef =



Test Regressions
---------------- =



platform         | arch | lab     | compiler | defconfig           | regres=
sions
-----------------+------+---------+----------+---------------------+-------=
-----
beaglebone-black | arm  | lab-cip | gcc-10   | omap2plus_defconfig | 1     =
     =


  Details:     https://kernelci.org/test/plan/id/659bfa6cc326bf500852a42f

  Results:     41 PASS, 10 FAIL, 1 SKIP
  Full config: omap2plus_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.299-cip105-289-gad0914f265af/arm/omap2plus_defconfig/gcc=
-10/lab-cip/baseline-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/armel/rootfs.cpio.gz =



  * baseline.bootrr.deferred-probe-empty: https://kernelci.org/test/case/id=
/659bfa6cc326bf500852a45d
        new failure (last pass: v4.19.299-cip105-158-g856c181dce342)

    2024-01-08T13:36:08.147545  / # #
    2024-01-08T13:36:08.248833  export SHELL=3D/bin/sh
    2024-01-08T13:36:08.249280  #
    2024-01-08T13:36:08.349965  / # export SHELL=3D/bin/sh. /lava-1071701/e=
nvironment
    2024-01-08T13:36:08.350419  =

    2024-01-08T13:36:08.451132  / # . /lava-1071701/environment/lava-107170=
1/bin/lava-test-runner /lava-1071701/1
    2024-01-08T13:36:08.451808  =

    2024-01-08T13:36:08.496861  / # /lava-1071701/bin/lava-test-runner /lav=
a-1071701/1
    2024-01-08T13:36:08.677043  + export 'TESTRUN_ID=3D1_bootrr'
    2024-01-08T13:36:08.677346  + cd /lava-1071701/1/tests/1_bootrr =

    ... (10 line(s) more)  =

 =20

