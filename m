Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1136DC4332F
	for <webhook@archiver.kernel.org>; Wed,  9 Nov 2022 11:44:10 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web08.2259.1667994242516162792
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 09 Nov 2022 03:44:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=6G43YZc6;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id s196so16014009pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 09 Nov 2022 03:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O0SRPCWoi474n9Io3VJ9Xa0P4gBqPGENBBWB5blNaS8=;
        b=6G43YZc6Ds28WEOZn+cDgkqO4p9CZULVhD1Or+kkGy/wT3MmxCMMl8pZcuUf0zM66N
         fU3s+0rX3ms/mgw6ub+Rx4v0EyZqkpTk0TElI43d+1bqXQmUxCjVvGcGD5Gi8VQasB3v
         VtBDm22eeqaK1+7dQSHbjrVEylJjchsXekN470p6fU11bqKnoE5R8vfFyASf7FeeStAG
         zEF8HQGs8nQw89u+Jim5ITc9lP9TQIgmdVwUzM8a1UpQBmQgmO7E44eRLmQ9DrfnbSxo
         OQrXkUUXDaPfPGb7d5FN5J6XXSAX5N3nmROlSJjDAeqH90UlPKrkd1kuzy+w5g9w4+IT
         YmcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0SRPCWoi474n9Io3VJ9Xa0P4gBqPGENBBWB5blNaS8=;
        b=1VbtnNOp5ARXt15VPrVf1PjOuBbrsQEWgz8NOQxbMRW400mOe36osFjd8zuNo3OOOf
         deJOlO7px1gQZlSW+JXKKyL7/z3fsthQfuRLincSvsQh2kEtKOESuZILmhApIsaIMlC4
         ntv2tIN14mwcLbMP8XbFmtCIpXJZHoQBoQXJvb8j/tbI3GLM3pyqG5mWZ5AavrbP0z3P
         AlL3IH+fwWf9ENAMZvBDNT3egCwXR9WlopPESdzPyCGvXkl6NGtnFjiISENgM6gWIQDO
         uq/8WBgvLW59G0JTtApuLh3hqdHpZF/dmGqNsPRIxA/vpRljZF4I0Ke3x1sjhx9mD8n6
         qW4Q==
X-Gm-Message-State: ACrzQf20zvc6rQiqlmDmoQQ5L4yUrkNvHPDi0IE6YC9vcKV9mwd0BC83
	u48L+o4Lts20zSI0Y2xIAkMKZOGmrp0BVOg+
X-Google-Smtp-Source: AMsMyM67VMiJnAIEItYnH6wHXnB25fbL2Yg7JNMGy9x5k0NhHzIRL2jDek1Aw7kfhTxya0rEnRdu5A==
X-Received: by 2002:a05:6a00:1a47:b0:52e:6a8c:5430 with SMTP id h7-20020a056a001a4700b0052e6a8c5430mr59934669pfv.48.1667994241686;
        Wed, 09 Nov 2022 03:44:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709027e4900b00187022627d8sm8808889pln.62.2022.11.09.03.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:44:01 -0800 (PST)
Message-ID: <636b9281.170a0220.165a7.e4f9@mx.google.com>
Date: Wed, 09 Nov 2022 03:44:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip smc: 6 runs, 2 regressions (v5.10.153-cip19)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Nov 2022 11:44:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9964

cip/linux-5.10.y-cip smc: 6 runs, 2 regressions (v5.10.153-cip19)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.153-cip19/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.153-cip19
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      0f7fc281d55b27b299e8388c7d44809289ba8b99 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/636b80da098ba2621de7db53

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.153=
-cip19/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20221024.1/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/636b80da098ba2621d=
e7db5f
        failing since 128 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-11-09T10:28:24.068937  <8>[   12.561134] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/636b80da098ba2621d=
e7db60
        failing since 128 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2022-11-09T10:28:24.050869  <8>[   12.543083] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>   =

 =20

