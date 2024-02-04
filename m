Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9941AC48297
	for <webhook@archiver.kernel.org>; Sun,  4 Feb 2024 05:40:36 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web10.33695.1707025227507906699
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 03 Feb 2024 21:40:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=wRRTZ6OS;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.181, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3be48947186so1925740b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 03 Feb 2024 21:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1707025226; x=1707630026; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7dFRPmfDn1bDbk1QjurQy9UCfT6EOForXgrqZOOS0E=;
        b=wRRTZ6OSuq19GmhKGUWT32hXenj0DqH12XOjRHz6yqYODAZPJvsoSPK1c4/WqlfrYs
         DZt33vx8zMbCJYkeSm6dXfXvbKg1r+cD9oc26EmFe3kI15WNrHwbEWNwPmIHB5/0Vd9U
         DiLx0IJ2vnwZBGgRY95K66N/GOiv0jkHnXEdSj1XFzHMiZAIyBP1FW1SGNwLuFAGOw5J
         xRif5fejAc31XW5AwKIqx52PIKoQvZ34AHTrhQUQhcdzWVfwsvqy9uKWBkZQxa+B9MOZ
         5AZS78CKDX6u3EogYDZI4HsiWOLZ9krOk0/n+HbOiGCREd42TlvvI1CLPFVlAj0Ad3VB
         lD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707025226; x=1707630026;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7dFRPmfDn1bDbk1QjurQy9UCfT6EOForXgrqZOOS0E=;
        b=R+PduiuCfY38F0wpHDS5QnBLWn7vZ14ZYYH7HCLBBz5c1rwjvvQGFizoCFYutb16y3
         ncCehl+1v0JvWzfD4ugYDPzSADtcSjmMBxe8Z45QIYA9Z0cdORAEzl6Yo9qoORhF3cld
         iiKqgAZYqvk85sFhn5bjnHv1s9Cj3uvG1urvXUlRNEG8aaBiVSkmFmiiLpSqpG83o9IQ
         amFbeR8yWu5uLprN6yAhzcbt0E7R6i7fdOOtKMGd9rS4TP5HVZ+OcW8cnJAD/B/Gxz4i
         Qeg82vyHPDe/yjHetEfVRwOFECHK0ymsFI0yOeDRYDGNvZDRXsRSzJ1ZsMUaZBmz39bD
         CC+A==
X-Gm-Message-State: AOJu0YwKGCuJ2uHyR/QtFfjgu9dFn2vDR+bLb/ApGHfT4wlFacKov0vT
	lJ3uaZsKQ3yp3AX4JeBU3f0eKvvCl4hszVx0Po8WSgam90t/i80fqIsklyYCrDwDxUDKtB5hldF
	5SR0=
X-Google-Smtp-Source: AGHT+IGFAsVl70TStTqdhEiRFt7qybLxNGuFCWKo3uKIbhYvU7hh7ZaD4snC8qegbvydaIRo3Vg4+Q==
X-Received: by 2002:a05:6808:189f:b0:3bf:d218:79ae with SMTP id bi31-20020a056808189f00b003bfd21879aemr2864895oib.10.1707025226089;
        Sat, 03 Feb 2024 21:40:26 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id hy10-20020a056a006a0a00b006e03ee738edsm178378pfb.117.2024.02.03.21.40.25
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 21:40:25 -0800 (PST)
Message-ID: <65bf2349.050a0220.edeb2.05e4@mx.google.com>
Date: Sat, 03 Feb 2024 21:40:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.75-cip14-132-g6e54756fbd6c2
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs,
 1 regressions (v6.1.75-cip14-132-g6e54756fbd6c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 04 Feb 2024 05:40:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14649

cip-gitlab/ci/pavel/linux-test ltp-fcntl-locktests: 13 runs, 1 regressions =
(v6.1.75-cip14-132-g6e54756fbd6c2)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.75-cip14-132-g6e54756fbd6c2/plan/ltp-fcntl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.75-cip14-132-g6e54756fbd6c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      6e54756fbd6c2a85eb65a7be04700955d2e49b68

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


  Details:     https://kernelci.org/test/plan/id/65bf13127b3868272500a043

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-=
locktests-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.75-cip14-132-g6e54756fbd6c2/arm64/defconfig/gcc-10/lab-cip/ltp-fcntl-=
locktests-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/65bf13127b=
3868272500a044
        new failure (last pass: v4.19.299-cip105-1134-gc868d5e4adaa) =

 =20

