Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBB1C6FD1F
	for <webhook@archiver.kernel.org>; Tue, 26 Mar 2024 18:43:20 +0000 (UTC)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
 by mx.groups.io with SMTP id smtpd.web11.18159.1711478348888452421
 for <cip-dev@lists.cip-project.org>;
 Tue, 26 Mar 2024 11:39:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UTm5RDhy;
 spf=pass (domain: gmail.com, ip: 209.85.160.176, mailfrom: flamefire89@gmail.com)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-430c4b1a439so37575561cf.3
        for <cip-dev@lists.cip-project.org>; Tue, 26 Mar 2024 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478348; x=1712083148; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qGkZTlTeVG49dzNbYUhlI8jGlADFwzGK+4u8D17E+I8=;
        b=UTm5RDhyS4cMD95TuKn9GmGm1RZvBO7WtZW8rvt8hJE587dZKfpAHdshJ0NdF4/ZPC
         F9GBd1/0iP4yf3rOKxT02t4T26ypT38HDsVYHl/E3/hk8hKJz6lOuc459ClZdbT1uRDo
         uErERzrH7bOXF0TQA5xe6VYEuRyoA0+/jZ5JdecJuANzQH8vHu3LwVZNIql4j0shD9Cl
         KVRJBucMAvbwp8F/BhLVa9e3gfB7kcKDI6dj9ZPpEETg5aZJluAjJQCtNl1cYTJuNxlG
         TJGpA/vUTT9KytcQmtVbXSjjzVcd8I/IIMQDzFlhvRY/Rxxvc7CfjlQaf5VR0xeW140A
         DaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478348; x=1712083148;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qGkZTlTeVG49dzNbYUhlI8jGlADFwzGK+4u8D17E+I8=;
        b=KHQI8ggXvqRQB7uUqPiGETSJXn7OaxdvR6cTlTQ9WargN3hy2pnQCPMGAZ+Wes2Pfd
         fWIB++i1pPmBWHDxYVfyuh7jJHn8d461DEHwsgTDEdw4WNzrYEfMHSKucy3ryN9V4ytp
         f6JtlWnPW3IgRJDObXaWdky0SMaUSGStTc8yqh57o45k1kCIDnBbsP+G+1RXX203MN4V
         4D1VkVmDLi7rAdRYfI52spW4q/4VQbVMbqMWqValJNV2YeQJBJZIlp3BjF42jog50nBN
         7mjPTvSFlAaPDcUZJHQuCphWcEQR+mBp4C7vJCKqGu5K5Peg/ybrKyiEXw8H3L4HBnI9
         mQng==
X-Gm-Message-State: AOJu0Yy0tqdKmdvi4ypafi0oLx31Q3BbVPI5zoK5TgDKDfeJ7p2qCcOX
	aiFSYjqOvpBtvdTgDfv3VlkUQCTawOeHzGwNc/QtS8/lJFBcz7Sb2F2BMbuuqf7vroORjfILxaD
	z1av5cRa14rirSEUwDfMZfSHU2t99G89eIek=
X-Google-Smtp-Source: AGHT+IEIS7ILz0SOexFkL84yERJD4q0cZVIyA2u9m8mvptm2JfjQI23x45al2I95EDBiB9n33Xp99qan6AJEVgEePDE=
X-Received: by 2002:ac8:5c55:0:b0:431:7329:9945 with SMTP id
 j21-20020ac85c55000000b0043173299945mr416165qtj.60.1711478347760; Tue, 26 Mar
 2024 11:39:07 -0700 (PDT)
MIME-Version: 1.0
From: Alex Grund <flamefire89@gmail.com>
Date: Tue, 26 Mar 2024 19:38:57 +0100
Message-ID: <CAFm405kQcpwwY9i52V0CHtOem84ze_MOLfTxVJVUbG6MKt6zjQ@mail.gmail.com>
Subject: [4.4] Broken GIV crypto
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="000000000000f595d20614949aac"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 26 Mar 2024 18:43:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15416

--000000000000f595d20614949aac
Content-Type: text/plain; charset="UTF-8"

Hi,
I need to report a bug against the linux-4.4.y-st branch caused by commit
24a1889c (crypto: api - Disallow identical driver names)

The upstream commit on which this is based is applied to a kernel tree that
removed the GIV ciphers and the CRYPTO_ALG_TYPE_GIVCIPHER in upstream
commit c79b411eaa (crypto: skcipher - remove remnants of internal IV
generators)

However in 4.4 this is still present and after "something" registered a
"cts(cbc(aes))" alg on the "cts(cbc(aes-ce))" driver the code in
crypto_lookup_skcipher will dismiss it because of the missing GIVCIPHER
flag (type is BLKCIPHER)
It will then add a fitting alg through crypto_givcipher_default which ends
up calling "__crypto_register_alg" which then fails (returns EEXISTS)
because it is adding it with the same name and driver name, although the
flag is different (GIVCIPHER instead of BLKCIPHER) which is actually fine:
__crypto_alg_lookup checks for a matching type before checking the name.

Hence duplicate names are OK if the flags are different.

I hence argue that the commit should be reverted as it causes regressions.
In my case the device doesn't boot at all anymore as it relies on that
crypto alg.

Regards,
Alexander Grund

--000000000000f595d20614949aac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I need to report a bug against the linu=
x-4.4.y-st branch caused by commit 24a1889c (crypto: api - Disallow identic=
al driver names)<br><br></div><div>The upstream commit on which this is bas=
ed is applied to a kernel tree that removed the GIV ciphers and the CRYPTO_=
ALG_TYPE_GIVCIPHER in upstream commit c79b411eaa (crypto: skcipher - remove=
 remnants of internal IV generators)<br><br></div><div>However in 4.4 this =
is still present and after &quot;something&quot; registered a &quot;cts(cbc=
(aes))&quot; alg on the &quot;cts(cbc(aes-ce))&quot; driver the code in cry=
pto_lookup_skcipher will dismiss it because of the missing GIVCIPHER flag (=
type is BLKCIPHER)<br></div><div>It will then add a fitting alg through cry=
pto_givcipher_default which ends up calling &quot;__crypto_register_alg&quo=
t; which then fails (returns EEXISTS) because it is adding it with the same=
 name and driver name, although the flag is different (GIVCIPHER instead of=
 BLKCIPHER) which is actually fine: __crypto_alg_lookup checks for a matchi=
ng type before checking the name.<br><br></div><div>Hence duplicate names a=
re OK if the flags are different.<br><br></div><div>I hence argue that the =
commit should be reverted as it causes regressions. In my case the device d=
oesn&#39;t boot at all anymore as it relies on that crypto alg.<br><br></di=
v><div>Regards,<br></div><div>Alexander Grund<br></div></div>

--000000000000f595d20614949aac--

