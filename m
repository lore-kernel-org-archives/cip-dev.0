Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210DBC4332F
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 10:32:34 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
 by mx.groups.io with SMTP id smtpd.web11.17164.1669199544542723674
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 23 Nov 2022 02:32:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=fpZtx996;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.174, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f174.google.com with SMTP id s196so16430062pgs.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 23 Nov 2022 02:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=exudOsjVhgRJf/qAjwIN8faCaXN8E7IHsCy0hhxUgZE=;
        b=fpZtx9963Uvw6erbDqRU1PjC7ubJaTtXVKRfK+SBU7yjsgrDmptrcwQbkkJdkQn4lh
         WdYC+sXvMcujj2kDA0PRliwD2iAV73HgdFK38++5chnXftnvgGZGjOfWzOx+moqCJENT
         XIe7QZ9T99x7j9JquKvJhGjwrp6BFLKxkq0BUsy47aCWdM8dRKNAuLxJURdhY9l5WntW
         OeodCKFWkmfLg9EsVokWL0G6rvYxoAmmDuaw30ycVMc/NEbwfhfslSt39QMgE8JPd9e+
         3cO9XI5l/wd3FkGtTMOns/FZT1paMMYOWYuDE1rOtuNZL7z8iu2iTLICmcok/2XJCnJb
         kk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exudOsjVhgRJf/qAjwIN8faCaXN8E7IHsCy0hhxUgZE=;
        b=74H5BjvriUeEvRuP4zbASUVde3GQ1gyvAGGKkFNCOjgawDZAYv9gimaxEnbDK/Whqk
         ITk9XyNizIX3ZA6DTWsuv4dx4sK/fGBR0CT/vy39phvWslNVwIc4Rfg02TgC4su2ai5Z
         oa0X5psgzGS10VvnEZZ6UJ2LNKsd06NRj3jlHjCmQNgmm7Cc7WCrz31EI/bkKrC5czhY
         gR7lxr4A5Nr7vCObTfsGjRCOrYQY296IQawO+0q6SANsjfU7HFazcl/iQT9moEAAIOrX
         x/A6aC4rxTl379RnDurb4J8hRTdr4hIa/Ii5o5G9RUZgxSse4a5MJ+9yRqcUU5g8tnfA
         924A==
X-Gm-Message-State: ANoB5pkd7TTD3QghTbg5haiqbKRIHPWBLzuRMuPFOecmJGWKk8u9aVmz
	RGwUfCsPwTXve+LwxO39i76Jkxs4TdJiI3ItLOA=
X-Google-Smtp-Source: AA0mqf6oOXvRCNSTuQHNzbv6Dxlc2363GnJF5mqT6Z3B821m53cmdxRkfix/Gz6i/xYQ4Wn9JPcHow==
X-Received: by 2002:a63:2361:0:b0:45f:f8df:108e with SMTP id u33-20020a632361000000b0045ff8df108emr6908546pgm.127.1669199543124;
        Wed, 23 Nov 2022 02:32:23 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902710e00b0018703bf3ec9sm13806452pll.61.2022.11.23.02.32.22
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 02:32:22 -0800 (PST)
Message-ID: <637df6b6.170a0220.3879e.54e9@mx.google.com>
Date: Wed, 23 Nov 2022 02:32:22 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Kernel: v4.19.265-cip85-36-gf1ffb3de9576
X-Kernelci-Report-Type: test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 5 runs,
 8 regressions (v4.19.265-cip85-36-gf1ffb3de9576)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Nov 2022 10:32:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10088

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 5 runs, 8 regression=
s (v4.19.265-cip85-36-gf1ffb3de9576)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =

rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.265-cip85-36-gf1ffb3de9576/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.265-cip85-36-gf1ffb3de9576
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      f1ffb3de957658ca822f84e1016111475207d8a3

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  a15eb3cdfa3556203167572e15754f1f59ba26bf =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/637de9ad5c91af64112abd07

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.265-cip85-36-gf1ffb3de9576/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.265-cip85-36-gf1ffb3de9576/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/637de9ad5c9=
1af64112abd0c
        failing since 19 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/637de9ad5c9=
1af64112abd0c
        failing since 19 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C523NA-A20057-coral  | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/637df118592fb2a7a92abd30

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.265-cip85-36-gf1ffb3de9576/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.265-cip85-36-gf1ffb3de9576/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/637df118592=
fb2a7a92abd35
        failing since 19 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/637df118592=
fb2a7a92abd35
        failing since 19 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
hp-11A-G6-EE-grunt        | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/637de93408a7cc04272abd02

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.265-cip85-36-gf1ffb3de9576/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.265-cip85-36-gf1ffb3de9576/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/637de93408a=
7cc04272abd07
        failing since 19 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/637de93408a=
7cc04272abd07
        failing since 19 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0,=
 first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
rk3399-gru-kevin          | arm64  | lab-collabora | gcc-10   | defconfig+a=
rm64-chromebook   | 2          =


  Details:     https://kernelci.org/test/plan/id/637df1cde85a2609c52abd21

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.265-cip85-36-gf1ffb3de9576/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.265-cip85-36-gf1ffb3de9576/arm64/defconfig+arm64-chromeb=
ook/gcc-10/lab-collabora/ltp-timers-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221107.1/arm64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/637df1cde85=
a2609c52abd26
        new failure (last pass: v4.19.264-cip84-50-g1e56b70eaf66) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/637df1cde85=
a2609c52abd26
        new failure (last pass: v4.19.264-cip84-50-g1e56b70eaf66) =

 =20

