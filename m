Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DEAC433F5
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 04:58:09 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web12.1601.1637211487007973013
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 20:58:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=FUg9ejNl;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.46,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f46.google.com with SMTP id
 u18-20020a9d7212000000b00560cb1dc10bso8802650otj.11
        for <cip-dev@lists.cip-project.org>;
 Wed, 17 Nov 2021 20:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Daa/nZLRHlF/ogmVrXKhVPSLr6yVUCt0SAJj8uXC7ho=;
        b=FUg9ejNlHQ9KXE87JJlPq51QmIHJnByAN4DOSxSXDrePX5waz87MyqphDR5L+Q1gyA
         Y7C62hOS4dck9rNRlSchP2PGxfthD+frXnk9mXrrjw4yXH4rdWpJiyYVV3HWRNz7JtA2
         zm/JUQqTwMmPzy6WZi5/s8LsGvUcfcHGifPgx6+lKX/E3YDXjgRuMYpm3A++hC6DYzR4
         yynraaQ/GNvxPinmgnV8ptEAWwiA2YleYlmeeUtlFqizO75yd95QBlgmI3YNFMdWGRT9
         QKgedwskPcNRk7dRHQXFqxk0S5HYGWrBD3UZH0C9lBVAxYT8BPQUBXXy+kCPwHDlmMBX
         B0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Daa/nZLRHlF/ogmVrXKhVPSLr6yVUCt0SAJj8uXC7ho=;
        b=t6PA1qDZIKRVipOUxZZZUbDOOhBNpj4zZDwlOztSXcNRWIapMYak1LSghdC/iH8sCh
         qNE4OR1hbyJO7oaTr0Gep5vGg6dZw83/WPJ4yH3EID1bKq+ltGJt47Z0URkvRb85m67F
         8aDSWeQ3yNUPCwCOPDfA6YpCXdsT6WT5A59RXiVncNrhTEe4aYs+NpaZvv4b622IpnC5
         Ma8RhE2zre1wlNa4Ifg8rUfo+Icykcga14hBqmQpQ+QYI9hT5NIoIgtSakhhhG0K2MYt
         3SE3OSdDG/AJ4BIHN4Kco8uFbriuQ99WTmNgTN9liNLo1xw4B3Bqy78rmGFAYNJp7pKs
         wRFw==
X-Gm-Message-State: AOAM530tO+pU60PBaLs21RI6iR5Eaw6VJUBst+tmVPfSeojGdL0khtC7
	z8CrrtJx0Av7/Qp/VSKFT2U+Qo5EzqMy1ZkjLTY/WvWVmnWExQ==
X-Google-Smtp-Source: 
 ABdhPJy2RS1aRUo4ZVb2wux3/uyZ3VLN08idv4e9x7zcFAqgLoSGVWcpPxH6EckPzCFnsByS2trNj+D7K4f/97mYPvQ=
X-Received: by 2002:a9d:4a8d:: with SMTP id
 i13mr19403436otf.180.1637211486005;
 Wed, 17 Nov 2021 20:58:06 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 Nov 2021 13:57:30 +0900
Message-ID: 
 <CAODzB9oWEo6D48YUEckgv7Q9QfQdvNMjmuUkTS8SKFHagDi8Kw@mail.gmail.com>
Subject: FYI: meta-spdxscanner with meta-debian/deby
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Nov 2021 04:58:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6949

Hello !

I modified meta-spdxscanner warrior branch[1] to work with meta-debian.
I tested meta-debian and deby(cip-core/deby). I could build without
errors building core-image-minimal with do_spdx task on both
deby-tiny(DISTRO=deby-tine) and deby(DISTRO=deby) distributions. The
do_spdx task seems working.

From output of spdx files, I can see following lines.

openssl

##File

FileName: spdx_temp/openssl-1.1.1d/include/openssl/x509_vfy.h
SPDXID: SPDXRef-item195247
FileChecksum: SHA1: 5dca1c0a935f3f075642539d399e7c6969ff1214
FileChecksum: MD5: 99fd343f8b3970195c79684291fb6fc9
LicenseConcluded: NOASSERTION
LicenseInfoInFile: LicenseRef-UnclassifiedLicense
FileCopyrightText: <text> Copyright 1995-2019 The OpenSSL Project
Authors. All Rights Reserved. </text>

coreutils

##File

FileName: spdx_temp/coreutils-8.30/src/expand-common.c
SPDXID: SPDXRef-item396438
FileChecksum: SHA1: a11068900b49e7c1732f096ca21ccd1343375eeb
FileChecksum: MD5: 4a6529ea8806170c9be8169a29360fd8
LicenseConcluded: NOASSERTION
LicenseInfoInFile: GPL-3.0+
FileCopyrightText: <text> Copyright (C) 1989-2018 Free Software
Foundation, Inc. </text>


I use following tools and version/revision for fossology related tools.

* fossology

Docker image tag 3.3.0[2].

* fossdriver

master branch commit 18410187b0a90654510f34dd783b456c53e681dd [3].

unfortunately, I'm not sure how to add fossdriver to kas docker
container, so I didn't use docker to build image.

1: https://github.com/masami256/meta-spdxscanner/tree/warrior-metadebian
2: https://hub.docker.com/layers/fossology/fossology/3.3.0/images/sha256-b596124b47a29d24d2fdd63f7ba19b9fc27ce67f090e7ee527b02c07c66b54ee?context=explore
3: https://github.com/fossology/fossdriver/tree/18410187b0a90654510f34dd783b456c53e681dd

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

