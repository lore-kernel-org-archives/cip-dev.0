Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BCDC83F10
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 02:10:36 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web10.5463.1693188634000056828
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 27 Aug 2023 19:10:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=3ZnBvBoV;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68c3ec0578bso594878b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 27 Aug 2023 19:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1693188633; x=1693793433;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KKV5LQZxZRtarFK3hiYXqcAlKRWgvNFacrQPOZyxLak=;
        b=3ZnBvBoVJ0K7o+kjCAFqVKG+RhHxkPEeD8IdOa4QWhL7DZ45XOayB55n7QrtgbjsWP
         TQY3RO4GkEc2HMHQU8i2f7L/D4ZueWmIOZx/rERSrXlB86QSCcqr7pWCbT1vm0mM1BIE
         bH/Y3cCNX6olEL2phG3DY6MM8zS08EV5U4OrdnL3Y6R7wA4yduGHfOYNhPBWwgJvGKRl
         Ndrbh84qns8ZjQ4fBpGsdu73ag/krHjM67TRpCU//bXBANS6cIwJCCj0kBBwGV2E7gy2
         rp9IvSz/FzAorW8kC8A0Ce4yLHfzaCQVTz6oCv31+Dpv6gY189tjrxI2hWE6mX3kMJTw
         5ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693188633; x=1693793433;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKV5LQZxZRtarFK3hiYXqcAlKRWgvNFacrQPOZyxLak=;
        b=VzAxjWmqgp5vABnPlLj9NlMO+6MwqKTY/wSlFHHLzOE6kjiUF9sW34CeKDtB5b6rni
         u7S36Qhx+j0uUmxS2Tt8T6XKWP2HAoMUlV5yGcos55jXPJEa8TxqjgMsSMSrj+LLmH01
         c631ETUwnQtB/5/dNERHQMWqsl+UwwW/oRT0HGVluAXw5u9N9Ke+hZ3gkM9SUzd/8rgy
         CEKYsJ5l6RVbVyRj5d20Qmmasj2eQ4L71QQq0BkPTwjHyvg7BhdW2z1lpzqUg0qWhrP8
         2CRvuN7AVq9Y1DUjyeZeXOD73rY6SE6nmsLYoIdWBjJmL5s76gBhBfV5KEePa3sUL4r9
         eJiQ==
X-Gm-Message-State: AOJu0YxaGmlBkusUhyQKjbKY3xvbLDSdNp/kqL+G1YyMQGmirFP8c8O4
	36syM2b/Isz/yYGfUqZl9BaHqewGKMIyoWlmu/g=
X-Google-Smtp-Source: AGHT+IEPh6LmghL7Ce1eGa++S1n1aYhafzUX0glK6RRLXc/C3fUte2LU/RhW0tUmZ+PzSTEaXE9T0g==
X-Received: by 2002:a05:6a20:7d8e:b0:140:730b:4b3f with SMTP id v14-20020a056a207d8e00b00140730b4b3fmr25422092pzj.1.1693188633074;
        Sun, 27 Aug 2023 19:10:33 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id v14-20020a62a50e000000b0064398fe3451sm5445732pfm.217.2023.08.27.19.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 19:10:32 -0700 (PDT)
Message-ID: <64ec0218.620a0220.edccf.8111@mx.google.com>
Date: Sun, 27 Aug 2023 19:10:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.191-cip38
Subject: cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.191-cip38)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 02:10:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12868

cip/linux-5.10.y-cip smc: 3 runs, 2 regressions (v5.10.191-cip38)

Regressions Summary
-------------------

platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.191-cip38/plan/smc/

  Test:     smc
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.191-cip38
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      78bddf33c2b7d94fc34e09bc56638615095ddc28 =



Test Regressions
---------------- =



platform                     | arch   | lab           | compiler | defconfi=
g                    | regressions
-----------------------------+--------+---------------+----------+---------=
---------------------+------------
hp-x360-12b-c...4020-octopus | x86_64 | lab-collabora | gcc-10   | x86_64_d=
efcon...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/64ebefc89914d85923286d91

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.191=
-cip38/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-collabora/smc-hp-x=
360-12b-ca0010nr-n4020-octopus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/x86/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/64ebefc89914d85923=
286d9d
        failing since 419 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-08-28T00:52:21.072293  <8>[   16.881566] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>
   =


  * smc.CVE-2018-3640: https://kernelci.org/test/case/id/64ebefc89914d85923=
286d9e
        failing since 419 days (last pass: v5.10.125-cip10, first fail: v5.=
10.126-cip11)

    2023-08-28T00:52:21.059082  <8>[   16.867958] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3640 RESULT=3Dfail>
   =

 =20

