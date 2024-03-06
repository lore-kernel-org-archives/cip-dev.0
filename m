Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F66DC54E5D
	for <webhook@archiver.kernel.org>; Wed,  6 Mar 2024 22:46:55 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
 by mx.groups.io with SMTP id smtpd.web10.9703.1709765208915308143
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 06 Mar 2024 14:46:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nfkF6ebT;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.173, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e6568e169aso292666b3a.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 06 Mar 2024 14:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709765207; x=1710370007; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IK9OLgAqheXQVEZB/ez8XicefizyhiDqly8zJQRkZME=;
        b=nfkF6ebTVV1clSxMEYfX/DecoUWl6LBNWRx/BLCwo7y3KAnm2/kzONR2DZcIVO5+U7
         srfh65XquGBkFKJ+56jaaEJ4pic9FTZAW8JYh3ZjugqrXXjJp3XTr3gUynMZe6LIeKgT
         6fHQp00E7C7MdgtNI1vN1Lsx50WL6jcrL6JtlK2LDvt5HR2GoF1D5O1Dj6QkF2k7S4iR
         c2wimh9RzYeLQ7IVA+EUjEx3nxY3oO4bWe1YH3ZtAFPi8lz9o6jZ9JGE4d2yc7HJyZXQ
         ePC/+tfyqF1nRGZyu1Wcz28ccDARcsG6P/KatVdnf+u4RQJ91BP/t6LuYUbRkbE+CiwQ
         F8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765207; x=1710370007;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IK9OLgAqheXQVEZB/ez8XicefizyhiDqly8zJQRkZME=;
        b=oWmiZfzQEE0Ow/g6W3xv0s7yZ4b0rCwwV6UnKcn5I4SEB48Ebj+MPcPJPZV092LDev
         IPp/RDXeUsssxbRbP0uf3ceZrTZwCPrrx9xoj2qd0UoHJouVBz4JQrq4zTSquBIQ8NvW
         T4FQctpNKelfjcymu1Z5Y/Ts3BY0XL7vblmmsGtzwmA8pBsp15AnO21e5/2OlBIfKc5x
         EebFXPjL0q5ZobCa5ujURPV4IuqlWY5/VykoJvEe8wJLXM/Dexk1N5lu3etFdOIOS4WL
         66GhNtA4Mf5J2Vo2EK76dsSFdzQ2f6TLII8yqGTxWyZmXFeoxMbDUH7lZQSAf4WkExYs
         R2Ng==
X-Gm-Message-State: AOJu0YxVycB3XpsYdki7D6LQi7xGmhQtjAHpFmCuDwp8xSsHfjtoXXPB
	4TMCLc+MXNC5nr9DEowO3/pSRUBePBveNJATGXKmjIbYTgXPS5XVvAjZQlJ+lMm/RAo6P3HEtpE
	nAys=
X-Google-Smtp-Source: AGHT+IG25V1PylhO0C5csRg/61JzY71LOFlDsSh0E5wY8yvwKw18Yo09eZk2VJmZ6kbfvv4UoZFyhQ==
X-Received: by 2002:a05:6a20:971a:b0:1a1:4ed3:c088 with SMTP id hr26-20020a056a20971a00b001a14ed3c088mr5199115pzc.42.1709765207322;
        Wed, 06 Mar 2024 14:46:47 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fe22-20020a056a002f1600b006e56277fd45sm11344734pfb.190.2024.03.06.14.46.46
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 14:46:46 -0800 (PST)
Message-ID: <65e8f256.050a0220.5530f.dba2@mx.google.com>
Date: Wed, 06 Mar 2024 14:46:46 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.209-cip44-594-gb47da48f3bae7
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs,
 1 regressions (v5.10.209-cip44-594-gb47da48f3bae7)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Mar 2024 22:46:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15244

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 8 runs, 1 reg=
ressions (v5.10.209-cip44-594-gb47da48f3bae7)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-594-gb47da48f3bae7/plan/kselfte=
st-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-594-gb47da48f3bae7
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b47da48f3bae7f477104b0c214451338a6a343df =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
 | regressions
-------------------------+-------+---------+----------+--------------------=
-+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+kselftest=
 | 1          =


  Details:     https://kernelci.org/test/plan/id/65e8e2134fe046b6b34c42f7

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-594-gb47da48f3bae7/arm64/defconfig+kselftest/g=
cc-10/lab-cip/kselftest-seccomp-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/65e8e2134fe0=
46b6b34c42f8
        failing since 125 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

