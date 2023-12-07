Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8142C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 23:14:51 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
 by mx.groups.io with SMTP id smtpd.web11.106759.1701990891368020618
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Thu, 07 Dec 2023 15:14:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20230601.gappssmtp.com header.s=20230601 header.b=nBOcHn1R;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.161.42, mailfrom: bot@kernelci.org)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-58dd3528497so698123eaf.3
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Thu, 07 Dec 2023 15:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1701990890; x=1702595690; darn=lists.cip-project.org;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=05qksFuVQeYEQf0FHZzBnzkAA6Q6TyMuELNxOysDIlw=;
        b=nBOcHn1RK0IJhNyDKw4lAkkbtWF+Tmyam2JrDjZq/UZN2+WL6f/NSvQrMAXz4KFbO6
         nGPz23ey14B28co6dyDlM6UGmFxQZtf915lk7adaHknirXLRAFJekAKSMw5VYeUAqJjD
         nFl4GXaKLJRptM9zkbmEyTRbRfJf26+INASjZ/xrIHKQw7ZZXwOwzcvCxDVgLwXCE1b7
         WDhd7dqa7LJ42qIvNhDCb8veqNtetwpnsVNl1DAqYJeZxKKgESJr/Oh/FFyu8LXrODVr
         FJoQm5Phhmev004TRKEK0PrX/gepYsEjniz60rZaRuc1AFGCSgc11heE7Jo2yaCOw9JX
         6laA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701990890; x=1702595690;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05qksFuVQeYEQf0FHZzBnzkAA6Q6TyMuELNxOysDIlw=;
        b=HnksEezZX5Qk//FIQRO969bqpLAVNkNe6zqvqqlGtdQZtyRaa3AbIG8JfrMCz172QB
         dndgwRhbQf0iLfxx6mYI2EXAi61h5pep9xng6FvwnCzL0YMRykGZiKo33HHQHs8EIGZT
         +1REq/9DYKzMlnlhtIPKDuWtqPu1TYLjPW8thRZwtAac4ghTb/Qdy+1ttnF103yseGbM
         jAMiy9pyIN4YaQoNGPOLhkDxmXXE/xpHHTPVH6e7sYnV2FvTmOIFT5qEQDSvh75iuT2o
         G6so4ATrS6RwqxNpPYnFmF0zQcYyqmGK/iVg6ROI1b6v45UH5dXIwqSPOBlT3f8KIx6r
         Nf1Q==
X-Gm-Message-State: AOJu0YyE2ncf/lMh7CWU+eNKhBtIjxGGLDa9Na5b5byQyzUa78ggj2ZK
	ENKEQKXLhUB76vhtTw/b4xHXowhQQgPazpNlpHuR/Q==
X-Google-Smtp-Source: AGHT+IGKpDrGo4V9n8XhLfwOSoJ+V99KtenwyF78zONcunnHd0psH4zUYnFdteLLAne7CS2aB6zBIw==
X-Received: by 2002:a05:6358:520b:b0:16e:1f19:5b09 with SMTP id b11-20020a056358520b00b0016e1f195b09mr4360484rwa.26.1701990889920;
        Thu, 07 Dec 2023 15:14:49 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([20.171.243.82])
        by smtp.gmail.com with ESMTPSA id u18-20020a056a00159200b006bf83e892e9sm310393pfk.155.2023.12.07.15.14.49
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 15:14:49 -0800 (PST)
Message-ID: <657251e9.050a0220.a91f6.1d1d@mx.google.com>
Date: Thu, 07 Dec 2023 15:14:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/pavel/linux-test
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Report-Type: test
X-Kernelci-Kernel: v5.10.201-cip41-63-g2bc5a8583f4a8
Subject: cip-gitlab/ci/pavel/linux-test ltp-pty: 6 runs,
 1 regressions (v5.10.201-cip41-63-g2bc5a8583f4a8)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 23:14:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13933

cip-gitlab/ci/pavel/linux-test ltp-pty: 6 runs, 1 regressions (v5.10.201-ci=
p41-63-g2bc5a8583f4a8)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fpavel%2Fli=
nux-test/kernel/v5.10.201-cip41-63-g2bc5a8583f4a8/plan/ltp-pty/

  Test:     ltp-pty
  Tree:     cip-gitlab
  Branch:   ci/pavel/linux-test
  Describe: v5.10.201-cip41-63-g2bc5a8583f4a8
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      2bc5a8583f4a8a28f328fe05c444332335079a44

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  3f0b2176930cf15a26597e28abf4356050136bbe =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/65724f1c0409c151a8e13476

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/ltp-p=
ty-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-pavel-linux-test=
/v5.10.201-cip41-63-g2bc5a8583f4a8/arm64/defconfig/gcc-10/lab-broonie/ltp-p=
ty-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20230623.0/arm64/initrd.cpio.gz =



  * ltp-pty.login: https://kernelci.org/test/case/id/65724f1c0409c151a8e134=
77
        new failure (last pass: v5.10.201-cip41-28-g38e219eb6aa85) =

 =20

