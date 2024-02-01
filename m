Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5948DC48291
	for <webhook@archiver.kernel.org>; Thu,  1 Feb 2024 15:05:22 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web11.17515.1706799920983394559
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 01 Feb 2024 07:05:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vHpfyW87;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d731314e67so7499135ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 01 Feb 2024 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1706799920; x=1707404720; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9ET7PHfdegxc0DzQI2h5qKgbPC3xN/4JC7XhZMJdJ0k=;
        b=vHpfyW87MQZAQIY/65vYjfVvIrFq0EGG5xUdkkaYzDRbmpsgTZDdzPh4HOLWjXTFcN
         9BX779aGlBlUEQRqaTEdVbqOBU7fvBwowhck9u8bfAL5XsPtyXOO2uATzTzjNC3vb/f5
         Q00wcstDn+EwvQP32WYkOol5AIcW1mj07BuS3bXO0ncrX+vFjxIT85IGVK73b7zTqfFE
         kTO3kjHVT08OeM8Y0i+UhF8W9JwiTPB4vEEWDjOoSffVjpDl1EPIQIXa5os8c72zBPU2
         0MIKoyNL1TcOgVGsW3hZmitPtjvi8NKOMKfP6cG3qIHw0ON+8F7Va4JjJwZm9he4PM5/
         kdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799920; x=1707404720;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ET7PHfdegxc0DzQI2h5qKgbPC3xN/4JC7XhZMJdJ0k=;
        b=V22rMK4QEm78LmbB05hzNpGXRF4JjRWgGCrvlMoAMp5rmhF02cXKvrwGnv3Svt/XBE
         Hl38CuwA6iDp1iSsQbG7ejxjeG2drtNDJangsitsqtFJeV/+dkTSXozm5TQCzU2SlOU/
         Ts/qS0B9QWBrhAprMa1OYnCPGIHZFjjQyIZozr+LNdS1kZbFoXCzkI8KGw3hC8g92xr8
         GIdEdSatmWPszqEBkVK6gq4DYJrF/ABkOpPp7M689LmbMOFv3QUqJWTKx39QQRTttvb0
         POf7dHAc3TQgKV9+mSSGRa9PxFTQvRT4A91dESkhpB8CVK39slCJYvLI8XLCPHAJ3lei
         HoPQ==
X-Gm-Message-State: AOJu0YzDlIUSRyNSTGvIk9E+dFj44Kkg2HpgTlZXE3ocPKyMlEWeAt7S
	9wAbB2Y58YM9iqdKzHqA8XykvfmTDuFgGY/+zi1dOUH9YebVpAGikwu1o5WmPPftOCeqXV4QMk+
	0
X-Google-Smtp-Source: AGHT+IGOMp8jMOvVX2AhlEXV6baANJQVnm6vGscbDskV62iQEOieZe5M8VDXEF5mc+PxGyrtCfI9AA==
X-Received: by 2002:a17:902:6803:b0:1d9:5b4d:6ffe with SMTP id h3-20020a170902680300b001d95b4d6ffemr931379plk.52.1706799919939;
        Thu, 01 Feb 2024 07:05:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWC16kaj/JTiXeBnUYH5ndnDRPIY0qUNOaA6MWx/bnvEIjAcGsaH2w7f7OlBvgtlQvBMchHnaS+CSfAXwAl5Es4zlki8ZslPvZbPNFaiyTQGGsn0vq8fFzh9jioSRLY8AzY8dnAhAAfIJipT2EzEYo1Gg==
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c24600b001d96580e7f8sm21124plg.257.2024.02.01.07.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:05:19 -0800 (PST)
Message-ID: <65bbb32f.170a0220.50c99.02ab@mx.google.com>
Date: Thu, 01 Feb 2024 07:05:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Tree: cip
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Kernel: v6.1.72-cip13-31-g9539320ac89dc
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip kselftest-filesystems: 7 runs,
 1 regressions (v6.1.72-cip13-31-g9539320ac89dc)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Feb 2024 15:05:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14583

cip/linux-6.1.y-cip kselftest-filesystems: 7 runs, 1 regressions (v6.1.72-c=
ip13-31-g9539320ac89dc)

Regressions Summary
-------------------

platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.72-cip13-31-g9539320ac89dc/plan/kselftest-filesystems/

  Test:     kselftest-filesystems
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.72-cip13-31-g9539320ac89dc
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      9539320ac89dc2caf6bf646eca56ac33ae7c615b =



Test Regressions
---------------- =



platform        | arch  | lab           | compiler | defconfig             =
     | regressions
----------------+-------+---------------+----------+-----------------------=
-----+------------
mt8173-elm-hana | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrome=
book | 1          =


  Details:     https://kernelci.org/test/plan/id/65bba3ad7d6fd8e06b00a057

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-filesystems-mt8173-elm-hana.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-31-g9539320ac89dc/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/kselftest-filesystems-mt8173-elm-hana.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230623.0/arm64/initrd.cpio.gz =



  * kselftest-filesystems.login: https://kernelci.org/test/case/id/65bba3ad=
7d6fd8e06b00a058
        new failure (last pass: v6.1.72-cip13-30-g79e2886a5da69) =

 =20

