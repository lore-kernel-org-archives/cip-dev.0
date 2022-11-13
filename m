Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3725C43219
	for <webhook@archiver.kernel.org>; Sun, 13 Nov 2022 09:19:12 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.1128.1668331150357832341
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 13 Nov 2022 01:19:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ucJfWQc7;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.176, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f176.google.com with SMTP id p21so7634251plr.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 13 Nov 2022 01:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GgakzsEEI0O/DnooT/srrwbtxz8Uer29M4zuVRyNqIM=;
        b=ucJfWQc7v4qIH0AITJB98HAkrX6in/6c4sRmbAjFti5CDerFRGWV5QYpaTPkrJhtgZ
         OmslHgJoNyh99YuOqMIKACyQbxcDeKFF9lFYsD0M9g4SXd2oysFC0jHp1WmhCnBRUMth
         Seh75vDdvMqwr9BCZPy+6i96AqCLILEwahIutk9TtGdxSIEQxUJdJO/JYCHS4L2zJcef
         Mh2kNLeZqwy2Gq6JP7+czFbDE/pjl20VYwwU//7pE5F5+wsjUOPr63iy2B1C857vGEZg
         qbxQkkTU4eq969TuKUtH7BnNlOl5Yz0iNFKRGUA96Tq1iL+9pcdRPD9TLZKaLFYeXF26
         hL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgakzsEEI0O/DnooT/srrwbtxz8Uer29M4zuVRyNqIM=;
        b=N1CyKn2tvfMGhIFjTcYAVpeplfnFAftrJOdOMu6YkgKEM/v5fbB7alFJ4QsW0pGuIZ
         mHs7Dv1Y5+kdeRrN5pXNPXNEiBUK1oPKxJB/ZWtEU2rh2OOAZvFCZcJiRDGL/H602RJe
         bHOsl+/wjT6rN+lKckftIROZzAtRBO9X3JjibKdHF4jPnIueaBlyxaMkw41fCAd20/12
         1TOA+3pYi0EP+TVPHNvLzPSyi0+3pFUwva7R8aAzBllAATc5bNfKicbuuEya+6HBgAwT
         9lcbgFGwWewXfRdPXdes6jmiIwk/HwnCOpr8rCuN5xPYRYs6No8jMP/gia0EsZ1zMcDU
         +bfQ==
X-Gm-Message-State: ANoB5plfZom3+2j2o9KzSPUirwkKNEnzD2e8n1iPr6z7P3QBwsAWwusK
	ujSUfCFT/PJ7g5WOvnR18SDlyVf7oipGKlHPt+Q=
X-Google-Smtp-Source: AA0mqf5ytEQ3+kGlsT9ErWzNVcTXr3HOpB3UMpPREvn9aZyB9WC5MXXgqnFqksWSyc+l5GbPQ/WO1A==
X-Received: by 2002:a17:902:8210:b0:17c:b7ac:86f with SMTP id x16-20020a170902821000b0017cb7ac086fmr9028951pln.140.1668331149706;
        Sun, 13 Nov 2022 01:19:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b00179e1f08634sm4832807plk.222.2022.11.13.01.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 01:19:09 -0800 (PST)
Message-ID: <6370b68d.170a0220.2e95d.6d2a@mx.google.com>
Date: Sun, 13 Nov 2022 01:19:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.154-cip20
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 5 runs,
 1 regressions (v5.10.154-cip20)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Nov 2022 09:19:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10029

cip/linux-5.10.y-cip kselftest-seccomp: 5 runs, 1 regressions (v5.10.154-ci=
p20)

Regressions Summary
-------------------

platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.154-cip20/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.154-cip20
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      efa0ded8f5c8a9e3835e4aea63caa6cffb0ccda8 =



Test Regressions
---------------- =



platform                  | arch   | lab           | compiler | defconfig  =
                  | regressions
--------------------------+--------+---------------+----------+------------=
------------------+------------
asus-C433TA-AJ0005-rammus | x86_64 | lab-collabora | gcc-10   | x86_64_defc=
on...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/6370a1f042e7765c81e7db73

  Results:     87 PASS, 3 FAIL, 8 SKIP
  Full config: x86_64_defconfig+x86-chromebook+kselftest
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.154=
-cip20/x86_64/x86_64_defconfig+x86-chromebook+kselftest/gcc-10/lab-collabor=
a/kselftest-seccomp-asus-C433TA-AJ0005-rammus.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/amd64/initrd.cpio.gz =



  * kselftest-seccomp.seccomp_seccomp_benchmark: https://kernelci.org/test/=
case/id/6370a1f042e7765c81e7db75
        failing since 3 days (last pass: v5.10.153-cip19, first fail: v5.10=
.153-cip19-3-gc76f4e7e5c71)

    2022-11-13T07:50:59.020321     =

 =20

