Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA8DC61DF4
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 12:07:26 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web11.134073.1700827636701461090
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 24 Nov 2023 04:07:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=N6R6LgZg;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1cfaaa79766so1632275ad.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 24 Nov 2023 04:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1700827635; x=1701432435; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rO9jFnlD+BvaZzCZKXX4/R9UdI/XhYc/Zcyn1nYgH8g=;
        b=N6R6LgZg78Z6ODY8Xcf/6ALYd1nh90M0FlzzbtiEodBfoR1OVw3x8Rah3MiHGap+On
         7JgM9zS2oR2Zx5iwn8GpzABkAiXNLHj163hOa/yZb1heHrurS1VVH466iN+P6haDkepk
         GIdfmBb8zDqnlwS/Mzw5LXSr0fg/p//mscHsEORWeKXNWPeiH8XQc7zeZGTh2ap06Bv3
         TbdBBhm1SuCwEo4RgYqQ1ud63QrzueuTS1yor132etQ2zun/YBqAT+/VYCmYC0PX8S70
         O03PqB+iZHBfDqK9Yh56lwik1AtiSiCttjvqxd4m4wgCv2bK1QqNHaP5Zu1JpJ4Abdpi
         2FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700827635; x=1701432435;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rO9jFnlD+BvaZzCZKXX4/R9UdI/XhYc/Zcyn1nYgH8g=;
        b=bZ96NSwS/vc0V2/BfFZDn+/9M7aAobPSkkukvyOx5ZXIS9NeeR838YR8T/LeH8D2Mp
         1+5QfCmb1bIhXua7OOF4xcQv4XtkRZL7zdst2i+qOnuGrdSysh4iYTkrB07y3VhrwMWH
         f/TEMma4OaofVYDQ8DI6sAvgbB6MED8eH9uq8U6RqHpSyox8DpOAKEkSD2nTmcqKz7HV
         s8XpExFoMc5MFUi0cLbs2WizYQNk1mP5N4NcbiXQWgURn93vQ0llDbsVblepngz8YrtI
         JdkefNmM7TUFr2O1yWfF+j+NILCZWMzNeHz+kv39c9g+vPxJaerNJRAUH6rAW/C8Yjrh
         i8aA==
X-Gm-Message-State: AOJu0YyFt8AessVjFJh+NPRbwNU9J5DTIe6dQn6XyRHDERN0CTiVFKfG
	uJ/+CYf2doovaNyP2HR3ElIDx15F1juqARXp7L8=
X-Google-Smtp-Source: AGHT+IGJ+BzzOD+gjIojctbeEoEOJIahbpYbwMMWRdfXYtLDXXl4v2vUZaF6xU/7L3SKXF327eyX0g==
X-Received: by 2002:a17:902:c40d:b0:1ce:33b2:a1e0 with SMTP id k13-20020a170902c40d00b001ce33b2a1e0mr3174628plk.33.1700827635597;
        Fri, 24 Nov 2023 04:07:15 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b001c613091aeasm3017914plf.297.2023.11.24.04.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 04:07:12 -0800 (PST)
Message-ID: <656091f0.170a0220.11fa11.7101@mx.google.com>
Date: Fri, 24 Nov 2023 04:07:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v5.10.201-cip41-11-ga539098fe70dd
Subject: cip/linux-5.10.y-cip ltp-mm: 5 runs,
 1 regressions (v5.10.201-cip41-11-ga539098fe70dd)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 12:07:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13736

cip/linux-5.10.y-cip ltp-mm: 5 runs, 1 regressions (v5.10.201-cip41-11-ga53=
9098fe70dd)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-11-ga539098fe70dd/plan/ltp-mm/

  Test:     ltp-mm
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


  Details:     https://kernelci.org/test/plan/id/65608832e10b86a87d7e4a7a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-11-ga539098fe70dd/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/65608832e10b86a87d7e4a7b
        failing since 681 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

