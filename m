Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC4BC4706F
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 01:30:05 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.42024.1703122199748665008
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 20 Dec 2023 17:29:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=jobu2Hl4;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28bcc273833so243790a91.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 20 Dec 2023 17:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1703122199; x=1703726999; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p99cB4+3OxinjEVvzuth/uZPSX36L20ht4b5ZnnThFs=;
        b=jobu2Hl4lOZS1iO+E/7lg/NqSJ6gzgZUgzjCkDImTTOqiMGBknRN4Uth1wfMGF0J/P
         jpCmiUJc0zdeLv44To8hyvuG/jZIBm5svtQVKmPS+OReqafH8gGqrNhp5uvB1Yn8qlWE
         X4nqYbqmGDESevid2X5qvKCG7TYc5kNJGzCgWiO880OBG6gPqevqbg12V9jFLax6YA1o
         +Nz1Y3DVF6o1N3uhcuh1RvFdy+6LEhYzCa/1UgNI+520cNoPFNvwhk9FXzxIUHvgDwEC
         eprg9AzBUh24f4j5RM0QD0bAq281ejxhYCzFcOOrIfk0Eo3DIAbND3STYMivjpIIvRF4
         TEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703122199; x=1703726999;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p99cB4+3OxinjEVvzuth/uZPSX36L20ht4b5ZnnThFs=;
        b=gPdvyeH06SZsbRGTUCy1erqbBpNrLvnzgn/AlWydFPAtzTf2pb56otyJhzrHBXE+eA
         3h3B5e2A2jsmleEatonrWIbGe7xiV58lwxJpKoJgWXX2B7qnGKIaKJancSOk1PwuVPqj
         NZcOAjuHrqqOYixTLIwxNjbtkph1OV2fK6lFyQnbOTJ4v9dflSIwRR96LW0gTKZKP4J8
         ocnuuFRB9CCP5/yUjWirkvleCfRyjf7WkjbI2F3c7uRg9ZoGKMatkdf/cBXLryhU2XeO
         Zg8fyrbPl4cM1Aw4zoafqSv1fG3zPl71OstHusJqx261flnUuCudd45WUsUVqYQRy1Hw
         il1g==
X-Gm-Message-State: AOJu0YycUd0ODdzgOOsMc319878nroT6yDFGVTWEp8tAZPDhFE2OpGss
	kMm+XXFGGgnokmoKRR+wGE9PkNdPbkriFRm040E=
X-Google-Smtp-Source: AGHT+IFs5lrQTObhOBYnMSLyxiTGOY8SHjR0DiHQKghD4rZsBB+THcNav2KBbaBM2MByFKE98OnzRQ==
X-Received: by 2002:a17:90a:b30e:b0:28b:a3a5:355a with SMTP id d14-20020a17090ab30e00b0028ba3a5355amr3926651pjr.66.1703122198757;
        Wed, 20 Dec 2023 17:29:58 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t24-20020a17090ad15800b0028be4f51d2dsm498940pjw.5.2023.12.20.17.29.54
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:29:55 -0800 (PST)
Message-ID: <65839513.170a0220.90661.2676@mx.google.com>
Date: Wed, 20 Dec 2023 17:29:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-540-g3640150b3b169
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 11 runs,
 2 regressions (v5.10.201-cip41-540-g3640150b3b169)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 01:30:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14178

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-pty: 11 runs, 2 regressions =
(v5.10.201-cip41-540-g3640150b3b169)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.201-cip41-540-g3640150b3b169/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.201-cip41-540-g3640150b3b169
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      3640150b3b169fcd03031a9e8aab166a9730a1f9

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm64-chr=
omebook | 1          =


  Details:     https://kernelci.org/test/plan/id/658388abbfa66ee200e134b1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/658388abbfa66ee200e134=
b2
        failing since 48 days (last pass: v5.10.182-cip35-289-g3c0549540706=
, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =



platform                 | arch  | lab     | compiler | defconfig          =
        | regressions
-------------------------+-------+---------+----------+--------------------=
--------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig          =
        | 1          =


  Details:     https://kernelci.org/test/plan/id/65838a287d09192151e1348c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.201-cip41-540-g3640150b3b169/arm64/defconfig/gcc-10/lab-=
cip/ltp-pty-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65838a287d09192151e134=
8d
        new failure (last pass: v5.10.201-cip41-69-g8f7b450fc28ed) =

 =20

