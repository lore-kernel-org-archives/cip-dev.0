Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17807C54E50
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 12:06:57 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web10.9112.1708690009653651483
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Fri, 23 Feb 2024 04:06:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nw7eZZVj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.210.174, mailfrom: bot@kernelci.org)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e34d12404eso130748b3a.2
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Fri, 23 Feb 2024 04:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1708690008; x=1709294808; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=li/pNl0MdGIfNKAaAj0qTL1KPBMd4os0gdt96ceHJN4=;
        b=nw7eZZVj4dcKer1W9rAybJDqtaN1QGQBrAVBWB/xqNU6Q+LdTGIc+YyRgOu9yL679D
         cW62mu88QaOJjXamLdXYZhUT+kX8l3OEINhvTOth4OvDsZQG3e3pE1zBOKBKqSGMBXAl
         JzZF9Ks7ueUP8Szhu06/Rd5SyvyGcFgJGXcLQHsmyeYVITz4RHH8DDrXQ2dnzOHO9IvB
         HM7yqidSiBqNcATZhQB8Fz2Qqtdm4boUUnOykxSzM6kXPsnWxyFVpRfZGRxgF5WeI7ok
         9Xwh9ogNHJoLXyb/uxsijQA2u1wxzGeSmTVKGG9yt+0jvjvS4Gy/dnzbp935x2RG3ixz
         A02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708690008; x=1709294808;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=li/pNl0MdGIfNKAaAj0qTL1KPBMd4os0gdt96ceHJN4=;
        b=ohwbuwyO434p5olGbk+6U3r7uedtZMxGXTARCE8Quu0XChpydqYqjleHmzLfZ++pfO
         K+Ai2A2NG6t/osrI9Vuf0jBUQrZAJdUnLo1KHZT6xxzaUDvYP1qOLpa14LNO3FP8uLM9
         4YdzfOhtZSdlvHNnJaVFqF1+0FdiQFXME8idYriQGvWe5yiUz6t55+C0dkWvt3LfhmAd
         iaj6QfBGhL35eBQzPJ/I48qABqIGr3P6RTgxnUCEus++lUT/TsOoYuqlLyWLFSpu0fsg
         X7gAd6lKYnkhrZKnJpkoWsLjPTHszIm1UOIpN5VucBWB/38SGgESNGl8o5EqbDqIMFc+
         I16Q==
X-Gm-Message-State: AOJu0YyVION2PAEITDlqh17VVf4XZoZQu07GYrG9ERWjwliBe5dRPBQG
	EXfR7/mM03Kg9Bse1Vvo2/ESbApiTylD6Wn0S40xiBzfT3ZAswlRuTIjUCtMS8suVR9dWiyTfQy
	0pvA=
X-Google-Smtp-Source: AGHT+IG9OHtVvXJ+vFXIN7xBTVvRES7mmEqJNaIb8yR1tEzdr+L/jq7Bp3wd3Jct8gFn/iEFxJLG9A==
X-Received: by 2002:a05:6a20:6d9e:b0:19e:987c:78a7 with SMTP id gl30-20020a056a206d9e00b0019e987c78a7mr1403783pzb.32.1708690008186;
        Fri, 23 Feb 2024 04:06:48 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id t42-20020a056a0013aa00b006e06b8548c3sm3495760pfg.139.2024.02.23.04.06.47
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:06:47 -0800 (PST)
Message-ID: <65d88a57.050a0220.881a3.d0dd@mx.google.com>
Date: Fri, 23 Feb 2024 04:06:47 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Kernel: v5.10.209-cip44-424-g38943e302f8c8
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs,
 1 regressions (v5.10.209-cip44-424-g38943e302f8c8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Feb 2024 12:06:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15072

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc kselftest-lkdtm: 7 runs, 1 regre=
ssions (v5.10.209-cip44-424-g38943e302f8c8)

Regressions Summary
-------------------

platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.209-cip44-424-g38943e302f8c8/plan/kselfte=
st-lkdtm/

  Test:     kselftest-lkdtm
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.209-cip44-424-g38943e302f8c8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      38943e302f8c8bda23c2853f688afa5e35cae90d =



Test Regressions
---------------- =



platform                 | arch  | lab     | compiler | defconfig          =
          | regressions
-------------------------+-------+---------+----------+--------------------=
----------+------------
r8a774a1-hihope-rzg2m-ex | arm64 | lab-cip | gcc-10   | defconfig+arm...ok+=
kselftest | 1          =


  Details:     https://kernelci.org/test/plan/id/65d876cc7fafb429ad63703e

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook+kselftest
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.209-cip44-424-g38943e302f8c8/arm64/defconfig+arm64-chrom=
ebook+kselftest/gcc-10/lab-cip/kselftest-lkdtm-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20240129.0/arm64/initrd.cpio.gz =



  * kselftest-lkdtm.login: https://kernelci.org/test/case/id/65d876cc7fafb4=
29ad63703f
        failing since 112 days (last pass: v5.10.184-cip36-10-ga711f789c23e=
1, first fail: v5.10.194-cip39-915-g96fa7f16cf02) =

 =20

