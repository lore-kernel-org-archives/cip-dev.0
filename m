Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12684C7EE2F
	for <webhook@archiver.kernel.org>; Fri,  3 Mar 2023 20:28:00 +0000 (UTC)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
 by mx.groups.io with SMTP id smtpd.web10.1959.1677875271743612750
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 03 Mar 2023 12:27:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=0midiLZo;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.173, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f173.google.com with SMTP id n6so3969243plf.5
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 03 Mar 2023 12:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1677875271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DoRlxGAna3ZM7iHvek8R3wmCPcL4xBhwc9QvXLDDWmk=;
        b=0midiLZoc+BhSL7vH3QV482xXl6fwqka+WDetC+dY/acQlbhqCc5HQxr7jL9LF/1EE
         r65CTtQ7RwFj1RSW0tRUQpjZMSRFOGMbVcg7LCt+/SiyIJAJRoKf/Muw/dRXJFTb2Gzk
         gZoeD8UD2+Yu5HKjuDJqkQsKXa3rOVk6P7Vucw0udh2NG5UVvRa1G77Y5ijNcca77TkV
         RwcsjH2/ou+H+rj2royGGeYSMCd3Ax/IuCw26H/2A6gj1OoYE9XzvfojMZCa08KWWQQI
         a2tvb2oJb+L5RirvJQK7wU3jrTT3h8/LdIvmdbqW9/D4G9Q4Ol2s7zJreKj+SDbWxrf2
         XgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875271;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DoRlxGAna3ZM7iHvek8R3wmCPcL4xBhwc9QvXLDDWmk=;
        b=xt3J6rPZ8SDCFahOsvveg3uGOLKoXgvw4TB4Vorv//htWcVmBtA2lO1hQHK/wfC1id
         qQgKQtP6k4DEEtCkuNOs1JGKCXdxMfGhA1US7Vnv3ePpUexZ932ZPTMMlFiVWncEkI/5
         zIfl7C2qLSmCkqJ0VeVn5RHK7Rdd5Lx1kRMzeqeviX4OhUtPMjGN5GEE/dtXOqbzLT80
         2UguySpc8UgzGiKoSlJD/i89gC2+NvPmXUdx7aKRNQ5M5uxUc7S4J4gNnnIKe5OtmMfA
         wLWSQdvb0bE5zjzaLPKaaolGvKBa6U0E+m2Fv7q1yB9m15YMhEiadhmRCxl0oBaY/aJy
         TRfw==
X-Gm-Message-State: AO0yUKVPwrYXJgkx7JmPvHH2ivGpBth3+wI38U4+YRFtJwZ5hrc0nikw
	uYpHM/kcBaM77NAJqWZltqm0tW//cX1AhyCBdPeMCQ==
X-Google-Smtp-Source: AK7set/ydyWJ7LKYNKdh3O61HDTGmsF/Y4tFLYlrOXIGU0b6LwvIFKtLQQuqeAFV4D2MRysciAhCag==
X-Received: by 2002:a17:902:aa02:b0:19a:839d:b682 with SMTP id be2-20020a170902aa0200b0019a839db682mr2893950plb.17.1677875270935;
        Fri, 03 Mar 2023 12:27:50 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id kb15-20020a170903338f00b0019cc28bfc0fsm1910961plb.34.2023.03.03.12.27.50
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 12:27:50 -0800 (PST)
Message-ID: <64025846.170a0220.2b269.4847@mx.google.com>
Date: Fri, 03 Mar 2023 12:27:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.168-cip27-109-g23841ec76bec
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 67 runs,
 1 regressions (v5.10.168-cip27-109-g23841ec76bec)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 20:28:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10924

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc baseline-nfs: 67 runs, 1 regress=
ions (v5.10.168-cip27-109-g23841ec76bec)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.168-cip27-109-g23841ec76bec/plan/baseline=
-nfs/

  Test:     baseline-nfs
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.168-cip27-109-g23841ec76bec
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      23841ec76bec7ddf00658918b23753dc2ca930ce =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
                | regressions
-----------------------------+-------+-------------+----------+------------=
----------------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+a=
rm64-chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/640250a08a0e1c4aa68c864a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.168-cip27-109-g23841ec76bec/arm64/defconfig+arm64-chrome=
book/gcc-10/lab-broonie/baseline-nfs-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye/20=
230224.0/arm64/initrd.cpio.gz =



  * baseline-nfs.login: https://kernelci.org/test/case/id/640250a08a0e1c4aa=
68c864b
        new failure (last pass: v5.10.167-cip26-192-ga2cd4acb16b2) =

 =20

