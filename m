Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98CCC4167B
	for <webhook@archiver.kernel.org>; Mon,  4 Dec 2023 00:34:37 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
 by mx.groups.io with SMTP id smtpd.web10.53724.1701650071811210390
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 03 Dec 2023 16:34:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=MYa8Gsys;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.53, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-58d1b767b2bso2698442eaf.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 03 Dec 2023 16:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701650070; x=1702254870; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g11SZOJ51KYfKOFm2dHNshJ+2/sPQAU2zlRJrkppWYk=;
        b=MYa8GsysslP9WeGqZAS5T7QI6wiXNhRyvDWz/sZoojONm0bxiZKtABnmgqyy8Maymw
         5dSrvQ2e5gptwjNpK5jFQ+Wj1k+BXOGlBplpeqbEB93sABvaGM/+v5BK8H0OWYnRVXKT
         9yuGaX+EX5XJ1Brnc6waSsJKrEqVlqxHvkko0Lv0xTrLyuAIBrMp7FM/g/Bt4JNNMerh
         rx2lqKDB9pkauGEDAMnq5Z8C9Zth+xPzxfLLU2ay37svYJ2gyJBw6XzKpwcseveMuBOI
         MkIX2zWkCfCGxFL+K+B98h2/QtYtSoUY9uLVAcExrlO2WQDc2+UPcZ35xwWVBRu38PM1
         zi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701650070; x=1702254870;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g11SZOJ51KYfKOFm2dHNshJ+2/sPQAU2zlRJrkppWYk=;
        b=wt3nlBHlxx9X0UdMHUeOSSiw33/pOULH9nmxwNqzBd8Q20tzLoKAONybi0i4hFYDxJ
         91E72ehY6nqwX/XWaUKsqAmP5z/KO9ziXrV4pP5omZEXahyH0tbHcjtFqwTbp6LtVNbK
         14bRbPOu+RZzqGfj/0jsmZXimMyHAon+BdlCuNhIKBcKpZzirbWKVqZygE+dWafxQxqD
         XZG9gMXM+9l3AGkTbgGqh6EpeDcnslO6AC3CDsV2aAcGmMic4enaMoQZQwwoq/1KvhuB
         tqOSg095BTuJNx4Ze1vHTNhbiWd3fUFjIZgmvOSJ0BGGdNGS/WxFZt9H9w1ElawRNW/y
         2fnQ==
X-Gm-Message-State: AOJu0YxNj1EKNEABBBPs9P1HEsNxvDM0EAeKeKLHo/GH+08apkhNx+Zz
	SafGOR2p9bYe742VaBpe82Eq+NwgcE++YoB6RJr9Vg==
X-Google-Smtp-Source: AGHT+IE8nppb9j21mb2a0Eg7p0y0YpYvgjAXWT41BT7a7mRXdE5dG8QWkGGqudT/hn9jDlg7/cmGjQ==
X-Received: by 2002:a05:6358:3406:b0:170:17eb:b39 with SMTP id h6-20020a056358340600b0017017eb0b39mr2122952rwd.35.1701650070030;
        Sun, 03 Dec 2023 16:34:30 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id z2-20020a656642000000b005c2130fd8d7sm5627712pgv.91.2023.12.03.16.34.29
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 16:34:29 -0800 (PST)
Message-ID: <656d1e95.650a0220.be47f.ea4d@mx.google.com>
Date: Sun, 03 Dec 2023 16:34:29 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v6.1.64-cip10-rt5
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 10 runs,
 1 regressions (v6.1.64-cip10-rt5)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Dec 2023 00:34:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13783

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 10 runs, 1 regression=
s (v6.1.64-cip10-rt5)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.64-cip10-rt5/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.64-cip10-rt5
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      b0295fc12bdaf65b61b93e18a316c8e20c1f2507 =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/656d1a287e2b06f46ae13479

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-file=
systems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.64-cip10-rt5/arm/multi_v7_defconfig/gcc-10/lab-broonie/kselftest-file=
systems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/656d1a28=
7e2b06f46ae1347a
        new failure (last pass: v6.1.62-cip9-12-g3a5321f469b07) =

 =20

