Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4972.1793968689582076762
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2026 04:38:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@intwineconnect.com header.s=google header.b=ayT2tzCz;
 spf=pass (domain: intwineconnect.com, ip: 209.85.208.41, mailfrom: lnasby@intwineconnect.com)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b579003f29so848303a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 06 Nov 2026 04:38:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793968688; cv=none;
        d=google.com; s=arc-20260327;
        b=X1IoZmPaNtbz9MtgQgIweu3YxTIFJMR7WzuI/rkFlOlOJHZMX/qvAy0xFTppcnpU+8
         OTrRJF0sv3ozf8vG+hukkKhjla3y2A35qTfccOfQxcLKlGUBu+KsVuXHYN+qA/g19CvK
         sqgOr09iaj10USFHNTWlf62YxV9rn85D46I4CO0c97r5B3JnQpsq1KAJy+hADNCnulCw
         1PKbg8I1/sC9qiI3KbDG/D4xY6LuEloQaR6ao1KasoqUizjEvYPm9349bNg+bUHR54I6
         XaWYh3GxxCkgUWvXVt8JE17iw6DBdiPnmTLfNxR+BhWKwjAmwwNlaCUV4deWxlWX7NOX
         g4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=E5cRSh8WPMIsb5WjFEbxl2LuLdSyf8980GXS4EHJRWM=;
        fh=RaKH4vXZgYv/1PYcQkfLRK5D2CnBMLe+KcXQA6BQxAs=;
        b=Gy7hDGyqOoMK12yneMaBih2EQqk/1tsDz9RX5aWob99VvgbQFyF5gmocRp34GCUDKj
         ngAhpx8s3gnia1A5/Cyr9pDaDBhruXiZQPsn41AXz8SMpZ9SaJrB1AN0SQ07tdaynDVQ
         qwc8qT8biLMbawhjNXhe3XuQb15cBeYte/nUO/V3lx+fwbnrsM/Td2rGAM+tAxpF1pHG
         TttTsfpFN3q4kWjCYoCoFcDsL3GFm+fzx6W3Gl43NeWeZm4wL44wjSFn+xRkLpBBMW4a
         JVEhf7rZSHOI72yqSxQixT5KKtW+Twx43WBHlbH/eZpQeKuSrtNL7OLK3MIiW9jvDzbg
         CTDQ==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intwineconnect.com; s=google; t=1793968688; x=1794573488; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=E5cRSh8WPMIsb5WjFEbxl2LuLdSyf8980GXS4EHJRWM=;
        b=ayT2tzCzIQrq7aAMbMOZucz7aX0zykDdMhTJs6EsvSTqgBQrGTSE9rK1uAPg79ZGmp
         OhEqBkp2PqulIFmKtZW1yiVGVu8Awf6C3uugc1TGPYuhkRNm/RDEjp/NXwle6BKyz2YH
         lamfm00LeBc0IRgQDrKfPk5W8wmqAuD0tOFjYa8282YpSN9Im3ZqyEnlcZvY7VCo4AZK
         TdM61vBrUZhoLVEy3mKXOPvNp1e0BfMFr+RyMUlPxHn9dY+unH+ze25nVMmuN4rvit1y
         dwVPUwNCTPg0uIueohyIXZKGWYIHRlO17L0CGMAvxJjFhNyQSmmymiVK+znUzvkMoZEj
         M08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793968688; x=1794573488;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E5cRSh8WPMIsb5WjFEbxl2LuLdSyf8980GXS4EHJRWM=;
        b=hvOQ3EpWd460yqah86aO0CNhW+FKdKpjC8vOpK7cF7XccBRjBJ10N7+OasKylPbKvu
         FqfgRvy5X0vC+nITp1oqgCTXa7laVnPycaY4+bsfACa3YzHpOfmmTGAopH0q1vpiz6Ut
         PIXrVvq6YwayjUy5wxBoL1ZEPnHWb2N9/aeCK+uz+Whuwld3sqz3wDw4NT6rUf4Pq5pa
         uZQ1V8+pVNvxIwrulyb9AtC+M99YFKi53PgUhq5TQVAhz/tgd0v5/9ixIgFRaiiemSV1
         eyJfO9DImgJDsx8wV/IdybnIUGRjjLPRPr4+SIt6pyVGzFK0VrneMa/MmXAddngZGdVv
         mdlg==
X-Gm-Message-State: APuU4Z+BViAJPMcrPWAzX1NvsZQswQSpcEYscoxoFKTRbt9hzixiqPQd
	Gi1Ry2RtifF4dZ7dh/kG5lqoPrCMDtNFWl5oUBvUCdgnhDOJiqPVgkb3GWE6u0JmajF943vT6OI
	cCtJapX5rxJPvvLSwIowQ501DTK9DtWUUM4s5C87zqel/o4bEv1GERrs=
X-Gm-Gg: AYBFou3AAxxHaTSneZzCPAHcyl7DcrsHQjDqplUVjq64HgB0yYNOkyOBzXMIIk17Gme
	V0XALZA2t4t4wSFSL2HS1OmYmvq1GJAr+hHY0hFxNjVUu82dHgSoV8IptBGC1AVw9OLgmw2pfjk
	EpqH/7AJ29BQBKDXFjTmoGzhgtjEcy4lY+K4t0u4DUjo8NVr6At8z+HUErahZNHsD/lId2J0uxV
	ovr1WU87maSh9uzGn1hAwjEsZgJuzijan8ZUWLAm3opdqqrlXrTZKK5Mz5nlu4BXll7AzPISdG4
	BWM6qVR5wU90hAhkiSypE5+WQNABgoLTdS2ZbjWIy14s5iDIyy1jT8oZREua2s+zJKiA7xgra/w
	wkCnEC71Q0lEXvAZKTMuNGVMDddQTC/Dk/U8oN+numnY+2F6CfIdj98Pk3IttBtQTmSAZEDNaFT
	uESEtNb5YUZmBntXtzJ+Z6pg==
X-Received: by 2002:a05:6000:4685:b0:48e:3d2:44b1 with SMTP id
 ffacd0b85a97d-492775f0487mr3306155f8f.52.1793968218374; Fri, 06 Nov 2026
 04:30:18 -0800 (PST)
MIME-Version: 1.0
From: Luke Nasby <lnasby@intwineconnect.com>
Date: Fri, 6 Nov 2026 13:30:07 +0100
X-Gm-Features: AclHuK_qjpw9fWA5pH0jgRoW-gMz2vOuVyp9LwQ7h5PwAtdkinvpcfnscKwVSaM
Message-ID: <CAJ6VbXKXLDH1cQ2C7kFOrOmH1Jtdq6DYYK1L2YYaHE=_WqynMQ@mail.gmail.com>
Subject: Question about the 4.19.325-cip137 release
To: cip-dev@lists.cip-project.org
Content-Type: multipart/alternative; boundary="0000000000006517d6065f9ac6da"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 07:59:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24819

--0000000000006517d6065f9ac6da
Content-Type: text/plain; charset="UTF-8"

Hello,

Do you have a general timeline on when cip137 will be released? There is no
rush, mostly just curious based on the normal rate of cip releases.

As an unrelated question: are modules like CONFIG_WIREGUARD or similar
things expected to work on this kernel? When we try it on our
installations, we get issues like:
'
arm64/crypto/sha1-ce-glue.c: In function 'sha1_ce_update':
arch/arm64/crypto/sha1-ce-glue.c:41:2: error: implicit declaration of
function 'kernel_neon_begin_partial' [-Werror=implicit-function-declaration]
  kernel_neon_begin_partial(16);
  ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
scripts/Makefile.build:333: recipe for target
'arch/arm64/crypto/sha1-ce-glue.o' failed
make[1]: *** [arch/arm64/crypto/sha1-ce-glue.o] Error 1
make[1]: *** Waiting for unfinished jobs....
'
Due to seemingly out of date crypto functions required for those to run. Is
this a known issue? Or something that is only a problem on our end?

Thanks for your time,
- Luke Nasby

--0000000000006517d6065f9ac6da
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>Do you have a general=
 timeline on when cip137 will be released? There is no rush, mostly just cu=
rious based on the normal rate of cip releases.</div><div><br></div><div>As=
 an unrelated question: are modules like CONFIG_WIREGUARD or similar things=
 expected to work on this kernel? When we try it on our installations, we g=
et issues like:<br>&#39;</div><div>arm64/crypto/sha1-ce-glue.c: In function=
 &#39;sha1_ce_update&#39;:<br>arch/arm64/crypto/sha1-ce-glue.c:41:2: error:=
 implicit declaration of function &#39;kernel_neon_begin_partial&#39; [-Wer=
ror=3Dimplicit-function-declaration]<br>=C2=A0 kernel_neon_begin_partial(16=
);<br>=C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~~<br>cc1: some warnings being treated =
as errors<br>scripts/Makefile.build:333: recipe for target &#39;arch/arm64/=
crypto/sha1-ce-glue.o&#39; failed<br>make[1]: *** [arch/arm64/crypto/sha1-c=
e-glue.o] Error 1<br>make[1]: *** Waiting for unfinished jobs....<br>&#39;<=
/div><div>Due to seemingly out of date crypto functions required for those =
to run. Is this a known issue? Or something that is only a problem on our e=
nd?</div><div><br></div><div>Thanks for your time,</div><div>- Luke Nasby</=
div></div>

--0000000000006517d6065f9ac6da--
