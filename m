Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0363BC67871
	for <webhook@archiver.kernel.org>; Sat, 14 Jan 2023 14:17:23 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.116529.1673705840615381218
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sat, 14 Jan 2023 06:17:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=XeIDenI9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.50, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f50.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso3517547pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sat, 14 Jan 2023 06:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WIRQwwgcDkQmV3ESYtzL4IjXaGswUXxCTIkPTkxgFKk=;
        b=XeIDenI9g/q2RjSCqnH/QNcMiGRgXgsEFZSQMJwx5rCXWeu/k3VDT8x8V1iA8Gwaw5
         gI2lTTBhNQA1W09Tt1C/SK9vU/uPD+kTYVnEw5TNmwaDYV/gcn1WodunzEHXfAwvWPEE
         0BCOVKVY0MRncjWXAxx1e/qkz8LomkKIl4QeIk6ni+jtgQMyArSzw5d4g8ygeQ53nMVg
         pCzu/hIXUApRPUBcBiHl5rjoKhHgoIG74ViR6vyEUZ7xZF2JT4xtYTeX16Q4XOwrYxUc
         7W4vCqTqJ69Rx5xIERutnjBjJO/BKB5dhemRL4/C09q/CLSJ/yI8hLYwX/ddCXqiSk/j
         33Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WIRQwwgcDkQmV3ESYtzL4IjXaGswUXxCTIkPTkxgFKk=;
        b=Xm1r9KWcSufvFfcBjkuPXwb2vaE6tIv7OAwPxjzwMNSPmufrSbgKvQisGydfkKFbzf
         4AHdk6jbUvMWygLOZ3YhvAoO0jV27dXYPhp2inX8XlCYMH0LBAtQFKBmjOroWZA9nRs1
         zpHHv2sI6JrZWU82dCXR8R4H7VT5WwhUX6/wMQXjRbxEI2NFzVCbYKS/XvEb/ZufQRVr
         luFVrOyTwIUt7QEJWyhiACLSfhoLEFScWrQ0W/xR0B1CKNHPUOCnsoW9V1E6Cbp8VnTt
         08MLAHIcA+Y1aaQRKzAg2d6PqKmghtohMGLdkbrsqv7HQrkZMZQnCYgoEqOz60C9/g9t
         FjgQ==
X-Gm-Message-State: AFqh2koGvPRr9kk3oyYQf8V0O9xrwyv8dENvKG0Js3Ma75hpSVjue4kp
	ggSt6uYwygK1ggaGQnef5PqM8FjMr9BUp7smIsXuVw==
X-Google-Smtp-Source: AMrXdXsedMzBKH+upK+DThQzyvwyLskKN5EGHlYL45060t/1EZT86Uf/4J1ACoK8/+H+9/dbbygxjg==
X-Received: by 2002:a17:903:2691:b0:192:a174:178f with SMTP id jf17-20020a170903269100b00192a174178fmr11430773plb.37.1673705839686;
        Sat, 14 Jan 2023 06:17:19 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001945339354asm6336488plf.197.2023.01.14.06.17.19
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 06:17:19 -0800 (PST)
Message-ID: <63c2b96f.170a0220.64663.a37b@mx.google.com>
Date: Sat, 14 Jan 2023 06:17:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.162-cip24-788-g63c30712099cf
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 7
 runs, 1 regressions (v5.10.162-cip24-788-g63c30712099cf)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 14 Jan 2023 14:17:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10364

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-fcntl-locktests: 7 runs, 1 r=
egressions (v5.10.162-cip24-788-g63c30712099cf)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.162-cip24-788-g63c30712099cf/plan/ltp-fcn=
tl-locktests/

  Test:     ltp-fcntl-locktests
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.162-cip24-788-g63c30712099cf
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      63c30712099cff890a9fa023533c2971e6a4f87e =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/63c2ad1099d6270fc01d39ce

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm64/defconfig/gcc-10/lab-=
broonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.162-cip24-788-g63c30712099cf/arm64/defconfig/gcc-10/lab-=
broonie/ltp-fcntl-locktests-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230109.0/arm64/initrd.cpio.gz =


  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  29a4437646ddbcf389965136680e06d40cbc4722 =



  * ltp-fcntl-locktests.login: https://kernelci.org/test/case/id/63c2ad1099=
d6270fc01d39cf
        new failure (last pass: v5.10.161-cip23-65-gca8c192cb189) =

 =20

