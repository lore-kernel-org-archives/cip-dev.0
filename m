Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BC3C10F07
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 17:49:15 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
 by mx.groups.io with SMTP id smtpd.web11.42461.1702057749707021699
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 08 Dec 2023 09:49:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=JaqJIfA3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.215.182, mailfrom: bot@kernelci.org)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c66418decaso1668974a12.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 08 Dec 2023 09:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1702057748; x=1702662548; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b/Tu753yWJRH+aD8jtXvBoNvk0O9GX/wA5Qtk1wGH/M=;
        b=JaqJIfA3aEC1De4LIgURTTRVKOVaRuTYq1JwLQHLv4GHW9mR71QeePvfeqpSf4Kao9
         I5apIqcPSG3as9fGWBptPWRi/6Tw/afOs88g6l5fKt4AsS3rGS6mv4PXqtDaol5SzeIF
         +mXXMrXQGyKsKTs3XzdO9CuYggEQaPeamgQJ/XCd9y342ysGdvx/8UCR1BDhlDhHuadN
         53bLgkNbsYYT73i2qswETT6SvLD+vKWgetDwmfqNNafcz9hfEOg23ApwD4L0JqRKUzcr
         7wsp7mdc33cUb23MwPqiuHr3eO2hM00ny7m7FHaIBE/3o1XhNCRdFqg/MlC1ehQn//yH
         1LuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057748; x=1702662548;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/Tu753yWJRH+aD8jtXvBoNvk0O9GX/wA5Qtk1wGH/M=;
        b=u4K5hCnMVZq5cUAwS2AUrPSPpOEVoEQb0ZOhW69z00YG6ofDwvFTdxGOmIVrcFJLlx
         sc7E4E3Gu5eZspW09ApiHUKbYQ/CJLEhq+VVtIoCQw5Ak6uRU8DkmQQWNV6dBfKWFPnP
         z4MZb9mqAAagJ0eoyICF1l6iPaWU8fao9nfQkljAvDicH61G155HFrwC5FA6+HCt2tOf
         2VmXEO6ObSPYsfcRehBNRhR8TL36DouQQZPA8BCVM+MhH2ut3CWOUGfulK+dTyy7YXb+
         vPBmTRq59uIanW+ELpVe7eQEYozjuXQ4BV4QLCSY/aDOPUbiDoevI0ZTSkC/mYW89DC0
         +5Kw==
X-Gm-Message-State: AOJu0YzrD6JeV/lwUusWTJojMWbqn5aDUZfaEBMNRAAPygfwyuIR2KX6
	ThNJe+V0+43qX4BugazB7w1QNqTS7usDTdA51u6A2g==
X-Google-Smtp-Source: AGHT+IGrAEw38eZKmarLUGWV6aSeP0PRzSiTTyOgfXthQS+pYXddlTMwCVYnS9WMOg53ziPgin8Kxg==
X-Received: by 2002:a17:90b:20c:b0:286:6cc0:b92c with SMTP id fy12-20020a17090b020c00b002866cc0b92cmr369081pjb.99.1702057748567;
        Fri, 08 Dec 2023 09:49:08 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id l17-20020a17090aaa9100b0028593e9eaadsm3599978pjq.31.2023.12.08.09.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 09:49:05 -0800 (PST)
Message-ID: <65735711.170a0220.99f57.ab17@mx.google.com>
Date: Fri, 08 Dec 2023 09:49:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-46-g596f4c151d286
Subject: cip/linux-5.10.y-cip kselftest-seccomp: 1 runs,
 1 regressions (v5.10.201-cip41-46-g596f4c151d286)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 17:49:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13985

cip/linux-5.10.y-cip kselftest-seccomp: 1 runs, 1 regressions (v5.10.201-ci=
p41-46-g596f4c151d286)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.201-cip41-46-g596f4c151d286/plan/kselftest-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.201-cip41-46-g596f4c151d286
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      596f4c151d286c71a3612a2120ab33f4ac885d2e =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65734ab14cb83bd520e13490

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.201=
-cip41-46-g596f4c151d286/arm64/defconfig+kselftest/gcc-10/lab-cip/kselftest=
-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65734ab14cb8=
3bd520e13491
        failing since 65 days (last pass: v5.10.184-cip36, first fail: v5.1=
0.194-cip39-1-g53e59f50ca3ff) =

 =20

