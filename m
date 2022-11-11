Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B056C433FE
	for <webhook@archiver.kernel.org>; Fri, 11 Nov 2022 04:57:11 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web09.2100.1668142630302725934
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 10 Nov 2022 20:57:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=ESLAxreO;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.179, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f179.google.com with SMTP id 130so3951080pfu.8
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 10 Nov 2022 20:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SwSDlWEB7mAk+g/ySHnv56tSrMjv5PSLcB2SvJmN/PA=;
        b=ESLAxreO/CxZkW8/OmXkDmoJjinnPwulaFpX8AGAfRWOm/TE6H38pkaH5KS8S1ZKHL
         on7CMjaw1Pl0z3bcA9915URHPj1P3Xp1W86nA9rprLurJVKM4d7CyWmHvn8Q6qVvuHJ6
         afgX0Rkt7Poa95WRK9Xpy6SlRAQ8H/dFgrFde0SKNYsYiBvZV258Qprm3i3P70dosf05
         sL1arJZv/TD+pl1EpvYoWah2/+fVVX+4IxjRvQRxS+DpVM1ebnP4XPcUKZ1bJICRHXmK
         qaSvbyBj4i9+UzUcScfv78Cbcb/ESarZoorDmuyeyybzmAdaLPN7BRGSfX7bmjjzXQhv
         7JDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwSDlWEB7mAk+g/ySHnv56tSrMjv5PSLcB2SvJmN/PA=;
        b=WzeoeYf05Vr6Wdqg8F4OWAec1/PfpYpOF1K9FgIyPARrB/NwMlQkcQ08RgHp0Opp94
         2W0it3z8VM1hoREkTEiBE2R3M35ddgBcHiMakmBegq6fqz9gv6Oag5yqVKEN9o0eQoSu
         qAJCelJWg5fjtWAFLrGy+pG4/h/9vblabRzearPKToxRUUzh6t2MijY5Bc8ErxTysnU9
         pRHXmQwAe2+KyESCTNVkaNqwZz59/hrqxyjY6425h2hlxd5VelbB1yL+CSr4bWZTxHPg
         mFqTceYPOPHXcXDafWhPZFJxruOUxEzKlyvNmIjFnBAbwLHVrJUKayiVOdZ5w64IlO2e
         Lycg==
X-Gm-Message-State: ANoB5pnonHTwKzYhVx5kH2c5fV3Z+9xS/dZLXTLX1zs00NIn5u/xibAQ
	Rp3a9gWKbiX/jjEJjULgNNHTN7U5uFWDQECSao8=
X-Google-Smtp-Source: AA0mqf4ApClwbTzjxVxt2dRoESRF/CoPgYF9C3WqMc14TG9QuuS9I0nwu9VEKn5a3QPRm3YQ/WXZXw==
X-Received: by 2002:aa7:8396:0:b0:56b:c95f:34dd with SMTP id u22-20020aa78396000000b0056bc95f34ddmr842014pfm.74.1668142629595;
        Thu, 10 Nov 2022 20:57:09 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id iz17-20020a170902ef9100b0016f196209c9sm593171plb.123.2022.11.10.20.57.08
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 20:57:09 -0800 (PST)
Message-ID: <636dd625.170a0220.c1aba.1306@mx.google.com>
Date: Thu, 10 Nov 2022 20:57:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.153-cip19-122-g149fbc7cd21d
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 5
 runs, 1 regressions (v5.10.153-cip19-122-g149fbc7cd21d)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Nov 2022 04:57:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10015

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-filesystems: 5 runs, 1=
 regressions (v5.10.153-cip19-122-g149fbc7cd21d)

Regressions Summary
-------------------

platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.153-cip19-122-g149fbc7cd21d/plan/kselftes=
t-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.153-cip19-122-g149fbc7cd21d
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      149fbc7cd21d7e3a412f88c0e29d060f55e237f6 =



Test Regressions
---------------- =



platform                     | arch  | lab          | compiler | defconfig =
| regressions
-----------------------------+-------+--------------+----------+-----------=
+------------
meson-g12b-a311d-khadas-vim3 | arm64 | lab-baylibre | gcc-10   | defconfig =
| 1          =


  Details:     https://kernelci.org/test/plan/id/636dc73258ed8320d0e7db60

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.153-cip19-122-g149fbc7cd21d/arm64/defconfig/gcc-10/lab-b=
aylibre/kselftest-filesystems-meson-g12b-a311d-khadas-vim3.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20221024.1/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/636dc732=
58ed8320d0e7db61
        failing since 71 days (last pass: v5.10.136-cip14-542-g97767707d3d0=
, first fail: v5.10.138-cip15-90-gd4130d0ee3c7) =

 =20

