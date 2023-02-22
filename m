Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD71CC61DA4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 05:46:44 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web11.2271.1677044802635716622
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Tue, 21 Feb 2023 21:46:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=C2cx6htu;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id fd25so3054849pfb.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Tue, 21 Feb 2023 21:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l3JXTWgjk26W0u3/kke+GNzMFW1tzuxRSOXvcMdVS+4=;
        b=C2cx6htuEJEdFybpoKqYlrISk6m63JPpUvM9dtPeT/wRlfEOoqmNfqqr/gHr/b/Zmg
         UG2yjA1zNGfv5kOYpa7RZESaM097uNqeye8CPF5ortFmjnKntgm4x3jKUdpAQUD85DWB
         VVCL+EK54tXjHPLL5Az4+vhup2W1PVrccyZ7OwXnm3BbWrhYE2COg7GlgMmM4v+nzN4W
         Z8J8ic3ON3jvSe2evPjwSf5nye6/4EqTFro61JAb0NjsKnBk8t/9SkRFK5QxoJdHh0bN
         SCDNk+cRXCi/8rVGnVkAxG4m+MoGi6W7pbB5e3xGlufsVofIjGGevVfPTQ0oxBZRxsrx
         e8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3JXTWgjk26W0u3/kke+GNzMFW1tzuxRSOXvcMdVS+4=;
        b=aneil144bZq42m2TwrvplQdqAKaXax9bHWd7dEBxmZt0ayMvHXYKbx31rZ6UqWD35P
         nzbQSOqny2ghfBrF+3Fsykm5M7XfEQZ6N2zp4JLQzXggiIUH7H/JkHZiOGBq39om8X1O
         EgKScmmvsBz9Km6MgSGoJQYGDXejTX/Pm0KPXMkiERY9O4YrTKz+tYxfGOWPamx4+4Uu
         8mMaNwia2txSQ3KcSld51lPgKLhVkZ/tyLc3MwlDYiCEVJIUF2QooBiWTiR2ZebEahVN
         mu1YyhOvdpsf3Hi5eW5fOOX9K3AVicBlXBq5GRzjH57mf1CnOMEkdQaNdl231ZMd4YX7
         7W6A==
X-Gm-Message-State: AO0yUKWUObZqD1fKrQHFp7rSRVGR6jtzYZFucPlcZlNgxFMGFaExeEAA
	TIQo7h0eY2CM38sOsYVCoTlAl4H6jh+GMptRzc0=
X-Google-Smtp-Source: AK7set+6pQbL+pM48N2I73I6k849WNmB0XE5sRYG1vrDYs3tjq74eUGNV+ZA3LehWkUsqqD4jExa4Q==
X-Received: by 2002:aa7:8f0b:0:b0:5a8:380d:7822 with SMTP id x11-20020aa78f0b000000b005a8380d7822mr6203337pfr.23.1677044801739;
        Tue, 21 Feb 2023 21:46:41 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id k11-20020aa790cb000000b005a8d396ae27sm600521pfk.8.2023.02.21.21.46.41
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 21:46:41 -0800 (PST)
Message-ID: <63f5ac41.a70a0220.bc51c.1809@mx.google.com>
Date: Tue, 21 Feb 2023 21:46:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v5.10.167-cip26-2-g1e87e7748b91
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 1 runs,
 1 regressions (v5.10.167-cip26-2-g1e87e7748b91)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Feb 2023 05:46:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10770

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-seccomp: 1 runs, 1 reg=
ressions (v5.10.167-cip26-2-g1e87e7748b91)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.167-cip26-2-g1e87e7748b91/plan/kselftest-=
seccomp/

  Test:     kselftest-seccomp
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.167-cip26-2-g1e87e7748b91
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      1e87e7748b91cc6ec7f9f32d6d156ee15f651805 =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig  =
         | regressions
-----------------------------+-------+-------------+----------+------------=
---------+------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig+k=
selftest | 1          =


  Details:     https://kernelci.org/test/plan/id/63f5a4d3de10789b8d8c864c

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm64/defconfig+kselftest/gcc-=
10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.167-cip26-2-g1e87e7748b91/arm64/defconfig+kselftest/gcc-=
10/lab-broonie/kselftest-seccomp-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230217.0/arm64/initrd.cpio.gz =



  * kselftest-seccomp.login: https://kernelci.org/test/case/id/63f5a4d3de10=
789b8d8c864d
        new failure (last pass: v5.10.165-cip25-144-g43e1d8dfbb26) =

 =20

