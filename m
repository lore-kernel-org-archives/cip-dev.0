Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272B7C46CC6
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 16:15:50 +0000 (UTC)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
 by mx.groups.io with SMTP id smtpd.web10.26660.1702570548443966970
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 08:15:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vhhxDCnc;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.178, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so4817091a12.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702570547; x=1703175347; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AORBIb+X/oPMA307kykVPh+pRqQ2nhESTd66ZAYMJ9s=;
        b=vhhxDCncDEAh2cgW89eNbC/8/xSZrNEUGTWAzlNvHchgjMMPmZyC9NMmgLivP6VWLK
         T/1EVibVWnWYEocLl7F7Lhv5Q3JIjByhwTi4inAsgarXrtJeMECwTZP1BeoSWH3GAO6e
         d18pMo1KBshd6z2sDybjqr7x+deozZ/9NUgCnE0OagCz+0r+v27TfdI3aKfuumgca3Y7
         KE4nNndmWyM1ILiyszAllyQS+PmlC65z/Y4SVGRYdx8ukTsolScRld7puCRN0mJSLCvb
         5nHCn3P0Qoyen4HEldku/KHzXT0cnvQkS0g1iJbaCVFt5R+udAlMB6g31q+bVb2e69aJ
         /fSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570547; x=1703175347;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AORBIb+X/oPMA307kykVPh+pRqQ2nhESTd66ZAYMJ9s=;
        b=XR2HtATAIoODpRjPkjqUSU5QwMBwD2nuQQ/guOPeQ/Gf9/DLpspW3lw5VEEaW0bBfX
         HB8Zlgu7gfQx4ojahNiLwAnGkyiUq4jDpvMPvCdcmgWz/QjoHTcDfMNe3DQPSWg8NvQc
         vG3mT3Hc4jhHye7PbWh5MSCAVGtqrwcA0l8KPpPGXBm+nsKBbYbWdCYlt2cYlx5v7xMo
         ZZ7aCwJivyajIKbNbWIENL18nZ3NbtE/nYnMi88g05llDvr/Wu/SBoeDlgWgHYFnlDms
         a6WeTOd5JcLYoXkobP3IwJtg84MWTcZRsdu02jU5Ek6AW0zZMc2ExOl6MGXGuOb7s9u9
         iZOQ==
X-Gm-Message-State: AOJu0YzXDZ6SJg+Nppbla9JMoTmsWt1BJC3tGZPDesCUE/Up0SbgyAIC
	kXHQZEvKbjaR3ub7KIEfPhmLHAy5Z1bRLYfrpjc=
X-Google-Smtp-Source: AGHT+IEs6pVuFCQ8ACGqF7VRE5K7yP9bdQoksTML3vhyybnceC+Jig9rD2pkq1t2iEI6Tf1Iohvisw==
X-Received: by 2002:a05:6a21:8181:b0:190:6363:954 with SMTP id pd1-20020a056a21818100b0019063630954mr4934206pzb.58.1702570547621;
        Thu, 14 Dec 2023 08:15:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id q16-20020a62ae10000000b006a77343b0ccsm12027865pff.89.2023.12.14.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:15:45 -0800 (PST)
Message-ID: <657b2a31.620a0220.a43e6.55f8@mx.google.com>
Date: Thu, 14 Dec 2023 08:15:45 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-69-g8f7b450fc28ed
Subject: cip/linux-5.10.y-cip ltp-mm: 5 runs,
 1 regressions (v5.10.201-cip41-69-g8f7b450fc28ed)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 16:15:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14120

cip/linux-5.10.y-cip ltp-mm: 5 runs, 1 regressions (v5.10.201-cip41-69-g8f7=
b450fc28ed)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-69-g8f7b450fc28ed/plan/ltp-mm/

  Test:     ltp-mm
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-69-g8f7b450fc28ed
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      8f7b450fc28ed99196853536c98ae36c2567e160

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


  Details:     https://kernelci.org/test/plan/id/657b1e6e57769552a2e134e7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-69-g8f7b450fc28ed/arm64/defconfig/gcc-10/lab-cip/ltp-mm-r8a774a1-hih=
ope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-mm.login: https://kernelci.org/test/case/id/657b1e6e57769552a2e134e8
        failing since 701 days (last pass: v5.10.83-cip1-74-g842fbb4554b8, =
first fail: v5.10.83-cip1-89-ga7f9ee34265b) =

 =20

