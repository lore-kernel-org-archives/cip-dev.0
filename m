X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
 by mx.groups.io with SMTP id smtpd.web08.697.1648512123882843484
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 28 Mar 2022 17:02:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=V4RFUSuc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.178, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f178.google.com with SMTP id f10so5787689plr.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 28 Mar 2022 17:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from;
        bh=cwwHG0aZVFk+GJ5VI7t1dPpjc0yLrswXchJKDT1kSyM=;
        b=V4RFUSucA96a7Sg3DJqc1I9ZGTOxoke30kUPSZW2HylAdpkbqO8Snocfwsy96ATP/H
         g5Cj4x0L79jS+FffYV7qGKockG9eC9BsIhyYB85/BWvq5gqlnuj1AszW8+2pex/tBEfH
         MiHxj+SdFbUEJNqVrNlcReSWWx1nnhBVfEaqgnB6fPC+ugJAGxfWE19kLl5hvkmCozC/
         9e0mjgHpTK0fub8QF54Hxk2evcdEoOGb5V4SVliiCnrVx5r8cIDNhF3LJDMvASQWAY5B
         40Jfxxa7XfTXSoPKXuz5tkX0/SJ0Z+BWZFf8FVjZGrCe7QbU/2MmWWIRShYalI0qx1ps
         Joag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from;
        bh=cwwHG0aZVFk+GJ5VI7t1dPpjc0yLrswXchJKDT1kSyM=;
        b=YBfF1fwqWu+GYPsrS7nVDvqo3E2U+W5cnfyihPuqNfk13Pjrqytj45ckN/c0C1UcLi
         J8XE7aLimEns8zlFSE7pfXITYBItfaYax3TnBVuGMRLcufzQUBn0cfEfT5r6HHoc4Eym
         KS8lUpMWd9HX9aCiR5LOl2xG7zJKva4rE+HxmDek1DfUknemDb1qTEvVe6KYw/60oxhy
         3QuizeY5VLMibKrmgOtINcF15k+3Jte0VjLCrqKJznTS23fkBx5pk/zBTjrSoWoJGRD7
         Au02oJtAse+hLhgM3WftHSFwDTYBc88WSFdfRqpBQaUSHjXOyLYozFeqvbx+AUQEm7FY
         Tyig==
X-Gm-Message-State: AOAM5310aocG9hNhhgE1uME7xVgWrsLPkpVFVhYgAxm12ffrx1xMh1m6
	oYZNe5NQc2KS9dPIR2zI9Aryj/L8trDRyh7f6J4=
X-Google-Smtp-Source: ABdhPJw9ZQdGkUbzEZ0MEAO9JtrVM6HJdAzWBrkPCuL2qtXQ38Sl0qW/Q9nj4go5GMRXfP9LHQoNWw==
X-Received: by 2002:a17:90b:2496:b0:1b9:a6dd:ae7 with SMTP id nt22-20020a17090b249600b001b9a6dd0ae7mr1623512pjb.35.1648512123186;
        Mon, 28 Mar 2022 17:02:03 -0700 (PDT)
Return-Path: <bot@kernelci.org>
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b004fb44e0cb17sm6810442pfw.116.2022.03.28.17.02.02
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:02:02 -0700 (PDT)
Message-ID: <62424c7a.1c69fb81.4795d.1df0@mx.google.com>
Date: Mon, 28 Mar 2022 17:02:02 -0700 (PDT)
MIME-Version: 1.0
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.104-cip3-224-gbc5581d50c4e
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs, 2 regressions (v5.10.104-cip3-224-gbc5581d50c4e) #kernelci
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
From: "kernelci.org bot" <bot@kernelci.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"
List-Id: <cip-dev.lists.cip-project.org>

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-timers: 8 runs, 2 regression=
s (v5.10.104-cip3-224-gbc5581d50c4e)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.104-cip3-224-gbc5581d50c4e/plan/ltp-timer=
s/

  Test:     ltp-timers
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.104-cip3-224-gbc5581d50c4e
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      bc5581d50c4ebee1d73a29e0e3e0ce12e959112f

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  dc836ec4cd4e02e1346001f828c1f1988a8d7d54 =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 2          =


  Details:     https://kernelci.org/test/plan/id/6242411afb7dd792e0ae06ed

  Results:     32 PASS, 4 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.104-cip3-224-gbc5581d50c4e/x86_64/x86_64_defconfig+x86-c=
hromebook/gcc-10/lab-collabora/ltp-timers-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20220311.1/amd64/initrd.cpio.gz =



  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6242411afb7=
dd792e0ae06f2
        failing since 19 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39) =


  * ltp-timers.clock_settime: https://kernelci.org/test/case/id/6242411afb7=
dd792e0ae06f2
        failing since 19 days (last pass: v5.10.100-cip2-319-gcbff87047566,=
 first fail: v5.10.100-cip2-425-g0a0d92194f39) =

 =20

