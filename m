Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD42AC6FA99
	for <webhook@archiver.kernel.org>; Sun, 12 Mar 2023 08:20:11 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web11.62828.1678609202272285626
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Sun, 12 Mar 2023 00:20:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=Eta+KLwj;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.216.46, mailfrom: bot@kernelci.org)
Received: by mail-pj1-f46.google.com with SMTP id fy10-20020a17090b020a00b0023b4bcf0727so1417128pjb.0
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Sun, 12 Mar 2023 00:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112; t=1678609201;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2iPGZdTN1J8+TvGKIhfGYaqjo7lkwf8224QDP1tfQf8=;
        b=Eta+KLwjMfVaFcgkZzQsf6kcY7+bcKtMKP+t7mzWOWP6Jeyb3Kp7/qpx2V65V8b58b
         /Y2boDuXcFDlMNNuEUlPjy5+q/tPWirzrwoOkfXuJ5kF5J9sNmMQzGYvkaC4xQxH0oD/
         XppvipsgCFn+rbd9tfQjB1SIli50Mqg2A6YUSDu8XpwP5iLq7PtfpWSpdzDPTYcVQcCA
         HUwNTTjkvUenTgR19n0KDgXJUFvYzfhPK+rlxmovJ2TbxbzRYRKjlECXJWCXkLaheCaF
         LIUUuZb1qkBZN0V28ea1BN6oKSCFWzRFEFuXt/veiH4ICEH7WyIMT/oWnzWxMYIM256+
         u2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678609201;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2iPGZdTN1J8+TvGKIhfGYaqjo7lkwf8224QDP1tfQf8=;
        b=CobIusk4o99wzutRQXbWYDEUoZ9D0kJSaCnppkjHjQ20bZFI7G1edwYfXvafWw47pS
         mGxP56imLH0YiCRRqvTjLlOLK3+xwiVUz2dCm6UUwzF/0HIiCSqaSb7ZdR/TqGH65GKj
         gQaKfh52LLuZd5Bb2Kf+mdIDQIjEm1dDIeS25+r+VnJSReHBwFshWewRzJ8D1sFgZyQT
         VSC4dAjq2Vgbt4NpopkY7CG5krd5rz0YhkZEgfimqwwszs++QZmmXJPRRXqngNbVD6NL
         J8h2PWoJgnwb/s9i84rNgFiAQQsv/gIQ4n+itS9fkYIE4a0VhYK4MapjA/yhr7whgjI1
         6qyA==
X-Gm-Message-State: AO0yUKWhMJlKnm5X3h0ZytVkOt8Gtc7wAP+cCDAqm67F8UCfMqoCcjRj
	5/PgHrU6OvDeWlfZ1R1ScJ27HcXJI0T20Wa+6KQ=
X-Google-Smtp-Source: AK7set9ZUTvLB8xjT6VbsE1Yq+ZONG5S3nKhmKG8PoM8oHOK6kTH88PzWFNicaCZUmOL35/YNTCUHQ==
X-Received: by 2002:a17:902:a416:b0:19e:bfec:7928 with SMTP id p22-20020a170902a41600b0019ebfec7928mr19677717plq.24.1678609201389;
        Sun, 12 Mar 2023 00:20:01 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id h14-20020a170902f54e00b001a0403f6a97sm370502plf.202.2023.03.12.00.20.00
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 00:20:01 -0800 (PST)
Message-ID: <640d8b31.170a0220.6d38b.06b6@mx.google.com>
Date: Sun, 12 Mar 2023 00:20:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: ci/iwamatsu/linux-4.19.y-cip-rc
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Kernel: v4.19.273-cip92-277-g507c8d80b9e20
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 8 runs,
 1 regressions (v4.19.273-cip92-277-g507c8d80b9e20)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 12 Mar 2023 08:20:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10984

cip-gitlab/ci/iwamatsu/linux-4.19.y-cip-rc kselftest-futex: 8 runs, 1 regre=
ssions (v4.19.273-cip92-277-g507c8d80b9e20)

Regressions Summary
-------------------

platform  | arch  | lab           | compiler | defconfig                  |=
 regressions
----------+-------+---------------+----------+----------------------------+=
------------
hip07-d05 | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chromebook |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-4.19.y-cip-rc/kernel/v4.19.273-cip92-277-g507c8d80b9e20/plan/kselfte=
st-futex/

  Test:     kselftest-futex
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-4.19.y-cip-rc
  Describe: v4.19.273-cip92-277-g507c8d80b9e20
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      507c8d80b9e20db87bb0fbf5ce478b7f2c81093a =



Test Regressions
---------------- =



platform  | arch  | lab           | compiler | defconfig                  |=
 regressions
----------+-------+---------------+----------+----------------------------+=
------------
hip07-d05 | arm64 | lab-collabora | gcc-10   | defconfig+arm64-chromebook |=
 1          =


  Details:     https://kernelci.org/test/plan/id/640d84a9fe459902ac8c864a

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig+arm64-chromebook
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/kselftest-futex-hip07-d05.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-4=
.19.y-cip-rc/v4.19.273-cip92-277-g507c8d80b9e20/arm64/defconfig+arm64-chrom=
ebook/gcc-10/lab-collabora/kselftest-futex-hip07-d05.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-ks=
elftest/20230303.0/arm64/initrd.cpio.gz =



  * kselftest-futex.login: https://kernelci.org/test/case/id/640d84a9fe4599=
02ac8c864b
        new failure (last pass: v4.19.273-cip92-24-g2070ce514972) =

 =20

