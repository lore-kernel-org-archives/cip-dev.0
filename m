Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5E1C54E41
	for <webhook@archiver.kernel.org>; Sat,  2 Mar 2024 23:37:08 +0000 (UTC)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
 by mx.groups.io with SMTP id smtpd.web11.63458.1709422619014235809
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 02 Mar 2024 15:36:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=sc16xP9c;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.167.169, mailfrom: bot@kernelci.org)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c1e753eb80so360670b6e.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 02 Mar 2024 15:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1709422618; x=1710027418; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CHu+RTw2mQ14dNp2cOXOfz/g/YqDCR9X7CXDA3Zm7V4=;
        b=sc16xP9cTJsduRpFfAIxzEtsLS6DtZiepn16rVtq8RXvh+kszhSDR2xuTBFxiAvMpj
         qk7W7W/w2I5LeKNPlsXffY6Djsf/J3Jxz4YS2PBgXWaI8XjvNd4TVcyrXKQLrAh2ft2S
         mWT1dgyxyVsZ5OL5VUUwxqTeeGAgZRthG2GJ4tuy5G5KTTVxHsCuOS1ArM7Up1pL7/ET
         BFjxxl8/SO+7PuJ+s8ynH3ddORBOJ7WCWloPAoVqFaNuwIdIa47MhSW4ml1+VLTeE2HZ
         t4O7DFgmL92EOJ9soXy8q/888WQ5v9ANJXIxdl3EBdVC/SU9czAoUmfqp4C/fNQXFfIX
         QM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709422618; x=1710027418;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHu+RTw2mQ14dNp2cOXOfz/g/YqDCR9X7CXDA3Zm7V4=;
        b=JliYDqt/Dc1n35qNwTLDQfQiIWOljZowMpJ0sPoJIArSdQRd/pGBX03CH2BAxG8bj7
         iTtWeF0sCuqbSQBsd6mACmoH9xvt5PRBy3tAmIPehjQ9yxR4hcMMx/cDWPn3nOWzNgGH
         YWhec1hE8xSrw7+oO474d7FCaQZmn9GqvU3DcdqLh8c+cq59vfugYeg/TxsezifHaX5Y
         rE5RCijp/zPyyXsyzuQMi6GZ4s3m8T6EchGEehHMt6wSnqvGTKkFTCiUSTtjcaZeeGv/
         hjMWa46XDfYdK93FcpEfWE7iIaZQHjAP32ijDvgqj2pliIwZZDT6eE7kumz4PQns+M10
         UAbg==
X-Gm-Message-State: AOJu0YwJldO15bWinzrgJv1pgUk5hFNCSwuZ3rDh6QXTt8gQeYwB48Pm
	bIX+ZAgz8tTNq1XtbZi0PBOWNe3oDiMX6qpGiDQs5JO1NYvyAynO2fXsikZ9NkO1dBBVCaEQFv0
	LkCU=
X-Google-Smtp-Source: AGHT+IGACR3Xw+Hr4ZVotTyKlw76uCcR2sYG4x6i67Mvi+p2WYnlCqKHY6il3bDkLdxY5WzalASPvQ==
X-Received: by 2002:a05:6808:347:b0:3c1:c1ae:1613 with SMTP id j7-20020a056808034700b003c1c1ae1613mr5395256oie.54.1709422617857;
        Sat, 02 Mar 2024 15:36:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id fa13-20020a17090af0cd00b00298f2ad430csm5335596pjb.0.2024.03.02.15.36.57
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 15:36:57 -0800 (PST)
Message-ID: <65e3b819.170a0220.52b46.744a@mx.google.com>
Date: Sat, 02 Mar 2024 15:36:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Kernel: v6.1.78-cip15-404-gdddfc5d4f194
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 9 runs,
 1 regressions (v6.1.78-cip15-404-gdddfc5d4f194)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 02 Mar 2024 23:37:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15169

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 9 runs, 1 regressions=
 (v6.1.78-cip15-404-gdddfc5d4f194)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.78-cip15-404-gdddfc5d4f194/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.78-cip15-404-gdddfc5d4f194
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      dddfc5d4f194925df6ee3d06e86b1d1e12412f06 =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig | regress=
ions
-------------------------+-------+---------+----------+-----------+--------=
----
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig | 1      =
    =


  Details:     https://kernelci.org/test/plan/id/65e3b0e6196dde7ee3637012

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-cip/kselftest-f=
ilesystems-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.78-cip15-404-gdddfc5d4f194/arm64/defconfig/gcc-10/lab-cip/kselftest-f=
ilesystems-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65e3b0e6=
196dde7ee3637013
        failing since 31 days (last pass: v4.19.299-cip105-1134-gc868d5e4ad=
aa, first fail: v6.1.72-cip13-32-gf60d2e8cb51c) =

 =20

