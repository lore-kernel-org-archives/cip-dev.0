Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD0AC54E49
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 01:05:52 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
 by mx.groups.io with SMTP id smtpd.web11.40728.1709341543954035502
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 01 Mar 2024 17:05:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=jhvxlXNw;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.42, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-299ea1f1989so2067134a91.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 01 Mar 2024 17:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709341543; x=1709946343; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+HAdPf2gyUq+LiefysXBf0b7HODk48SZfnZ7QGh14tg=;
        b=jhvxlXNw/4G8nOM++0Lk7m8WnmXoaUjklwTcd3Ohwo79wpwAK3XXEgSAFcq9j7mFYK
         JU0nZScBpRaa5HcM4PrveBohBhlogB4WQ84O0sT46esQw7wHAh6vCPuMjqrWt/kMfQj6
         bNebOSiRBZ1XAUDLa9kbrLtwSZATVPD/RhkugVjFvFcTxv8mU253wnwCf/sl1UmoPB/1
         Jl75QQTbHUEKlTWheRjBI5K4h8FHqdZNfLnHHAR08K3UoOjgpI3X8h1Wn7dq8Sj8B+yC
         9hdwfeCCXmsKln1LHjpyNcZjBPd5VLUPyVP8faGawQQ9prudaW3RY6N1XuFpaCOe1LGV
         5nvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341543; x=1709946343;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HAdPf2gyUq+LiefysXBf0b7HODk48SZfnZ7QGh14tg=;
        b=lVY0dwXjvWTWkqrKNCAfs5tsMo2p3CnULn7uuM3LiWmZmXgX4434l1TYVOJLPPdoJl
         oeEG6QLFCQUa76frXXmQzImhhaCwN83gVk6mK7pExsrlmY/F5idbh69MKa/wTLmGghHD
         3+XWYE4MwyRDxlsTa7/+cGmQYNqfcfcEg6rmT7qJEDtbux+Ku6q4Wx9Bko4ZVqVDhHLC
         xWS5Yxz/xjmvw1D8ZaNdxKnGr0vBKnpxszFSovbJO0NKidqwc1UqMAwcbRna9YWhwzh7
         MOEx+f7RjfTdb1Tjo7fFHVYyDpU/S8bE8a1dm2kc3biMI0P6ECOdReCY39muG1BsqhqP
         ehEQ==
X-Gm-Message-State: AOJu0YyQikY9cl20QjJhrnIYpU+XnKCw30cBpPXeJlZLrdKlb+tMx6LQ
	+0UaNt0v+BeCdO1koJ+dzkmfljCsoB8D4TMFHAc0HRsvBiGbowXBV+O9WvZcTqEK+N8F/aJySte
	ONZE=
X-Google-Smtp-Source: AGHT+IHBwrybbeUM43S6dT9oNZiYHReyu+8SHTCeKeBPuK9wij3fBVP1m86cIL2oQ3rrmSoab2ee1g==
X-Received: by 2002:a17:90a:df13:b0:299:3e54:83fe with SMTP id gp19-20020a17090adf1300b002993e5483femr3162612pjb.36.1709341542586;
        Fri, 01 Mar 2024 17:05:42 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id cp12-20020a170902e78c00b001dcfaab3457sm167146plb.104.2024.03.01.17.05.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:05:41 -0800 (PST)
Message-ID: <65e27b65.170a0220.d29ac.0fd9@mx.google.com>
Date: Fri, 01 Mar 2024 17:05:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v4.19.306-cip107-1142-gdcbd51e7744f
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test smc: 5 runs,
 2 regressions (v4.19.306-cip107-1142-gdcbd51e7744f)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 01:05:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15154

cip-gitlab/ci/pavel/linux-test smc: 5 runs, 2 regressions (v4.19.306-cip107=
-1142-gdcbd51e7744f)

Regressions Summary
-------------------

platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
juno-uboot               | arm64 | lab-broonie | gcc-10   | defconfig | 1  =
        =

r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v4.19.306-cip107-1142-gdcbd51e7744f/plan/smc/

  Test:     smc
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v4.19.306-cip107-1142-gdcbd51e7744f
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dcbd51e7744fcf9baa3ea87a028b574fda95d428 =



Test Regressions
---------------- =



platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
juno-uboot               | arm64 | lab-broonie | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65e269a48eeab82b3563701b

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/smc=
-juno-uboot.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-broonie/smc=
-juno-uboot.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * smc.login: https://kernelci.org/test/case/id/65e269a48eeab82b3563701c
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da) =

 =



platform                 | arch  | lab         | compiler | defconfig | reg=
ressions
-------------------------+-------+-------------+----------+-----------+----=
--------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip     | gcc-10   | defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/65e268dd4b6a626bb663704a

  Results:     14 PASS, 2 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-cip/smc-r8a=
774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v4.19.306-cip107-1142-gdcbd51e7744f/arm64/defconfig/gcc-10/lab-cip/smc-r8a=
774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/buildroot/buildroo=
t-baseline/20230623.0/arm64/rootfs.cpio.gz =



  * smc.CVE-2018-3639: https://kernelci.org/test/case/id/65e268dd4b6a626bb6=
637056
        new failure (last pass: v5.10.209-cip44-51-gdb99ac443b0da)

    2024-03-01T23:46:27.408178  <8>[   19.217724] <LAVA_SIGNAL_TESTCASE TES=
T_CASE_ID=3DCVE-2018-3639 RESULT=3Dfail>   =

 =20

