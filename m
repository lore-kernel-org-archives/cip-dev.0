Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18594C64EC7
	for <webhook@archiver.kernel.org>; Sat, 25 Feb 2023 19:56:00 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
 by mx.groups.io with SMTP id smtpd.web11.51923.1677354957985345088
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 25 Feb 2023 11:55:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=1gX5oA0O;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.180, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f180.google.com with SMTP id i3so2908707plg.6
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 25 Feb 2023 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HsPFHxZrsT+GQSmbUS3aKUn5rwVRjl5zEwLygMufTjM=;
        b=1gX5oA0OcbXJeT3pt5nmVlA9y4tEL4PpIw4dycrawDrz5bL5pFF45LWSonSso7VHtM
         PDQAM0KbW+vYHiNuHRAj39cW35NYN5NbPNRAgcGpQ+K5SSiahw3tQUWtNXKjurwbSoj0
         ufgLFrrv8IK7Q8lMvcVhGjeFenD2tYNR+9lOGTxdtNW2C1QvCui9BCTZGOquNfbt3E4o
         eE7Yj5p5h60XdFxhM5hXU54a2AdZuEkQh6DMew/3XRGW0eNyXGaiOX2M26+fq35ICdNg
         zsbjv+L8J9HIre0Nn8cuXmKLOvpuHQ3MSzU1PMj7b7RJRDnlS84GAZdPdw8IqbIJ6GHP
         eAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsPFHxZrsT+GQSmbUS3aKUn5rwVRjl5zEwLygMufTjM=;
        b=fzkjOmclkF5ZyUtN0n4okQKjuY1JfydutACz6ImwfK2xE9mJHPlLJ5tSDbU/uuFj0d
         w0Va2SjV/hDf1Lbt8vnImlgkt9bwzY2YuD8sUXpxvELZG26T5DYWAqBnIyHLCAcHe5M0
         lva5LglaZzuaFIpondriVm4fzNh93fDeWqhjTc5czKm/DNqPl6DM2roJwHvhr6xdG+2l
         xTtVawPbdgSUtX4p/i+CwngNuiqwHfC5JGDEvDQh4ed+uNM7Hc3BFIjCMwE9HaVUDv4K
         DOZVep+kPKI+QGCXkYKac75lC0rY8xHiokz6zrp2P8ymRLYZcgqBRB15vQzt+NTuGNjW
         yJkQ==
X-Gm-Message-State: AO0yUKWE6PSVF9KmVApROwHgabngAjFOlqjr3inidP0YjnjtbSneegi1
	UMVfrGJT98hPRukZBzTbcr8brlW5/o54h3TUqZk=
X-Google-Smtp-Source: AK7set9jnl4UX3onl9gkvZlV6sE+tTNuZ7G75mwhGjcjL4hQl1yzpCoEm8y88opeaZVBV/OpmObvhg==
X-Received: by 2002:a17:902:dacf:b0:19a:a210:825 with SMTP id q15-20020a170902dacf00b0019aa2100825mr3801870plx.20.1677354957317;
        Sat, 25 Feb 2023 11:55:57 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902968400b00198f36a8941sm1615794plp.221.2023.02.25.11.55.56
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 11:55:57 -0800 (PST)
Message-ID: <63fa67cd.170a0220.f8b7d.25aa@mx.google.com>
Date: Sat, 25 Feb 2023 11:55:57 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-86-g19cf8cd2dd993
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs,
 1 regressions (v5.10.168-cip27-86-g19cf8cd2dd993)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 25 Feb 2023 19:56:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10850

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 7 runs, 1 reg=
ressions (v5.10.168-cip27-86-g19cf8cd2dd993)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-86-g19cf8cd2dd993/plan/kselftes=
t-seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-86-g19cf8cd2dd993
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      19cf8cd2dd99376e3a8b44aa56fbc1e1f7bfb770 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                  | regressions
-----------------------------+-------+-------------+----------+------------=
------------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm...ok+kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63fa55b7d6a2ae26498c867a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-librete=
ch-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-86-g19cf8cd2dd993/arm64/defconfig+arm64-chrome=
book+kselftest/gcc-10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-librete=
ch-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63fa55b7d6a2=
ae26498c867b
        new failure (last pass: v5.10.167-cip26-192-ga2cd4acb16b2) =

 =20

