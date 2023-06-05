Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6061C7EE24
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 18:37:44 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
 by mx.groups.io with SMTP id smtpd.web10.16983.1685990255491896655
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Mon, 05 Jun 2023 11:37:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@kernelci-org.20221208.gappssmtp.com header.s=20221208 header.b=QEp1fme3;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.169, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b01bd7093aso26945865ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Mon, 05 Jun 2023 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20221208.gappssmtp.com; s=20221208; t=1685990254; x=1688582254;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kzPDw/7fl5UlCYNXLn2lTnvTrGaH+dqBi/QUEC6YMXs=;
        b=QEp1fme30tId2r8gcpAFoEsPvjbh6BpH2k7hU8iJl1PmaDm5kwdF0uaIzQLC/XB7PF
         VCUqzMsG3uwsveq1RDOjCfxZWxBmSm8w+M8y+zlh1Wkmxc5PhKDtvkDCireA96kTa/XU
         k5ZJ8K/GO2EwzSE+v+N5Eet0XQqouHpFlTeEZ27GT6oBeH1EJTEmJGdnNPDHp9IXKC3x
         cX46unNSvv/w2UwPWqVl8u1Irf0FaR+qZozBpsMsKbln2vuOQVDyXZDKKgwxGMCwdAoV
         oTxiYsGGTe57hvVXlfYtUgzeKPLquHOUSOyA6T25AVW2lO4bkwhLDAhzQdTpKom977NY
         Wd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685990254; x=1688582254;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzPDw/7fl5UlCYNXLn2lTnvTrGaH+dqBi/QUEC6YMXs=;
        b=Bl5SxyKXAZTpaLF7DLJb4B06zQrNjzldNEqHUfdKZBc0pFY6CPArL6MnhhyaDb7GZO
         wcjYd3C0bcRMdr87Ub0OMJWEKK+v8DGfTD087NEfCikXKEw3gmh91/dzMNoVY7qV6Fk/
         CDxFX4Dp9CWn3FwVNlkVPslbWsNWGWgRMiVbmGoWdWxUnda7LDi72xfz635Fujg9/O89
         9w1kZqT5WD7HN1ESem9WBlCWQx0sapL2ssvw/pUc5Yuhg7Fxk/ieJLkN39gjSDRT7yuL
         taU9ZhH3k2Pvu5L8cV+zLI282OKng2lrp5vGRDOleqFwKcKTKsjYsADrHn9SDNJF6jkt
         sBVg==
X-Gm-Message-State: AC+VfDzhY2g5kghpynhvXFq9cIPRibo6Kl/FAniyvnsfNztYydk8inew
	rOdGd3pMp57JIpIFISqxkMbAdnQrNawOhKvGXYFhug==
X-Google-Smtp-Source: ACHHUZ6lVshA0aYfFyMGRkuOepczni6I4YKsZ0F/ixhADLKQoc3a1B0B+iBJSodMcaEM9X8FnPpyAQ==
X-Received: by 2002:a17:902:da8b:b0:1b2:2400:f327 with SMTP id j11-20020a170902da8b00b001b22400f327mr1497473plx.5.1685990254353;
        Mon, 05 Jun 2023 11:37:34 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id x16-20020a1709027c1000b001b04b1bd774sm6897363pll.208.2023.06.05.11.37.33
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 11:37:33 -0700 (PDT)
Message-ID: <647e2b6d.170a0220.82ec5.b9d2@mx.google.com>
Date: Mon, 05 Jun 2023 11:37:33 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.180-cip34-26-gc198172c84b6a
X-Kernelci-Report-Type: test
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 10 runs,
 2 regressions (v5.10.180-cip34-26-gc198172c84b6a)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 18:37:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11817

cip-gitlab/ci/pavel/linux-test kselftest-filesystems: 10 runs, 2 regression=
s (v5.10.180-cip34-26-gc198172c84b6a)

Regressions Summary
-------------------

platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =

mt8173-elm-hana          | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.180-cip34-26-gc198172c84b6a/plan/kselftest-filesystem=
s/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.180-cip34-26-gc198172c84b6a
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      c198172c84b6a9338925de15df053d71eda6a6cc =



Test Regressions
---------------- =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
asus-C523NA-A20057-coral | x86_64 | lab-collabora | gcc-10   | x86_64_defco=
n...6-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1be6ec6cb34ec9f5de58

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/x86_64/x86_64_defconfig+x86-chromebook/g=
cc-10/lab-collabora/kselftest-filesystems-asus-C523NA-A20057-coral.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/amd64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/647e1be6=
ec6cb34ec9f5de59
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =



platform                 | arch   | lab           | compiler | defconfig   =
                 | regressions
-------------------------+--------+---------------+----------+-------------=
-----------------+------------
mt8173-elm-hana          | arm64  | lab-collabora | gcc-10   | defconfig+ar=
m64-chromebook   | 1          =


  Details:     https://kernelci.org/test/plan/id/647e1d234eab3bacc1f5de25

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.180-cip34-26-gc198172c84b6a/arm64/defconfig+arm64-chromebook/gcc-10/=
lab-collabora/kselftest-filesystems-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230527.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/647e1d23=
4eab3bacc1f5de26
        new failure (last pass: v6.1.26-1298-g61395b9756bd5) =

 =20

