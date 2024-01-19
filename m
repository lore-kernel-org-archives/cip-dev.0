Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389E1C47422
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 02:02:24 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web10.12257.1705629742203482927
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 18 Jan 2024 18:02:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=vPMIewJx;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.175, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d70a98c189so1911825ad.1
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 18 Jan 2024 18:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1705629741; x=1706234541; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GYS8sz4H8Ky7qRcHvKaJSRnTFEa4Y7X+Vg+4hhtsnV0=;
        b=vPMIewJx3nCz7lIHbc948uV98L0ek/LIAXHgtsPx6v5g17/wRn3Ld8PPJMOHBJT8gE
         n5DYNW2mrJ7sAMlVeZ2QZfbc4mQ5eHD+Vc+EUrvrVOFTuyCwUWUUj56jMCKtvyPczQ2x
         iqv3yNxWcGhuuJF8BfuUGvG3y0oGdLN1Muno4ZPxeN/9ojsx1e5nEWbhuFUbPfX7Tlrx
         Qya1m9ppxuhHFGUO0khdCNHvFuKF2elt0PJJAjUTBsD9r34gwbDruFK/lweh2HBs3jtR
         Afrs08qQRKjy/qlaC93VjMsjgSchPYhC5ZSWdzJmxt/NcAbUNPy8qWi/OTFZcCXWCi2A
         TQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705629741; x=1706234541;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GYS8sz4H8Ky7qRcHvKaJSRnTFEa4Y7X+Vg+4hhtsnV0=;
        b=O45zR1QP8B6qZ6Xa1U5HQP6cO6YDhZZUSMzZPxsHToByjmKjZ791GfkEEXcWUt7HPu
         3rVB7duJGL5uVN4T4J3O0bIj+E0dMeEUFjqkVG6PKXZA8qbo0lAoZAY1DOSVbqWVE8Os
         7Qr+w7g/3F1b00sPY8mH7KwmsnmmFoOThEcqA8pJDlfcfa6Iy6jHR3IhTWpkPO13q088
         nXc8NampeZaxbGin136wFBzxZZ/LxMUT/hrZSJR+BzVwO5AHfDtT6DjuBkVWAgb8j7Mw
         Tl0gN/Jdkotbm5vQQqmOhmTjJ+6qf5MLYE3N3yZL73zv4fKBs4hR99wrDwEmcIlwwuyu
         qJpg==
X-Gm-Message-State: AOJu0YxXv+EKeMk4ufhbB/NqQnp+Qw6Hncg9gBXuachLeHqQGk/97EZ9
	D/MPXsmhpr/9CGIG8L56lW0jk2wrBCaWqdW3Dd7+QwtsGpMBJMixvlFZWEhAA2ESvMu1A/QBMAu
	gf08=
X-Google-Smtp-Source: AGHT+IEhg32sOhmGqf82Tbx2FLCmV3XxglJeMWRj9KOPkr4j3P85vNQy8fzt79VabZUQH6+PjX7+rA==
X-Received: by 2002:a17:902:e882:b0:1d7:1b2a:5086 with SMTP id w2-20020a170902e88200b001d71b2a5086mr745297plg.107.1705629741140;
        Thu, 18 Jan 2024 18:02:21 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id kq15-20020a170903284f00b001d6ff1795aasm1997876plb.28.2024.01.18.18.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 18:02:20 -0800 (PST)
Message-ID: <65a9d82c.170a0220.4b632.a001@mx.google.com>
Date: Thu, 18 Jan 2024 18:02:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-6.1.y-cip
X-Kernelci-Tree: cip
X-Kernelci-Kernel: v6.1.72-cip13-30-g79e2886a5da69
X-Kernelci-Report-Type: test
Subject: cip/linux-6.1.y-cip ltp-pty: 6 runs,
 1 regressions (v6.1.72-cip13-30-g79e2886a5da69)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org,
 kernel-build-reports@lists.linaro.org, kernelci-results@groups.io
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 02:02:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14420

cip/linux-6.1.y-cip ltp-pty: 6 runs, 1 regressions (v6.1.72-cip13-30-g79e28=
86a5da69)

Regressions Summary
-------------------

platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:  https://kernelci.org/test/job/cip/branch/linux-6.1.y-cip/kernel=
/v6.1.72-cip13-30-g79e2886a5da69/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip
  Branch:   linux-6.1.y-cip
  Describe: v6.1.72-cip13-30-g79e2886a5da69
  URL:      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.g=
it
  SHA:      79e2886a5da69a8a86ec82215b5e9e0748943546

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform         | arch  | lab           | compiler | defconfig            =
      | regressions
-----------------+-------+---------------+----------+----------------------=
------+------------
rk3399-gru-kevin | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chrom=
ebook | 1          =


  Details:     https://kernelci.org/test/plan/id/65a9d0880bcdd2cf1652a3f1

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/ltp-pty-rk3399-gru-kevin.txt
  HTML log:    https://storage.kernelci.org//cip/linux-6.1.y-cip/v6.1.72-ci=
p13-30-g79e2886a5da69/arm64/defconfig+arm64-chromebook/gcc-10/lab-collabora=
/ltp-pty-rk3399-gru-kevin.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65a9d0880bcdd2cf1652a3=
f2
        new failure (last pass: v6.1.67-cip12) =

 =20

