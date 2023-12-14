Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C12FC4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 17:22:40 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.28663.1702574552155016118
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 14 Dec 2023 09:22:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=buf4y2PJ;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.174, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d367494c96so4348345ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 14 Dec 2023 09:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702574551; x=1703179351; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YRdFzefi78xfvWNuk2fLyQ2PCtMbQLdJrF3jt+G6fNQ=;
        b=buf4y2PJcnp98Zc9Tcp29oCl62zq2x9NXUfbrHJRXRNvfMxTjpBz7IFAjsl1pWVaeD
         rCi4uzAsrOb6wg9a2FCjPbKVCNus6WhK8nGJ+0UcJbQwJxHURgjFg9XCeOK7g5g78n7I
         FbKKRrVHPsHwkXxGvsjO6cFjdiZZlSA+tcaXn7mQpdqzf+EXKOwh7HocYvkW3ds2eI1m
         5xFbABLMavt3SBtSwkJxnjo7wlGUalgNBj+9G6/LgGlIP+W+HX1/yviLorfL5jlmvWPT
         QMtRC3MCy/xXJTWv60/nMIb+uY/3HRCdZNOWw4fy2bOvwpSXFw8ti+Q009TPzg4G9lD5
         aqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702574551; x=1703179351;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRdFzefi78xfvWNuk2fLyQ2PCtMbQLdJrF3jt+G6fNQ=;
        b=CEcA6X87OJ1g8oSfCDYaPW6hTUUoklu7dPa3WvosOMll6cRXQ66hMf6OADz62jke0p
         DvPiBqIcWth0Nq4vZQZFTQCSPxJ2RarAW0GiDft+33kRe6irS7JHB4twYkaNcREiMUcY
         8ZeRAZ76UW1OajNRgItUE8FxgHcKp4rfXecVndf2kN7kUhU99BMD7+WBPSENZcM/MTe2
         0L0y8pjN+OJvQY49BS2oYREjUm6nk6DW7CcuLkUbLo1IPJjjm39CLMqij9ifXBToika9
         5wHwitS6FF6+S2yhELYk6P+DWpi15Sj1aMCzbg7j0d7LbEyW5FEM8TfINHmsfI4Sgzqm
         Fvdg==
X-Gm-Message-State: AOJu0YxwF7oRjxgRKl7uaMcqso/7GOTHzwmWpFq6uYbvneJaRmf4QcYB
	S8iqQHwGTv6lD1POOacHFzsHO3yf0qFUuy6rXOU=
X-Google-Smtp-Source: AGHT+IGpP1hSqiUWP/io2ohrpLFDn2md9JMMOirb7ybt4EfA3OsCKtKtMPNCRMK1kpN1QaqeijClMQ==
X-Received: by 2002:a17:903:645:b0:1d3:7757:b5bc with SMTP id kh5-20020a170903064500b001d37757b5bcmr426649plb.73.1702574551175;
        Thu, 14 Dec 2023 09:22:31 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902ce9100b001cfb99d8b82sm12692511plg.136.2023.12.14.09.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:22:30 -0800 (PST)
Message-ID: <657b39d6.170a0220.cc057.73e4@mx.google.com>
Date: Thu, 14 Dec 2023 09:22:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.66-cip11-1-g2d3d776d703d7
Subject: cip/linux-6.1.y-cip kselftest-futex: 6 runs,
 1 regressions (v6.1.66-cip11-1-g2d3d776d703d7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 17:22:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14126

cip/linux-6.1.y-cip kselftest-futex: 6 runs, 1 regressions (v6.1.66-cip11-1=
-g2d3d776d703d7)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.66-cip11-1-g2d3d776d703d7/plan/kselftest-futex/

  Test:     kselftest-futex
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.66-cip11-1-g2d3d776d703d7
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      2d3d776d703d7a5abcbbebb5ff00910d7e1102ac =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/657b2a01c4000d5a53e13481

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.66-ci=
p11-1-g2d3d776d703d7/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-mes=
on-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.66-ci=
p11-1-g2d3d776d703d7/arm64/defconfig/gcc-10/lab-broonie/kselftest-futex-mes=
on-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/657b2a01c4000d=
5a53e13482
        new failure (last pass: v6.1.64-cip10) =

 =20

