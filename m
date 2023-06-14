Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA14CEB64D9
	for <webhook@archiver.kernel.org>; Wed, 14 Jun 2023 13:16:45 +0000 (UTC)
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
 by mx.groups.io with SMTP id smtpd.web10.11405.1686748603310583255
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 14 Jun 2023 06:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=oVzY8cIo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.172, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-652328c18d5so5005219b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 14 Jun 2023 06:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1686748602; x=1689340602;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Paop2kdZn5gaA2rGs+zv412szPVIzMcaJAmtrqrSmlo=;
        b=oVzY8cIoIs0NMWkCU3VvUsrzWC717289Z5dJ9aycMsWGcXR8i69whXefI1iPgCVGbD
         9bluVDZoyVT+GeOqs15yp6m3E+sRvCxHTYjyEObYHu/mthNzHB2bREXAlwsIfpLnRcxU
         GLgShodxwcCkve/7FnqRIFItZlkob6/y2Mzq7V3oGtj4pcRqexhpiPPsCW4LHwJcDjwO
         /hCsA+u7Fr0+MXPp6uqtoLre6sHWC42LZBJZefNHWMwiyoR2MkVPzM2JLqsHza5/U2bR
         hTYWs0lSFNqIrq5lSuMYaLyTunBun1ashZ6A3YMvcd84E0EixAnpOwyArwK+R7waEhx/
         UZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748602; x=1689340602;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Paop2kdZn5gaA2rGs+zv412szPVIzMcaJAmtrqrSmlo=;
        b=kbmuNy1nin2ReH14gvtEpQkbs5m1oNwSvLYZmd5H/kddnUHNJsiw10dT8ivXRIwsbE
         Zaq+4viyMQQqkIGVkpslXA3Jt+7sCsvZpu/dGPgrY+A7PpvCCDAy8s0kfIPmJyrxIQP8
         lMRcUcJKQcIqB0n8jNZ/LH0fWu0JrnEgHF5SRdm43IFG/q0dp2qb9gAXCSplYwzr8pUu
         dzmBUSPxc0WSewiHHnFI4sF+BgXt7njb3SuYHLQJmDvwyXjdpLGkz/UAAbe/VmFGpjjv
         idDfaodx21z1GMSoWCW286vQ40zdi5Q/CCwhBdumPAN/imHu8rK0eKzGQHplfOTcK9Y+
         ycvw==
X-Gm-Message-State: AC+VfDx6PHHO76+umJg/uu+K9IN7cvVmXq+KI/jXrmLvdSWn69wsNUl+
	wNt7O2r6JOxorx1XEJrE/Ud8ngf6/NbtIjXCmmFt0g==
X-Google-Smtp-Source: ACHHUZ7sMYigXufoDlP5Sb3hWXcVUB6ZwpAlhckNOyRbIaYfbY9yQUFmBrYb67AbgxzCB9jm32jXiQ==
X-Received: by 2002:a05:6a20:7da5:b0:10a:dd89:420f with SMTP id v37-20020a056a207da500b0010add89420fmr1446768pzj.6.1686748602131;
        Wed, 14 Jun 2023 06:16:42 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id n17-20020a6563d1000000b00513cc8c9597sm10084697pgv.10.2023.06.14.06.16.40
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:16:41 -0700 (PDT)
Message-ID: <6489bdb9.650a0220.4a12c.4377@mx.google.com>
Date: Wed, 14 Jun 2023 06:16:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v4.19.284-cip99-114-g02e97826987bf
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs,
 2 regressions (v4.19.284-cip99-114-g02e97826987bf)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jun 2023 13:16:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12023

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc ltp-timers: 6 runs, 2 regression=
s (v4.19.284-cip99-114-g02e97826987bf)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.284-cip99-114-g02e97826987bf/plan/ltp-tim=
ers/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.284-cip99-114-g02e97826987bf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      02e97826987bf9401c9a3fb9d2d52ab90340ea1d

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  97c2fdb137a68e1eefed07c900db1a862edcdbf8 =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6489b6979d96fe819a30612e

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.284-cip99-114-g02e97826987bf/x86_64/x86_64_defconfig+x86=
-chromebook/gcc-10/lab-collabora/ltp-timers-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230609.0/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b6979d9=
6fe819a306133
        failing since 222 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6489b6979d9=
6fe819a306133
        failing since 222 days (last pass: v4.19.256-cip80-1-g68250b8eafbe0=
, first fail: v4.19.261-cip83-311-g41979a0fec1a) =

 =20

