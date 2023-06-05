Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59492C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 10:30:42 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web11.4169.1685961036387050033
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 03:30:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=eFpUo0+S;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.176, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6532671ccc7so3421706b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685961035; x=1688553035;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cr+hlguDZA0ae+4kRQiz2v4IyIuTh5qpCjaP4e6jOKY=;
        b=eFpUo0+SN26xyDDpbsaDpQQz/mmxlp0dtOnXg9XgBeKUgcEwotDRulG7T+rJvkucMA
         4OiEBlIexhQQqhDGCeBBkdIWI4bdIZcUVN8WzShTtgZvmcBwv8Yb0O5uyHUgHXWGL1aC
         /g+28Ymf5vSUI3kZdo428eFYMbGsfHFKAMkqyC+YnuyZ/qX70zppO0vtdZsYzkxFvIip
         x+TVVqyCsOMKLQl9t1W2Khwz/0276xGbbarTUVWAc1dX8wDvCM4eRCJjVpVCkYHP6/A4
         gFiOong94q+a7375PHI+BYzPfGaqpTilOQuDE7bpncX307hE+apaW6hWGep0CivuYEzs
         7lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685961035; x=1688553035;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cr+hlguDZA0ae+4kRQiz2v4IyIuTh5qpCjaP4e6jOKY=;
        b=RmJ2X8d13MUcJrb6JlBU0+dMt3uetUHftIVPf/vA1JF5EseixzzJjJv2PMDKCoPwiA
         IFzuelVKdgJ/GNDODpdRASKqTxeNFFeL6dXqujDvdpomzn0cDC3pP9fYhIhFCcL/TqBE
         SjExiU3nWChNS7L5FZDF9rWde+fb32mHTkLa3xTog9feH21MIBGIxsRBAZFNV722hbdn
         QnYA2u9tRM7GfAcvYKQveJGyrgLLRcdefh94DLb4pDUbjAMhDkkf1hV0CX/1XuPF3t0A
         Onf/6QWJPxuEPLCnypITi9O/XeWnwi75tZxoYFoCgEgFRFy4WXM4g7UTNj+qeQV41DjJ
         TFlQ==
X-Gm-Message-State: AC+VfDxGk3TANs1YgO1pwkqjfhSQ6kZEQpcrn64JjMbAVkh+I69jJEuZ
	G+hwtflEMtfJxSeJlHLmDeN8efdb5I6AQn96LPOUfA==
X-Google-Smtp-Source: ACHHUZ6ptFfM2ZpYW2Vm1rSInXkTDuAJPk82NUcgJMuDrDj0dCXDNHGl8f/t6zPBDtPc52r6BTsLwg==
X-Received: by 2002:a05:6a20:3c90:b0:103:8c8b:c689 with SMTP id b16-20020a056a203c9000b001038c8bc689mr8270685pzj.51.1685961035289;
        Mon, 05 Jun 2023 03:30:35 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id r12-20020a62e40c000000b0064ff855751fsm3491374pfh.4.2023.06.05.03.30.34
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 03:30:34 -0700 (PDT)
Message-ID: <647db94a.620a0220.19ff2.4f7d@mx.google.com>
Date: Mon, 05 Jun 2023 03:30:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v6.1.26-1302-g2631206dd75c2
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs,
 1 regressions (v6.1.26-1302-g2631206dd75c2)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 10:30:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11783

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 4 runs, 1 regressions=
 (v6.1.26-1302-g2631206dd75c2)

Regressions Summary
-------------------

platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v6.1.26-1302-g2631206dd75c2/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v6.1.26-1302-g2631206dd75c2
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2631206dd75c25509be5c8ba4a58388ccad120ec =



Test Regressions
---------------- =



platform         | arch | lab         | compiler | defconfig          | reg=
ressions
-----------------+------+-------------+----------+--------------------+----=
--------
beaglebone-black | arm  | lab-broonie | gcc-10   | multi_v7_defconfig | 1  =
        =


  Details:     https://kernelci.org/test/plan/id/647da9c12826ad82cbf5de34

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: multi_v7_defconfig
  Compiler:    gcc-10 (arm-linux-gnueabihf-gcc (Debian 10.2.1-6) 10.2.1 202=
10110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-filesystems-beaglebone-black.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v6.1.26-1302-g2631206dd75c2/arm/multi_v7_defconfig/gcc-10/lab-broonie/ksel=
ftest-filesystems-beaglebone-black.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/armhf/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/647da9c1=
2826ad82cbf5de35
        new failure (last pass: v6.1.26-1301-g6369cf0363211) =

 =20

