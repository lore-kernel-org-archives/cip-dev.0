Return-Path: <webhook@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391F3C5479D
	for <webhook@archiver.kernel.org>; Wed,  4 Jan 2023 13:22:13 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.11796.1672838523226174211
 for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>;
 Wed, 04 Jan 2023 05:22:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernelci-org.20210112.gappssmtp.com header.s=20210112 header.b=C0keDpQ9;
 spf=none, err=permanent DNS error (domain: kernelci.org, ip: 209.85.214.179, mailfrom: bot@kernelci.org)
Received: by mail-pl1-f179.google.com with SMTP id b2so35838128pld.7
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>; Wed, 04 Jan 2023 05:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uKUWSuMFBFK375r8t5QNqMKh43XE6Zprt4K7qSJdfEg=;
        b=C0keDpQ968yEkVLU6/suLb81y797QdEkBSBrmhlNqzxDgQYV8udfkpU5mgsIB1nQik
         lNe/9oBlk6fJehzW2t4HCwcsRoI20k0V+FnZBJSziG7xIqtrOgOdcCYIhn61Yb5prAgA
         BEdxFi3X+lxPKNdhBNVIQMdHylXVF2qO99CiUORHzSs4pbOqmzWbwDeDIk7wFV9XKLka
         ltGVXMK+ivo8WKOzgiBZrJGM/wuut6QX1AfdWqXxpB6Wa3CP1IEUUBC6lmfuHyBfC39D
         aK3z8Mb+v5Yz4fN4uF95AjsQEA9E+Vqqq8b1j9buR+LPUyEatFLEec2YOR4FAMLoAu5L
         m67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:to:subject:content-transfer-encoding:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKUWSuMFBFK375r8t5QNqMKh43XE6Zprt4K7qSJdfEg=;
        b=fRQ++CfDZywGs4D9goJxrI/vuvDH3n6TN7ODj7Rsu/si1LsGJ7bnxDFy8DQSi1GXco
         EPfBqOjDc3Ja6dwd8wmkeCTuPjvik1XgfcZDM2dKkFnwgHGP0sLQMhjKopoH62kA/2xq
         cHaeJ9J6NS1jTRZHH4MA860P9JSBVHn135KPaZNRiOV9po7BP07fmL6HOYKTQiWutOC6
         pwCHnqKCqQm12KPB6//bZid0VBL0UNbX+wMQSW+u+ept0JDMPdLu123nmLUohpE1jQNi
         DoXpCOgciK7zKIpElklbS8ZKCrYfe/7aTMpH++S35RcW9BUH+Wj31YdKWxoQroNT2m7Z
         youA==
X-Gm-Message-State: AFqh2kp982sPidYFetuxsy1VWv5LzfHmwM8v920D7MAkrdl6CfGSS4bq
	sze8kbeg62zmSOLf3Lh3SU9dwo/WvcU1K7pfZ2M=
X-Google-Smtp-Source: AMrXdXu89H19ySztaUpNK4BSeqef2gUt+9pWRy/b1yRrzV/cSR9EZvv7QuinzdmZre2bwGKK5w1fPw==
X-Received: by 2002:a17:902:a514:b0:192:f500:e822 with SMTP id s20-20020a170902a51400b00192f500e822mr822785plq.37.1672838522459;
        Wed, 04 Jan 2023 05:22:02 -0800 (PST)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id u18-20020a170903125200b00189adf6770fsm24407878plh.233.2023.01.04.05.22.01
        for <cip-dev+int+1680+2922216858170285886@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 05:22:01 -0800 (PST)
Message-ID: <63b57d79.170a0220.116d1.6a84@mx.google.com>
Date: Wed, 04 Jan 2023 05:22:01 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.10.161-cip23-65-gca8c192cb189
X-Kernelci-Tree: cip-gitlab
X-Kernelci-Branch: ci/iwamatsu/linux-5.10.y-cip-rc
X-Kernelci-Report-Type: test
Subject: cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 14 runs,
 2 regressions (v5.10.161-cip23-65-gca8c192cb189)
To: cip-dev+int+1680+2922216858170285886@lists.cip-project.org
From: "kernelci.org bot" <bot@kernelci.org>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 13:22:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10309

cip-gitlab/ci/iwamatsu/linux-5.10.y-cip-rc ltp-ipc: 14 runs, 2 regressions =
(v5.10.161-cip23-65-gca8c192cb189)

Regressions Summary
-------------------

platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =

r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:  https://kernelci.org/test/job/cip-gitlab/branch/ci%2Fiwamatsu%2=
Flinux-5.10.y-cip-rc/kernel/v5.10.161-cip23-65-gca8c192cb189/plan/ltp-ipc/

  Test:     ltp-ipc
  Tree:     cip-gitlab
  Branch:   ci/iwamatsu/linux-5.10.y-cip-rc
  Describe: v5.10.161-cip23-65-gca8c192cb189
  URL:      https://gitlab.com/cip-project/cip-kernel/linux-cip.git
  SHA:      ca8c192cb189c6be84da2274a96e73320a638b43

  Test suite revisions:
    ltp-tests
      URL:  https://github.com/linux-test-project/ltp.git
      SHA:  8048a7cf905e36645b6b0f0fb8c5031a5ed1c97f =



Test Regressions
---------------- =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
meson-gxl-s905x-libretech-cc | arm64 | lab-broonie | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/63b5744bcfb9b8da514eee4d

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-br=
oonie/ltp-ipc-meson-gxl-s905x-libretech-cc.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-br=
oonie/ltp-ipc-meson-gxl-s905x-libretech-cc.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221230.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63b5744bcfb9b8da514eee=
4e
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =



platform                     | arch  | lab         | compiler | defconfig |=
 regressions
-----------------------------+-------+-------------+----------+-----------+=
------------
r8a774a1-hihope-rzg2m-ex     | arm64 | lab-cip     | gcc-10   | defconfig |=
 1          =


  Details:     https://kernelci.org/test/plan/id/63b57538a96fea27684eee30

  Results:     0 PASS, 1 FAIL, 0 SKIP
  Full config: defconfig
  Compiler:    gcc-10 (aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210=
110)
  Plain log:   https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-ci=
p/ltp-ipc-r8a774a1-hihope-rzg2m-ex.txt
  HTML log:    https://storage.kernelci.org//cip-gitlab/ci-iwamatsu-linux-5=
.10.y-cip-rc/v5.10.161-cip23-65-gca8c192cb189/arm64/defconfig/gcc-10/lab-ci=
p/ltp-ipc-r8a774a1-hihope-rzg2m-ex.html
  Rootfs:      http://storage.kernelci.org/images/rootfs/debian/bullseye-lt=
p/20221230.0/arm64/initrd.cpio.gz =



  * ltp-ipc.login: https://kernelci.org/test/case/id/63b57538a96fea27684eee=
31
        new failure (last pass: v5.10.158-cip22-142-g79bb6f9db05d) =

 =20

