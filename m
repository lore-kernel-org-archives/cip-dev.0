Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC7BC636D0
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 00:19:02 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.122241.1700785138244189927
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 23 Nov 2023 16:18:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=tPi01BvD;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.182, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6cbe6d514cdso938457b3a.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 23 Nov 2023 16:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700785137; x=1701389937; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8tx2YIZ4dPZMPEAuROio7NAKQnEVuFmTda/h43rPU7Q=;
        b=tPi01BvDfiDAfOJNv7wSdjEH8WrFxPGJz74kYSec5AIXdJzXRTK+um/ogzNEi0wg2a
         QJXshrHf3KaUZekxx2cz7U0KKlV/pahoV5yeWzsAdMvAMEKCvaVZMemSw8zVS5geWYY7
         o9rm+9cJIYG+vOl2MM3SCY+y1UKLJg9LSgyzci3k0lGlpLs7H24Revn6I4L5FLmi14l1
         nxkEPOMZNQKhbLvNUP1F/5kOoXTXUFsvllUGtjbaxIe/qzX6bdhY0uYR4C0gMN/uKFx3
         XKKyKws2ksDoYAxWEX4XT1tzdjuB/c/hH2WK/M3I8YMryYcu3OMhw8PXlyU1lwvDhzwL
         XhCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785137; x=1701389937;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8tx2YIZ4dPZMPEAuROio7NAKQnEVuFmTda/h43rPU7Q=;
        b=W/3dmE3yUdt9EWTCBDeIkzVwpbrTKk9AA4fVc8J+ZCLqykZCCH5pYNxwNPQtl+XEdE
         Yx6z6YvfaF9FI/B+I8MKxnaYpAYn55ZtB0kSGWrZro2WB3wVHGaTnAeg+OdVyN/BdvKP
         grMfZJJzA9k5Zg3Jcl+889y1v7twnU7Eaj+lt3RATJb/1yyL/WyxsKgjXjaf1Aj4t0Dj
         wWrsI248+KDEXWMNmtyz4s9MSt7e46vTivn/+40o7GkwWHXdESTUszrGVAaBIeKfzOvh
         K/gCPHxr4wG320vqXwE8B3NHUzh/gp2zgy+mQNLWd/+quLvrwtNgaagOfi3s/lY/rDJ0
         /A+g==
X-Gm-Message-State: AOJu0Yw70igSLWcAV83UG3Q0C3A+c2F/dADzwzOW9oLmdf1nopOY6gay
	VD8liQ43MgfH6q1FAchEymnu/NiDEgRgQ5TphEI=
X-Google-Smtp-Source: AGHT+IHxojjhD55gzJkGzlZUZKAFIvgcW5P3z+3GM+DWu+oG5F/S0jgYQTpidjtuNWgrMAPp1br4pg==
X-Received: by 2002:a05:6a00:2787:b0:6bd:f760:6ab1 with SMTP id bd7-20020a056a00278700b006bdf7606ab1mr1103195pfb.14.1700785137189;
        Thu, 23 Nov 2023 16:18:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id x23-20020aa793b7000000b006cb638ba1aasm1741941pff.49.2023.11.23.16.18.51
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:18:52 -0800 (PST)
Message-ID: <655febec.a70a0220.4f964.48e1@mx.google.com>
Date: Thu, 23 Nov 2023 16:18:52 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.201-rt98-828-g27523c64bc5dd
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 9 runs,
 1 regressions (v5.10.201-rt98-828-g27523c64bc5dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 00:19:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13699

cip-gitlab/ci/pavel/linux-test ltp-pty: 9 runs, 1 regressions (v5.10.201-rt=
98-828-g27523c64bc5dd)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-rt98-828-g27523c64bc5dd/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-rt98-828-g27523c64bc5dd
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      27523c64bc5dd6f1af1b227b80017fea69e616b6

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
               | regressions
-------------------------+--------+---------------+----------+-------------=
---------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
nfig+x86-board | 1          =


  Details:     https://kernelci.org/test/plan/id/655fe0b71b2694080b7e4a87

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-board
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-rt98-828-g27523c64bc5dd/x86_64/x86_64_defconfig+x86-board/gcc-10=
/lab-collabora/ltp-pty-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/655fe0b71b2694080b7e4a=
88
        new failure (last pass: v6.1.58-cip7-132-gb38ea1474c159) =

 =20

