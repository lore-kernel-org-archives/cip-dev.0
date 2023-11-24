Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8143BC61DF7
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:07:16 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.134069.1700827635209786721
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:07:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=gJxwyDTq;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.177, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6cbe7386263so1183212b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700827634; x=1701432434; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qtg3bp/luBI7EO1ajR19llBxJK6nRwzSib2/a/O3qbw=;
        b=gJxwyDTqLhPvpE583IWGISLh9Ey6x02HBnrbXQckhQoc+bQzkvfrNdowZ44fPIbXWh
         jK6//ORMO8+RqLqpULQIDwkQnd66sg0+ymeIVueuSxWt0PyOOapb4MZStO5okPQuNZRK
         6gzyxkWutus8Ro1vhyrX/H30+Mj2IVallwqohboUuN2/SD1eCR0HieLWWUOYmQGt0vP4
         /RfvjZehT5WtfbFU1CwrKEytra0NgZasMxPLF5/gdx9IbWNHjr/AY8WG5C2OAHrjODQH
         NbgJboXeOVBylZveMfK4F9MQ13zvzW6eJkvXAsOnk1wA7ptuACwCjm8vSopwW74YIgoy
         2l+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827634; x=1701432434;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qtg3bp/luBI7EO1ajR19llBxJK6nRwzSib2/a/O3qbw=;
        b=pHuuhPcc1GiQxjDf/G7wUn/IEll48yoUd4wCxujSP5JDe4acOYf7+oHY91xeidCCty
         RcQnnwbkaAHKsvPnsPReQRu1tu+ZqdFGKT7DuoER1vkrERSYRVefG3uxWaK2L/xAfS23
         XjtvYeeEyDP+svnVpmkYD1grJkgRnOBA1YGnyZInlAL8DEDfyYzQKMNh2fwGtvKaDQCE
         4aYkc/moE8/pvI6AOork803T2LAuTVAykHttZlyi+jSDYrYH3z7pUsIt+KrRVCSlsZjo
         Uene7SBBgHfhW/QYd9qhv7qW70GaCOe7iGfRfct9CI1097pHUPt8Fy6nGGi+bPK9oWKG
         YCXQ==
X-Gm-Message-State: AOJu0YzTVAW0pv4zHPBqJhyqiJ2rKqJzLV4chw0uJOIeDOx8rFUmDw8T
	whjlXrTT1YIy6uew0j/ImJflEP49HefnY6uIOnI=
X-Google-Smtp-Source: AGHT+IFxjAJ8NAI/DgUbz3laVavWRWQfSiU4i/Yk/EXSCFsq+CNTwbPKAXChNuzixwyoWxVwpKGenA==
X-Received: by 2002:a05:6a21:189:b0:18b:d946:5d1 with SMTP id le9-20020a056a21018900b0018bd94605d1mr3086950pzb.54.1700827633980;
        Fri, 24 Nov 2023 04:07:13 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id r6-20020aa78b86000000b006be4bb0d2dcsm2840613pfd.149.2023.11.24.04.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:07:11 -0800 (PST)
Message-ID: <656091ef.a70a0220.efc84.6be7@mx.google.com>
Date: Fri, 24 Nov 2023 04:07:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip ltp-timers: 9 runs,
 1 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:07:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13735

cip/linux-5.10.y-cip ltp-timers: 9 runs, 1 regressions (v5.10.201-cip41-11-=
ga539098fe70dd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/ltp-timers/

  Test:     ltp-timers
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-11-ga539098fe70dd
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      a539098fe70dd29de0ce67ad5a39c40867ba5b2c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/6560837eaaf78b81937e4a70

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/ltp-timers-r8a774a1=
-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-timers.login: https://kernelci.org/test/case/id/6560837eaaf78b81937=
e4a71
        failing since 14 days (last pass: v5.10.194-cip39-1-g53e59f50ca3ff,=
 first fail: v5.10.200-cip40) =

 =20

