Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AA7C4167B
	for <webhook@archiver.kernel.org>; Fri,  4 Nov 2022 09:23:49 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.web11.9158.1667553826560097457
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 04 Nov 2022 02:23:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=BCZViy34;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.43, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f43.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so7673167pjk.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 04 Nov 2022 02:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6BmTk3/rLyHLbdkZx04ftuLoRxfP3IBYCwzDiySsSRE=;
        b=BCZViy34Ss+fXxbl/V5KN3cw1648n6Xv7aLKn4uu3c5WxPwDibUERuF9wMASbafskD
         FiYJ1e/ZJKaAUk/up3xZF8L9hz0LYW4YQvnY8xAxI2La2HGxmQHuHT1bvEa2QWeRtJ4s
         Wgh2LeiwtzwGLN9biVeg1gsY8YbKee+77mcbkBJdSCltRW4ej/LsaLiwrTk3pCGYRMRz
         7mPeXF8O6XjKhT+RmYDcXyoz3es69FMCPb+u8R+bjGVoY2CsIxIUIbLebIQLlrdMcvBt
         6W1AvEOyVCZhtO+8/+zhO8KOI6IBrHxso6P6PC5GQBNJUUB+61QwvW9UZtP/nKZ3c13D
         WFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BmTk3/rLyHLbdkZx04ftuLoRxfP3IBYCwzDiySsSRE=;
        b=y60yhunHxKlxajihzp4exteUCz6NdwaEYgu/ZjrC+t6+0jGqqPmoYoqCMA7t8mxaV9
         YaA8kJJ43tA9biVUz8q3Ezz37saoIqC7t8ym6KIB9WaeGmobm0RoH/wUrvErW9JZAUPW
         IRuk6eUYi43AkamUo/aI5KRsCr1WnebRS4KclZ6LbkAqZFBpExEn2e5Ij7Wb075CK5Kk
         ym3krAz5tpeaiy0Yd2LDtFVPNyxnoO66IkS0J8Cd8YruuxZo9K35TLkBoj+Cl4FviYUg
         IAtTN8P4PBY6HXVuzz1guglAAk9dVr1RdP2m2qrERWiGbwlNX1ukGtOj78SmJugEkJjn
         VCig==
X-Gm-Message-State: ACrzQf2CFREEsypawD0QB6Gqza3PAVFUQf3aG2aerWrgeRfc+EVpZgBR
	9SRXya2ZC6Fd6USyj70vewetzNYPXeX4Ag==
X-Google-Smtp-Source: AMsMyM6tYksBoX5urMvP+dKAqBr9DCG5EliPckBGljAzNS9aTD+shYmiK5FlzQaE8kbeusTmDRh7gw==
X-Received: by 2002:a17:90a:d50e:b0:213:7a2e:8991 with SMTP id t14-20020a17090ad50e00b002137a2e8991mr36194818pju.113.1667553825913;
        Fri, 04 Nov 2022 02:23:45 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090340ca00b00176b3c9693esm2058705pld.299.2022.11.04.02.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 02:23:45 -0700 (PDT)
Message-ID: <6364da21.170a0220.61613.41cd@mx.google.com>
Date: Fri, 04 Nov 2022 02:23:45 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.147-cip18-12-gcb2b164780be
X-Kernelci-Branch: linux-5.10.y-cip
X-Kernelci-Tree: cip
Subject: cip/linux-5.10.y-cip ltp-pty: 4 runs,
 1 regressions (v5.10.147-cip18-12-gcb2b164780be)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Nov 2022 09:23:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9931

cip/linux-5.10.y-cip ltp-pty: 4 runs, 1 regressions (v5.10.147-cip18-12-gcb=
2b164780be)

Regressions Summary
-------------------

platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-5.10.y-cip/kerne=
l/v5.10.147-cip18-12-gcb2b164780be/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-5.10.y-cip
  Describe: v5.10.147-cip18-12-gcb2b164780be
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      cb2b164780beff6c4be7ccfd9020e39c07c44f3c

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  b79157c8375cfdd2abfc59f63afe8ea09eaa8c5d =



Test Regressions
---------------- =



platform           | arch   | lab           | compiler | defconfig         =
           | regressions
-------------------+--------+---------------+----------+-------------------=
-----------+------------
hp-11A-G6-EE-grunt | x86_64 | lab-collabora | gcc-10   | x86_64_defcon...6-=
chromebook | 1          =


  Details:     https://kernelci.org/test/plan/id/6364cc1926ca838308e7db4f

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: x86_64_defconfig+x86-chromebook
  Compiler:    gcc-10 (gcc (Debian 10.2.1-6) 10.2.1 20210110)
  Plain log:   https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-pty-hp-11A-G6-EE-grunt.txt
  HTML log:    https://storage.kernelci.org//cip/linux-5.10.y-cip/v5.10.147=
-cip18-12-gcb2b164780be/x86_64/x86_64_defconfig+x86-chromebook/gcc-10/lab-c=
ollabora/ltp-pty-hp-11A-G6-EE-grunt.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221024.1/amd64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/6364cc1926ca838308e7db=
50
        new failure (last pass: v5.10.147-cip18) =

 =20

